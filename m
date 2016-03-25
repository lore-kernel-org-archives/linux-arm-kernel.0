From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:04:41 +0000
Subject: [RFC PATCH 18/45] KVM: arm/arm64: vgic-new: Add ACTIVE registers
 handlers
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-19-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_mmio.c | 81 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
index 788e186..bfc530c 100644
--- a/virt/kvm/arm/vgic/vgic_mmio.c
+++ b/virt/kvm/arm/vgic/vgic_mmio.c
@@ -289,6 +289,83 @@ static int vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int vgic_mmio_read_active(struct kvm_vcpu *vcpu,
+				 struct kvm_io_device *this,
+				 gpa_t addr, int len, void *val)
+{
+	struct vgic_io_device *iodev = container_of(this,
+						    struct vgic_io_device, dev);
+	u32 intid = (addr - iodev->base_addr) * 8;
+	u32 value = 0;
+	int i;
+
+	if (iodev->redist_vcpu)
+		vcpu = iodev->redist_vcpu;
+
+	/* Loop over all IRQs affected by this read */
+	for (i = 0; i < len * 8; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+		if (irq->active)
+			value |= (1U << i);
+		spin_unlock(&irq->irq_lock);
+	}
+
+	write_mask32(value, addr & 3, len, val);
+	return 0;
+}
+
+static int vgic_mmio_write_cactive(struct kvm_vcpu *vcpu,
+				   struct kvm_io_device *this,
+				   gpa_t addr, int len, const void *val)
+{
+	struct vgic_io_device *iodev = container_of(this,
+						    struct vgic_io_device, dev);
+	u32 intid = (addr - iodev->base_addr) * 8;
+	int i;
+
+	if (iodev->redist_vcpu)
+		vcpu = iodev->redist_vcpu;
+
+	for_each_set_bit(i, val, len * 8) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+
+		irq->active = false;
+		/* TODO: Anything more to do? Does flush/sync cover this? */
+
+		spin_unlock(&irq->irq_lock);
+	}
+	return 0;
+}
+
+static int vgic_mmio_write_sactive(struct kvm_vcpu *vcpu,
+				   struct kvm_io_device *this,
+				   gpa_t addr, int len, const void *val)
+{
+	struct vgic_io_device *iodev = container_of(this,
+						    struct vgic_io_device, dev);
+	u32 intid = (addr - iodev->base_addr) * 8;
+	int i;
+
+	if (iodev->redist_vcpu)
+		vcpu = iodev->redist_vcpu;
+
+	for_each_set_bit(i, val, len * 8) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
+
+		spin_lock(&irq->irq_lock);
+
+		irq->active = true;
+		/* TODO: Anything more to do? Does flush/sync cover this? */
+
+		spin_unlock(&irq->irq_lock);
+	}
+	return 0;
+}
+
 static int vgic_mmio_read_priority(struct kvm_vcpu *vcpu,
 				   struct kvm_io_device *this,
 				   gpa_t addr, int len, void *val)
@@ -347,9 +424,9 @@ struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_PENDING_CLEAR,
 		vgic_mmio_read_pending, vgic_mmio_write_cpending, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ACTIVE_SET,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 1),
+		vgic_mmio_read_active, vgic_mmio_write_sactive, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ACTIVE_CLEAR,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 1),
+		vgic_mmio_read_active, vgic_mmio_write_cactive, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_PRI,
 		vgic_mmio_read_priority, vgic_mmio_write_priority, 8),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_TARGET,
-- 
2.7.3
