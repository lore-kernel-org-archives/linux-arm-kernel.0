From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  5 Jan 2016 10:18:51 +0100
Subject: [PATCH v2 1/2] arm64/module: fix relocation of movz instruction with
 negative immediate
Message-ID: <1451985532-6487-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The test whether a movz instruction with a signed immediate should be
turned into a movn instruction (i.e., when the immediate is negative)
is flawed, since the value of imm is always positive. Also, the
subsequent bounds check is incorrect since the limit update never
executes, due to the fact that the imm_type comparison will always be
false for negative signed immediates.

Let's fix this by performing the sign test on sval directly, and
replacing the bounds check with a simple comparison against U16_MAX.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/module.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f4bc779e62e8..400141549b28 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -30,9 +30,6 @@
 #include <asm/insn.h>
 #include <asm/sections.h>
 
-#define	AARCH64_INSN_IMM_MOVNZ		AARCH64_INSN_IMM_MAX
-#define	AARCH64_INSN_IMM_MOVK		AARCH64_INSN_IMM_16
-
 void *module_alloc(unsigned long size)
 {
 	void *p;
@@ -110,16 +107,21 @@ static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len)
 	return 0;
 }
 
+enum aarch64_insn_movw_imm_type {
+	AARCH64_INSN_IMM_MOVNZ,
+	AARCH64_INSN_IMM_MOVK
+};
+
 static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
-			   int lsb, enum aarch64_insn_imm_type imm_type)
+			   int lsb, enum aarch64_insn_movw_imm_type imm_type)
 {
-	u64 imm, limit = 0;
+	u64 imm;
 	s64 sval;
 	u32 insn = le32_to_cpu(*(u32 *)place);
 
 	sval = do_reloc(op, place, val);
 	sval >>= lsb;
-	imm = sval & 0xffff;
+	imm = sval;
 
 	if (imm_type == AARCH64_INSN_IMM_MOVNZ) {
 		/*
@@ -128,7 +130,7 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
 		 * immediate is less than zero.
 		 */
 		insn &= ~(3 << 29);
-		if ((s64)imm >= 0) {
+		if (sval >= 0) {
 			/* >=0: Set the instruction to MOVZ (opcode 10b). */
 			insn |= 2 << 29;
 		} else {
@@ -138,31 +140,15 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
 			 *     don't need to do anything other than
 			 *     inverting the new immediate field.
 			 */
-			imm = ~imm;
+			imm = ~sval;
 		}
-		imm_type = AARCH64_INSN_IMM_MOVK;
 	}
 
 	/* Update the instruction with the new encoding. */
-	insn = aarch64_insn_encode_immediate(imm_type, insn, imm);
+	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, imm);
 	*(u32 *)place = cpu_to_le32(insn);
 
-	/* Shift out the immediate field. */
-	sval >>= 16;
-
-	/*
-	 * For unsigned immediates, the overflow check is straightforward.
-	 * For signed immediates, the sign bit is actually the bit past the
-	 * most significant bit of the field.
-	 * The AARCH64_INSN_IMM_16 immediate type is unsigned.
-	 */
-	if (imm_type != AARCH64_INSN_IMM_16) {
-		sval++;
-		limit++;
-	}
-
-	/* Check the upper bits depending on the sign of the immediate. */
-	if ((u64)sval > limit)
+	if (imm > U16_MAX)
 		return -ERANGE;
 
 	return 0;
@@ -267,25 +253,25 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			overflow_check = false;
 		case R_AARCH64_MOVW_UABS_G0:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
-					      AARCH64_INSN_IMM_16);
+					      AARCH64_INSN_IMM_MOVK);
 			break;
 		case R_AARCH64_MOVW_UABS_G1_NC:
 			overflow_check = false;
 		case R_AARCH64_MOVW_UABS_G1:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
-					      AARCH64_INSN_IMM_16);
+					      AARCH64_INSN_IMM_MOVK);
 			break;
 		case R_AARCH64_MOVW_UABS_G2_NC:
 			overflow_check = false;
 		case R_AARCH64_MOVW_UABS_G2:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
-					      AARCH64_INSN_IMM_16);
+					      AARCH64_INSN_IMM_MOVK);
 			break;
 		case R_AARCH64_MOVW_UABS_G3:
 			/* We're using the top bits so we can't overflow. */
 			overflow_check = false;
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 48,
-					      AARCH64_INSN_IMM_16);
+					      AARCH64_INSN_IMM_MOVK);
 			break;
 		case R_AARCH64_MOVW_SABS_G0:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
-- 
2.5.0
