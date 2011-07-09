From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:29 +0100
Subject: [PATCH 42/51] ARM: kprobes: Decode 32-bit Thumb data-processing
	(modified immediate) instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-43-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   58 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index eac945c..cf83448 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -241,6 +241,58 @@ static const union decode_item t32_table_1110_101x[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_0x0x___0[] = {
+	/* Data-processing (modified immediate)				*/
+
+	/* TST			1111 0x00 0001 xxxx 0xxx 1111 xxxx xxxx */
+	/* TEQ			1111 0x00 1001 xxxx 0xxx 1111 xxxx xxxx */
+	DECODE_EMULATEX	(0xfb708f00, 0xf0100f00, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, 0, 0, 0)),
+
+	/* CMN			1111 0x01 0001 xxxx 0xxx 1111 xxxx xxxx */
+	DECODE_OR	(0xfbf08f00, 0xf1100f00),
+	/* CMP			1111 0x01 1011 xxxx 0xxx 1111 xxxx xxxx */
+	DECODE_EMULATEX	(0xfbf08f00, 0xf1b00f00, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOPC, 0, 0, 0, 0)),
+
+	/* MOV			1111 0x00 010x 1111 0xxx xxxx xxxx xxxx */
+	/* MVN			1111 0x00 011x 1111 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfbcf8000, 0xf04f0000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(0, 0, NOSPPC, 0, 0)),
+
+	/* ???			1111 0x00 101x xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfbe08000, 0xf0a00000),
+	/* ???			1111 0x00 110x xxxx 0xxx xxxx xxxx xxxx */
+	/* ???			1111 0x00 111x xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfbc08000, 0xf0c00000),
+	/* ???			1111 0x01 001x xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfbe08000, 0xf1200000),
+	/* ???			1111 0x01 100x xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfbe08000, 0xf1800000),
+	/* ???			1111 0x01 111x xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfbe08000, 0xf1e00000),
+
+	/* ADD Rd, SP, #imm	1111 0x01 000x 1101 0xxx xxxx xxxx xxxx */
+	/* SUB Rd, SP, #imm	1111 0x01 101x 1101 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfb4f8000, 0xf10d0000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(SP, 0, NOPC, 0, 0)),
+
+	/* AND			1111 0x00 000x xxxx 0xxx xxxx xxxx xxxx */
+	/* BIC			1111 0x00 001x xxxx 0xxx xxxx xxxx xxxx */
+	/* ORR			1111 0x00 010x xxxx 0xxx xxxx xxxx xxxx */
+	/* ORN			1111 0x00 011x xxxx 0xxx xxxx xxxx xxxx */
+	/* EOR			1111 0x00 100x xxxx 0xxx xxxx xxxx xxxx */
+	/* ADD			1111 0x01 000x xxxx 0xxx xxxx xxxx xxxx */
+	/* ADC			1111 0x01 010x xxxx 0xxx xxxx xxxx xxxx */
+	/* SBC			1111 0x01 011x xxxx 0xxx xxxx xxxx xxxx */
+	/* SUB			1111 0x01 101x xxxx 0xxx xxxx xxxx xxxx */
+	/* RSB			1111 0x01 110x xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfa008000, 0xf0000000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, 0)),
+
+	DECODE_END
+};
+
 static const union decode_item t32_table_1111_0xxx___1[] = {
 	/* Branches and miscellaneous control				*/
 
@@ -277,6 +329,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfe000000, 0xea000000, t32_table_1110_101x),
 
 	/*
+	 * Data-processing (modified immediate)
+	 *			1111 0x0x xxxx xxxx 0xxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfa008000, 0xf0000000, t32_table_1111_0x0x___0),
+
+	/*
 	 * Branches and miscellaneous control
 	 *			1111 0xxx xxxx xxxx 1xxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
