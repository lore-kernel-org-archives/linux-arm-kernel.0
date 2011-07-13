From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:01 +0100
Subject: [PATCH 12/24] ARM: kprobes: Migrate ARM space_cccc_0111__1 to
	decoding tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-13-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   82 ++++++++++++++++++-----------------------
 1 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 6203505..58faacc 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1373,57 +1373,47 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
 	DECODE_END
 };
 
-static enum kprobe_insn __kprobes
-space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* Undef : cccc 0111 1111 xxxx xxxx xxxx 1111 xxxx */
-	if ((insn & 0x0ff000f0) == 0x03f000f0)
-		return INSN_REJECTED;
+static const union decode_item arm_cccc_0111_____xxx1_table[] = {
+	/* Media instructions						*/
 
-	/* SMLALD : cccc 0111 0100 xxxx xxxx xxxx 00x1 xxxx */
-	/* SMLSLD : cccc 0111 0100 xxxx xxxx xxxx 01x1 xxxx */
-	if ((insn & 0x0ff00090) == 0x07400010)
-		return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn, asi);
-
-	/* SMLAD  : cccc 0111 0000 xxxx xxxx xxxx 00x1 xxxx :Q */
-	/* SMUAD  : cccc 0111 0000 xxxx 1111 xxxx 00x1 xxxx :Q */
-	/* SMLSD  : cccc 0111 0000 xxxx xxxx xxxx 01x1 xxxx :Q */
-	/* SMUSD  : cccc 0111 0000 xxxx 1111 xxxx 01x1 xxxx :  */
-	/* SMMLA  : cccc 0111 0101 xxxx xxxx xxxx 00x1 xxxx :  */
-	/* SMMUL  : cccc 0111 0101 xxxx 1111 xxxx 00x1 xxxx :  */
-	/* USADA8 : cccc 0111 1000 xxxx xxxx xxxx 0001 xxxx :  */
-	/* USAD8  : cccc 0111 1000 xxxx 1111 xxxx 0001 xxxx :  */
-	if ((insn & 0x0ff00090) == 0x07000010 ||
-	    (insn & 0x0ff000d0) == 0x07500010 ||
-	    (insn & 0x0ff000f0) == 0x07800010) {
-
-		if ((insn & 0x0000f000) == 0x0000f000)
-			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-		else
-			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
-	}
+	/* UNDEFINED		cccc 0111 1111 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_REJECT	(0x0ff000f0, 0x07f000f0),
 
-	/* SMMLS  : cccc 0111 0101 xxxx xxxx xxxx 11x1 xxxx :  */
-	if ((insn & 0x0ff000d0) == 0x075000d0)
-		return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
+	/* SMLALD		cccc 0111 0100 xxxx xxxx xxxx 00x1 xxxx */
+	/* SMLSLD		cccc 0111 0100 xxxx xxxx xxxx 01x1 xxxx */
+	DECODE_CUSTOM	(0x0ff00090, 0x07400010, prep_emulate_rdhi16rdlo12rs8rm0_wflags),
 
-	/* SBFX   : cccc 0111 101x xxxx xxxx xxxx x101 xxxx :  */
-	/* UBFX   : cccc 0111 111x xxxx xxxx xxxx x101 xxxx :  */
-	if ((insn & 0x0fa00070) == 0x07a00050)
-		return prep_emulate_rd12rm0(insn, asi);
+	/* SMUAD		cccc 0111 0000 xxxx 1111 xxxx 00x1 xxxx */
+	/* SMUSD		cccc 0111 0000 xxxx 1111 xxxx 01x1 xxxx */
+	DECODE_OR	(0x0ff0f090, 0x0700f010),
+	/* SMMUL		cccc 0111 0101 xxxx 1111 xxxx 00x1 xxxx */
+	DECODE_OR	(0x0ff0f0d0, 0x0750f010),
+	/* USAD8		cccc 0111 1000 xxxx 1111 xxxx 0001 xxxx */
+	DECODE_CUSTOM	(0x0ff0f0f0, 0x0780f010, prep_emulate_rd16rs8rm0_wflags),
 
-	/* BFI    : cccc 0111 110x xxxx xxxx xxxx x001 xxxx :  */
-	/* BFC    : cccc 0111 110x xxxx xxxx xxxx x001 1111 :  */
-	if ((insn & 0x0fe00070) == 0x07c00010) {
+	/* SMLAD		cccc 0111 0000 xxxx xxxx xxxx 00x1 xxxx */
+	/* SMLSD		cccc 0111 0000 xxxx xxxx xxxx 01x1 xxxx */
+	DECODE_OR	(0x0ff00090, 0x07000010),
+	/* SMMLA		cccc 0111 0101 xxxx xxxx xxxx 00x1 xxxx */
+	DECODE_OR	(0x0ff000d0, 0x07500010),
+	/* USADA8		cccc 0111 1000 xxxx xxxx xxxx 0001 xxxx */
+	DECODE_CUSTOM	(0x0ff000f0, 0x07800010, prep_emulate_rd16rn12rs8rm0_wflags),
 
-		if ((insn & 0x0000000f) == 0x0000000f)
-			return prep_emulate_rd12_modify(insn, asi);
-		else
-			return prep_emulate_rd12rn0_modify(insn, asi);
-	}
+	/* SMMLS		cccc 0111 0101 xxxx xxxx xxxx 11x1 xxxx */
+	DECODE_CUSTOM	(0x0ff000d0, 0x075000d0, prep_emulate_rd16rn12rs8rm0_wflags),
 
-	return INSN_REJECTED;
-}
+	/* SBFX			cccc 0111 101x xxxx xxxx xxxx x101 xxxx */
+	/* UBFX			cccc 0111 111x xxxx xxxx xxxx x101 xxxx */
+	DECODE_CUSTOM	(0x0fa00070, 0x07a00050, prep_emulate_rd12rm0),
+
+	/* BFC			cccc 0111 110x xxxx xxxx xxxx x001 1111 */
+	DECODE_CUSTOM	(0x0fe0007f, 0x07c0001f, prep_emulate_rd12_modify),
+
+	/* BFI			cccc 0111 110x xxxx xxxx xxxx x001 xxxx */
+	DECODE_CUSTOM	(0x0fe00070, 0x07c00010, prep_emulate_rd12rn0_modify),
+
+	DECODE_END
+};
 
 static enum kprobe_insn __kprobes
 space_cccc_01xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
@@ -1532,7 +1522,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	else if ((insn & 0x0f000010) == 0x07000010)
 
-		return space_cccc_0111__1(insn, asi);
+		return kprobe_decode_insn(insn, asi, arm_cccc_0111_____xxx1_table, false);
 
 	else if ((insn & 0x0c000000) == 0x04000000)
 
-- 
1.7.2.5
