From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:02 +0100
Subject: [PATCH 13/24] ARM: kprobes: Migrate ARM space_cccc_01xx to decoding
	tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-14-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   37 +++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 58faacc..319e6fe 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1415,23 +1415,24 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
 	DECODE_END
 };
 
-static enum kprobe_insn __kprobes
-space_cccc_01xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* LDR   : cccc 01xx x0x1 xxxx xxxx xxxx xxxx xxxx */
-	/* LDRB  : cccc 01xx x1x1 xxxx xxxx xxxx xxxx xxxx */
-	/* LDRBT : cccc 01x0 x111 xxxx xxxx xxxx xxxx xxxx */
-	/* LDRT  : cccc 01x0 x011 xxxx xxxx xxxx xxxx xxxx */
-	/* STR   : cccc 01xx x0x0 xxxx xxxx xxxx xxxx xxxx */
-	/* STRB  : cccc 01xx x1x0 xxxx xxxx xxxx xxxx xxxx */
-	/* STRBT : cccc 01x0 x110 xxxx xxxx xxxx xxxx xxxx */
-	/* STRT  : cccc 01x0 x010 xxxx xxxx xxxx xxxx xxxx */
-
-	if ((insn & 0x00500000) == 0x00500000 && is_r15(insn, 12))
-		return INSN_REJECTED;	/* LDRB into PC */
-
-	return prep_emulate_ldr_str(insn, asi);
-}
+static const union decode_item arm_cccc_01xx_table[] = {
+	/* Load/store word and unsigned byte				*/
+
+	/* LDRB/STRB pc,[...]	cccc 01xx x0xx xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0x0c40f000, 0x0440f000),
+
+	/* LDR			cccc 01xx x0x1 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRB			cccc 01xx x1x1 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRBT		cccc 01x0 x111 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRT			cccc 01x0 x011 xxxx xxxx xxxx xxxx xxxx */
+	/* STR			cccc 01xx x0x0 xxxx xxxx xxxx xxxx xxxx */
+	/* STRB			cccc 01xx x1x0 xxxx xxxx xxxx xxxx xxxx */
+	/* STRBT		cccc 01x0 x110 xxxx xxxx xxxx xxxx xxxx */
+	/* STRT			cccc 01x0 x010 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_CUSTOM	(0x0c000000, 0x04000000, prep_emulate_ldr_str),
+
+	DECODE_END
+};
 
 static enum kprobe_insn __kprobes
 space_cccc_100x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
@@ -1526,7 +1527,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	else if ((insn & 0x0c000000) == 0x04000000)
 
-		return space_cccc_01xx(insn, asi);
+		return kprobe_decode_insn(insn, asi, arm_cccc_01xx_table, false);
 
 	else if ((insn & 0x0e000000) == 0x08000000)
 
-- 
1.7.2.5
