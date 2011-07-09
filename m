From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:34 +0100
Subject: [PATCH 47/51] ARM: kprobes: Decode 32-bit Thumb memory hint
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-48-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

We'll treat the preload instructions as nops as they are just
performance hints.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 6cc51b4..bf1113c 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -489,6 +489,33 @@ static const union decode_item t32_table_1111_0xxx___1[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_100x_x0x1__1111[] = {
+	/* Memory hints							*/
+
+	/* PLD (literal)	1111 1000 x001 1111 1111 xxxx xxxx xxxx */
+	/* PLI (literal)	1111 1001 x001 1111 1111 xxxx xxxx xxxx */
+	DECODE_SIMULATE	(0xfe7ff000, 0xf81ff000, kprobe_simulate_nop),
+
+	/* PLD{W} (immediate)	1111 1000 10x1 xxxx 1111 xxxx xxxx xxxx */
+	DECODE_OR	(0xffd0f000, 0xf890f000),
+	/* PLD{W} (immediate)	1111 1000 00x1 xxxx 1111 1100 xxxx xxxx */
+	DECODE_OR	(0xffd0ff00, 0xf810fc00),
+	/* PLI (immediate)	1111 1001 1001 xxxx 1111 xxxx xxxx xxxx */
+	DECODE_OR	(0xfff0f000, 0xf990f000),
+	/* PLI (immediate)	1111 1001 0001 xxxx 1111 1100 xxxx xxxx */
+	DECODE_SIMULATEX(0xfff0ff00, 0xf910fc00, kprobe_simulate_nop,
+						 REGS(NOPCX, 0, 0, 0, 0)),
+
+	/* PLD{W} (register)	1111 1000 00x1 xxxx 1111 0000 00xx xxxx */
+	DECODE_OR	(0xffd0ffc0, 0xf810f000),
+	/* PLI (register)	1111 1001 0001 xxxx 1111 0000 00xx xxxx */
+	DECODE_SIMULATEX(0xfff0ffc0, 0xf910f000, kprobe_simulate_nop,
+						 REGS(NOPCX, 0, 0, 0, NOSPPC)),
+
+	/* Other unallocated instructions...				*/
+	DECODE_END
+};
+
 const union decode_item kprobe_decode_thumb32_table[] = {
 
 	/*
@@ -540,6 +567,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_REJECT	(0xff100000, 0xf9000000),
 
 	/*
+	 * Memory hints
+	 *			1111 100x x0x1 xxxx 1111 xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfe50f000, 0xf810f000, t32_table_1111_100x_x0x1__1111),
+
+	/*
 	 * Coprocessor instructions
 	 *			1111 11xx xxxx xxxx xxxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
