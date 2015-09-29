From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:13:57 +0300
Subject: [PATCH v5 00/23] ILP32 for ARM64
Message-ID: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V5 reincarnation for ILP32.

This is mostly the same code as Andrew suggested in v3:
	https://lkml.org/lkml/2014/9/3/704.

V4 series and discussion:
	https://lkml.org/lkml/2015/4/13/691

Discussion on v3 and v4 raised questions and some disagreement in community,
and therefore patches are not accepted till now. In this v5 I tried to avoid any
changes that are not about obvious fixes, so all interface and implementation
questions are still here.

In v5:
 - rebased on top of 4.3.0-rc3;
 - build fixed if ILP32 enabled without AARCH32;
 - PATCH v4 22/24 (use compat for stack_t) dropped because it confuses
   debug tools like gdb and strace;
 - PATCH v4 20/24 (use compat-syscalls for msgsnd and msgrcv for ILP32)
   dropped as breaking tests;
 - PATCH v5 22/23 (msgrcv, msgsnd handlers) introduced for proper 
   handling of msgrcv, msgsnd;
 - other minor fixes.

Questions under discussion:
 - What for ILP32 on ARM64?
	See https://lkml.org/lkml/2015/4/13/814
	and http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
	Briefly,
	 - for compatibility;
	 - for performance;
	 - for memory saving.

 - ABI questions: time_t and so on;
	I think we are out of choice now. Patches to GCC and Glibc are
	upstreamed more than a year ago, and there already might be a code compiled
	against existing ABI. At the end, there is no major disagreement, and final
	word is after ABI users. And I found no objections from that side.

 - Implementation questions: use ILP32 separated table or not, and others;
	Code proposed by Andrew works just fine for more than a year,
	and it even shows slightly better performance comparing to LP64:
	http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
	So I see no reason to change something except obvious bugs, if found.

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

Philipp Tomsich (4):
  arm64:ilp32: add documentation on the ILP32 ABI for ARM64
  arm64:ilp32: COMPAT_USE_64BIT_TIME is true for ILP32 tasks
  arm64:ilp32: add vdso-ilp32 and use for signal return
  arm64:ilp32: change COMPAT_ELF_PLATFORM to report a a subplatform for
    ILP32

Yury Norov (1):
  aarch64: ilp32: msgrcv, msgsnd handlers

 Documentation/arm64/ilp32.txt                      |  64 ++++++
 arch/arm64/Kconfig                                 |  14 +-
 arch/arm64/Makefile                                |   6 +-
 arch/arm64/include/asm/compat.h                    |  65 +++++-
 arch/arm64/include/asm/elf.h                       | 105 ++++++++--
 arch/arm64/include/asm/fpsimd.h                    |   2 +-
 arch/arm64/include/asm/hwcap.h                     |  12 +-
 arch/arm64/include/asm/memory.h                    |   2 +-
 arch/arm64/include/asm/processor.h                 |  12 +-
 arch/arm64/include/asm/ptrace.h                    |   2 +-
 arch/arm64/include/asm/signal32.h                  |   2 +
 arch/arm64/include/asm/stat.h                      |   2 +
 arch/arm64/include/asm/thread_info.h               |   3 +-
 arch/arm64/include/asm/unistd.h                    |   8 +-
 arch/arm64/include/asm/vdso.h                      |   4 +
 arch/arm64/include/uapi/asm/bitsperlong.h          |   9 +-
 arch/arm64/include/uapi/asm/posix_types.h          |  12 +-
 arch/arm64/include/uapi/asm/siginfo.h              |  21 ++
 arch/arm64/include/uapi/asm/signal.h               |  32 +++
 arch/arm64/include/uapi/asm/unistd.h               |   7 +
 arch/arm64/kernel/Makefile                         |   8 +-
 arch/arm64/kernel/asm-offsets.c                    |   2 +-
 arch/arm64/kernel/entry.S                          |  18 +-
 arch/arm64/kernel/head.S                           |   2 +-
 arch/arm64/kernel/hw_breakpoint.c                  |   6 +-
 arch/arm64/kernel/process.c                        |   4 +-
 arch/arm64/kernel/ptrace.c                         |  51 +++--
 arch/arm64/kernel/signal.c                         |  23 ++-
 arch/arm64/kernel/sys_ilp32.c                      | 223 +++++++++++++++++++++
 arch/arm64/kernel/traps.c                          |   4 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore            |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile              |  72 +++++++
 .../siginfo.h => kernel/vdso-ilp32/vdso-ilp32.S}   |  22 +-
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S      |  98 +++++++++
 arch/arm64/kernel/vdso.c                           |  73 +++++--
 include/linux/compat.h                             |   4 +
 include/uapi/asm-generic/siginfo.h                 |  17 +-
 include/uapi/asm-generic/signal.h                  |  27 ++-
 include/uapi/asm-generic/unistd.h                  |   5 +-
 kernel/ptrace.c                                    |  24 ++-
 40 files changed, 973 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 copy arch/arm64/{include/uapi/asm/siginfo.h => kernel/vdso-ilp32/vdso-ilp32.S} (60%)
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S

-- 
2.1.4
