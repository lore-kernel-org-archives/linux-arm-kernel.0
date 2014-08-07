From: keescook@chromium.org (Kees Cook)
Date: Thu,  7 Aug 2014 08:01:45 -0700
Subject: [PATCH v2 0/8] arm: support CONFIG_RODATA
Message-ID: <1407423713-4160-1-git-send-email-keescook@chromium.org>
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

Thanks to everyone who has been testing this series and working on its
various pieces!

-Kees

v2:
- fix typo in kexec merge (buildbot)
- flip index order for highmem pte access (lauraa)
- added kgdb updates (dianders)
