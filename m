From: jintack.lim@linaro.org (Jintack Lim)
Date: Mon,  2 Oct 2017 22:10:57 -0500
Subject: [RFC PATCH v2 15/31] KVM: arm64: Move system register helper
 functions around
In-Reply-To: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
References: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1507000273-3735-13-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jintack Lim <jintack@cs.columbia.edu>

We are about to add a framework to handle system instruction traps. To
reuse existing helper functions, let's move them around.

No functional change.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 89 ++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 395b964..541bb97 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1621,6 +1621,51 @@ static bool access_id_aa64mmfr0_el1(struct kvm_vcpu *v,
 	{ SYS_DESC(SYS_SP_EL2), NULL, reset_special, SP_EL2, 0},
 };
 
+#define reg_to_match_value(x)						\
+	({								\
+		unsigned long val;					\
+		val  = (x)->Op0 << 14;					\
+		val |= (x)->Op1 << 11;					\
+		val |= (x)->CRn << 7;					\
+		val |= (x)->CRm << 3;					\
+		val |= (x)->Op2;					\
+		val;							\
+	 })
+
+static int match_sys_reg(const void *key, const void *elt)
+{
+	const unsigned long pval = (unsigned long)key;
+	const struct sys_reg_desc *r = elt;
+
+	return pval - reg_to_match_value(r);
+}
+
+static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
+					 const struct sys_reg_desc table[],
+					 unsigned int num)
+{
+	unsigned long pval = reg_to_match_value(params);
+
+	return bsearch((void *)pval, table, num, sizeof(table[0]),
+		       match_sys_reg);
+}
+
+static void perform_access(struct kvm_vcpu *vcpu,
+			   struct sys_reg_params *params,
+			   const struct sys_reg_desc *r)
+{
+	/*
+	 * Not having an accessor means that we have configured a trap
+	 * that we don't know how to handle. This certainly qualifies
+	 * as a gross bug that should be fixed right away.
+	 */
+	BUG_ON(!r->access);
+
+	/* Skip instruction if instructed so */
+	if (likely(r->access(vcpu, params, r)))
+		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+}
+
 static bool trap_dbgidr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -1968,56 +2013,12 @@ static const struct sys_reg_desc *get_target_table(unsigned target,
 	}
 }
 
-#define reg_to_match_value(x)						\
-	({								\
-		unsigned long val;					\
-		val  = (x)->Op0 << 14;					\
-		val |= (x)->Op1 << 11;					\
-		val |= (x)->CRn << 7;					\
-		val |= (x)->CRm << 3;					\
-		val |= (x)->Op2;					\
-		val;							\
-	 })
-
-static int match_sys_reg(const void *key, const void *elt)
-{
-	const unsigned long pval = (unsigned long)key;
-	const struct sys_reg_desc *r = elt;
-
-	return pval - reg_to_match_value(r);
-}
-
-static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
-					 const struct sys_reg_desc table[],
-					 unsigned int num)
-{
-	unsigned long pval = reg_to_match_value(params);
-
-	return bsearch((void *)pval, table, num, sizeof(table[0]), match_sys_reg);
-}
-
 int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
 
-static void perform_access(struct kvm_vcpu *vcpu,
-			   struct sys_reg_params *params,
-			   const struct sys_reg_desc *r)
-{
-	/*
-	 * Not having an accessor means that we have configured a trap
-	 * that we don't know how to handle. This certainly qualifies
-	 * as a gross bug that should be fixed right away.
-	 */
-	BUG_ON(!r->access);
-
-	/* Skip instruction if instructed so */
-	if (likely(r->access(vcpu, params, r)))
-		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-}
-
 /*
  * emulate_cp --  tries to match a sys_reg access in a handling table, and
  *                call the corresponding trap handler.
-- 
1.9.1
