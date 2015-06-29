From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 29 Jun 2015 17:37:10 +0200
Subject: [PATCH 0/7] KVM: arm/arm64: gsi routing support
Message-ID: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the advent of GICv3 ITS in-kernel emulation, KVM GSI routing
appears to be requested. More specifically MSI routing is needed.
irqchip routing does not sound to be really useful on arm but usage of
MSI routing also mandates to integrate irqchip routing. The initial
implementation of irqfd on arm must be upgraded with the integration
of kvm irqchip.c code and the implementation of its standard hooks
in the architecture specific part.

In case KVM_SET_GSI_ROUTING ioctl is not called, a default routing
table with flat irqchip routing entries is built enabling to inject gsi
corresponding to the SPI indexes seen by the guest.

As soon as KVM_SET_GSI_ROUTING is called, user-space overwrites this
default routing table and is responsible for building the whole routing
table.

for arm/arm64 KVM_SET_GSI_ROUTING has a limited support:
- only applies to KVM_IRQFD and not to KVM_IRQ_LINE

- irqchip routing was tested on Calxeda midway (VFIO with irqfd)
- MSI routing without GICv3 ITS was tested using APM Xgene-I
  (qemu VIRTIO-PCI vhost net without gsi_direct_mapping).
- MSI routing with GICv2 ITS is NOT yet tested.

Code can be found at https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.1-gsi-routing-patch

It applies on Andre's [PATCH 00/13] arm64: KVM: GICv3 ITS emulation
(http://www.spinics.net/lists/kvm/msg117402.html)

History:

RFC -> PATCH:
- clearly state limited support on arm/arm64:
  KVM_IRQ_LINE not impacted by GSI routing
- add default routing table feature (new patch file)
- changed uapi to use padding field area
- reword api.txt


Eric Auger (7):
  KVM: api: add kvm_irq_routing_extended_msi
  KVM: kvm_host: add kvm_extended_msi
  KVM: irqchip: convey devid to kvm_set_msi
  KVM: arm/arm64: enable irqchip routing
  KVM: arm/arm64: build a default routing table
  KVM: arm/arm64: enable MSI routing
  KVM: arm: implement kvm_set_msi by gsi direct mapping

 Documentation/virtual/kvm/api.txt |  30 ++++++++--
 arch/arm/include/asm/kvm_host.h   |   2 +
 arch/arm/kvm/Kconfig              |   3 +
 arch/arm/kvm/Makefile             |   2 +-
 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/kvm/Kconfig            |   2 +
 arch/arm64/kvm/Makefile           |   2 +-
 include/kvm/arm_vgic.h            |   9 ---
 include/linux/kvm_host.h          |  10 ++++
 include/uapi/linux/kvm.h          |   6 +-
 virt/kvm/arm/vgic.c               | 117 ++++++++++++++++++++++++++++----------
 virt/kvm/irqchip.c                |  20 +++++--
 12 files changed, 154 insertions(+), 50 deletions(-)

-- 
1.9.1
