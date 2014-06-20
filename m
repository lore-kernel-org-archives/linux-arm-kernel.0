From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jun 2014 14:00:04 +0100
Subject: [PATCH v3 6/9] arm64: KVM: check ordering of all system register
 tables
In-Reply-To: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403269207-1625-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have multiple tables for the various system registers
we trap. Make sure we check the order of all of them, as it is
critical that we get the order right (been there, done that...).

Reviewed-by: Anup Patel <anup.patel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1fb1bff..9147b0c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1299,14 +1299,32 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	return write_demux_regids(uindices);
 }
 
+static int check_sysreg_table(const struct sys_reg_desc *table, unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 1; i < n; i++) {
+		if (cmp_sys_reg(&table[i-1], &table[i]) >= 0) {
+			kvm_err("sys_reg table %p out of order (%d)\n", table, i - 1);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 void kvm_sys_reg_table_init(void)
 {
 	unsigned int i;
 	struct sys_reg_desc clidr;
 
 	/* Make sure tables are unique and in order. */
-	for (i = 1; i < ARRAY_SIZE(sys_reg_descs); i++)
-		BUG_ON(cmp_sys_reg(&sys_reg_descs[i-1], &sys_reg_descs[i]) >= 0);
+	BUG_ON(check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs)));
+	BUG_ON(check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs)));
+	BUG_ON(check_sysreg_table(cp14_64_regs, ARRAY_SIZE(cp14_64_regs)));
+	BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs)));
+	BUG_ON(check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs)));
+	BUG_ON(check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs)));
 
 	/* We abuse the reset function to overwrite the table itself. */
 	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
-- 
1.8.3.4
