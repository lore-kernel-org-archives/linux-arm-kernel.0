From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 21 Aug 2014 14:06:54 +0100
Subject: [PATCH v2 13/15] arm/arm64: KVM: add SGI system register trapping
In-Reply-To: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1408626416-11326-14-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the injection of a (virtual) inter-processor interrupt (SGI)
on a GICv2 works by writing to a MMIO register, GICv3 uses system
registers to trigger them.
Trap the appropriate registers both on ARM and ARM64 machines and
call the SGI handler function in the vGICv3 emulation code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/kvm/coproc.c       |   19 +++++++++++++++++++
 arch/arm64/kvm/sys_regs.c   |   26 ++++++++++++++++++++++++++
 virt/kvm/arm/vgic-v3-emul.c |    2 +-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 37a0fe1..1cd049f 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -230,6 +230,22 @@ done:
 	return true;
 }
 
+static bool access_gic_sgi(struct kvm_vcpu *vcpu,
+			   const struct coproc_params *p,
+			   const struct coproc_reg *r)
+{
+	u64 val;
+
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p);
+
+	val = *vcpu_reg(vcpu, p->Rt1);
+	val |= (u64)*vcpu_reg(vcpu, p->Rt2) << 32;
+	vgic_v3_dispatch_sgi(vcpu, val);
+
+	return true;
+}
+
 /*
  * Generic accessor for VM registers. Only called as long as HCR_TVM
  * is set.
@@ -401,6 +417,9 @@ static const struct coproc_reg cp15_regs[] = {
 	{ CRn(10), CRm( 3), Op1( 0), Op2( 1), is32,
 			access_vm_reg, reset_unknown, c10_AMAIR1},
 
+	/* ICC_SGI1R */
+	{ CRm64(12), Op1( 0), is64, access_gic_sgi},
+
 	/* VBAR: swapped by interrupt.S. */
 	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c12_VBAR, 0x00000000 },
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a79538a..befbcfd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -165,6 +165,27 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+/*
+ * Trapping on the GICv3 SGI system register.
+ * Forward the request to the VGIC emulation.
+ * The cp15_64 code makes sure this automatically works
+ * for both AArch64 and AArch32 accesses.
+ */
+static bool access_gic_sgi(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	u64 val;
+
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p);
+
+	val = *vcpu_reg(vcpu, p->Rt);
+	vgic_v3_dispatch_sgi(vcpu, val);
+
+	return true;
+}
+
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			const struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -431,6 +452,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	/* VBAR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
 	  NULL, reset_val, VBAR_EL1, 0 },
+	/* ICC_SGI1R_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
+	  access_gic_sgi },
 	/* CONTEXTIDR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
 	  access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
@@ -659,6 +683,8 @@ static const struct sys_reg_desc cp14_64_regs[] = {
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
+	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
+
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_sctlr, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
index 82ca1b5..ac5c5ee 100644
--- a/virt/kvm/arm/vgic-v3-emul.c
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -802,7 +802,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
 	 */
 	spin_lock(&dist->lock);
 	kvm_for_each_vcpu(c, c_vcpu, kvm) {
-		if (target_cpus == 0)
+		if (!mode && target_cpus == 0)
 			break;
 		if (mode && c == vcpu_id)       /* not to myself */
 			continue;
-- 
1.7.9.5
