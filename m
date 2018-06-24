From: christoffer.dall@arm.com (Christoffer Dall)
Date: Mon, 25 Jun 2018 00:11:03 +0200
Subject: [PATCH 4/4] KVM: arm/arm64: vgic: Allow VMs to configure interrupt
 groups
In-Reply-To: <20180624221103.15055-1-christoffer.dall@arm.com>
References: <20180624221103.15055-1-christoffer.dall@arm.com>
Message-ID: <20180624221103.15055-5-christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the required MMIO accessors for GICv2 and GICv3 for the
IGROUPR distributor and redistributor registers.

This can allow guests to change behavior compared to running on previous
versions of KVM, but only to align with the architecture and hardware
implementations.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  2 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  2 +-
 virt/kvm/arm/vgic/vgic-mmio.c    | 38 ++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic-mmio.h    |  6 +++++
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index 8d18f89397d3..ff3834d16ac9 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -362,7 +362,7 @@ static const struct vgic_register_region vgic_v2_dist_registers[] = {
 		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_IGROUP,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, NULL, NULL, 1,
+		vgic_mmio_read_group, vgic_mmio_write_group, NULL, NULL, 1,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ENABLE_SET,
 		vgic_mmio_read_enable, vgic_mmio_write_senable, NULL, NULL, 1,
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 287784095b5b..76e422859745 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -451,7 +451,7 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
 		vgic_mmio_read_rao, vgic_mmio_write_wi, 4,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_IGROUPR,
-		vgic_mmio_read_rao, vgic_mmio_write_wi, NULL, NULL, 1,
+		vgic_mmio_read_group, vgic_mmio_write_group, NULL, NULL, 1,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ISENABLER,
 		vgic_mmio_read_enable, vgic_mmio_write_senable, NULL, NULL, 1,
diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index ff9655cfeb2f..ae31bd0dd365 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -40,6 +40,44 @@ void vgic_mmio_write_wi(struct kvm_vcpu *vcpu, gpa_t addr,
 	/* Ignore */
 }
 
+unsigned long vgic_mmio_read_group(struct kvm_vcpu *vcpu,
+				   gpa_t addr, unsigned int len)
+{
+	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
+	u32 value = 0;
+	int i;
+
+	/* Loop over all IRQs affected by this read */
+	for (i = 0; i < len * 8; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		if (irq->group)
+			value |= BIT(i);
+
+		vgic_put_irq(vcpu->kvm, irq);
+	}
+
+	return value;
+}
+
+void vgic_mmio_write_group(struct kvm_vcpu *vcpu, gpa_t addr,
+			   unsigned int len, unsigned long val)
+{
+	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
+	int i;
+	unsigned long flags;
+
+	for (i = 0; i < len * 8; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock_irqsave(&irq->irq_lock, flags);
+		irq->group = !!(val & BIT(i));
+		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
+
+		vgic_put_irq(vcpu->kvm, irq);
+	}
+}
+
 /*
  * Read accesses to both GICD_ICENABLER and GICD_ISENABLER return the value
  * of the enabled bit, so there is only one function for both here.
diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
index 5693f6df45ec..10798625f9ce 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.h
+++ b/virt/kvm/arm/vgic/vgic-mmio.h
@@ -134,6 +134,12 @@ unsigned long vgic_mmio_read_rao(struct kvm_vcpu *vcpu,
 void vgic_mmio_write_wi(struct kvm_vcpu *vcpu, gpa_t addr,
 			unsigned int len, unsigned long val);
 
+unsigned long vgic_mmio_read_group(struct kvm_vcpu *vcpu, gpa_t addr,
+				   unsigned int len);
+
+void vgic_mmio_write_group(struct kvm_vcpu *vcpu, gpa_t addr,
+			   unsigned int len, unsigned long val);
+
 unsigned long vgic_mmio_read_enable(struct kvm_vcpu *vcpu,
 				    gpa_t addr, unsigned int len);
 
-- 
2.17.1
