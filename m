From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Sun, 16 Sep 2018 23:17:23 +0100
Subject: [PATCH] arm64: sysreg: Clean up instructions for modifying PSTATE
 fields
Message-ID: <20180916221723.4306-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instructions for modifying the PSTATE fields which were not supported
in the older toolchains (e.g, PAN, UAO) are generated using macros.
We have so far used the normal sys_reg() helper for defining the PSTATE
fields. While this works fine, it is really difficult to correlate the
code with the Arm ARM definition.

As per Arm ARM, the PSTATE fields are defined only using Op1, Op2 fields,
with fixed values for Op0, CRn. Also the CRm field has been reserved
for the Immediate value for the instruction. So using the sys_reg()
looks quite confusing.

This patch cleans up the instruction helpers by bringing them
in line with the Arm ARM definitions to make it easier to correlate
code with the document. No functional changes.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1
 - Rebased to arm64 for-next/core.
 - Cleanup SSBS defintions and replace CRm_shift => PSTATE_Imm_shift
---
 arch/arm64/include/asm/sysreg.h | 28 +++++++++++++++++++---------
 arch/arm64/kernel/cpufeature.c  |  6 +++---
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 3091ae5975a3..7e9ab1fa090c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -84,16 +84,26 @@
 
 #endif	/* CONFIG_BROKEN_GAS_INST */
 
-#define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
-#define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
-#define REG_PSTATE_SSBS_IMM		sys_reg(0, 3, 4, 0, 1)
+/*
+ * Instructions for modifying PSTATE fields.
+ * As per Arm ARM for v8-A, Section "C.5.1.3 op0 == 0b00, architectural hints,
+ * barriers and CLREX, and PSTATE access", ARM DDI 0487 C.a, system instructions
+ * for accessing PSTATE fields have the following encoding:
+ *	Op0 = 0, CRn = 4
+ *	Op1, Op2 encodes the PSTATE field modified and defines the constraints.
+ *	CRm = Imm4 for the instruction.
+ *	Rt = 0x1f
+ */
+#define pstate_field(op1, op2)		((op1) << Op1_shift | (op2) << Op2_shift)
+#define PSTATE_Imm_shift		CRm_shift
 
-#define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |	\
-				      (!!x)<<8 | 0x1f)
-#define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
-				      (!!x)<<8 | 0x1f)
-#define SET_PSTATE_SSBS(x) __emit_inst(0xd5000000 | REG_PSTATE_SSBS_IMM | \
-				       (!!x)<<8 | 0x1f)
+#define PSTATE_PAN			pstate_field(0, 4)
+#define PSTATE_UAO			pstate_field(0, 3)
+#define PSTATE_SSBS			pstate_field(3, 1)
+
+#define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
+#define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
+#define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 35796ca1db50..f15e2fb97011 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1045,7 +1045,7 @@ static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
 	if (user_mode(regs))
 		return 1;
 
-	if (instr & BIT(CRm_shift))
+	if (instr & BIT(PSTATE_Imm_shift))
 		regs->pstate |= PSR_SSBS_BIT;
 	else
 		regs->pstate &= ~PSR_SSBS_BIT;
@@ -1055,8 +1055,8 @@ static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
 }
 
 static struct undef_hook ssbs_emulation_hook = {
-	.instr_mask	= ~(1U << CRm_shift),
-	.instr_val	= 0xd500001f | REG_PSTATE_SSBS_IMM,
+	.instr_mask	= ~(1U << PSTATE_Imm_shift),
+	.instr_val	= 0xd500401f | PSTATE_SSBS,
 	.fn		= ssbs_emulation_handler,
 };
 
-- 
2.19.0
