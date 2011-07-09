From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:38 +0100
Subject: [PATCH 51/51] ARM: kprobes: Decode 32-bit Thumb multiply and absolute
	difference instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-52-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   49 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 4ef12d1..902ca59 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -315,6 +315,10 @@ t32_emulate_rdlo12rdhi8rn16rm0_noflags(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rdhi] = rdhiv;
 }
 
+/* These emulation encodings are functionally equivalent... */
+#define t32_emulate_rd8rn16rm0ra12_noflags \
+		t32_emulate_rdlo12rdhi8rn16rm0_noflags
+
 static const union decode_item t32_table_1110_100x_x0xx[] = {
 	/* Load/store multiple instructions */
 
@@ -789,6 +793,45 @@ static const union decode_item t32_table_1111_1010___1111[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_1011_0[] = {
+	/* Multiply, multiply accumulate, and absolute difference	*/
+
+	/* ???			1111 1011 0000 xxxx 1111 xxxx 0001 xxxx */
+	DECODE_REJECT	(0xfff0f0f0, 0xfb00f010),
+	/* ???			1111 1011 0111 xxxx 1111 xxxx 0001 xxxx */
+	DECODE_REJECT	(0xfff0f0f0, 0xfb70f010),
+
+	/* SMULxy		1111 1011 0001 xxxx 1111 xxxx 00xx xxxx */
+	DECODE_OR	(0xfff0f0c0, 0xfb10f000),
+	/* MUL			1111 1011 0000 xxxx 1111 xxxx 0000 xxxx */
+	/* SMUAD{X}		1111 1011 0010 xxxx 1111 xxxx 000x xxxx */
+	/* SMULWy		1111 1011 0011 xxxx 1111 xxxx 000x xxxx */
+	/* SMUSD{X}		1111 1011 0100 xxxx 1111 xxxx 000x xxxx */
+	/* SMMUL{R}		1111 1011 0101 xxxx 1111 xxxx 000x xxxx */
+	/* USAD8		1111 1011 0111 xxxx 1111 xxxx 0000 xxxx */
+	DECODE_EMULATEX	(0xff80f0e0, 0xfb00f000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, NOSPPC)),
+
+	/* ???			1111 1011 0111 xxxx xxxx xxxx 0001 xxxx */
+	DECODE_REJECT	(0xfff000f0, 0xfb700010),
+
+	/* SMLAxy		1111 1011 0001 xxxx xxxx xxxx 00xx xxxx */
+	DECODE_OR	(0xfff000c0, 0xfb100000),
+	/* MLA			1111 1011 0000 xxxx xxxx xxxx 0000 xxxx */
+	/* MLS			1111 1011 0000 xxxx xxxx xxxx 0001 xxxx */
+	/* SMLAD{X}		1111 1011 0010 xxxx xxxx xxxx 000x xxxx */
+	/* SMLAWy		1111 1011 0011 xxxx xxxx xxxx 000x xxxx */
+	/* SMLSD{X}		1111 1011 0100 xxxx xxxx xxxx 000x xxxx */
+	/* SMMLA{R}		1111 1011 0101 xxxx xxxx xxxx 000x xxxx */
+	/* SMMLS{R}		1111 1011 0110 xxxx xxxx xxxx 000x xxxx */
+	/* USADA8		1111 1011 0111 xxxx xxxx xxxx 0000 xxxx */
+	DECODE_EMULATEX	(0xff8000c0, 0xfb000000, t32_emulate_rd8rn16rm0ra12_noflags,
+						 REGS(NOSPPC, NOSPPCX, NOSPPC, 0, NOSPPC)),
+
+	/* Other unallocated instructions...				*/
+	DECODE_END
+};
+
 static const union decode_item t32_table_1111_1011_1[] = {
 	/* Long multiply, long multiply accumulate, and divide		*/
 
@@ -883,6 +926,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xff00f000, 0xfa00f000, t32_table_1111_1010___1111),
 
 	/*
+	 * Multiply, multiply accumulate, and absolute difference
+	 *			1111 1011 0xxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xff800000, 0xfb000000, t32_table_1111_1011_0),
+
+	/*
 	 * Long multiply, long multiply accumulate, and divide
 	 *			1111 1011 1xxx xxxx xxxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
