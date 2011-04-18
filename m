From: tixy@yxit.co.uk (Tixy)
Date: Mon, 18 Apr 2011 08:53:55 +0100
Subject: [PATCH 2/5] ARM: kprobes: Consolidate stub decoding functions
In-Reply-To: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
References: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303113238-23920-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Following the change to remove support for coprocessor instructions
we are left with three stub functions which can be consolidated.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   40 ++++++++-----------------------------
 1 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 0b3d971..35dd112 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1428,33 +1428,19 @@ space_cccc_101x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 }
 
 static enum kprobe_insn __kprobes
-space_cccc_1100_010x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+space_cccc_11xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	/* Coprocessor instructions... */
 	/* MCRR : cccc 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
 	/* MRRC : cccc 1100 0101 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
-	return INSN_REJECTED;
-}
+	/* LDC  : cccc 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
+	/* STC  : cccc 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
+	/* CDP  : cccc 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
+	/* MCR  : cccc 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
+	/* MRC  : cccc 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
 
-static enum kprobe_insn __kprobes
-space_cccc_110x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* LDC : cccc 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
-	/* STC : cccc 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
-	return INSN_REJECTED;
-}
+	/* SVC  : cccc 1111 xxxx xxxx xxxx xxxx xxxx xxxx */
 
-static enum kprobe_insn __kprobes
-space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* BKPT : 1110 0001 0010 xxxx xxxx xxxx 0111 xxxx */
-	/* SWI  : cccc 1111 xxxx xxxx xxxx xxxx xxxx xxxx */
-	if ((insn & 0xfff000f0) == 0xe1200070 ||
-	    (insn & 0x0f000000) == 0x0f000000)
-		return INSN_REJECTED;
-
-	/* CDP : cccc 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
-	/* MCR : cccc 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
-	/* MRC : cccc 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
 	return INSN_REJECTED;
 }
 
@@ -1598,17 +1584,9 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		return space_cccc_101x(insn, asi);
 
-	} else if ((insn & 0x0fe00000) == 0x0c400000) {
-
-		return space_cccc_1100_010x(insn, asi);
-
-	} else if ((insn & 0x0e000000) == 0x0c000000) {
-
-		return space_cccc_110x(insn, asi);
-
 	}
 
-	return space_cccc_111x(insn, asi);
+	return space_cccc_11xx(insn, asi);
 }
 
 void __init arm_kprobe_decode_init(void)
-- 
1.7.2.5
