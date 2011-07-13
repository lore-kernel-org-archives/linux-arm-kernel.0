From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:03 +0100
Subject: [PATCH 14/24] ARM: kprobes: Migrate ARM space_cccc_100x to decoding
	tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-15-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 319e6fe..b2fd2c8 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1434,25 +1434,18 @@ static const union decode_item arm_cccc_01xx_table[] = {
 	DECODE_END
 };
 
-static enum kprobe_insn __kprobes
-space_cccc_100x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* LDM(2) : cccc 100x x101 xxxx 0xxx xxxx xxxx xxxx */
-	/* LDM(3) : cccc 100x x1x1 xxxx 1xxx xxxx xxxx xxxx */
-	if ((insn & 0x0e708000) == 0x85000000 ||
-	    (insn & 0x0e508000) == 0x85010000)
-		return INSN_REJECTED;
-
-	/* LDM(1) : cccc 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
-	/* STM(1) : cccc 100x x0x0 xxxx xxxx xxxx xxxx xxxx */
-
-	/*
-	 * Make the instruction unconditional because the new emulation
-	 * functions don't bother to setup the PSR context.
-	 */
-	insn = (insn | 0xe0000000) & ~0x10000000;
-	return kprobe_decode_ldmstm(insn, asi);
-}
+static const union decode_item arm_cccc_100x_table[] = {
+	/* Block data transfer instructions				*/
+
+	/* LDM			cccc 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
+	/* STM			cccc 100x x0x0 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_CUSTOM	(0x0e400000, 0x08000000, kprobe_decode_ldmstm),
+
+	/* STM (user registers)	cccc 100x x1x0 xxxx xxxx xxxx xxxx xxxx */
+	/* LDM (user registers)	cccc 100x x1x1 xxxx 0xxx xxxx xxxx xxxx */
+	/* LDM (exception ret)	cccc 100x x1x1 xxxx 1xxx xxxx xxxx xxxx */
+	DECODE_END
+};
 
 static enum kprobe_insn __kprobes
 space_cccc_101x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
@@ -1531,7 +1524,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	else if ((insn & 0x0e000000) == 0x08000000)
 
-		return space_cccc_100x(insn, asi);
+		return kprobe_decode_insn(insn, asi, arm_cccc_100x_table, false);
 
 	else if ((insn & 0x0e000000) == 0x0a000000)
 
-- 
1.7.2.5
