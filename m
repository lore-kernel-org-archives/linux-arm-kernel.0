From: jintack.lim@linaro.org (Jintack Lim)
Date: Mon,  2 Oct 2017 22:10:59 -0500
Subject: [RFC PATCH v2 17/31] KVM: arm64: Rework the system instruction
 emulation framework
In-Reply-To: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
References: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1507000273-3735-15-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the system instruction emulation framework to handle potentially
all system instruction traps other than MSR/MRS instructions. Those
system instructions would be AT and TLBI instructions controlled by
HCR_EL2.NV, AT, and TTLB bits.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 66 ++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 88ce172..481bea64 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1621,6 +1621,11 @@ static bool access_id_aa64mmfr0_el1(struct kvm_vcpu *v,
 	{ SYS_DESC(SYS_SP_EL2), NULL, reset_special, SP_EL2, 0},
 };
 
+#define SYS_INSN_TO_DESC(insn, access_fn, forward_fn)	\
+	{ SYS_DESC((insn)), (access_fn), NULL, 0, 0, NULL, NULL, (forward_fn) }
+static struct sys_reg_desc sys_insn_descs[] = {
+};
+
 #define reg_to_match_value(x)						\
 	({								\
 		unsigned long val;					\
@@ -1674,6 +1679,25 @@ static void perform_access(struct kvm_vcpu *vcpu,
 		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 }
 
+static int emulate_sys_instr(struct kvm_vcpu *vcpu, struct sys_reg_params *p)
+{
+
+	const struct sys_reg_desc *r;
+
+	/* Search from the system instruction table. */
+	r = find_reg(p, sys_insn_descs, ARRAY_SIZE(sys_insn_descs));
+
+	if (likely(r)) {
+		perform_access(vcpu, p, r);
+	} else {
+		kvm_err("Unsupported guest sys instruction at: %lx\n",
+			*vcpu_pc(vcpu));
+		print_sys_reg_instr(p);
+		kvm_inject_undefined(vcpu);
+	}
+	return 1;
+}
+
 static bool trap_dbgidr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -2236,47 +2260,6 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-static int emulate_tlbi(struct kvm_vcpu *vcpu,
-			     struct sys_reg_params *params)
-{
-	/* TODO: support tlbi instruction emulation*/
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
-static int emulate_at(struct kvm_vcpu *vcpu,
-			     struct sys_reg_params *params)
-{
-	/* TODO: support address translation instruction emulation */
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
-static int emulate_sys_instr(struct kvm_vcpu *vcpu,
-			     struct sys_reg_params *params)
-{
-	int ret = 0;
-
-	/*
-	 * Forward this trap to the virtual EL2 if the virtual HCR_EL2.NV
-	 * bit is set.
-	 */
-	if (forward_nv_traps(vcpu))
-		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
-
-	/* TLB maintenance instructions*/
-	if (params->CRn == 0b1000)
-		ret = emulate_tlbi(vcpu, params);
-	/* Address Translation instructions */
-	else if (params->CRn == 0b0111 && params->CRm == 0b1000)
-		ret = emulate_at(vcpu, params);
-
-	if (ret)
-		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-
-	return ret;
-}
-
 static void reset_sys_reg_descs(struct kvm_vcpu *vcpu,
 			      const struct sys_reg_desc *table, size_t num)
 {
@@ -2754,6 +2737,7 @@ void kvm_sys_reg_table_init(void)
 	BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs)));
 	BUG_ON(check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs)));
 	BUG_ON(check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs)));
+	BUG_ON(check_sysreg_table(sys_insn_descs, ARRAY_SIZE(sys_insn_descs)));
 
 	/* We abuse the reset function to overwrite the table itself. */
 	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
-- 
1.9.1
