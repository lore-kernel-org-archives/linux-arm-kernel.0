From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:04:50 +0000
Subject: [RFC PATCH 27/45] KVM: arm/arm64: vgic-new: Add GICv3 IROUTER
 register handlers
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-28-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those set the affinity of a SPI interrupt.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_mmio.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
index 544ba31..44fdba5 100644
--- a/virt/kvm/arm/vgic/vgic_mmio.c
+++ b/virt/kvm/arm/vgic/vgic_mmio.c
@@ -668,6 +668,60 @@ static u32 compress_mpidr(unsigned long mpidr)
 	return ret;
 }
 
+static unsigned long decompress_mpidr(u32 value)
+{
+	unsigned long mpidr;
+
+	mpidr  = ((value >>  0) & 0xFF) << MPIDR_LEVEL_SHIFT(0);
+	mpidr |= ((value >>  8) & 0xFF) << MPIDR_LEVEL_SHIFT(1);
+	mpidr |= ((value >> 16) & 0xFF) << MPIDR_LEVEL_SHIFT(2);
+	mpidr |= (u64)((value >> 24) & 0xFF) << MPIDR_LEVEL_SHIFT(3);
+
+	return mpidr;
+}
+
+static int vgic_mmio_read_irouter(struct kvm_vcpu *vcpu,
+				  struct kvm_io_device *this,
+				  gpa_t addr, int len, void *val)
+{
+	struct vgic_io_device *iodev = container_of(this,
+						    struct vgic_io_device, dev);
+	int intid = (addr - iodev->base_addr) / 8;
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, NULL, intid);
+
+	if (!irq) {
+		memset(val, 0, len);
+		return 0;
+	}
+
+	write_mask64(decompress_mpidr(irq->mpidr), addr & 7, len, val);
+
+	return 0;
+}
+
+static int vgic_mmio_write_irouter(struct kvm_vcpu *vcpu,
+				   struct kvm_io_device *this,
+				   gpa_t addr, int len, const void *val)
+{
+	struct vgic_io_device *iodev = container_of(this,
+						    struct vgic_io_device, dev);
+	int intid = (addr - iodev->base_addr) / 8;
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, NULL, intid);
+	u64 mpidr;
+
+	if (!irq)
+		return 0;
+
+	mpidr = decompress_mpidr(irq->mpidr);
+	mpidr = mask64(mpidr, addr & 7, len, val);
+
+	irq->mpidr = compress_mpidr(mpidr);
+
+	vgic_v3_irq_change_affinity(vcpu->kvm, intid, mpidr);
+
+	return 0;
+}
+
 static int vgic_mmio_read_v3r_misc(struct kvm_vcpu *vcpu,
 				   struct kvm_io_device *this,
 				   gpa_t addr, int len, void *val)
@@ -837,6 +891,8 @@ struct vgic_register_region vgic_v3_dist_registers[] = {
 		vgic_mmio_read_config, vgic_mmio_write_config, 2),
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_IGRPMODR,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 1),
+	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_IROUTER,
+		vgic_mmio_read_irouter, vgic_mmio_write_irouter, 64),
 	REGISTER_DESC_WITH_LENGTH(GICD_IDREGS,
 		vgic_mmio_read_v3_idregs, vgic_mmio_write_wi, 48),
 };
-- 
2.7.3
