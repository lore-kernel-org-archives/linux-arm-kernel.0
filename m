From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  5 Jul 2018 15:16:47 +0100
Subject: [PATCHv2 0/7] arm64: PSR <-> SPSR_ELx mapping fixes
Message-ID: <20180705141654.8714-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPSR_ELx format has diverged from the AArch32-native SPSR format since the
addition of DIT. Thus, we need to map between the two for certain compat
operations.

Also, when we added support for DIT, we forgot to account for this in
valid_user_regs(), causing PSTATE.DIT to be cleared upon sigreturn.

These patches (based on v4.18-rc2) fix those issues, cleaning up the COMPAT_PSR
definitions to try to avoid confusiong in future.

The COMPAT_PSR_ definitions are now used for the AArch32-native SPR format
(i.e. they are the compat userspace view), with PSR_AA32_ definitions used for
the AArch64 view of the PSR for AArch32 tasks.

Since v1 [1]:
* Fix compat_restore_sigframe() pstate mangling
* Fix dangling reference to COMPAT_PSR_T_BIT
* Move static inlines into #ifndef __ASSEMBLY__ block
* Accumulate acks

Will, I've verified that each patch in this series builds fine (building with
defconfig), and works fine on my Juno board. Sorry again for the mess with v1.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586136.html

Mark Rutland (7):
  arm64: add PSR_AA32_* definitions
  arm64: don't zero DIT on signal return
  arm64: compat: map SPSR_ELx<->PSR for signals
  arm64: ptrace: map SPSR_ELx<->PSR for compat tasks
  arm64: use PSR_AA32 definitions
  kvm/arm: use PSR_AA32 definitions
  arm64: remove unused COMPAT_PSR definitions

 arch/arm/include/asm/kvm_emulate.h       | 14 +++---
 arch/arm64/include/asm/kvm_emulate.h     | 10 ++--
 arch/arm64/include/asm/processor.h       |  6 +--
 arch/arm64/include/asm/ptrace.h          | 79 +++++++++++++++++++++-----------
 arch/arm64/kernel/armv8_deprecated.c     | 24 +++++-----
 arch/arm64/kernel/cpufeature.c           |  2 +-
 arch/arm64/kernel/process.c              | 20 ++++----
 arch/arm64/kernel/ptrace.c               | 34 ++++++++------
 arch/arm64/kernel/signal32.c             | 18 +++++---
 arch/arm64/kvm/guest.c                   | 14 +++---
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  2 +-
 arch/arm64/kvm/regmap.c                  | 22 ++++-----
 arch/arm64/kvm/reset.c                   |  4 +-
 virt/kvm/arm/aarch32.c                   | 20 ++++----
 14 files changed, 153 insertions(+), 116 deletions(-)

-- 
2.11.0
