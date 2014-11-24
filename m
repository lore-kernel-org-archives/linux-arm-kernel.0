From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Mon, 24 Nov 2014 23:26:36 +0200
Subject: [RFC PATCH 0/5] ARM: KVM: Enable the ioeventfd capability of KVM on
 ARM
Message-ID: <20141124212240.10605.46770.stgit@i3820>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOEVENTFD KVM capability is a prerequisite for vhost support,
and is also used to implement improved interrupt handling in VFIO drivers.

This series enables the ioeventfd KVM capability on ARM.

The implementation routes MMIO access in the IO abort handler to the KVM IO bus.
If there is already a registered ioeventfd handler for this address, the file
descriptor will be triggered.

We extended the KVM IO bus API to expose the VCPU struct pointer. Now the VGIC
MMIO access is done through this API. For this to operate the VGIC registers a
kvm_io_device which reprresents the whole MMIO region.

The patches are implemented on top of the latest Andre's vGICv3 work from here:
http://www.linux-arm.org/git?p=linux-ap.git;a=shortlog;h=refs/heads/kvm-gicv3/v4

The code was tested on Dual Cortex-A15 Exynos5250 (ARM Chromebook).

---

Nikolay Nikolaev (5):
      KVM: redesing kvm_io_bus_ API to pass VCPU structure to the callbacks.
      ARM: on IO mem abort - route the call to KVM MMIO bus
      KVM: ARM VGIC add kvm_io_bus_ frontend
      ARM: enable linking against eventfd and irqchip
      ARM: enable KVM_CAP_IOEVENTFD


 arch/arm/kvm/Kconfig       |    1 +
 arch/arm/kvm/Makefile      |    2 +
 arch/arm/kvm/arm.c         |    3 ++
 arch/arm/kvm/mmio.c        |   32 ++++++++++++++++
 arch/ia64/kvm/kvm-ia64.c   |    4 +-
 arch/powerpc/kvm/powerpc.c |    4 +-
 arch/s390/kvm/diag.c       |    2 +
 arch/x86/kvm/vmx.c         |    2 +
 arch/x86/kvm/x86.c         |   11 +++---
 include/kvm/arm_vgic.h     |    3 +-
 include/linux/kvm_host.h   |   10 +++--
 virt/kvm/arm/vgic.c        |   88 +++++++++++++++++++++++++++++++++++++-------
 virt/kvm/coalesced_mmio.c  |    5 ++-
 virt/kvm/eventfd.c         |    4 +-
 virt/kvm/iodev.h           |   23 ++++++++----
 virt/kvm/kvm_main.c        |   32 ++++++++--------
 16 files changed, 163 insertions(+), 63 deletions(-)

--
Signature
