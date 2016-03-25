From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:04:39 +0000
Subject: [RFC PATCH 16/45] KVM: arm/arm64: vgic-new: Add PENDING registers
 handlers
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-17-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_mmio.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
index 0688a69..8514f92 100644
--- a/virt/kvm/arm/vgic/vgic_mmio.c
+++ b/virt/kvm/arm/vgic/vgic_mmio.c
@@ -206,6 +206,89 @@ static int vgic_mmio_write_cenable(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int vgic_mmio_read_pending(struct kvm_vcpu *vcpu,
+				  struct kvm_io_device *this,
+				  gpa_t addr, int len, void *val)
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
+		if (irq->pending)
+			value |= (1U << i);
+		spin_unlock(&irq->irq_lock);
+	}
+
+	write_mask32(value, addr & 3, len, val);
+	return 0;
+}
+
+static int vgic_mmio_write_spending(struct kvm_vcpu *vcpu,
+				    struct kvm_io_device *this,
+				    gpa_t addr, int len, const void *val)
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
+		irq->pending = true;
+		if (irq->config == VGIC_CONFIG_LEVEL)
+			irq->soft_pending = true;
+
+		vgic_queue_irq(vcpu->kvm, irq);
+	}
+
+	return 0;
+}
+
+static int vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,
+				    struct kvm_io_device *this,
+				    gpa_t addr, int len, const void *val)
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
+		if (irq->config == VGIC_CONFIG_LEVEL) {
+			irq->soft_pending = false;
+			irq->pending = irq->line_level;
+		} else {
+			irq->pending = false;
+		}
+		/* TODO: Does the exit/entry code take care of "unqueuing"? */
+
+		spin_unlock(&irq->irq_lock);
+	}
+	return 0;
+}
+
 struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GIC_DIST_CTRL,
 		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12),
@@ -216,9 +299,9 @@ struct vgic_register_region vgic_v2_dist_registers[] = {
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ENABLE_CLEAR,
 		vgic_mmio_read_enable, vgic_mmio_write_cenable, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_PENDING_SET,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 1),
+		vgic_mmio_read_pending, vgic_mmio_write_spending, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_PENDING_CLEAR,
-		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 1),
+		vgic_mmio_read_pending, vgic_mmio_write_cpending, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ACTIVE_SET,
 		vgic_mmio_read_nyi, vgic_mmio_write_nyi, 1),
 	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ACTIVE_CLEAR,
-- 
2.7.3
