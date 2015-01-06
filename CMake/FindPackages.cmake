# generated by Buildyard, do not edit.

include(System)
list(APPEND FIND_PACKAGES_DEFINES ${SYSTEM})
# Copyright (c) 2014 Stefan.Eilemann@epfl.ch

# Provides common_package(Name args) which improves find_package.
# First invokes find_package with all the given arguments, and then
# falls back to using pkg_config if available. The pkg_config path
# does only implement the version, REQUIRED and QUIET find_package
# arguments (e.g. no COMPONENTS)

find_package(PkgConfig)
set(ENV{PKG_CONFIG_PATH}
  "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig:$ENV{PKG_CONFIG_PATH}")

macro(COMMON_PACKAGE Name)
  string(TOUPPER ${Name} COMMON_PACKAGE_NAME)
  set(COMMON_PACKAGE_ARGS ${ARGN}) # ARGN is not a list. make one.
  set(COMMON_PACKAGE_VERSION)

  if(COMMON_PACKAGE_ARGS)
    list(GET COMMON_PACKAGE_ARGS 0 COMMON_PACKAGE_VERSION)
    if(COMMON_PACKAGE_VERSION MATCHES "^[0-9.]+$") # is a version
      set(COMMON_PACKAGE_VERSION ">=${COMMON_PACKAGE_VERSION}")
    else()
      set(COMMON_PACKAGE_VERSION)
    endif()
  endif()

  list(FIND COMMON_PACKAGE_ARGS "QUIET" COMMON_PACKAGE_QUIET_POS)
  if(COMMON_PACKAGE_QUIET_POS EQUAL -1)
    set(COMMON_PACKAGE_QUIET)
  else()
    set(COMMON_PACKAGE_QUIET "QUIET")
  endif()

  list(FIND COMMON_PACKAGE_ARGS "REQUIRED" COMMON_PACKAGE_REQUIRED_POS)
  if(COMMON_PACKAGE_REQUIRED_POS EQUAL -1) # Optional find
    find_package(${Name} ${COMMON_PACKAGE_ARGS}) # try standard cmake way
    if((NOT ${Name}_FOUND) AND (NOT ${COMMON_PACKAGE_NAME}_FOUND) AND PKG_CONFIG_EXECUTABLE)
      pkg_check_modules(${Name} ${Name}${COMMON_PACKAGE_VERSION}
        ${COMMON_PACKAGE_QUIET}) # try pkg_config way
    endif()
  else() # required find
    list(REMOVE_AT COMMON_PACKAGE_ARGS ${COMMON_PACKAGE_REQUIRED_POS})
    find_package(${Name} ${COMMON_PACKAGE_ARGS}) # try standard cmake way
    if((NOT ${Name}_FOUND) AND (NOT ${COMMON_PACKAGE_NAME}_FOUND) AND PKG_CONFIG_EXECUTABLE)
      pkg_check_modules(${Name} REQUIRED ${Name}${COMMON_PACKAGE_VERSION}
        ${COMMON_PACKAGE_QUIET}) # try pkg_config way (and fail if needed)
    endif()
  endif()
endmacro()

common_package(Boost 1.41.0  REQUIRED COMPONENTS program_options unit_test_framework serialization system thread)
common_package(LibJpegTurbo 1.2.1  REQUIRED )
common_package(Qt4 4.6  REQUIRED COMPONENTS QtCore QtGui QtNetwork)
common_package(GLUT    )
common_package(OpenGL    )

if(EXISTS ${PROJECT_SOURCE_DIR}/CMake/FindPackagesPost.cmake)
  include(${PROJECT_SOURCE_DIR}/CMake/FindPackagesPost.cmake)
endif()

if(BOOST_FOUND)
  set(Boost_name BOOST)
  set(Boost_FOUND TRUE)
elseif(Boost_FOUND)
  set(Boost_name Boost)
  set(BOOST_FOUND TRUE)
