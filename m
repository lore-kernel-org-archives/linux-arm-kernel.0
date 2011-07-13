From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:00 +0100
Subject: [PATCH 11/24] ARM: kprobes: Migrate ARM space_cccc_0110__1 to
	decoding tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-12-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |  217 +++++++++++++++++------------------------
 1 files changed, 91 insertions(+), 126 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index eb11a56..6203505 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1281,132 +1281,97 @@ static const union decode_item arm_cccc_001x_table[] = {
 	DECODE_END
 };
 
-static enum kprobe_insn __kprobes
-space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* SEL : cccc 0110 1000 xxxx xxxx xxxx 1011 xxxx GE: !!! */
-	if ((insn & 0x0ff000f0) == 0x068000b0) {
-		if (is_r15(insn, 12))
-			return INSN_REJECTED;	/* Rd is PC */
-		insn &= 0xfff00ff0;	/* Rd = r0, Rn = r0 */
-		insn |= 0x00000001;	/* Rm = r1 */
-		asi->insn[0] = insn;
-		asi->insn_handler = emulate_sel;
-		return INSN_GOOD;
-	}
-
-	/* SSAT   : cccc 0110 101x xxxx xxxx xxxx xx01 xxxx :Q */
-	/* USAT   : cccc 0110 111x xxxx xxxx xxxx xx01 xxxx :Q */
-	/* SSAT16 : cccc 0110 1010 xxxx xxxx xxxx 0011 xxxx :Q */
-	/* USAT16 : cccc 0110 1110 xxxx xxxx xxxx 0011 xxxx :Q */
-	if ((insn & 0x0fa00030) == 0x06a00010 ||
-	    (insn & 0x0fb000f0) == 0x06a00030) {
-		if (is_r15(insn, 12))
-			return INSN_REJECTED;	/* Rd is PC */
-		insn &= 0xffff0ff0;	/* Rd = r0, Rm = r0 */
-		asi->insn[0] = insn;
-		asi->insn_handler = emulate_sat;
-		return INSN_GOOD;
-	}
-
-	/* REV    : cccc 0110 1011 xxxx xxxx xxxx 0011 xxxx */
-	/* REV16  : cccc 0110 1011 xxxx xxxx xxxx 1011 xxxx */
-	/* RBIT   : cccc 0110 1111 xxxx xxxx xxxx 0011 xxxx */
-	/* REVSH  : cccc 0110 1111 xxxx xxxx xxxx 1011 xxxx */
-	if ((insn & 0x0ff00070) == 0x06b00030 ||
-	    (insn & 0x0ff00070) == 0x06f00030)
-		return prep_emulate_rd12rm0(insn, asi);
-
-	/* ???       : cccc 0110 0000 xxxx xxxx xxxx xxx1 xxxx :   */
-	/* SADD16    : cccc 0110 0001 xxxx xxxx xxxx 0001 xxxx :GE */
-	/* SADDSUBX  : cccc 0110 0001 xxxx xxxx xxxx 0011 xxxx :GE */
-	/* SSUBADDX  : cccc 0110 0001 xxxx xxxx xxxx 0101 xxxx :GE */
-	/* SSUB16    : cccc 0110 0001 xxxx xxxx xxxx 0111 xxxx :GE */
-	/* SADD8     : cccc 0110 0001 xxxx xxxx xxxx 1001 xxxx :GE */
-	/* ???       : cccc 0110 0001 xxxx xxxx xxxx 1011 xxxx :   */
-	/* ???       : cccc 0110 0001 xxxx xxxx xxxx 1101 xxxx :   */
-	/* SSUB8     : cccc 0110 0001 xxxx xxxx xxxx 1111 xxxx :GE */
-	/* QADD16    : cccc 0110 0010 xxxx xxxx xxxx 0001 xxxx :   */
-	/* QADDSUBX  : cccc 0110 0010 xxxx xxxx xxxx 0011 xxxx :   */
-	/* QSUBADDX  : cccc 0110 0010 xxxx xxxx xxxx 0101 xxxx :   */
-	/* QSUB16    : cccc 0110 0010 xxxx xxxx xxxx 0111 xxxx :   */
-	/* QADD8     : cccc 0110 0010 xxxx xxxx xxxx 1001 xxxx :   */
-	/* ???       : cccc 0110 0010 xxxx xxxx xxxx 1011 xxxx :   */
-	/* ???       : cccc 0110 0010 xxxx xxxx xxxx 1101 xxxx :   */
-	/* QSUB8     : cccc 0110 0010 xxxx xxxx xxxx 1111 xxxx :   */
-	/* SHADD16   : cccc 0110 0011 xxxx xxxx xxxx 0001 xxxx :   */
-	/* SHADDSUBX : cccc 0110 0011 xxxx xxxx xxxx 0011 xxxx :   */
-	/* SHSUBADDX : cccc 0110 0011 xxxx xxxx xxxx 0101 xxxx :   */
-	/* SHSUB16   : cccc 0110 0011 xxxx xxxx xxxx 0111 xxxx :   */
-	/* SHADD8    : cccc 0110 0011 xxxx xxxx xxxx 1001 xxxx :   */
-	/* ???       : cccc 0110 0011 xxxx xxxx xxxx 1011 xxxx :   */
-	/* ???       : cccc 0110 0011 xxxx xxxx xxxx 1101 xxxx :   */
-	/* SHSUB8    : cccc 0110 0011 xxxx xxxx xxxx 1111 xxxx :   */
-	/* ???       : cccc 0110 0100 xxxx xxxx xxxx xxx1 xxxx :   */
-	/* UADD16    : cccc 0110 0101 xxxx xxxx xxxx 0001 xxxx :GE */
-	/* UADDSUBX  : cccc 0110 0101 xxxx xxxx xxxx 0011 xxxx :GE */
-	/* USUBADDX  : cccc 0110 0101 xxxx xxxx xxxx 0101 xxxx :GE */
-	/* USUB16    : cccc 0110 0101 xxxx xxxx xxxx 0111 xxxx :GE */
-	/* UADD8     : cccc 0110 0101 xxxx xxxx xxxx 1001 xxxx :GE */
-	/* ???       : cccc 0110 0101 xxxx xxxx xxxx 1011 xxxx :   */
-	/* ???       : cccc 0110 0101 xxxx xxxx xxxx 1101 xxxx :   */
-	/* USUB8     : cccc 0110 0101 xxxx xxxx xxxx 1111 xxxx :GE */
-	/* UQADD16   : cccc 0110 0110 xxxx xxxx xxxx 0001 xxxx :   */
-	/* UQADDSUBX : cccc 0110 0110 xxxx xxxx xxxx 0011 xxxx :   */
-	/* UQSUBADDX : cccc 0110 0110 xxxx xxxx xxxx 0101 xxxx :   */
-	/* UQSUB16   : cccc 0110 0110 xxxx xxxx xxxx 0111 xxxx :   */
-	/* UQADD8    : cccc 0110 0110 xxxx xxxx xxxx 1001 xxxx :   */
-	/* ???       : cccc 0110 0110 xxxx xxxx xxxx 1011 xxxx :   */
-	/* ???       : cccc 0110 0110 xxxx xxxx xxxx 1101 xxxx :   */
-	/* UQSUB8    : cccc 0110 0110 xxxx xxxx xxxx 1111 xxxx :   */
-	/* UHADD16   : cccc 0110 0111 xxxx xxxx xxxx 0001 xxxx :   */
-	/* UHADDSUBX : cccc 0110 0111 xxxx xxxx xxxx 0011 xxxx :   */
-	/* UHSUBADDX : cccc 0110 0111 xxxx xxxx xxxx 0101 xxxx :   */
-	/* UHSUB16   : cccc 0110 0111 xxxx xxxx xxxx 0111 xxxx :   */
-	/* UHADD8    : cccc 0110 0111 xxxx xxxx xxxx 1001 xxxx :   */
-	/* ???       : cccc 0110 0111 xxxx xxxx xxxx 1011 xxxx :   */
-	/* ???       : cccc 0110 0111 xxxx xxxx xxxx 1101 xxxx :   */
-	/* UHSUB8    : cccc 0110 0111 xxxx xxxx xxxx 1111 xxxx :   */
-	if ((insn & 0x0f800010) == 0x06000010) {
-		if ((insn & 0x00300000) == 0x00000000 ||
-		    (insn & 0x000000e0) == 0x000000a0 ||
-		    (insn & 0x000000e0) == 0x000000c0)
-			return INSN_REJECTED;	/* Unallocated space */
-		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
-	}
-
-	/* PKHBT     : cccc 0110 1000 xxxx xxxx xxxx x001 xxxx :   */
-	/* PKHTB     : cccc 0110 1000 xxxx xxxx xxxx x101 xxxx :   */
-	if ((insn & 0x0ff00030) == 0x06800010)
-		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
-
-	/* SXTAB16   : cccc 0110 1000 xxxx xxxx xxxx 0111 xxxx :   */
-	/* SXTB16    : cccc 0110 1000 1111 xxxx xxxx 0111 xxxx :   */
-	/* ???       : cccc 0110 1001 xxxx xxxx xxxx 0111 xxxx :   */
-	/* SXTAB     : cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx :   */
-	/* SXTB      : cccc 0110 1010 1111 xxxx xxxx 0111 xxxx :   */
-	/* SXTAH     : cccc 0110 1011 xxxx xxxx xxxx 0111 xxxx :   */
-	/* SXTH      : cccc 0110 1011 1111 xxxx xxxx 0111 xxxx :   */
-	/* UXTAB16   : cccc 0110 1100 xxxx xxxx xxxx 0111 xxxx :   */
-	/* UXTB16    : cccc 0110 1100 1111 xxxx xxxx 0111 xxxx :   */
-	/* ???       : cccc 0110 1101 xxxx xxxx xxxx 0111 xxxx :   */
-	/* UXTAB     : cccc 0110 1110 xxxx xxxx xxxx 0111 xxxx :   */
-	/* UXTB      : cccc 0110 1110 1111 xxxx xxxx 0111 xxxx :   */
-	/* UXTAH     : cccc 0110 1111 xxxx xxxx xxxx 0111 xxxx :   */
-	/* UXTH      : cccc 0110 1111 1111 xxxx xxxx 0111 xxxx :   */
-	if ((insn & 0x0f8000f0) == 0x06800070) {
-		if ((insn & 0x00300000) == 0x00100000)
-			return INSN_REJECTED;	/* Unallocated space */
-
-		if ((insn & 0x000f0000) == 0x000f0000)
-			return prep_emulate_rd12rm0(insn, asi);
-		else
-			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
-	}
+static const union decode_item arm_cccc_0110_____xxx1_table[] = {
+	/* Media instructions						*/
+
+	/* SEL			cccc 0110 1000 xxxx xxxx xxxx 1011 xxxx */
+	DECODE_EMULATEX	(0x0ff000f0, 0x068000b0, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(NOPC, NOPC, 0, 0, NOPC)),
+
+	/* SSAT			cccc 0110 101x xxxx xxxx xxxx xx01 xxxx */
+	/* USAT			cccc 0110 111x xxxx xxxx xxxx xx01 xxxx */
+	DECODE_OR(0x0fa00030, 0x06a00010),
+	/* SSAT16		cccc 0110 1010 xxxx xxxx xxxx 0011 xxxx */
+	/* USAT16		cccc 0110 1110 xxxx xxxx xxxx 0011 xxxx */
+	DECODE_EMULATEX	(0x0fb000f0, 0x06a00030, emulate_rd12rn16rm0_rwflags_nopc,
+						 REGS(0, NOPC, 0, 0, NOPC)),
+
+	/* REV			cccc 0110 1011 xxxx xxxx xxxx 0011 xxxx */
+	/* REV16		cccc 0110 1011 xxxx xxxx xxxx 1011 xxxx */
+	/* RBIT			cccc 0110 1111 xxxx xxxx xxxx 0011 xxxx */
+	/* REVSH		cccc 0110 1111 xxxx xxxx xxxx 1011 xxxx */
+	DECODE_CUSTOM	(0x0fb00070, 0x06b00030, prep_emulate_rd12rm0),
+
+	/* ???			cccc 0110 0x00 xxxx xxxx xxxx xxx1 xxxx */
+	DECODE_REJECT	(0x0fb00010, 0x06000010),
+	/* ???			cccc 0110 0xxx xxxx xxxx xxxx 1011 xxxx */
+	DECODE_REJECT	(0x0f8000f0, 0x060000b0),
+	/* ???			cccc 0110 0xxx xxxx xxxx xxxx 1101 xxxx */
+	DECODE_REJECT	(0x0f8000f0, 0x060000d0),
+	/* SADD16		cccc 0110 0001 xxxx xxxx xxxx 0001 xxxx */
+	/* SADDSUBX		cccc 0110 0001 xxxx xxxx xxxx 0011 xxxx */
+	/* SSUBADDX		cccc 0110 0001 xxxx xxxx xxxx 0101 xxxx */
+	/* SSUB16		cccc 0110 0001 xxxx xxxx xxxx 0111 xxxx */
+	/* SADD8		cccc 0110 0001 xxxx xxxx xxxx 1001 xxxx */
+	/* SSUB8		cccc 0110 0001 xxxx xxxx xxxx 1111 xxxx */
+	/* QADD16		cccc 0110 0010 xxxx xxxx xxxx 0001 xxxx */
+	/* QADDSUBX		cccc 0110 0010 xxxx xxxx xxxx 0011 xxxx */
+	/* QSUBADDX		cccc 0110 0010 xxxx xxxx xxxx 0101 xxxx */
+	/* QSUB16		cccc 0110 0010 xxxx xxxx xxxx 0111 xxxx */
+	/* QADD8		cccc 0110 0010 xxxx xxxx xxxx 1001 xxxx */
+	/* QSUB8		cccc 0110 0010 xxxx xxxx xxxx 1111 xxxx */
+	/* SHADD16		cccc 0110 0011 xxxx xxxx xxxx 0001 xxxx */
+	/* SHADDSUBX		cccc 0110 0011 xxxx xxxx xxxx 0011 xxxx */
+	/* SHSUBADDX		cccc 0110 0011 xxxx xxxx xxxx 0101 xxxx */
+	/* SHSUB16		cccc 0110 0011 xxxx xxxx xxxx 0111 xxxx */
+	/* SHADD8		cccc 0110 0011 xxxx xxxx xxxx 1001 xxxx */
+	/* SHSUB8		cccc 0110 0011 xxxx xxxx xxxx 1111 xxxx */
+	/* UADD16		cccc 0110 0101 xxxx xxxx xxxx 0001 xxxx */
+	/* UADDSUBX		cccc 0110 0101 xxxx xxxx xxxx 0011 xxxx */
+	/* USUBADDX		cccc 0110 0101 xxxx xxxx xxxx 0101 xxxx */
+	/* USUB16		cccc 0110 0101 xxxx xxxx xxxx 0111 xxxx */
+	/* UADD8		cccc 0110 0101 xxxx xxxx xxxx 1001 xxxx */
+	/* USUB8		cccc 0110 0101 xxxx xxxx xxxx 1111 xxxx */
+	/* UQADD16		cccc 0110 0110 xxxx xxxx xxxx 0001 xxxx */
+	/* UQADDSUBX		cccc 0110 0110 xxxx xxxx xxxx 0011 xxxx */
+	/* UQSUBADDX		cccc 0110 0110 xxxx xxxx xxxx 0101 xxxx */
+	/* UQSUB16		cccc 0110 0110 xxxx xxxx xxxx 0111 xxxx */
+	/* UQADD8		cccc 0110 0110 xxxx xxxx xxxx 1001 xxxx */
+	/* UQSUB8		cccc 0110 0110 xxxx xxxx xxxx 1111 xxxx */
+	/* UHADD16		cccc 0110 0111 xxxx xxxx xxxx 0001 xxxx */
+	/* UHADDSUBX		cccc 0110 0111 xxxx xxxx xxxx 0011 xxxx */
+	/* UHSUBADDX		cccc 0110 0111 xxxx xxxx xxxx 0101 xxxx */
+	/* UHSUB16		cccc 0110 0111 xxxx xxxx xxxx 0111 xxxx */
+	/* UHADD8		cccc 0110 0111 xxxx xxxx xxxx 1001 xxxx */
+	/* UHSUB8		cccc 0110 0111 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_CUSTOM	(0x0f800010, 0x06000010, prep_emulate_rd12rn16rm0_wflags),
+
+	/* PKHBT		cccc 0110 1000 xxxx xxxx xxxx x001 xxxx */
+	/* PKHTB		cccc 0110 1000 xxxx xxxx xxxx x101 xxxx */
+	DECODE_CUSTOM	(0x0ff00030, 0x06800010, prep_emulate_rd12rn16rm0_wflags),
+
+	/* ???			cccc 0110 1001 xxxx xxxx xxxx 0111 xxxx */
+	/* ???			cccc 0110 1101 xxxx xxxx xxxx 0111 xxxx */
+	DECODE_REJECT	(0x0fb000f0, 0x06900070),
+
+	/* SXTB16		cccc 0110 1000 1111 xxxx xxxx 0111 xxxx */
+	/* SXTB			cccc 0110 1010 1111 xxxx xxxx 0111 xxxx */
+	/* SXTH			cccc 0110 1011 1111 xxxx xxxx 0111 xxxx */
+	/* UXTB16		cccc 0110 1100 1111 xxxx xxxx 0111 xxxx */
+	/* UXTB			cccc 0110 1110 1111 xxxx xxxx 0111 xxxx */
+	/* UXTH			cccc 0110 1111 1111 xxxx xxxx 0111 xxxx */
+	DECODE_CUSTOM	(0x0f8f00f0, 0x068f0070, prep_emulate_rd12rm0),
+
+	/* SXTAB16		cccc 0110 1000 xxxx xxxx xxxx 0111 xxxx */
+	/* SXTAB		cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx */
+	/* SXTAH		cccc 0110 1011 xxxx xxxx xxxx 0111 xxxx */
+	/* UXTAB16		cccc 0110 1100 xxxx xxxx xxxx 0111 xxxx */
+	/* UXTAB		cccc 0110 1110 xxxx xxxx xxxx 0111 xxxx */
+	/* UXTAH		cccc 0110 1111 xxxx xxxx xxxx 0111 xxxx */
+	DECODE_CUSTOM	(0x0f8000f0, 0x06800070, prep_emulate_rd12rn16rm0_wflags),
 
-	/* Other instruction encodings aren't yet defined */
-	return INSN_REJECTED;
-}
+	DECODE_END
+};
 
 static enum kprobe_insn __kprobes
 space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
@@ -1563,7 +1528,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	else if ((insn & 0x0f000010) == 0x06000010)
 
-		return space_cccc_0110__1(insn, asi);
+		return kprobe_decode_insn(insn, asi, arm_cccc_0110_____xxx1_table, false);
 
 	else if ((insn & 0x0f000010) == 0x07000010)
 
-- 
1.7.2.5
