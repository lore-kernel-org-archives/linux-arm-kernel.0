From: zhichao.huang@linaro.org (Zhichao Huang)
Date: Sat, 16 May 2015 12:45:46 +0800
Subject: [PATCH 05/10] KVM: arm: check ordering of all system register tables
In-Reply-To: <1431751551-4788-1-git-send-email-zhichao.huang@linaro.org>
References: <1431751551-4788-1-git-send-email-zhichao.huang@linaro.org>
Message-ID: <1431751551-4788-6-git-send-email-zhichao.huang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have multiple tables for the various system registers
we trap. Make sure we check the order of all of them, as it is
critical that we get the order right (been there, done that...).

Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
---
 arch/arm/kvm/coproc.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index d23395b..16d5f69 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -737,6 +737,9 @@ static struct coproc_reg invariant_cp15[] = {
 	{ CRn( 0), CRm( 0), Op1( 0), Op2( 3), is32, NULL, get_TLBTR },
 	{ CRn( 0), CRm( 0), Op1( 0), Op2( 6), is32, NULL, get_REVIDR },
 
+	{ CRn( 0), CRm( 0), Op1( 1), Op2( 1), is32, NULL, get_CLIDR },
+	{ CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
+
 	{ CRn( 0), CRm( 1), Op1( 0), Op2( 0), is32, NULL, get_ID_PFR0 },
 	{ CRn( 0), CRm( 1), Op1( 0), Op2( 1), is32, NULL, get_ID_PFR1 },
 	{ CRn( 0), CRm( 1), Op1( 0), Op2( 2), is32, NULL, get_ID_DFR0 },
@@ -752,9 +755,6 @@ static struct coproc_reg invariant_cp15[] = {
 	{ CRn( 0), CRm( 2), Op1( 0), Op2( 3), is32, NULL, get_ID_ISAR3 },
 	{ CRn( 0), CRm( 2), Op1( 0), Op2( 4), is32, NULL, get_ID_ISAR4 },
 	{ CRn( 0), CRm( 2), Op1( 0), Op2( 5), is32, NULL, get_ID_ISAR5 },
-
-	{ CRn( 0), CRm( 0), Op1( 1), Op2( 1), is32, NULL, get_CLIDR },
-	{ CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
 };
 
 /*
@@ -1297,13 +1297,29 @@ int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	return write_demux_regids(uindices);
 }
 
+static int check_sysreg_table(const struct coproc_reg *table, unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 1; i < n; i++) {
+		if (cmp_reg(&table[i-1], &table[i]) >= 0) {
+			kvm_err("sys_reg table %p out of order (%d)\n",
+					table, i - 1);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 void kvm_coproc_table_init(void)
 {
 	unsigned int i;
 
 	/* Make sure tables are unique and in order. */
-	for (i = 1; i < ARRAY_SIZE(cp15_regs); i++)
-		BUG_ON(cmp_reg(&cp15_regs[i-1], &cp15_regs[i]) >= 0);
+	BUG_ON(check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs)));
+	BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs)));
+	BUG_ON(check_sysreg_table(invariant_cp15, ARRAY_SIZE(invariant_cp15)));
 
 	/* We abuse the reset function to overwrite the table itself. */
 	for (i = 0; i < ARRAY_SIZE(invariant_cp15); i++)
-- 
1.7.12.4
