From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:10 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
Message-ID: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an updated version of Andrew Pinski's ILP32 patch-series for ARM64
(see https://lkml.org/lkml/2014/9/3/704) which merges some changes from our
implementation of ILP32 with his.

I made sure to have Andrew as an author, wherever no significant
changes to his patches occurred and updated the author field on the
others, so it's easier for reviewers (and for Andrew) to track what 
changed and what did not... we've also tried to address as outstanding
review comments against those patches if we were aware of those (as a 
result and an exception to the aforementioned rule, some of original patches 
may have been updated, even if we the below list doesn't make it apparent).

Note that we didn't resort to changing the time_t definition to 32bit for
ILP32 (related to https://sourceware.org/bugzilla/show_bug.cgi?id=16437).

This patch-series has been verified using LTP in a buildroot-environment
with no unexpected fails (note, that the io_submit test currently fails,
as we haven't updated the userspace data-structures in libaio for ILP32,
yet). There's a full set of matching changes to binutils, gdb, gcc, glibc,
strace, LTP and openssl (probably other packages,too) to be submitted, once 
we have the kernel-level ABI changes committed.

If anybody wants to rerun LTP, let me know, so I can provide a
buildroot-generated rootfs-image via FTP.

The key differences from earlier changesets are:
 * updated to 4.0
 * fixes for functions using 'struct msgbuf' (using compat)
 * deduplication of code by using a 32bit stack_t (using compat)
 * updated the documentation to clarify the changes to stack_t
 * introduced a sub-architecture (via COMPAT_ELF_PLATFORM) to make
   life easier for tools (e.g. gdb) when attaching to a live process
   (a corefile is easily distinguishable by being ELFCLASS32).

Any review comments are welcome.
--Phil.


Andrew Pinski (18):
  arm64: ensure the kernel is compiled for LP64
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64: change some CONFIG_COMPAT over to use CONFIG_AARCH32_EL0
    instead
  arm64:ilp32: expose 'kernel_long' as 'long long' for ILP32
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64:ilp32: share signal structures between ILP32 and LP64 ABIs
  arm64:ilp32: use 64bit syscall-names for ILP32 when passing 64bit
    registers
  arm64:ilp32: use non-compat syscall names for ILP32 as for LP64
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64:ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64:ilp32: share HWCAP between LP64 and ILP32
  arm64:ilp32 use the native LP64 'start_thread' for ILP32 threads
  arm64:ilp32: support core dump generation for ILP32
  arm64: add support for starting ILP32 (ELFCLASS32) binaries
  ptrace: Allow compat to use the native siginfo
  arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64:ilp32: use the native siginfo instead of the compat siginfo
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Philipp Tomsich (6):
  arm64:ilp32: add documentation on the ILP32 ABI for ARM64
  arm64:ilp32: COMPAT_USE_64BIT_TIME is true for ILP32 tasks
  arm64:ilp32: add vdso-ilp32 and use for signal return
  arm64:ilp32: use compat-syscalls for msgsnd and msgrcv for ILP32
  arm64:ilp32: use compat for stack_t
  arm64:ilp32: change COMPAT_ELF_PLATFORM to report a a subplatform for
    ILP32

 Documentation/arm64/ilp32.txt                 |  64 ++++++++++++
 arch/arm64/Kconfig                            |  15 ++-
 arch/arm64/Makefile                           |   4 +
 arch/arm64/include/asm/compat.h               |  65 +++++++++++-
 arch/arm64/include/asm/elf.h                  | 105 +++++++++++++++++---
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |  12 ++-
 arch/arm64/include/asm/memory.h               |   2 +-
 arch/arm64/include/asm/processor.h            |  11 +-
 arch/arm64/include/asm/ptrace.h               |   2 +-
 arch/arm64/include/asm/signal32.h             |   2 +
 arch/arm64/include/asm/stat.h                 |   2 +
 arch/arm64/include/asm/thread_info.h          |   3 +-
 arch/arm64/include/asm/unistd.h               |   6 +-
 arch/arm64/include/asm/vdso.h                 |   4 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/include/uapi/asm/posix_types.h     |  12 ++-
 arch/arm64/include/uapi/asm/siginfo.h         |  21 ++++
 arch/arm64/include/uapi/asm/signal.h          |  32 ++++++
 arch/arm64/include/uapi/asm/unistd.h          |   7 ++
 arch/arm64/kernel/Makefile                    |   8 +-
 arch/arm64/kernel/asm-offsets.c               |   2 +-
 arch/arm64/kernel/entry.S                     |  18 +++-
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |   6 +-
 arch/arm64/kernel/process.c                   |   6 +-
 arch/arm64/kernel/ptrace.c                    |  49 ++++++---
 arch/arm64/kernel/signal.c                    |  40 +++++++-
 arch/arm64/kernel/sys_ilp32.c                 | 138 ++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c                     |   4 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  72 ++++++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 ++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  98 ++++++++++++++++++
 arch/arm64/kernel/vdso.c                      |  67 ++++++++++---
 include/linux/compat.h                        |   4 +
 include/uapi/asm-generic/siginfo.h            |  17 +++-
 include/uapi/asm-generic/signal.h             |  27 ++++-
 include/uapi/asm-generic/unistd.h             |   5 +-
 kernel/ptrace.c                               |  24 +++--
 40 files changed, 913 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S

-- 
1.9.1
