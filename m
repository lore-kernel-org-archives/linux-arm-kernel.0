From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 9 Jan 2017 16:59:37 +0530
Subject: [PATCH v7 00/20] ILP32 for ARM64
Message-ID: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables aarch64 with ilp32 mode.

As supporting work, it introduces ARCH_32BIT_OFF_T configuration
option that is enabled for existing 32-bit architectures but disabled
for new arches (so 64-bit off_t is is used by new userspace). Also it
deprecates getrlimit and setrlimit syscalls prior to prlimit64.

This version is based on linux-next from 2017-01-09. It works with
glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
CPUSpec.

This is not RFC anymore. I believe that all ABI and implementation
issues are resolved now. The way that kernel clears registers top
halves is probably the last question, and because there's no objection
for current approach for more that 6 month, I think, community agrees
with it.

Patches 1, 2, 3 and 8 are general, and may be applied separately.

Current version does not introduce ABI changes comparing to RFC3.
Kernel and GLIBC trees:
https://github.com/norov/linux/tree/ilp32-2017-01-09
https://github.com/norov/glibc/tree/dev9

(GLIBC patches are managed by Steve Ellsey, so my tree is only for
reference.)

Changes:
v3: https://lkml.org/lkml/2014/9/3/704
v4: https://lkml.org/lkml/2015/4/13/691
v5: https://lkml.org/lkml/2015/9/29/911
v6: https://lkml.org/lkml/2016/5/23/661
v7: RFC nowrap:  https://lkml.org/lkml/2016/6/17/990
v7: RFC2 nowrap: https://lkml.org/lkml/2016/8/17/245
v7: RFC3 nowrap: https://lkml.org/lkml/2016/10/21/883
v7: - 32-bit off_t deprecation is splitted for compat
      and native 32-bit arches, as it was initially
      done (patches 1, 2);
    - getrlimit() and setrlimit() syscalls deprecated for
      aarch64/ilp32 and all new architectures;
    - documentation is cleaned up (patch 4);
    - compat-related definitions moved from
      aarch64/include/elf.h to binfmt_elf32.c (patch 11)
    - for ptrace, execution mode detection is performed
      at runtime, as it was in v4 (patch 18)

Andrew Pinski (6):
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64: ensure the kernel is compiled for LP64
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64: ilp32: introduce ilp32-specific handlers for sigframe and
    ucontext
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Philipp Tomsich (1):
  arm64:ilp32: add vdso-ilp32 and use for signal return

