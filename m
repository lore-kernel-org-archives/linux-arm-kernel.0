From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 15 Apr 2016 18:11:33 +0100
Subject: [PATCH 22/45] KVM: arm/arm64: vgic-new: Add SGIPENDR register handlers
In-Reply-To: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
References: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1460740316-8755-23-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog RFC..v1:
- remove IRQ lock from read handler
- update pending bit on setting the first / clearing the last bit
- queue virtual IRQ if necessary
---
 virt/kvm/arm/vgic/vgic_mmio.c | 64 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
index 83641b3..daa2e00 100644
--- a/virt/kvm/arm/vgic/vgic_mmio.c
+++ b/virt/kvm/arm/vgic/vgic_mmio.c
@@ -624,6 +624,66 @@ static int vgic_mmio_write_sgir(struct kvm_vcpu *source_vcpu,
 	return 0;
 }
 
+static int vgic_mmio_read_sgipend(struct kvm_vcpu *vcpu,
+				  struct kvm_io_device *dev,
+				  gpa_t addr, int len, void *val)
+{
+	u32 intid = addr & 0x0f;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		((u8 *)val)[i] = irq->source;
+	}
+	return 0;
+}
+
+static int vgic_mmio_write_sgipendc(struct kvm_vcpu *vcpu,
+				    struct kvm_io_device *dev,
+				    gpa_t addr, int len, const void *val)
+{
+	u32 intid = addr & 0x0f;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+
+		irq->source &= ~((u8 *)val)[i];
+		if (!irq->source)
+			irq->pending = false;
+
+		spin_unlock(&irq->irq_lock);
+	}
+	return 0;
+}
+
+static int vgic_mmio_write_sgipends(struct kvm_vcpu *vcpu,
+				    struct kvm_io_device *dev,
+				    gpa_t addr, int len, const void *val)
+{
+	u32 intid = addr & 0x0f;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+
+		irq->source |= ((u8 *)val)[i];
+
+		if (irq->source) {
+			irq->pending = true;
+			vgic_queue_irq_unlock(vcpu->kvm, irq);
+		} else {
+			spin_unlock(&irq->irq_lock);
+		}
+	}
+	return 0;
+}
+
 struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_CTRL,
 		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12),
@@ -650,9 +710,9 @@ struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SOFTINT,
 		vgic_mmio_read_raz, vgic_mmio_write_sgir, 4),
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SGI_PENDING_CLEAR,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 16),
+		vgic_mmio_read_sgipend, vgic_mmio_write_sgipendc, 16),
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SGI_PENDING_SET,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 16),
+		vgic_mmio_read_sgipend, vgic_mmio_write_sgipends, 16),
 };
 
 /* Find the proper register handler entry given a certain address offset. */
-- 
2.7.3
