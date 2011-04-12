From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Apr 2011 07:45:23 +0100
Subject: [PATCH 3/6] ARM: kprobes: Reject probing of undefined media
	instructions
In-Reply-To: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302590726-3484-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The instructions space for media instructions contains some undefined
patterns. We need to reject probing of these because they may in future
become defined and the kprobes code may then emulate them faultily.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index f6367bf..a824a79 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1326,52 +1326,86 @@ space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	    (insn & 0x0ff00070) == 0x06f00030)
 		return prep_emulate_rd12rm0(insn, asi);
 
+	/* ???       : cccc 0110 0000 xxxx xxxx xxxx xxx1 xxxx :   */
 	/* SADD16    : cccc 0110 0001 xxxx xxxx xxxx 0001 xxxx :GE */
 	/* SADDSUBX  : cccc 0110 0001 xxxx xxxx xxxx 0011 xxxx :GE */
 	/* SSUBADDX  : cccc 0110 0001 xxxx xxxx xxxx 0101 xxxx :GE */
 	/* SSUB16    : cccc 0110 0001 xxxx xxxx xxxx 0111 xxxx :GE */
 	/* SADD8     : cccc 0110 0001 xxxx xxxx xxxx 1001 xxxx :GE */
+	/* ???       : cccc 0110 0001 xxxx xxxx xxxx 1011 xxxx :   */
+	/* ???       : cccc 0110 0001 xxxx xxxx xxxx 1101 xxxx :   */
 	/* SSUB8     : cccc 0110 0001 xxxx xxxx xxxx 1111 xxxx :GE */
 	/* QADD16    : cccc 0110 0010 xxxx xxxx xxxx 0001 xxxx :   */
 	/* QADDSUBX  : cccc 0110 0010 xxxx xxxx xxxx 0011 xxxx :   */
 	/* QSUBADDX  : cccc 0110 0010 xxxx xxxx xxxx 0101 xxxx :   */
 	/* QSUB16    : cccc 0110 0010 xxxx xxxx xxxx 0111 xxxx :   */
 	/* QADD8     : cccc 0110 0010 xxxx xxxx xxxx 1001 xxxx :   */
+	/* ???       : cccc 0110 0010 xxxx xxxx xxxx 1011 xxxx :   */
+	/* ???       : cccc 0110 0010 xxxx xxxx xxxx 1101 xxxx :   */
 	/* QSUB8     : cccc 0110 0010 xxxx xxxx xxxx 1111 xxxx :   */
 	/* SHADD16   : cccc 0110 0011 xxxx xxxx xxxx 0001 xxxx :   */
 	/* SHADDSUBX : cccc 0110 0011 xxxx xxxx xxxx 0011 xxxx :   */
 	/* SHSUBADDX : cccc 0110 0011 xxxx xxxx xxxx 0101 xxxx :   */
 	/* SHSUB16   : cccc 0110 0011 xxxx xxxx xxxx 0111 xxxx :   */
 	/* SHADD8    : cccc 0110 0011 xxxx xxxx xxxx 1001 xxxx :   */
+	/* ???       : cccc 0110 0011 xxxx xxxx xxxx 1011 xxxx :   */
+	/* ???       : cccc 0110 0011 xxxx xxxx xxxx 1101 xxxx :   */
 	/* SHSUB8    : cccc 0110 0011 xxxx xxxx xxxx 1111 xxxx :   */
+	/* ???       : cccc 0110 0100 xxxx xxxx xxxx xxx1 xxxx :   */
 	/* UADD16    : cccc 0110 0101 xxxx xxxx xxxx 0001 xxxx :GE */
 	/* UADDSUBX  : cccc 0110 0101 xxxx xxxx xxxx 0011 xxxx :GE */
 	/* USUBADDX  : cccc 0110 0101 xxxx xxxx xxxx 0101 xxxx :GE */
 	/* USUB16    : cccc 0110 0101 xxxx xxxx xxxx 0111 xxxx :GE */
 	/* UADD8     : cccc 0110 0101 xxxx xxxx xxxx 1001 xxxx :GE */
