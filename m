From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 15 Apr 2016 18:11:30 +0100
Subject: [PATCH 19/45] KVM: arm/arm64: vgic-new: Add CONFIG registers handlers
In-Reply-To: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
References: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1460740316-8755-20-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_mmio.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
index 3c3dbce..a8a96c8 100644
--- a/virt/kvm/arm/vgic/vgic_mmio.c
+++ b/virt/kvm/arm/vgic/vgic_mmio.c
@@ -477,6 +477,66 @@ static int vgic_mmio_write_priority(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int vgic_mmio_read_config(struct kvm_vcpu *vcpu,
+				 struct kvm_io_device *dev,
+				 gpa_t addr, int len, void *val)
+{
+	struct vgic_io_device *iodev = container_of(dev,
+						    struct vgic_io_device, dev);
+	u32 intid = (addr & 0xff) * 4;
+	u32 value = 0;
+	int i;
+
+	if (iodev->redist_vcpu)
+		vcpu = iodev->redist_vcpu;
+
+	for (i = 0; i < len * 4; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		if (irq->config == VGIC_CONFIG_EDGE)
+			value |= (2U << (i * 2));
+	}
+
+	write_mask32(value, addr & 3, len, val);
+	return 0;
+}
+
+static int vgic_mmio_write_config(struct kvm_vcpu *vcpu,
+				  struct kvm_io_device *dev,
+				  gpa_t addr, int len, const void *val)
+{
+	struct vgic_io_device *iodev = container_of(dev,
+						    struct vgic_io_device, dev);
+	u32 intid = (addr & 0xff) * 4;
+	int i;
+
+	if (iodev->redist_vcpu)
+		vcpu = iodev->redist_vcpu;
+
+	for (i = 0; i < len * 4; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		if (intid + i < 16)
+			continue;
+
+		/*
+		 * The spec says that interrupts must be disabled before
+		 * changing the configuration to avoid UNDEFINED behaviour.
+		 */
+
+		spin_lock(&irq->irq_lock);
+		if (test_bit(i * 2 + 1, val)) {
+			irq->config = VGIC_CONFIG_EDGE;
+		} else {
+			irq->config = VGIC_CONFIG_LEVEL;
+			irq->pending = irq->line_level | irq->soft_pending;
+		}
+		spin_unlock(&irq->irq_lock);
+	}
+
+	return 0;
+}
+
 struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_CTRL,
 		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12),
@@ -499,7 +559,7 @@ struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_TARGET,
 		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 8),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_CONFIG,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 8),
+		vgic_mmio_read_config, vgic_mmio_write_config, 2),
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SOFTINT,
 		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 4),
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_SGI_PENDING_CLEAR,
-- 
2.7.3
