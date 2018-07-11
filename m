From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:35 +0100
Subject: [PATCHv5 00/21] arm64: invoke syscalls with pt_regs
Message-ID: <20180711135656.20670-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series reworks arm64's syscall handling to minimize the propagation
of user-controlled register values into speculated code paths. As with
x86 [1], a wrapper is generated for each syscall, which extracts the
argument from a struct pt_regs. During kernel entry from userspace,
registers are zeroed.

The arm64 kernel code directly invokes some syscalls which the x86 code
doesn't, so I've added ksys_* wrappers for these, following the x86
example. The rest of the series is arm64-specific.

I've pushed the series out to my arm64/syscall-regs branch [2] on
kernel.org.

Since v1 [3]:
* Rebase atop of arm64 for-next/core (for SSBD conflicts)
* Move ksys_personality logic into <linux/syscalls.h>
* Move kcompat_sys_* wrappers to <linux/compat.h>
* Fix scno bounds check to use unsigned comparison
* Fix sve_user_reset() call in el0_svc_handler()
* Add BUILD_BUG() to the !CONFIG_ARM64_SVE stubs
* Accumulate acked-by / reviewed-by tags

Since v2 [4]:
* Rebase to v4.18-rc1
* Take upper 32 RES0 bits of SCTLR_ELx into account
* Accumulate acks

Since v3 [5]:
* Rebase to v4.18-rc3 to avoid conflict with FPSIMD/SVE fixes
* Accumulate acks / reviewed-by tags
* Rework __invoke_syscall() for consistency with do_ni_syscall()
* Rename sve_user_reset() to sve_user_discard()
* Tidied up comment placement
* Typo fixes

Since v4 [6]:
* Rework label names in apply_ssbd
* Clean up {compat_,}sys_call_table types
* Made syscall_fn_t[] arguments const
* Drop {compat_,}sys_call_table alignment

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180330093720.6780-1-linux at dominikbrodowski.net
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
[3] https://lkml.kernel.org/r/20180514094640.27569-1-mark.rutland at arm.com
[4] https://lkml.kernel.org/r/20180601112441.37810-1-mark.rutland at arm.com
[5] https://lkml.kernel.org/r/20180618120310.39527-1-mark.rutland at arm.com
[6] https://lkml.kernel.org/r/20180702110415.10465-1-mark.rutland at arm.com

Mark Rutland (21):
  arm64: consistently use unsigned long for thread flags
  arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
  arm64: kill config_sctlr_el1()
  arm64: kill change_cpacr()
  arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
  arm64: remove sigreturn wrappers
  arm64: introduce syscall_fn_t
  arm64: convert raw syscall invocation to C
  arm64: convert syscall trace logic to C
  arm64: convert native/compat syscall entry to C
  arm64: don't restore GPRs when context tracking
  arm64: don't reload GPRs after apply_ssbd
  arm64: zero GPRs upon entry from EL0
  arm64: drop alignment from syscall tables
  kernel: add ksys_personality()
  kernel: add kcompat_sys_{f,}statfs64()
  arm64: remove in-kernel call to sys_personality()
  arm64: use {COMPAT,}SYSCALL_DEFINE0 for sigreturn
  arm64: use SYSCALL_DEFINE6() for mmap
  arm64: convert compat wrappers to C
  arm64: implement syscall wrappers

 arch/arm64/Kconfig                       |   1 +
 arch/arm64/include/asm/fpsimd.h          |  17 +++-
 arch/arm64/include/asm/syscall.h         |   8 +-
 arch/arm64/include/asm/syscall_wrapper.h |  80 ++++++++++++++++
 arch/arm64/include/asm/sysreg.h          |  30 ++----
 arch/arm64/include/asm/unistd32.h        |  26 ++---
 arch/arm64/kernel/Makefile               |   5 +-
 arch/arm64/kernel/armv8_deprecated.c     |   8 +-
 arch/arm64/kernel/cpu_errata.c           |   3 +-
 arch/arm64/kernel/entry.S                | 157 ++++---------------------------
 arch/arm64/kernel/entry32.S              | 121 ------------------------
 arch/arm64/kernel/fpsimd.c               |  19 ----
 arch/arm64/kernel/signal.c               |   5 +-
 arch/arm64/kernel/signal32.c             |   6 +-
 arch/arm64/kernel/sys.c                  |  29 +++---
 arch/arm64/kernel/sys32.c                | 135 ++++++++++++++++++++++----
 arch/arm64/kernel/syscall.c              | 132 ++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c                |  18 +---
 arch/arm64/mm/fault.c                    |   2 +-
 fs/statfs.c                              |  14 ++-
 include/linux/compat.h                   |  11 +++
 include/linux/syscalls.h                 |  11 +++
 22 files changed, 462 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm64/include/asm/syscall_wrapper.h
 delete mode 100644 arch/arm64/kernel/entry32.S
 create mode 100644 arch/arm64/kernel/syscall.c

-- 
2.11.0
