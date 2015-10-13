From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 13 Oct 2015 18:22:15 +0100
Subject: [PATCH v3 07/24] arm64: Define helper for sys_reg id manipulation
In-Reply-To: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444756952-31145-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define helper macros to extract op0, op1, CRn, CRm & op2
for a given sys_reg id.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h |   36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4246e41..92fd7bb 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -22,9 +22,6 @@
 
 #include <asm/opcodes.h>
 
-#define SCTLR_EL1_CP15BEN	(0x1 << 5)
-#define SCTLR_EL1_SED		(0x1 << 8)
-
 /*
  * ARMv8 ARM reserves the following encoding for system registers:
  * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
@@ -35,15 +32,36 @@
  *	[11-8]  : CRm
  *	[7-5]   : Op2
  */
-#define sys_reg(op0, op1, crn, crm, op2) \
-	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
-
-#define REG_PSTATE_PAN_IMM                     sys_reg(0, 0, 4, 0, 4)
-#define SCTLR_EL1_SPAN                         (1 << 23)
+#define Op0_shift	19
+#define Op0_mask	0x3
+#define Op1_shift	16
+#define Op1_mask	0x7
+#define CRn_shift	12
+#define CRn_mask	0xf
+#define CRm_shift	8
+#define CRm_mask	0xf
+#define Op2_shift	5
+#define Op2_mask	0x7
 
-#define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
+#define sys_reg(op0, op1, crn, crm, op2) \
+	((((op0) & Op0_mask) << Op0_shift) | \
+	 ((op1) << Op1_shift) | ((crn) << CRn_shift) | \
+	 ((crm) << CRm_shift) | ((op2) << Op2_shift))
+
+#define sys_reg_Op0(id)	(((id) >> Op0_shift) & Op0_mask)
+#define sys_reg_Op1(id)	(((id) >> Op1_shift) & Op1_mask)
+#define sys_reg_CRn(id)	(((id) >> CRn_shift) & CRn_mask)
+#define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
+#define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
+
+#define REG_PSTATE_PAN_IMM	sys_reg(0, 0, 4, 0, 4)
+#define SET_PSTATE_PAN(x)	__inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
 
+#define SCTLR_EL1_CP15BEN	(0x1 << 5)
+#define SCTLR_EL1_SED		(0x1 << 8)
+#define SCTLR_EL1_SPAN		(0x1 << 23)
+
 #define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
 #define ID_AA64MMFR0_BIGENDEL_SHIFT	8
 
-- 
1.7.9.5
