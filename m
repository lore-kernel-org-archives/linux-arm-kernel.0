From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:42 +0000
Subject: [PATCH 26/29] arm64: KVM: 32bit coprocessor access for Cortex-A57
In-Reply-To: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362455265-24165-27-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable handling of 32bit coprocessor traps for Cortex-A57.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs_a57.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs_a57.c b/arch/arm64/kvm/sys_regs_a57.c
index dcc88fe..56c0641 100644
--- a/arch/arm64/kvm/sys_regs_a57.c
+++ b/arch/arm64/kvm/sys_regs_a57.c
@@ -59,6 +59,17 @@ static void reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	vcpu->arch.sys_regs[ACTLR_EL1] = actlr;
 }
 
+static bool access_ectlr(struct kvm_vcpu *vcpu,
+			 const struct sys_reg_params *p,
+			 const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+
+	*vcpu_reg(vcpu, p->Rt) = 0;
+	return true;
+}
+
 /*
  * A57-specific sys-reg registers.
  * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
@@ -74,12 +85,23 @@ static const struct sys_reg_desc a57_sys_regs[] = {
 	  NULL, reset_val, CPACR_EL1, 0 },
 };
 
+static const struct sys_reg_desc a57_cp15_regs[] = {
+	{ Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b001), /* ACTLR */
+	  access_actlr },
+	{ Op1(0b001), CRn(0b0000), CRm(0b1111), Op2(0b000), /* ECTLR */
+	  access_ectlr },
+};
+
 static struct kvm_sys_reg_target_table a57_target_table = {
 	.target = KVM_ARM_TARGET_CORTEX_A57,
 	.table64 = {
 		.table = a57_sys_regs,
 		.num = ARRAY_SIZE(a57_sys_regs),
 	},
+	.table32 = {
+		.table = a57_cp15_regs,
+		.num = ARRAY_SIZE(a57_cp15_regs),
+	},
 };
 
 static int __init sys_reg_a57_init(void)
-- 
1.7.12.4