+	/* ???       : cccc 0110 0101 xxxx xxxx xxxx 1011 xxxx :   */
+	/* ???       : cccc 0110 0101 xxxx xxxx xxxx 1101 xxxx :   */
 	/* USUB8     : cccc 0110 0101 xxxx xxxx xxxx 1111 xxxx :GE */
 	/* UQADD16   : cccc 0110 0110 xxxx xxxx xxxx 0001 xxxx :   */
 	/* UQADDSUBX : cccc 0110 0110 xxxx xxxx xxxx 0011 xxxx :   */
 	/* UQSUBADDX : cccc 0110 0110 xxxx xxxx xxxx 0101 xxxx :   */
 	/* UQSUB16   : cccc 0110 0110 xxxx xxxx xxxx 0111 xxxx :   */
 	/* UQADD8    : cccc 0110 0110 xxxx xxxx xxxx 1001 xxxx :   */
+	/* ???       : cccc 0110 0110 xxxx xxxx xxxx 1011 xxxx :   */
+	/* ???       : cccc 0110 0110 xxxx xxxx xxxx 1101 xxxx :   */
 	/* UQSUB8    : cccc 0110 0110 xxxx xxxx xxxx 1111 xxxx :   */
 	/* UHADD16   : cccc 0110 0111 xxxx xxxx xxxx 0001 xxxx :   */
 	/* UHADDSUBX : cccc 0110 0111 xxxx xxxx xxxx 0011 xxxx :   */
 	/* UHSUBADDX : cccc 0110 0111 xxxx xxxx xxxx 0101 xxxx :   */
 	/* UHSUB16   : cccc 0110 0111 xxxx xxxx xxxx 0111 xxxx :   */
 	/* UHADD8    : cccc 0110 0111 xxxx xxxx xxxx 1001 xxxx :   */
+	/* ???       : cccc 0110 0111 xxxx xxxx xxxx 1011 xxxx :   */
+	/* ???       : cccc 0110 0111 xxxx xxxx xxxx 1101 xxxx :   */
 	/* UHSUB8    : cccc 0110 0111 xxxx xxxx xxxx 1111 xxxx :   */
+	if ((insn & 0x0f800010) == 0x06000010) {
+		if ((insn & 0x00300000) == 0x00000000 ||
+		    (insn & 0x000000e0) == 0x000000a0 ||
+		    (insn & 0x000000e0) == 0x000000c0)
+			return INSN_REJECTED;	/* Unallocated space */
+		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+	}
+
 	/* PKHBT     : cccc 0110 1000 xxxx xxxx xxxx x001 xxxx :   */
 	/* PKHTB     : cccc 0110 1000 xxxx xxxx xxxx x101 xxxx :   */
+	if ((insn & 0x0ff00030) == 0x06800010)
+		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+
 	/* SXTAB16   : cccc 0110 1000 xxxx xxxx xxxx 0111 xxxx :   */
 	/* SXTB      : cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx :   */
+	/* ???       : cccc 0110 1001 xxxx xxxx xxxx 0111 xxxx :   */
 	/* SXTAB     : cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx :   */
 	/* SXTAH     : cccc 0110 1011 xxxx xxxx xxxx 0111 xxxx :   */
 	/* UXTAB16   : cccc 0110 1100 xxxx xxxx xxxx 0111 xxxx :   */
+	/* ???       : cccc 0110 1101 xxxx xxxx xxxx 0111 xxxx :   */
 	/* UXTAB     : cccc 0110 1110 xxxx xxxx xxxx 0111 xxxx :   */
 	/* UXTAH     : cccc 0110 1111 xxxx xxxx xxxx 0111 xxxx :   */
-	return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+	if ((insn & 0x0f8000f0) == 0x06800070) {
+		if ((insn & 0x00300000) == 0x00100000)
+			return INSN_REJECTED;	/* Unallocated space */
+		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+	}
+
+	/* Other instruction encodings aren't yet defined */
+	return INSN_REJECTED;
 }
 
 static enum kprobe_insn __kprobes
-- 
1.7.2.5