Yury Norov (13):
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit ABI: introduce ARCH_32BIT_OFF_T config option
  asm-generic: Drop getrlimit and setrlimit syscalls from default list
  arm64: ilp32: add documentation on the ILP32 ABI for ARM64
  thread: move thread bits accessors to separated file
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64: introduce binfmt_elf32.c
  arm64: ilp32: introduce binfmt_ilp32.c
  arm64: ilp32: share aarch32 syscall handlers
  arm64: signal: share lp64 signal routines to ilp32
  arm64: signal32: move ilp32 and aarch32 common code to separated file
  arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32

 Documentation/arm64/ilp32.txt                 |  45 +++++++
 arch/Kconfig                                  |   4 +
 arch/arc/Kconfig                              |   1 +
 arch/arc/include/uapi/asm/unistd.h            |   1 +
 arch/arm/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |  19 ++-
 arch/arm64/Makefile                           |   5 +
 arch/arm64/include/asm/compat.h               |  19 +--
 arch/arm64/include/asm/elf.h                  |  32 ++---
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/ftrace.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |   6 +-
 arch/arm64/include/asm/is_compat.h            |  90 ++++++++++++++
 arch/arm64/include/asm/memory.h               |   5 +-
 arch/arm64/include/asm/processor.h            |  11 +-
 arch/arm64/include/asm/ptrace.h               |   2 +-
 arch/arm64/include/asm/seccomp.h              |   2 +-
 arch/arm64/include/asm/signal32.h             |   9 +-
 arch/arm64/include/asm/signal32_common.h      |  27 ++++
 arch/arm64/include/asm/signal_common.h        |  33 +++++
 arch/arm64/include/asm/signal_ilp32.h         |  38 ++++++
 arch/arm64/include/asm/syscall.h              |   2 +-
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/asm/unistd.h               |   8 +-
 arch/arm64/include/asm/vdso.h                 |   6 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/include/uapi/asm/unistd.h          |  13 ++
 arch/arm64/kernel/Makefile                    |  18 ++-
 arch/arm64/kernel/asm-offsets.c               |   9 +-
 arch/arm64/kernel/binfmt_elf32.c              |  32 +++++
 arch/arm64/kernel/binfmt_ilp32.c              |  98 +++++++++++++++
 arch/arm64/kernel/cpufeature.c                |   8 +-
 arch/arm64/kernel/cpuinfo.c                   |  20 +--
 arch/arm64/kernel/entry.S                     |  34 +++++-
 arch/arm64/kernel/entry32.S                   |  80 ------------
 arch/arm64/kernel/entry32_common.S            | 107 ++++++++++++++++
 arch/arm64/kernel/entry_ilp32.S               |  22 ++++
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |   8 +-
 arch/arm64/kernel/perf_regs.c                 |   2 +-
 arch/arm64/kernel/process.c                   |   7 +-
 arch/arm64/kernel/ptrace.c                    |  80 ++++++++++--
 arch/arm64/kernel/signal.c                    | 102 ++++++++++------
 arch/arm64/kernel/signal32.c                  | 107 ----------------
 arch/arm64/kernel/signal32_common.c           | 135 ++++++++++++++++++++
 arch/arm64/kernel/signal_ilp32.c              | 170 ++++++++++++++++++++++++++
 arch/arm64/kernel/sys_ilp32.c                 | 100 +++++++++++++++
 arch/arm64/kernel/traps.c                     |   5 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  74 +++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 ++++++++++++++
 arch/arm64/kernel/vdso.c                      |  70 +++++++++--
 arch/arm64/kernel/vdso/gettimeofday.S         |  20 ++-
 arch/arm64/kernel/vdso/vdso.S                 |   6 +-
 arch/blackfin/Kconfig                         |   1 +
 arch/c6x/include/uapi/asm/unistd.h            |   1 +
 arch/cris/Kconfig                             |   1 +
 arch/frv/Kconfig                              |   1 +
 arch/h8300/Kconfig                            |   1 +
 arch/h8300/include/uapi/asm/unistd.h          |   1 +
 arch/hexagon/Kconfig                          |   1 +
 arch/hexagon/include/uapi/asm/unistd.h        |   1 +
 arch/m32r/Kconfig                             |   1 +
 arch/m68k/Kconfig                             |   1 +
 arch/metag/Kconfig                            |   1 +
 arch/metag/include/uapi/asm/unistd.h          |   1 +
 arch/microblaze/Kconfig                       |   1 +
 arch/mips/Kconfig                             |   1 +
 arch/mn10300/Kconfig                          |   1 +
 arch/nios2/Kconfig                            |   1 +
 arch/nios2/include/uapi/asm/unistd.h          |   1 +
 arch/openrisc/Kconfig                         |   1 +
 arch/openrisc/include/uapi/asm/unistd.h       |   1 +
 arch/parisc/Kconfig                           |   1 +
 arch/powerpc/Kconfig                          |   1 +
 arch/score/Kconfig                            |   1 +
 arch/score/include/uapi/asm/unistd.h          |   1 +
 arch/sh/Kconfig                               |   1 +
 arch/sparc/Kconfig                            |   1 +
 arch/tile/Kconfig                             |   1 +
 arch/tile/include/uapi/asm/unistd.h           |   1 +
 arch/tile/kernel/compat.c                     |   3 +
 arch/unicore32/Kconfig                        |   1 +
 arch/unicore32/include/uapi/asm/unistd.h      |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/um/Kconfig                           |   1 +
 arch/xtensa/Kconfig                           |   1 +
 drivers/clocksource/arm_arch_timer.c          |   2 +-
 include/linux/fcntl.h                         |   2 +-
 include/linux/thread_bits.h                   |  63 ++++++++++
 include/linux/thread_info.h                   |  54 +-------
 include/uapi/asm-generic/unistd.h             |  10 +-
 93 files changed, 1600 insertions(+), 408 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/include/asm/is_compat.h
 create mode 100644 arch/arm64/include/asm/signal32_common.h
 create mode 100644 arch/arm64/include/asm/signal_common.h
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c
 create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
 create mode 100644 arch/arm64/kernel/entry32_common.S
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal32_common.c
 create mode 100644 arch/arm64/kernel/signal_ilp32.c
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
 create mode 100644 include/linux/thread_bits.h

-- 
2.7.4
