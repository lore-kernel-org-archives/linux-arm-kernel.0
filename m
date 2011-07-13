From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:04 +0100
Subject: [PATCH 15/24] ARM: kprobes: Migrate remaining instruction decoding
	functions to tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-16-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |  170 ++++++++++++++++++++++-------------------
 1 files changed, 90 insertions(+), 80 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index b2fd2c8..f271212 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1209,27 +1209,6 @@ static const union decode_item arm_cccc_000x_table[] = {
 	DECODE_END
 };
 
-static enum kprobe_insn __kprobes
-space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	if ((insn & 0x0f900080) == 0x01000000)
-		return kprobe_decode_insn(insn, asi, arm_cccc_0001_0xx0____0xxx_table, false);
-
-	if ((insn & 0x0f900090) == 0x01000080)
-		return kprobe_decode_insn(insn, asi, arm_cccc_0001_0xx0____1xx0_table, false);
-
-	if ((insn & 0x0f0000f0) == 0x00000090)
-		return kprobe_decode_insn(insn, asi, arm_cccc_0000_____1001_table, false);
-
-	if ((insn & 0x0f0000f0) == 0x01000090)
-		return kprobe_decode_insn(insn, asi, arm_cccc_0001_____1001_table, false);
-
-	if ((insn & 0x0e000090) == 0x00000090)
-		return kprobe_decode_insn(insn, asi, arm_cccc_000x_____1xx1_table, false);
-
-	return kprobe_decode_insn(insn, asi, arm_cccc_000x_table, false);
-}
-
 static const union decode_item arm_cccc_001x_table[] = {
 	/* Data-processing (immediate)					*/
 
@@ -1447,31 +1426,96 @@ static const union decode_item arm_cccc_100x_table[] = {
 	DECODE_END
 };
 
-static enum kprobe_insn __kprobes
-space_cccc_101x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* B  : cccc 1010 xxxx xxxx xxxx xxxx xxxx xxxx */
-	/* BL : cccc 1011 xxxx xxxx xxxx xxxx xxxx xxxx */
-	asi->insn_handler = simulate_bbl;
-	return INSN_GOOD_NO_SLOT;
-}
+const union decode_item kprobe_decode_arm_table[] = {
+	/*
+	 * Unconditional instructions
+	 *			1111 xxxx xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xf0000000, 0xf0000000, arm_1111_table),
+
+	/*
+	 * Miscellaneous instructions
+	 *			cccc 0001 0xx0 xxxx xxxx xxxx 0xxx xxxx
+	 */
+	DECODE_TABLE	(0x0f900080, 0x01000000, arm_cccc_0001_0xx0____0xxx_table),
+
+	/*
+	 * Halfword multiply and multiply-accumulate
+	 *			cccc 0001 0xx0 xxxx xxxx xxxx 1xx0 xxxx
+	 */
+	DECODE_TABLE	(0x0f900090, 0x01000080, arm_cccc_0001_0xx0____1xx0_table),
+
+	/*
+	 * Multiply and multiply-accumulate
+	 *			cccc 0000 xxxx xxxx xxxx xxxx 1001 xxxx
+	 */
+	DECODE_TABLE	(0x0f0000f0, 0x00000090, arm_cccc_0000_____1001_table),
+
+	/*
+	 * Synchronization primitives
+	 *			cccc 0001 xxxx xxxx xxxx xxxx 1001 xxxx
+	 */
+	DECODE_TABLE	(0x0f0000f0, 0x01000090, arm_cccc_0001_____1001_table),
+
+	/*
+	 * Extra load/store instructions
+	 *			cccc 000x xxxx xxxx xxxx xxxx 1xx1 xxxx
+	 */
+	DECODE_TABLE	(0x0e000090, 0x00000090, arm_cccc_000x_____1xx1_table),
+
+	/*
+	 * Data-processing (register)
+	 *			cccc 000x xxxx xxxx xxxx xxxx xxx0 xxxx
+	 * Data-processing (register-shifted register)
+	 *			cccc 000x xxxx xxxx xxxx xxxx 0xx1 xxxx
+	 */
+	DECODE_TABLE	(0x0e000000, 0x00000000, arm_cccc_000x_table),
+
+	/*
+	 * Data-processing (immediate)
+	 *			cccc 001x xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0x0e000000, 0x02000000, arm_cccc_001x_table),
+
+	/*
+	 * Media instructions
+	 *			cccc 011x xxxx xxxx xxxx xxxx xxx1 xxxx
+	 */
+	DECODE_TABLE	(0x0f000010, 0x06000010, arm_cccc_0110_____xxx1_table),
+	DECODE_TABLE	(0x0f000010, 0x07000010, arm_cccc_0111_____xxx1_table),
+
+	/*
+	 * Load/store word and unsigned byte
+	 *			cccc 01xx xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0x0c000000, 0x04000000, arm_cccc_01xx_table),
+
+	/*
+	 * Block data transfer instructions
+	 *			cccc 100x xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0x0e000000, 0x08000000, arm_cccc_100x_table),
+
+	/* B			cccc 1010 xxxx xxxx xxxx xxxx xxxx xxxx */
+	/* BL			cccc 1011 xxxx xxxx xxxx xxxx xxxx xxxx */
+	DECODE_SIMULATE	(0x0e000000, 0x0a000000, simulate_bbl),
+
+	/*
+	 * Supervisor Call, and coprocessor instructions
+	 */
+
+	/* MCRR			cccc 1100 0100 xxxx xxxx xxxx xxxx xxxx */
+	/* MRRC			cccc 1100 0101 xxxx xxxx xxxx xxxx xxxx */
+	/* LDC			cccc 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
+	/* STC			cccc 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
+	/* CDP			cccc 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
+	/* MCR			cccc 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
+	/* MRC			cccc 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
+	/* SVC			cccc 1111 xxxx xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0x0c000000, 0x0c000000),
 
-static enum kprobe_insn __kprobes
-space_cccc_11xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* Coprocessor instructions... */
-	/* MCRR : cccc 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
-	/* MRRC : cccc 1100 0101 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
-	/* LDC  : cccc 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
-	/* STC  : cccc 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
-	/* CDP  : cccc 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
-	/* MCR  : cccc 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
-	/* MRC  : cccc 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
-
-	/* SVC  : cccc 1111 xxxx xxxx xxxx xxxx xxxx xxxx */
-
-	return INSN_REJECTED;
-}
+	DECODE_END
+};
 
 static void __kprobes arm_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
