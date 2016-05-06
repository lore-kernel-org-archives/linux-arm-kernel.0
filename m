From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  6 May 2016 11:45:48 +0100
Subject: [PATCH v3 35/55] KVM: arm/arm64: vgic-new: Add GICv3 IDREGS register
 handler
In-Reply-To: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462531568-9799-36-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We implement the only one ID register that is required by the
architecture, also this is the one that Linux actually checks.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Changelog v1 .. v2:
- adapt to new MMIO framework

 virt/kvm/arm/vgic/vgic-mmio-v3.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index d137242..48fba9c 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -110,6 +110,22 @@ static unsigned long vgic_mmio_read_v3r_iidr(struct kvm_vcpu *vcpu,
 	return extract_bytes(value, addr & 3, len);
 }
 
+static unsigned long vgic_mmio_read_v3_idregs(struct kvm_vcpu *vcpu,
+					      gpa_t addr, unsigned int len)
+{
+	u32 regnr = (addr & 0x3f) - (GICD_IDREGS & 0x3f);
+	u32 reg = 0;
+
+	switch (regnr + GICD_IDREGS) {
+	case GICD_PIDR2:
+		/* report a GICv3 compliant implementation */
+		reg = 0x3b;
+		break;
+	}
+
+	return extract_bytes(reg, addr & 3, len);
+}
+
 /*
  * The GICv3 per-IRQ registers are split to control PPIs and SGIs in the
  * redistributors, while SPIs are covered by registers in the distributor
@@ -160,7 +176,7 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_IROUTER,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 64),
 	REGISTER_DESC_WITH_LENGTH(GICD_IDREGS,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, 48),
+		vgic_mmio_read_v3_idregs, vgic_mmio_write_wi, 48),
 };
 
 static const struct vgic_register_region vgic_v3_rdbase_registers[] = {
@@ -175,7 +191,7 @@ static const struct vgic_register_region vgic_v3_rdbase_registers[] = {
 	REGISTER_DESC_WITH_LENGTH(GICR_PENDBASER,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 8),
 	REGISTER_DESC_WITH_LENGTH(GICR_IDREGS,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, 48),
+		vgic_mmio_read_v3_idregs, vgic_mmio_write_wi, 48),
 };
 
 static const struct vgic_register_region vgic_v3_sgibase_registers[] = {
-- 
2.7.3
