From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:54 +0100
Subject: [PATCH v4 26/32] arm64: KVM: CPU specific 32bit coprocessor access
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-27-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable handling of CPU specific 32bit coprocessor access. Not much
here either.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs_generic_v8.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index d4e8039..4268ab9 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -59,11 +59,21 @@ static const struct sys_reg_desc genericv8_sys_regs[] = {
 	  access_actlr, reset_actlr, ACTLR_EL1 },
 };
 
+static const struct sys_reg_desc genericv8_cp15_regs[] = {
+	/* ACTLR */
+	{ Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b001),
+	  access_actlr },
+};
+
 static struct kvm_sys_reg_target_table genericv8_target_table = {
 	.table64 = {
 		.table = genericv8_sys_regs,
 		.num = ARRAY_SIZE(genericv8_sys_regs),
 	},
+	.table32 = {
+		.table = genericv8_cp15_regs,
+		.num = ARRAY_SIZE(genericv8_cp15_regs),
+	},
 };
 
 static int __init sys_reg_genericv8_init(void)
-- 
1.8.2.3
