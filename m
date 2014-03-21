From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 21 Mar 2014 18:23:23 +0530
Subject: [PATCH v5 00/11] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
Message-ID: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
and Coordination Interface (PSCI) v0.1.

This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
such that it does not break current KVM ARM/ARM64 ABI.

The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
PSCI v0.2 to VCPUs.

Changlog:

V5:
 - Have separate last patch to advertise KVM_CAP_ARM_PSCI_0_2
 - Use kvm_psci_version() in kvm_psci_vcpu_on()
 - Return ALREADY_ON for PSCI v0.2 CPU_ON if VCPU is not paused
 - Remove per-VCPU suspend context
 - As-per PSCI v0.2 spec, only current CPU can suspend itself

V4:
 - Implement all mandatory functions required by PSCI v0.2

V3:
 - Make KVM_ARM_VCPU_PSCI_0_2 feature experiementatl for now so that
   it fails for user space till all mandatory PSCI v0.2 functions are
   emulated by KVM ARM/ARM64
 - Have separate patch for making KVM_ARM_VCPU_PSCI_0_2 feature available
   to user space. This patch can be defferred for now

V2:
 - Don't rename PSCI return values KVM_PSCI_RET_NI and KVM_PSCI_RET_INVAL
 - Added kvm_psci_version() to get PSCI version available to VCPU
 - Fixed grammer in Documentation/virtual/kvm/api.txt

V1:
 - Initial RFC PATCH

Anup Patel (11):
  KVM: Add capability to advertise PSCI v0.2 support
  ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
  KVM: Documentation: Add info regarding KVM_ARM_VCPU_PSCI_0_2 feature
  ARM/ARM64: KVM: Make kvm_psci_call() return convention more flexible
  KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API header
  ARM/ARM64: KVM: Emulate PSCI v0.2 SYSTEM_OFF and SYSTEM_RESET
  ARM/ARM64: KVM: Emulate PSCI v0.2 AFFINITY_INFO
  ARM/ARM64: KVM: Emulate PSCI v0.2 MIGRATE_INFO_TYPE and related
    functions
  ARM/ARM64: KVM: Fix CPU_ON emulation for PSCI v0.2
  ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
  ARM/ARM64: KVM: Advertise KVM_CAP_ARM_PSCI_0_2 to user space

 Documentation/virtual/kvm/api.txt |   17 +++
 arch/arm/include/asm/kvm_host.h   |    2 +-
 arch/arm/include/asm/kvm_psci.h   |    6 +-
 arch/arm/include/uapi/asm/kvm.h   |   35 +++++-
 arch/arm/kvm/arm.c                |    1 +
 arch/arm/kvm/handle_exit.c        |   10 +-
 arch/arm/kvm/psci.c               |  220 ++++++++++++++++++++++++++++++++++---
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/include/asm/kvm_psci.h |    6 +-
 arch/arm64/include/uapi/asm/kvm.h |   35 +++++-
 arch/arm64/kvm/handle_exit.c      |   10 +-
 include/uapi/linux/kvm.h          |    9 ++
 12 files changed, 326 insertions(+), 27 deletions(-)

-- 
1.7.9.5
