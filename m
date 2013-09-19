From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 19 Sep 2013 18:41:37 +0530
Subject: [PATCH v3 0/4] Target CPU=Host implementation for KVM ARM/ARM64
Message-ID: <1379596302-21522-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will be very useful for user space (QEMU/KVMTOOL) if it has a
method of querying VCPU target type matching to underlying Host. 
We can use such querying mechanism and implement machine models
in user space where VCPU target type is always same-as/similar-to
underlying Host (i.e. Target CPU=Host).

This patch series implements KVM_ARM_PREFERRED_TARGET vm ioclt for
querying VCPU target type matching underlying host. Using this new
ioctl we can implement VCPU target CPU=Host in user space.

Also, it is not mandatory to call KVM_ARM_PREFERRED_TARGET vm ioctl
and the old method of trying all possible target types using the
KVM_ARM_VCPU_INIT ioctl to initialize VCPU works fine.

V3:
 - Return -ENODEV if no preferred target available for host
 - Make KVM_ARM_PREFERRED_TARGET ioctl as vm ioctl

V2:
 - Renamed the ioclt to KVM_ARM_PREFERRED_TARGET
 - Return struct kvm_vcpu_init instace instead of just target type

V1:
 - Initial patch-set with ioctl named as KVM_ARM_SUITABLE_TARGET

Anup Patel (4):
  ARM: KVM: Implement kvm_vcpu_preferred_target() function
  ARM64: KVM: Implement kvm_vcpu_preferred_target() function
  ARM/ARM64: KVM: Implement KVM_ARM_PREFERRED_TARGET ioctl
  KVM: Add documentation for KVM_ARM_PREFERRED_TARGET ioctl

 Documentation/virtual/kvm/api.txt |   26 ++++++++++++++++++++++----
 arch/arm/include/asm/kvm_host.h   |    1 +
 arch/arm/kvm/arm.c                |   13 +++++++++++++
 arch/arm/kvm/guest.c              |   20 ++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |    1 +
 arch/arm64/kvm/guest.c            |   21 +++++++++++++++++++++
 include/uapi/linux/kvm.h          |    1 +
 7 files changed, 79 insertions(+), 4 deletions(-)

-- 
1.7.9.5
