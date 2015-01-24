From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 24 Jan 2015 13:59:24 +0200
Subject: [PATCH v3 0/5] ARM: KVM: Enable the ioeventfd capability of KVM on ARM
Message-ID: <20150124115815.11052.20755.stgit@i3820>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOEVENTFD KVM capability is a prerequisite for vhost support.

This series enables the ioeventfd KVM capability on ARM.

The implementation routes MMIO access in the IO abort handler to the KVM IO bus.
If there is already a registered ioeventfd handler for this address, the file
descriptor will be triggered.

We extended the KVM IO bus API to expose the VCPU struct pointer. Now the VGIC
MMIO access is done through this API. For this to operate the VGIC registers a
kvm_io_device which represents the whole dist MMIO region.

The code was tested on Dual Cortex-A15 Exynos5250 (ARM Chromebook).
ARM64 build was verified, but not run on actual HW.

Changes since v2:
 - rebased on top of kvmarm/next
 - moved vgic_register_kvm_io_dev to kvm_vgic_map_resources

Changes since v1:
 - fixed x86 compilation
 - GICv2/GICv3 dist base selection
 - added vgic_unregister_kvm_io_dev to free the iodev resources
 - enable eventfd on ARM64

---

Nikolay Nikolaev (5):
      KVM: Redesign kvm_io_bus_ API to pass VCPU structure to the callbacks.
      KVM: ARM: on IO mem abort - route the call to KVM MMIO bus
      KVM: ARM VGIC add kvm_io_bus_ frontend
      ARM/ARM64: enable linking against eventfd
      ARM: enable KVM_CAP_IOEVENTFD


 arch/arm/kvm/Kconfig       |    1 
 arch/arm/kvm/Makefile      |    2 -
 arch/arm/kvm/arm.c         |    3 +
 arch/arm/kvm/mmio.c        |   32 +++++++++++
 arch/arm64/kvm/Kconfig     |    1 
 arch/arm64/kvm/Makefile    |    2 -
 arch/powerpc/kvm/mpic.c    |   10 ++--
 arch/powerpc/kvm/powerpc.c |    4 +
 arch/s390/kvm/diag.c       |    2 -
 arch/x86/kvm/i8254.c       |   14 +++--
 arch/x86/kvm/i8259.c       |   12 ++--
 arch/x86/kvm/ioapic.c      |    8 +--
 arch/x86/kvm/lapic.c       |    4 +
 arch/x86/kvm/vmx.c         |    2 -
 arch/x86/kvm/x86.c         |   13 +++--
 include/kvm/arm_vgic.h     |    3 -
 include/linux/kvm_host.h   |   10 ++--
 virt/kvm/arm/vgic.c        |  123 ++++++++++++++++++++++++++++++++++++++++----
 virt/kvm/coalesced_mmio.c  |    5 +-
 virt/kvm/eventfd.c         |    4 +
 virt/kvm/iodev.h           |   23 +++++---
 virt/kvm/kvm_main.c        |   32 ++++++-----
 22 files changed, 231 insertions(+), 79 deletions(-)

--
Signature
