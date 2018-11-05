From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  5 Nov 2018 15:30:26 +0000
Subject: [PATCH] arm64: KVM: Don't generate UNDEF when LORegion feature is
 present
Message-ID: <20181105153026.169248-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently hide the LORegion feature, and generate an UNDEF
if the guest dares using the corresponding registers. This is
a bit extreme, as ARMv8.1 guarantees the feature to be present.

The guest should check the feature register before doing anything,
but we could also give the guest some slack (read "allow the
guest to be a bit stupid").

So instead of unconditionnaly deliver an exception, let's
only do it when the host doesn't support LORegion at all (or
when the feature has been sanitized out), and treat the registers
as RAZ/WI otherwise (with the exception of LORID_EL1 being RO).

Fixes: cc33c4e20185 ("arm64/kvm: Prohibit guest LOR accesses")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22fbbdbece3c..1133b74065f1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -314,12 +314,29 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 		return read_zero(vcpu, p);
 }
 
-static bool trap_undef(struct kvm_vcpu *vcpu,
-		       struct sys_reg_params *p,
-		       const struct sys_reg_desc *r)
+/*
+ * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
+ * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
+ * system, these registers should UNDEF. LORID_EL1 being a RO register, we
+ * treat it separately.
+ */
+static bool trap_loregion(struct kvm_vcpu *vcpu,
+			  struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
 {
-	kvm_inject_undefined(vcpu);
-	return false;
+	u64 val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	u32 sr = sys_reg((u32)r->Op0, (u32)r->Op1,
+			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
+
+	if (!(val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))) {
+		kvm_inject_undefined(vcpu);
+		return false;
+	}
+
+	if (p->is_write && sr == SYS_LORID_EL1)
+		return write_to_read_only(vcpu, p, r);
+
+	return trap_raz_wi(vcpu, p, r);
 }
 
 static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
@@ -1040,11 +1057,6 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
 			kvm_debug("SVE unsupported for guests, suppressing\n");
 
 		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
-	} else if (id == SYS_ID_AA64MMFR1_EL1) {
-		if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
-			kvm_debug("LORegions unsupported for guests, suppressing\n");
-
-		val &= ~(0xfUL << ID_AA64MMFR1_LOR_SHIFT);
 	}
 
 	return val;
@@ -1330,11 +1342,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
 	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
 
-	{ SYS_DESC(SYS_LORSA_EL1), trap_undef },
-	{ SYS_DESC(SYS_LOREA_EL1), trap_undef },
-	{ SYS_DESC(SYS_LORN_EL1), trap_undef },
-	{ SYS_DESC(SYS_LORC_EL1), trap_undef },
-	{ SYS_DESC(SYS_LORID_EL1), trap_undef },
+	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
 
 	{ SYS_DESC(SYS_VBAR_EL1), NULL, reset_val, VBAR_EL1, 0 },
 	{ SYS_DESC(SYS_DISR_EL1), NULL, reset_val, DISR_EL1, 0 },
-- 
2.19.1
