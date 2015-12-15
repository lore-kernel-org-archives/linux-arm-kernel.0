From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:26 +0300
Subject: [RFC3 PATCH v6 00/20] ILP32 for ARM64
Message-ID: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is still RFC because we have no glibc yet, that correspnds new ABI
introduced here. And so we cannot run tests. LP64 and AARCH32 tests show
no regression though.

  v3: https://lkml.org/lkml/2014/9/3/704
  v4: https://lkml.org/lkml/2015/4/13/691
  v5: https://lkml.org/lkml/2015/9/29/911

  v6:
 - time_t, __kenel_off_t and other types turned to be 32-bit
   for compatibility reasons (after v5 discussion);
 - related changes applied to ILP32 syscall table and handlers;
 - ILP32 VDSO code excluded. It's not mandatory, and caused questions
   during review process. We definitely make sure we will follow up
   with a VDSO later on because it is needed for performance reasons;
 - fixed build issues with different combinations of AARCH32 / ILP32
   enabling in config;
 - ILP32 TLS bug fixed;
 - entry32-common.S introduced to hold wrappers needed for both ILP32
   and AARCH32_EL0;
 - documentation updated according to latest changes;
 - rebased to the current head;
 - coding style re-checked;
 - ILP32 syscall table turned around.

 rfc3:
 - all structures and system calls are just like AARCH32 ones now. with 2
   exceptions: syscalls that take 64-bit parameter in 2 32-bit regosters
   are replaced with LP64 version; struct rt_sigframe is constructed both
   from LP64 and AARCH32 fields to be consistent with AARCH64 register set;
 - documentation rewritten accordingly;
 - common code for all 3 ABIs is moved to separated files for easy use,
   new headers and objects are introduced, incl: is_compat.h, thread_bits.h,
   signal_common.h, signal32_common.h.
 - ILP32 VDSO code restored, Nathans comments are addressed;
 - patch "arm64: ilp32: force IPC_64 in msgctl, shmctl, semctl" removed, as
   Arnd suggested general solution for IPC_64 problem.


Andrew Pinski (9):
  arm64: ensure the kernel is compiled for LP64
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64: change some CONFIG_COMPAT over to use CONFIG_AARCH32_EL0
    instead
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64:ilp32: share HWCAP between LP64 and ILP32
  arm64:ilp32 use the native LP64 'start_thread' for ILP32 threads
  arm64:ilp32: support core dump generation for ILP32
  arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Jan Dakinevich (1):
  arm64: ilp32: share aarch32 syscall wrappers to ilp32

Philipp Tomsich (2):
  arm64:ilp32: add vdso-ilp32 and use for signal return
  arm64:ilp32: change COMPAT_ELF_PLATFORM to report a a subplatform for
    ILP32

Yury Norov (8):
  arm64: ilp32: add documentation on the ILP32 ABI for ARM64
  thread: move thread bits accessors to separated file
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64: signal: wrap struct ucontext, fp and lr with struct sigframe
  arm64: signal: move ilp32 and lp64 common code to separated file
  arm64: signal32: move ilp32 and aarch32 common code to separated file
  arm64: ilp32: introduce ilp32-specific handlers for sigframe

 Documentation/arm64/ilp32.txt                 |  17 +++
 arch/arm64/Kconfig                            |  12 ++
 arch/arm64/Makefile                           |   5 +
 arch/arm64/include/asm/compat.h               |  19 +--
 arch/arm64/include/asm/elf.h                  | 118 +++++++++++++++--
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |  12 +-
 arch/arm64/include/asm/is_compat.h            |  86 +++++++++++++
 arch/arm64/include/asm/memory.h               |   3 +-
 arch/arm64/include/asm/processor.h            |  16 ++-
 arch/arm64/include/asm/ptrace.h               |   2 +-
 arch/arm64/include/asm/signal32.h             |   6 +-
 arch/arm64/include/asm/signal32_common.h      |  30 +++++
 arch/arm64/include/asm/signal_common.h        |  39 ++++++
 arch/arm64/include/asm/signal_ilp32.h         |  38 ++++++
 arch/arm64/include/asm/thread_info.h          |   3 +-
 arch/arm64/include/asm/unistd.h               |  13 +-
 arch/arm64/include/asm/vdso.h                 |   4 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/kernel/Makefile                    |  11 +-
 arch/arm64/kernel/asm-offsets.c               |   2 +-
 arch/arm64/kernel/entry.S                     |  18 ++-
 arch/arm64/kernel/entry32-common.S            |  37 ++++++
 arch/arm64/kernel/entry32.S                   |  29 -----
 arch/arm64/kernel/entry_ilp32.S               |  32 +++++
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |   6 +-
 arch/arm64/kernel/perf_regs.c                 |   2 +-
 arch/arm64/kernel/process.c                   |   5 +-
 arch/arm64/kernel/ptrace.c                    |  48 ++++---
 arch/arm64/kernel/signal.c                    | 176 +++-----------------------
 arch/arm64/kernel/signal32.c                  |  85 -------------
 arch/arm64/kernel/signal32_common.c           | 116 +++++++++++++++++
 arch/arm64/kernel/signal_common.c             | 174 +++++++++++++++++++++++++
 arch/arm64/kernel/signal_ilp32.c              | 126 ++++++++++++++++++
 arch/arm64/kernel/sys_ilp32.c                 |  77 +++++++++++
 arch/arm64/kernel/traps.c                     |   5 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  72 +++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 ++++++++++++++
 arch/arm64/kernel/vdso.c                      |  65 ++++++++--
 include/linux/thread_bits.h                   |  57 +++++++++
 include/linux/thread_info.h                   |  44 +------
 44 files changed, 1343 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/include/asm/is_compat.h
 create mode 100644 arch/arm64/include/asm/signal32_common.h
 create mode 100644 arch/arm64/include/asm/signal_common.h
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/entry32-common.S
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal32_common.c
 create mode 100644 arch/arm64/kernel/signal_common.c
 create mode 100644 arch/arm64/kernel/signal_ilp32.c
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
 create mode 100644 include/linux/thread_bits.h

-- 
2.5.0