endif()
if(Boost_name)
  list(APPEND FIND_PACKAGES_DEFINES DEFLECT_USE_BOOST)
  if(NOT COMMON_LIBRARY_TYPE MATCHES "SHARED")
    list(APPEND DEFLECT_DEPENDENT_LIBRARIES Boost)
  endif()
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} Boost")
  link_directories(${${Boost_name}_LIBRARY_DIRS})
  if(NOT "${${Boost_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(SYSTEM ${${Boost_name}_INCLUDE_DIRS})
  endif()
endif()

if(LIBJPEGTURBO_FOUND)
  set(LibJpegTurbo_name LIBJPEGTURBO)
  set(LibJpegTurbo_FOUND TRUE)
elseif(LibJpegTurbo_FOUND)
  set(LibJpegTurbo_name LibJpegTurbo)
  set(LIBJPEGTURBO_FOUND TRUE)
endif()
if(LibJpegTurbo_name)
  list(APPEND FIND_PACKAGES_DEFINES DEFLECT_USE_LIBJPEGTURBO)
  if(NOT COMMON_LIBRARY_TYPE MATCHES "SHARED")
    list(APPEND DEFLECT_DEPENDENT_LIBRARIES LibJpegTurbo)
  endif()
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} LibJpegTurbo")
  link_directories(${${LibJpegTurbo_name}_LIBRARY_DIRS})
  if(NOT "${${LibJpegTurbo_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${LibJpegTurbo_name}_INCLUDE_DIRS})
  endif()
endif()

if(QT4_FOUND)
  set(Qt4_name QT4)
  set(Qt4_FOUND TRUE)
elseif(Qt4_FOUND)
  set(Qt4_name Qt4)
  set(QT4_FOUND TRUE)
endif()
if(Qt4_name)
  list(APPEND FIND_PACKAGES_DEFINES DEFLECT_USE_QT4)
  if(NOT COMMON_LIBRARY_TYPE MATCHES "SHARED")
    list(APPEND DEFLECT_DEPENDENT_LIBRARIES Qt4)
  endif()
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} Qt4")
  link_directories(${${Qt4_name}_LIBRARY_DIRS})
  if(NOT "${${Qt4_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(SYSTEM ${${Qt4_name}_INCLUDE_DIRS})
  endif()
endif()

if(GLUT_FOUND)
  set(GLUT_name GLUT)
  set(GLUT_FOUND TRUE)
elseif(GLUT_FOUND)
  set(GLUT_name GLUT)
  set(GLUT_FOUND TRUE)
endif()
if(GLUT_name)
  list(APPEND FIND_PACKAGES_DEFINES DEFLECT_USE_GLUT)
  if(NOT COMMON_LIBRARY_TYPE MATCHES "SHARED")
    list(APPEND DEFLECT_DEPENDENT_LIBRARIES GLUT)
  endif()
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} GLUT")
  link_directories(${${GLUT_name}_LIBRARY_DIRS})
  if(NOT "${${GLUT_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${GLUT_name}_INCLUDE_DIRS})
  endif()
endif()

if(OPENGL_FOUND)
  set(OpenGL_name OPENGL)
  set(OpenGL_FOUND TRUE)
elseif(OpenGL_FOUND)
  set(OpenGL_name OpenGL)
  set(OPENGL_FOUND TRUE)
endif()
if(OpenGL_name)
  list(APPEND FIND_PACKAGES_DEFINES DEFLECT_USE_OPENGL)
  if(NOT COMMON_LIBRARY_TYPE MATCHES "SHARED")
    list(APPEND DEFLECT_DEPENDENT_LIBRARIES OpenGL)
  endif()
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} OpenGL")
  link_directories(${${OpenGL_name}_LIBRARY_DIRS})
  if(NOT "${${OpenGL_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${OpenGL_name}_INCLUDE_DIRS})
  endif()
endif()

set(DEFLECT_BUILD_DEBS autoconf;automake;cmake;doxygen;freeglut3-dev;git;git-review;libboost-program-options-dev;libboost-serialization-dev;libboost-system-dev;libboost-test-dev;libboost-thread-dev;libjpeg-turbo8-dev;libturbojpeg;pkg-config;subversion)

set(DEFLECT_DEPENDS Boost;LibJpegTurbo;Qt4;GLUT;OpenGL)

# Write defines.h and options.cmake
if(NOT PROJECT_INCLUDE_NAME)
  message(WARNING "PROJECT_INCLUDE_NAME not set, old or missing Common.cmake?")
  set(PROJECT_INCLUDE_NAME ${PROJECT_NAME})
endif()
if(NOT OPTIONS_CMAKE)
  set(OPTIONS_CMAKE ${CMAKE_CURRENT_BINARY_DIR}/options.cmake)
endif()
set(DEFINES_FILE "${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_INCLUDE_NAME}/defines${SYSTEM}.h")
list(APPEND COMMON_INCLUDES ${DEFINES_FILE})
set(DEFINES_FILE_IN ${DEFINES_FILE}.in)
file(WRITE ${DEFINES_FILE_IN}
  "// generated by CMake/FindPackages.cmake, do not edit.\n\n"
  "#ifndef ${PROJECT_NAME}_DEFINES_${SYSTEM}_H\n"
  "#define ${PROJECT_NAME}_DEFINES_${SYSTEM}_H\n\n")
file(WRITE ${OPTIONS_CMAKE} "# Optional modules enabled during build\n")
foreach(DEF ${FIND_PACKAGES_DEFINES})
  add_definitions(-D${DEF}=1)
  file(APPEND ${DEFINES_FILE_IN}
  "#ifndef ${DEF}\n"
  "#  define ${DEF} 1\n"
  "#endif\n")
if(NOT DEF STREQUAL SYSTEM)
  file(APPEND ${OPTIONS_CMAKE} "set(${DEF} ON)\n")
endif()
endforeach()
if(CMAKE_MODULE_INSTALL_PATH)
  install(FILES ${OPTIONS_CMAKE} DESTINATION ${CMAKE_MODULE_INSTALL_PATH}
    COMPONENT dev)
else()
  message(WARNING "CMAKE_MODULE_INSTALL_PATH not set, old or missing Common.cmake?")
endif()
file(APPEND ${DEFINES_FILE_IN}
  "\n#endif\n")

include(UpdateFile)
configure_file(${DEFINES_FILE_IN} ${DEFINES_FILE} COPYONLY)
if(Boost_FOUND) # another WAR for broken boost stuff...
  set(Boost_VERSION ${Boost_MAJOR_VERSION}.${Boost_MINOR_VERSION}.${Boost_SUBMINOR_VERSION})
endif()
if(CUDA_FOUND)
  string(REPLACE "-std=c++11" "" CUDA_HOST_FLAGS "${CUDA_HOST_FLAGS}")
  string(REPLACE "-std=c++0x" "" CUDA_HOST_FLAGS "${CUDA_HOST_FLAGS}")
endif()
if(OPENMP_FOUND)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif()
if(QT4_FOUND)
  if(WIN32)
    set(QT_USE_QTMAIN TRUE)
  endif()
  # Configure a copy of the 'UseQt4.cmake' system file.
  if(NOT EXISTS ${QT_USE_FILE})
    message(WARNING "Can't find QT_USE_FILE!")
  else()
    set(_customUseQt4File "${CMAKE_CURRENT_BINARY_DIR}/UseQt4.cmake")
    file(READ ${QT_USE_FILE} content)
    # Change all include_directories() to use the SYSTEM option
    string(REPLACE "include_directories(" "include_directories(SYSTEM " content ${content})
    string(REPLACE "INCLUDE_DIRECTORIES(" "INCLUDE_DIRECTORIES(SYSTEM " content ${content})
    file(WRITE ${_customUseQt4File} ${content})
    set(QT_USE_FILE ${_customUseQt4File})
    include(${QT_USE_FILE})
  endif()
endif()
if(FIND_PACKAGES_FOUND)
  if(MSVC)
    message(STATUS "Configured ${PROJECT_NAME} with ${FIND_PACKAGES_FOUND}")
  else()
    message(STATUS "Configured ${PROJECT_NAME} with ${CMAKE_BUILD_TYPE}${FIND_PACKAGES_FOUND}")
  endif()
endif()
