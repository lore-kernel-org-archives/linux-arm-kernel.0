From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:18:46 +0200
Subject: [GIT PULL] KVM/ARM and PSCI v0.2 Changes for 3.16
Message-ID: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Gleb,

The following changes since commit 198c74f43f0f5473f99967aead30ddc622804bc1:

  KVM: MMU: flush tlb out of mmu lock when write-protect the sptes (2014-04-23 17:49:52 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.16

for you to fetch changes up to 1252b3313642c3d0dff5b951b625468bf0dcd059:

  arm64: KVM: Enable minimalistic support for Cortex-A53 (2014-05-25 20:05:30 +0200)

----------------------------------------------------------------
Changed for the 3.16 merge window.

This includes KVM support for PSCI v0.2 and also includes generic Linux
support for PSCI v0.2 (on hosts that advertise that feature via their
DT), since the latter depends on headers introduced by the former.

Finally there's a small patch from Marc that enables Cortex-A53 support.

----------------------------------------------------------------
Anup Patel (12):
      KVM: Add capability to advertise PSCI v0.2 support
      ARM/ARM64: KVM: Add common header for PSCI related defines
      ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
      KVM: Documentation: Add info regarding KVM_ARM_VCPU_PSCI_0_2 feature
      ARM/ARM64: KVM: Make kvm_psci_call() return convention more flexible
      KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API header
      ARM/ARM64: KVM: Emulate PSCI v0.2 SYSTEM_OFF and SYSTEM_RESET
      ARM/ARM64: KVM: Emulate PSCI v0.2 AFFINITY_INFO
      ARM/ARM64: KVM: Emulate PSCI v0.2 MIGRATE_INFO_TYPE and related functions
      ARM/ARM64: KVM: Fix CPU_ON emulation for PSCI v0.2
      ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
      ARM/ARM64: KVM: Advertise KVM_CAP_ARM_PSCI_0_2 to user space

Ashwin Chaugule (3):
      PSCI: Add initial support for PSCIv0.2 functions
      Documentation: devicetree: Add new binding for PSCIv0.2
      ARM: Check if a CPU has gone offline

Marc Zyngier (1):
      arm64: KVM: Enable minimalistic support for Cortex-A53

 Documentation/devicetree/bindings/arm/psci.txt |  37 +++-
 Documentation/virtual/kvm/api.txt              |  17 ++
 arch/arm/include/asm/kvm_host.h                |   2 +-
 arch/arm/include/asm/kvm_psci.h                |   6 +-
 arch/arm/include/asm/psci.h                    |   7 +-
 arch/arm/include/uapi/asm/kvm.h                |  10 +-
 arch/arm/kernel/psci.c                         | 196 +++++++++++++++++----
 arch/arm/kernel/psci_smp.c                     |  33 ++++
 arch/arm/kvm/arm.c                             |   1 +
 arch/arm/kvm/handle_exit.c                     |  10 +-
 arch/arm/kvm/psci.c                            | 235 +++++++++++++++++++++++--
 arch/arm64/include/asm/cpu_ops.h               |   2 +
 arch/arm64/include/asm/cputype.h               |   1 +
 arch/arm64/include/asm/kvm_host.h              |   2 +-
 arch/arm64/include/asm/kvm_psci.h              |   6 +-
 arch/arm64/include/asm/psci.h                  |   2 +-
 arch/arm64/include/uapi/asm/kvm.h              |  13 +-
 arch/arm64/kernel/psci.c                       | 231 ++++++++++++++++++++----
 arch/arm64/kernel/smp.c                        |  22 +++
 arch/arm64/kvm/guest.c                         |   2 +
 arch/arm64/kvm/handle_exit.c                   |  10 +-
 arch/arm64/kvm/sys_regs_generic_v8.c           |   2 +
 include/uapi/linux/Kbuild                      |   1 +
 include/uapi/linux/kvm.h                       |   9 +
 include/uapi/linux/psci.h                      |  90 ++++++++++
 25 files changed, 831 insertions(+), 116 deletions(-)
 create mode 100644 include/uapi/linux/psci.h