@@ -1496,39 +1540,5 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	asi->insn_singlestep = arm_singlestep;
 	asi->insn_check_cc = kprobe_condition_checks[insn>>28];
-	asi->insn[1] = KPROBE_RETURN_INSTRUCTION;
-
-	if ((insn & 0xf0000000) == 0xf0000000)
-
-		return kprobe_decode_insn(insn, asi, arm_1111_table, false);
-
-	else if ((insn & 0x0e000000) == 0x00000000)
-
-		return space_cccc_000x(insn, asi);
-
-	else if ((insn & 0x0e000000) == 0x02000000)
-
-		return kprobe_decode_insn(insn, asi, arm_cccc_001x_table, false);
-
-	else if ((insn & 0x0f000010) == 0x06000010)
-
-		return kprobe_decode_insn(insn, asi, arm_cccc_0110_____xxx1_table, false);
-
-	else if ((insn & 0x0f000010) == 0x07000010)
-
-		return kprobe_decode_insn(insn, asi, arm_cccc_0111_____xxx1_table, false);
-
-	else if ((insn & 0x0c000000) == 0x04000000)
-
-		return kprobe_decode_insn(insn, asi, arm_cccc_01xx_table, false);
-
-	else if ((insn & 0x0e000000) == 0x08000000)
-
-		return kprobe_decode_insn(insn, asi, arm_cccc_100x_table, false);
-
-	else if ((insn & 0x0e000000) == 0x0a000000)
-
-		return space_cccc_101x(insn, asi);
-
-	return space_cccc_11xx(insn, asi);
+	return kprobe_decode_insn(insn, asi, kprobe_decode_arm_table, false);
 }
-- 
1.7.2.5
