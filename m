From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 12:08:59 +0100
Subject: [PATCH v3 0/9] arm/arm64: KVM: dynamic VGIC sizing
Message-ID: <1404817748-31302-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, the VGIC data structures have been statically sized, meaning
that we always have to support more interrupts than we actually want,
and more CPU interfaces than we should. This is a waste of resource,
and is the kind of things that should be tuneable.

This series addresses that issue by changing the data structures to be
dynamically allocated, and adds a new configuration attribute to
allocate the number of interrupts. When the attribute is not used, we
fallback to the old behaviour of allocating a fixed number of
interrupts.

The last patch of the series is a bit out of context, but tends to fit
well here code-wise. It solves an interesting issue having to do with
the placement of the GICV interface in Stage-2 when using 64k pages
(if the HW is not 64k aligned, we need to tell userspace about the
"sub-page offset" so it can correctly place the guest's GICC
region). This allows (together with the right userspace fix) to
correctly boot a guest on a 64k host kernel on a Juno platform.

This series is also the base for Andre Przywara's GICv3 distributor
emulation code (which can support far more than 8 vcpus and 1020
interrupts).

This has been tested on both ARM (TC2) and arm64 (model and Juno).

* From v2 [2]
  - Fixed bug that broke QEMU (register access can trigger allocation)
  - irq_pending_on_cpu is now dynamic (needed for more than 32 or 64 vcpus)
  - Rebased on top of Victor's BE patches

* From v1 [1]
  - Rebased on top of 3.16-rc1
  - Lots of cleanup
  
[1]: https://lists.cs.columbia.edu/pipermail/kvmarm/2013-October/005879.html
[2]: https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010050.html

Marc Zyngier (9):
  KVM: ARM: vgic: plug irq injection race
  arm/arm64: KVM: vgic: switch to dynamic allocation
  arm/arm64: KVM: vgic: Parametrize VGIC_NR_SHARED_IRQS
  arm/arm64: KVM: vgic: kill VGIC_MAX_CPUS
  arm/arm64: KVM: vgic: handle out-of-range MMIO accesses
  arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
  arm/arm64: KVM: vgic: delay vgic allocation until init time
  arm/arm64: KVM: vgic: make number of irqs a configurable attribute
  arm64: KVM: vgic: deal with GIC sub-page alignment

 arch/arm/include/uapi/asm/kvm.h   |   2 +
 arch/arm/kvm/arm.c                |  10 +-
 arch/arm64/include/uapi/asm/kvm.h |   2 +
 include/kvm/arm_vgic.h            |  56 +++---
 virt/kvm/arm/vgic.c               | 390 ++++++++++++++++++++++++++++++++------
 5 files changed, 368 insertions(+), 92 deletions(-)

-- 
2.0.0
