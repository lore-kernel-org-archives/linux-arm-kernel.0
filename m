From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:29 +0300
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
Message-ID: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V6 addresses comments collected for v5 series.
This is RFC because LTP tests fail (63 of 779).
But I don't expect that major changes are required
to fix regressions.

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
 - coding style re-checked.

Andrew Pinski (13):
  arm64: ensure the kernel is compiled for LP64
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64: change some CONFIG_COMPAT over to use CONFIG_AARCH32_EL0
    instead
  arm64:ilp32: share signal structures between ILP32 and LP64 ABIs
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64:ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64:ilp32: share HWCAP between LP64 and ILP32
  arm64:ilp32 use the native LP64 'start_thread' for ILP32 threads
  arm64:ilp32: support core dump generation for ILP32
  ptrace: Allow compat to use the native siginfo
  arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64:ilp32: use the native siginfo instead of the compat siginfo
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Jan Dakinevich (1):
  ilp32: common 32-bit wrappers

Philipp Tomsich (2):
  arm64:ilp32: add documentation on the ILP32 ABI for ARM64
  arm64:ilp32: change COMPAT_ELF_PLATFORM to report a a subplatform for
    ILP32

Yury Norov (1):
  aarch64: ilp32: use generic stat64 structure

 Documentation/arm64/ilp32.txt         |  55 +++++++
 arch/arm64/Kconfig                    |  14 +-
 arch/arm64/Makefile                   |   5 +
 arch/arm64/include/asm/compat.h       |  70 ++++++++-
 arch/arm64/include/asm/elf.h          | 105 +++++++++++--
 arch/arm64/include/asm/fpsimd.h       |   2 +-
 arch/arm64/include/asm/hwcap.h        |  12 +-
 arch/arm64/include/asm/memory.h       |   2 +-
 arch/arm64/include/asm/processor.h    |  18 ++-
 arch/arm64/include/asm/ptrace.h       |   2 +-
 arch/arm64/include/asm/signal32.h     |  19 +++
 arch/arm64/include/asm/stat.h         |   2 +
 arch/arm64/include/asm/thread_info.h  |   3 +-
 arch/arm64/include/asm/unistd.h       |  11 +-
 arch/arm64/include/uapi/asm/siginfo.h |  21 +++
 arch/arm64/include/uapi/asm/signal.h  |  31 ++++
 arch/arm64/kernel/Makefile            |   4 +-
 arch/arm64/kernel/asm-offsets.c       |   2 +-
 arch/arm64/kernel/entry.S             |  18 ++-
 arch/arm64/kernel/entry32-common.S    |  37 +++++
 arch/arm64/kernel/entry32.S           |  29 ----
 arch/arm64/kernel/head.S              |   2 +-
 arch/arm64/kernel/hw_breakpoint.c     |   7 +-
 arch/arm64/kernel/perf_regs.c         |   2 +-
 arch/arm64/kernel/process.c           |   4 +-
 arch/arm64/kernel/ptrace.c            |  47 +++---
 arch/arm64/kernel/signal.c            |  21 ++-
 arch/arm64/kernel/sys_ilp32.c         | 278 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c             |   4 +-
 arch/arm64/kernel/vdso.c              |  12 +-
 include/linux/compat.h                |   4 +
 include/uapi/asm-generic/siginfo.h    |  17 ++-
 include/uapi/asm-generic/signal.h     |  27 +++-
 include/uapi/asm-generic/stat.h       |   8 +-
 kernel/ptrace.c                       |  24 ++-
 35 files changed, 806 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/kernel/entry32-common.S
 create mode 100644 arch/arm64/kernel/sys_ilp32.c

-- 
2.1.4
