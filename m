From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Sep 2014 12:09:07 +0100
Subject: [PATCH v4 0/8] arm/arm64: KVM: dynamic VGIC sizing
Message-ID: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
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

This series is also the base for Andre Przywara's GICv3 distributor
emulation code (which can support far more than 8 vcpus and 1020
interrupts).

This has been tested on both ARM (TC2, A20) and arm64 (model and Juno).

The code is available from my kvm-arm64/kvmtool-vgic-dyn branch,
together with the corresponding kvmtool code.

* From v3 [3]
  - Number of comments added to the data structures, making slightly more
    obvious the various mappings
  - Dropped the nr_irqs field from bitmap and bytemap structures, as
    it was a leftover from the initial revision that only had a single
    pointer
  - Small cleanups all over the place
  - Dropped the "sub-page offset" patch for now, as this need some
    serious reworking
  - Rebased on top of Christoffer "vgic cleanup" series, with 3.17-rc4
    thrown in for a good measure

* From v2 [2]
  - Fixed bug that broke QEMU (register access can trigger allocation)
  - irq_pending_on_cpu is now dynamic (needed for more than 32 or 64 vcpus)
  - Rebased on top of Victor's BE patches

* From v1 [1]
  - Rebased on top of 3.16-rc1
  - Lots of cleanup

[1]: https://lists.cs.columbia.edu/pipermail/kvmarm/2013-October/005879.html
[2]: https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010050.html
[3]: https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010383.html

Marc Zyngier (8):
  KVM: ARM: vgic: plug irq injection race
  arm/arm64: KVM: vgic: switch to dynamic allocation
  arm/arm64: KVM: vgic: Parametrize VGIC_NR_SHARED_IRQS
  arm/arm64: KVM: vgic: kill VGIC_MAX_CPUS
  arm/arm64: KVM: vgic: handle out-of-range MMIO accesses
  arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
  arm/arm64: KVM: vgic: delay vgic allocation until init time
  arm/arm64: KVM: vgic: make number of irqs a configurable attribute

 Documentation/virtual/kvm/devices/arm-vgic.txt |  10 +
 arch/arm/include/uapi/asm/kvm.h                |   1 +
 arch/arm/kvm/arm.c                             |  10 +-
 arch/arm64/include/uapi/asm/kvm.h              |   1 +
 include/kvm/arm_vgic.h                         |  88 ++++--
 virt/kvm/arm/vgic.c                            | 396 +++++++++++++++++++++----
 6 files changed, 413 insertions(+), 93 deletions(-)

-- 
2.0.4
