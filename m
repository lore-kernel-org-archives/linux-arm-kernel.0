From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:10 +0100
Subject: [PATCH 21/24] ARM: kprobes: Use new versions of emulate_ldr() and
	emulate_str()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-22-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   44 +++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index d252e78..1ee38ad 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1275,19 +1275,25 @@ static const union decode_item arm_cccc_000x_____1xx1_table[] = {
 	DECODE_EMULATEX	(0x0e5000d0, 0x004000d0, emulate_ldrdstrd,
 						 REGS(NOPCWB, NOPCX, 0, 0, 0)),
 
-	/* Reject Rd is PC */
-	/* TODO: fold this into next entry when it is made a DECODE_EMULATE */
-	DECODE_REJECT	(0x0000f000, 0x0000f000),
-
 	/* STRH (register)	cccc 000x x0x0 xxxx xxxx xxxx 1011 xxxx */
+	DECODE_EMULATEX	(0x0e5000f0, 0x000000b0, emulate_str,
+						 REGS(NOPCWB, NOPC, 0, 0, NOPC)),
+
 	/* LDRH (register)	cccc 000x x0x1 xxxx xxxx xxxx 1011 xxxx */
 	/* LDRSB (register)	cccc 000x x0x1 xxxx xxxx xxxx 1101 xxxx */
 	/* LDRSH (register)	cccc 000x x0x1 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_EMULATEX	(0x0e500090, 0x00100090, emulate_ldr,
+						 REGS(NOPCWB, NOPC, 0, 0, NOPC)),
+
 	/* STRH (immediate)	cccc 000x x1x0 xxxx xxxx xxxx 1011 xxxx */
+	DECODE_EMULATEX	(0x0e5000f0, 0x004000b0, emulate_str,
+						 REGS(NOPCWB, NOPC, 0, 0, 0)),
+
 	/* LDRH (immediate)	cccc 000x x1x1 xxxx xxxx xxxx 1011 xxxx */
 	/* LDRSB (immediate)	cccc 000x x1x1 xxxx xxxx xxxx 1101 xxxx */
 	/* LDRSH (immediate)	cccc 000x x1x1 xxxx xxxx xxxx 1111 xxxx */
-	DECODE_CUSTOM	(0x0e000090, 0x00000090, prep_emulate_ldr_str),
+	DECODE_EMULATEX	(0x0e500090, 0x00500090, emulate_ldr,
+						 REGS(NOPCWB, NOPC, 0, 0, 0)),
 
 	DECODE_END
 };
@@ -1558,15 +1564,25 @@ static const union decode_item arm_cccc_01xx_table[] = {
 	/* LDRB/STRB pc,[...]	cccc 01xx x0xx xxxx xxxx xxxx xxxx xxxx */
 	DECODE_REJECT	(0x0c40f000, 0x0440f000),
 
-	/* LDR			cccc 01xx x0x1 xxxx xxxx xxxx xxxx xxxx */
-	/* LDRB			cccc 01xx x1x1 xxxx xxxx xxxx xxxx xxxx */
-	/* LDRBT		cccc 01x0 x111 xxxx xxxx xxxx xxxx xxxx */
-	/* LDRT			cccc 01x0 x011 xxxx xxxx xxxx xxxx xxxx */
-	/* STR			cccc 01xx x0x0 xxxx xxxx xxxx xxxx xxxx */
-	/* STRB			cccc 01xx x1x0 xxxx xxxx xxxx xxxx xxxx */
-	/* STRBT		cccc 01x0 x110 xxxx xxxx xxxx xxxx xxxx */
-	/* STRT			cccc 01x0 x010 xxxx xxxx xxxx xxxx xxxx */
-	DECODE_CUSTOM	(0x0c000000, 0x04000000, prep_emulate_ldr_str),
+	/* STR (immediate)	cccc 010x x0x0 xxxx xxxx xxxx xxxx xxxx */
+	/* STRB (immediate)	cccc 010x x1x0 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0e100000, 0x04000000, emulate_str,
+						 REGS(NOPCWB, ANY, 0, 0, 0)),
+
+	/* LDR (immediate)	cccc 010x x0x1 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRB (immediate)	cccc 010x x1x1 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0e100000, 0x04100000, emulate_ldr,
+						 REGS(NOPCWB, ANY, 0, 0, 0)),
+
+	/* STR (register)	cccc 011x x0x0 xxxx xxxx xxxx xxxx xxxx */
+	/* STRB (register)	cccc 011x x1x0 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0e100000, 0x06000000, emulate_str,
+						 REGS(NOPCWB, ANY, 0, 0, NOPC)),
+
+	/* LDR (register)	cccc 011x x0x1 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRB (register)	cccc 011x x1x1 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0e100000, 0x06100000, emulate_ldr,
+						 REGS(NOPCWB, ANY, 0, 0, NOPC)),
 
 	DECODE_END
 };
-- 
1.7.2.5
