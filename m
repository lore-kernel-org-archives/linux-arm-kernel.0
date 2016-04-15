From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 15 Apr 2016 18:11:36 +0100
Subject: [PATCH 25/45] KVM: arm/arm64: vgic-new: Add GICv3 redistributor IIDR,
 TYPER handlers
In-Reply-To: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
References: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1460740316-8755-26-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The redistributor TYPER tells the OS about the associated MPIDR,
also the LAST bit is crucial to determine the number of redistributors.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_mmio.c | 50 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
index a87bbca..7d275a7 100644
--- a/virt/kvm/arm/vgic/vgic_mmio.c
+++ b/virt/kvm/arm/vgic/vgic_mmio.c
@@ -739,6 +739,52 @@ static int vgic_mmio_write_v3_misc(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/*
+ * We use a compressed version of the MPIDR (all 32 bits in one 32-bit word)
+ * when we store the target MPIDR written by the guest.
+ */
+static u32 compress_mpidr(unsigned long mpidr)
+{
+	u32 ret;
+
+	ret = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8;
+	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16;
+	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24;
+
+	return ret;
+}
+
+static int vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
+				    struct kvm_io_device *dev,
+				    gpa_t addr, int len, void *val)
+{
+	struct vgic_io_device *iodev = container_of(dev,
+						    struct vgic_io_device, dev);
+	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(iodev->redist_vcpu);
+	int target_vcpu_id = iodev->redist_vcpu->vcpu_id;
+	u64 value;
+
+	value = (u64)compress_mpidr(mpidr) << 32;
+	value |= ((target_vcpu_id & 0xffff) << 8);
+	if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
+		value |= GICR_TYPER_LAST;
+
+	write_mask64(value, addr & 7, len, val);
+	return 0;
+}
+
+static int vgic_mmio_read_v3r_iidr(struct kvm_vcpu *vcpu,
+				   struct kvm_io_device *dev,
+				   gpa_t addr, int len, void *val)
+{
+	write_mask32((PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0),
+		     addr & 3, len, val);
+
+	return 0;
+}
+
+#endif
 
 /*
  * The GICv3 per-IRQ registers are split to control PPIs and SGIs in the
@@ -821,9 +867,9 @@ struct vgic_register_region vgic_v3_redist_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GICR_CTLR,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 4),
 	REGISTER_DESC_WITH_LENGTH(GICR_IIDR,
-		vgic_mmio_read_nyi, vgic_mmio_write_wi, 4),
+		vgic_mmio_read_v3r_iidr, vgic_mmio_write_wi, 4),
 	REGISTER_DESC_WITH_LENGTH(GICR_TYPER,
-		vgic_mmio_read_nyi, vgic_mmio_write_wi, 8),
+		vgic_mmio_read_v3r_typer, vgic_mmio_write_wi, 8),
 	REGISTER_DESC_WITH_LENGTH(GICR_PROPBASER,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 8),
 	REGISTER_DESC_WITH_LENGTH(GICR_PENDBASER,
-- 
2.7.3
