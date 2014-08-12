From: keescook@chromium.org (Kees Cook)
Date: Tue, 12 Aug 2014 11:24:22 -0700
Subject: [PATCH v3 0/7] arm: support CONFIG_RODATA
Message-ID: <1407867869-5194-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of patches to support CONFIG_RODATA on ARM, so that
the kernel text is RO, and non-text sections default to NX. To support
on-the-fly kernel text patching (via ftrace, kprobes, etc), fixmap
support has been finalized based on several versions of various patches
that are floating around on the mailing list. This series attempts to
include the least intrusive version, so that others can build on it for
future fixmap work.

The series has been heavily tested, and appears to be working correctly:

With CONFIG_ARM_PTDUMP, expected page table permissions are seen in
/sys/kernel/debug/kernel_page_tables.

Using CONFIG_LKDTM, the kernel now correctly detects bad accesses for
for the following lkdtm tests via /sys/kernel/debug/provoke-crash/DIRECT:
        EXEC_DATA
        WRITE_RO
        WRITE_KERN

ftrace works:
        CONFIG_FTRACE_STARTUP_TEST passes
        Enabling tracing works:
                echo function > /sys/kernel/debug/tracing/current_tracer

kprobes works:
        CONFIG_ARM_KPROBES_TEST passes

kexec works:
        kexec will load and start a new kernel

Built with and without CONFIG_HIGHMEM. Current limitation on fixmap is
that builds do not support 32 CPUs (max 31). This will be addressed by
additional patches to expand the fixmap to 3MB.

Thanks to everyone who has been testing this series and working on its
various pieces!

-Kees

v3:
- more cleanups in switch to generic fixmap (lauraa, robh)
- fixed kexec merge hunk glitch (will.deacon)
- added tested-by tags where appropriate from v2 testing

v2:
- fix typo in kexec merge (buildbot)
- flip index order for highmem pte access (lauraa)
- added kgdb updates (dianders)
