From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 14 Sep 2018 10:07:49 +0100
Subject: [PATCH] arm64: sysreg: Clean up instructions for modifying PSTATE
 fields
Message-ID: <20180914090749.18562-1-suzuki.poulose@arm.com>
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
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c1470931b897..68c22360551e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -84,13 +84,23 @@
 
 #endif	/* CONFIG_BROKEN_GAS_INST */
 
-#define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
-#define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
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
+#define PSTATE_PAN			pstate_field(0, 4)
+#define PSTATE_UAO			pstate_field(0, 3)
 
-#define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |	\
-				      (!!x)<<8 | 0x1f)
-#define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
-				      (!!x)<<8 | 0x1f)
+#define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
+#define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
-- 
2.19.0
