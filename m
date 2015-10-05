From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:01:55 +0100
Subject: [PATCH v2 06/22] arm64: sys_reg: Define System register encoding
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sys_reg defines the encoding of a system register as usable
in the mrs/msr instructions. i.e, the encoding is shifted to the left
by 5bits. Change it to the actual encoding of the register and
use shifted encoding in the mrs_s/msr_s macros. Also cleans up
some white space issues and alignments in the file.

This will be used in later patches for defining the encoding for the
CPU feature register infrastructure.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h |   51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4246e41..04e11b1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -22,11 +22,11 @@
 
 #include <asm/opcodes.h>
 
-#define SCTLR_EL1_CP15BEN	(0x1 << 5)
-#define SCTLR_EL1_SED		(0x1 << 8)
-
 /*
- * ARMv8 ARM reserves the following encoding for system registers:
+ * sys_reg: Defines the ARMv8 ARM encoding for the System register.
+ *
+ * ARMv8 ARM reserves the following encoding for system registers in the
+ * instructions accessing them.
  * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
  *  C5.2, version:ARM DDI 0487A.f)
  *	[20-19] : Op0
@@ -34,15 +34,40 @@
  *	[15-12] : CRn
  *	[11-8]  : CRm
  *	[7-5]   : Op2
+ * Hence we use [ sys_reg() << 5 ] in the mrs/msr instructions.
+ *
  */
+#define Op0_shift	14
+#define Op0_mask	0x3
+#define Op1_shift	11
+#define Op1_mask	0x7
+#define CRn_shift	7
+#define CRn_mask	0xf
+#define CRm_shift	3
+#define CRm_mask	0xf
+#define Op2_shift	0
+#define Op2_mask	0x7
+
+#define sys_reg_Op0(id)	(((id) >> Op0_shift) & Op0_mask)
+#define sys_reg_Op1(id)	(((id) >> Op1_shift) & Op1_mask)
+#define sys_reg_CRn(id)	(((id) >> CRn_shift) & CRn_mask)
+#define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
+#define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
+
 #define sys_reg(op0, op1, crn, crm, op2) \
-	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
+	(((op0 & Op0_mask) << Op0_shift) | ((op1) << Op1_shift) | \
+	 ((crn) << CRn_shift) | ((crm) << CRm_shift) | ((op2) << Op2_shift))
+
+
+#define REG_PSTATE_PAN_IMM	sys_reg(0, 0, 4, 0, 4)
+#define SET_PSTATE_PAN(x)	__inst_arm(0xd5000000 |\
+					   (REG_PSTATE_PAN_IMM << 5) |\
+					   (!!x)<<8 | 0x1f)
 
-#define REG_PSTATE_PAN_IMM                     sys_reg(0, 0, 4, 0, 4)
-#define SCTLR_EL1_SPAN                         (1 << 23)
 
-#define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
-				     (!!x)<<8 | 0x1f)
+#define SCTLR_EL1_CP15BEN	(0x1 << 5)
+#define SCTLR_EL1_SED		(0x1 << 8)
+#define SCTLR_EL1_SPAN		(0x1 << 23)
 
 #define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
 #define ID_AA64MMFR0_BIGENDEL_SHIFT	8
@@ -55,11 +80,11 @@
 	.equ	__reg_num_xzr, 31
 
 	.macro	mrs_s, rt, sreg
-	.inst	0xd5200000|(\sreg)|(__reg_num_\rt)
+	.inst	0xd5200000|((\sreg) << 5)|(__reg_num_\rt)
 	.endm
 
 	.macro	msr_s, sreg, rt
-	.inst	0xd5000000|(\sreg)|(__reg_num_\rt)
+	.inst	0xd5000000|((\sreg) << 5)|(__reg_num_\rt)
 	.endm
 
 #else
@@ -71,11 +96,11 @@ asm(
 "	.equ	__reg_num_xzr, 31\n"
 "\n"
 "	.macro	mrs_s, rt, sreg\n"
-"	.inst	0xd5200000|(\\sreg)|(__reg_num_\\rt)\n"
+"	.inst	0xd5200000|((\\sreg) << 5)|(__reg_num_\\rt)\n"
 "	.endm\n"
 "\n"
 "	.macro	msr_s, sreg, rt\n"
-"	.inst	0xd5000000|(\\sreg)|(__reg_num_\\rt)\n"
+"	.inst	0xd5000000|((\\sreg) << 5)|(__reg_num_\\rt)\n"
 "	.endm\n"
 );
 
-- 
1.7.9.5
