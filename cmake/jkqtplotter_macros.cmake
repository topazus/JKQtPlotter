function(jkqtplotter_installlibrary lib_name libIncludeSubdir cmakeSubdir BuildTypePart)
    install(TARGETS ${lib_name} EXPORT ${lib_name}_TARGETS
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${libIncludeSubdir}
    )
    if(WIN32 AND MSVC AND (NOT MSVC_VERSION LESS 1600) AND (NOT CMAKE_VERSION VERSION_LESS "3.1") AND (NOT BuildTypePart STREQUAL ""))
        message(STATUS "?????????????? INSTALL PDF BuildTypePart=${BuildTypePart}")
        install(FILES $<TARGET_PDB_FILE:${lib_name}> DESTINATION ${CMAKE_INSTALL_BINDIR} OPTIONAL)
    endif()
    set(JKQTP_CURRENT_TARGET_SHAREDPART "${BuildTypePart}")
    set(JKQTP_CURRENT_TARGET_FILENAME "${lib_name}Targets.cmake")
    configure_file(LibTarget.cmake.in "${CMAKE_CURRENT_BINARY_DIR}/${lib_name}Config.cmake" @ONLY)
    install(EXPORT ${lib_name}_TARGETS
        FILE "${JKQTP_CURRENT_TARGET_FILENAME}"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${cmakeSubdir}
    )

    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${lib_name}Version.cmake"
                    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${cmakeSubdir}  )
    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${lib_name}Config.cmake"
                                DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${cmakeSubdir}  )
endfunction(jkqtplotter_installlibrary)
