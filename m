From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  4 Feb 2014 15:18:12 +0530
Subject: [PATCH v3 0/4] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
Message-ID: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
and Coordination Interface (PSCI) v0.1.

This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
such that it does not break current KVM ARM/ARM64 ABI. Also, the patchset
provides emulation of only few PSCI v0.2 functions such as PSCI_VERSION,
CPU_ON, and CPU_OFF. Emulation of other PSCI v0.2 functions will be added
later.

The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
PSCI v0.2 to VCPUs.

Changlog:

V3:
 - Make KVM_ARM_VCPU_PSCI_0_2 feature experiementatl for now so that
   it fails for user space till all mandatory PSCI v0.2 functions are
   emulated by KVM ARM/ARM64
 - Have separate patch for making KVM_ARM_VCPU_PSCI_0_2 feature available
   to user space. This patch can be defferred for now.

V2:
 - Don't rename PSCI return values KVM_PSCI_RET_NI and KVM_PSCI_RET_INVAL
 - Added kvm_psci_version() to get PSCI version available to VCPU
 - Fixed grammer in Documentation/virtual/kvm/api.txt

V1:
 - Initial RFC PATCH

Anup Patel (4):
  ARM/ARM64: KVM: Add support for PSCI v0.2 emulation
  KVM: Add capability to advertise PSCI v0.2 support
  KVM: Documentation: Add info regarding KVM_ARM_VCPU_PSCI_0_2 feature
  ARM/ARM64: KVM: Allow KVM_ARM_VCPU_PSCI_0_2 feature for user space

 Documentation/virtual/kvm/api.txt |    2 +
 arch/arm/include/asm/kvm_host.h   |    2 +-
 arch/arm/include/asm/kvm_psci.h   |    4 ++
 arch/arm/include/uapi/asm/kvm.h   |   35 ++++++++++++++-
 arch/arm/kvm/arm.c                |    1 +
 arch/arm/kvm/psci.c               |   85 +++++++++++++++++++++++++++++++------
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/include/asm/kvm_psci.h |    4 ++
 arch/arm64/include/uapi/asm/kvm.h |   35 ++++++++++++++-
 include/uapi/linux/kvm.h          |    1 +
 10 files changed, 155 insertions(+), 16 deletions(-)

-- 
1.7.9.5
