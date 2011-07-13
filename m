From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:50 +0100
Subject: [PATCH 01/24] ARM: kprobes: Migrate ARM space_1111 to decoding tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   56 ++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index c6f2c69..ea96214 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -896,41 +896,35 @@ prep_emulate_rdhi16rdlo12rs8rm0_wflags(kprobe_opcode_t insn,
  * number of tests needed.
  */
 
-static enum kprobe_insn __kprobes
-space_1111(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* memory hint : 1111 0100 x001 xxxx xxxx xxxx xxxx xxxx : */
-	/* PLDI        : 1111 0100 x101 xxxx xxxx xxxx xxxx xxxx : */
-	/* PLDW        : 1111 0101 x001 xxxx xxxx xxxx xxxx xxxx : */
-	/* PLD         : 1111 0101 x101 xxxx xxxx xxxx xxxx xxxx : */
-	if ((insn & 0xfe300000) == 0xf4100000) {
-		asi->insn_handler = emulate_nop;
-		return INSN_GOOD_NO_SLOT;
-	}
+static const union decode_item arm_1111_table[] = {
+	/* Unconditional instructions					*/
 
-	/* BLX(1) : 1111 101x xxxx xxxx xxxx xxxx xxxx xxxx : */
-	if ((insn & 0xfe000000) == 0xfa000000) {
-		asi->insn_handler = simulate_blx1;
-		return INSN_GOOD_NO_SLOT;
-	}
+	/* memory hint		1111 0100 x001 xxxx xxxx xxxx xxxx xxxx */
+	/* PLDI (immediate)	1111 0100 x101 xxxx xxxx xxxx xxxx xxxx */
+	/* PLDW (immediate)	1111 0101 x001 xxxx xxxx xxxx xxxx xxxx */
+	/* PLD (immediate)	1111 0101 x101 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_SIMULATE	(0xfe300000, 0xf4100000, kprobe_simulate_nop),
 
-	/* CPS   : 1111 0001 0000 xxx0 xxxx xxxx xx0x xxxx */
-	/* SETEND: 1111 0001 0000 0001 xxxx xxxx 0000 xxxx */
+	/* BLX (immediate)	1111 101x xxxx xxxx xxxx xxxx xxxx xxxx */
+	DECODE_SIMULATE	(0xfe000000, 0xfa000000, simulate_blx1),
 
-	/* SRS   : 1111 100x x1x0 xxxx xxxx xxxx xxxx xxxx */
-	/* RFE   : 1111 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
+	/* CPS			1111 0001 0000 xxx0 xxxx xxxx xx0x xxxx */
+	/* SETEND		1111 0001 0000 0001 xxxx xxxx 0000 xxxx */
+	/* SRS			1111 100x x1x0 xxxx xxxx xxxx xxxx xxxx */
+	/* RFE			1111 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
 
 	/* Coprocessor instructions... */
-	/* MCRR2 : 1111 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd != Rn) */
-	/* MRRC2 : 1111 1100 0101 xxxx xxxx xxxx xxxx xxxx : (Rd != Rn) */
-	/* LDC2  : 1111 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
-	/* STC2  : 1111 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
-	/* CDP2  : 1111 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
-	/* MCR2  : 1111 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
-	/* MRC2  : 1111 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
-
-	return INSN_REJECTED;
-}
+	/* MCRR2		1111 1100 0100 xxxx xxxx xxxx xxxx xxxx */
+	/* MRRC2		1111 1100 0101 xxxx xxxx xxxx xxxx xxxx */
+	/* LDC2			1111 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
+	/* STC2			1111 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
+	/* CDP2			1111 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
+	/* MCR2			1111 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
+	/* MRC2			1111 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
+
+	/* Other unallocated instructions...				*/
+	DECODE_END
+};
 
 static enum kprobe_insn __kprobes
 space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
@@ -1477,7 +1471,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	if ((insn & 0xf0000000) == 0xf0000000)
 
-		return space_1111(insn, asi);
+		return kprobe_decode_insn(insn, asi, arm_1111_table, false);
 
 	else if ((insn & 0x0e000000) == 0x00000000)
 
-- 
1.7.2.5
