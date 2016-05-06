From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  6 May 2016 11:45:44 +0100
Subject: [PATCH v3 31/55] KVM: arm/arm64: vgic-new: Add SGIPENDR register
 handlers
In-Reply-To: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462531568-9799-32-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As this register is v2 specific, its implementation lives entirely
in vgic-mmio-v2.c.
This register allows setting the source mask of an IPI.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Changelog RFC..v1:
- remove IRQ lock from read handler
- update pending bit on setting the first / clearing the last bit
- queue virtual IRQ if necessary

Changelog v1 .. v2:
- adapt to new MMIO framework

 virt/kvm/arm/vgic/vgic-mmio-v2.c | 62 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index 8f8ea57..8006ac0 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -148,6 +148,64 @@ static void vgic_mmio_write_target(struct kvm_vcpu *vcpu,
 	}
 }
 
+static unsigned long vgic_mmio_read_sgipend(struct kvm_vcpu *vcpu,
+					    gpa_t addr, unsigned int len)
+{
+	u32 intid = addr & 0x0f;
+	int i;
+	u64 val = 0;
+
+	for (i = 0; i < len; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		val |= (u64)irq->source << (i * 8);
+	}
+	return val;
+}
+
+static void vgic_mmio_write_sgipendc(struct kvm_vcpu *vcpu,
+				     gpa_t addr, unsigned int len,
+				     unsigned long val)
+{
+	u32 intid = addr & 0x0f;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+
+		irq->source &= ~((val >> (i * 8)) & 0xff);
+		if (!irq->source)
+			irq->pending = false;
+
+		spin_unlock(&irq->irq_lock);
+	}
+}
+
+static void vgic_mmio_write_sgipends(struct kvm_vcpu *vcpu,
+				     gpa_t addr, unsigned int len,
+				     unsigned long val)
+{
+	u32 intid = addr & 0x0f;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+
+		irq->source |= (val >> (i * 8)) & 0xff;
+
+		if (irq->source) {
+			irq->pending = true;
+			vgic_queue_irq_unlock(vcpu->kvm, irq);
+		} else {
+			spin_unlock(&irq->irq_lock);
+		}
+	}
+}
+
 static const struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_CTRL,
 		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12),
@@ -174,9 +232,9 @@ static const struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SOFTINT,
 		vgic_mmio_read_raz, vgic_mmio_write_sgir, 4),
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SGI_PENDING_CLEAR,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, 16),
+		vgic_mmio_read_sgipend, vgic_mmio_write_sgipendc, 16),
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SGI_PENDING_SET,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, 16),
+		vgic_mmio_read_sgipend, vgic_mmio_write_sgipends, 16),
 };
 
 unsigned int vgic_v2_init_dist_iodev(struct vgic_io_device *dev)
-- 
2.7.3
