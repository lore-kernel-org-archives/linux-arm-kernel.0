From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:36 +0100
Subject: [PATCH 49/51] ARM: kprobes: Decode 32-bit Thumb data-processing
	(register) instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-50-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |  108 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 9be8bea..7c32e5b 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -661,6 +661,108 @@ static const union decode_item t32_table_1111_100x[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_1010___1111[] = {
+	/* Data-processing (register)					*/
+
+	/* ???			1111 1010 011x xxxx 1111 xxxx 1xxx xxxx */
+	DECODE_REJECT	(0xffe0f080, 0xfa60f080),
+
+	/* SXTH			1111 1010 0000 1111 1111 xxxx 1xxx xxxx */
+	/* UXTH			1111 1010 0001 1111 1111 xxxx 1xxx xxxx */
+	/* SXTB16		1111 1010 0010 1111 1111 xxxx 1xxx xxxx */
+	/* UXTB16		1111 1010 0011 1111 1111 xxxx 1xxx xxxx */
+	/* SXTB			1111 1010 0100 1111 1111 xxxx 1xxx xxxx */
+	/* UXTB			1111 1010 0101 1111 1111 xxxx 1xxx xxxx */
+	DECODE_EMULATEX	(0xff8ff080, 0xfa0ff080, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(0, 0, NOSPPC, 0, NOSPPC)),
+
+
+	/* ???			1111 1010 1xxx xxxx 1111 xxxx 0x11 xxxx */
+	DECODE_REJECT	(0xff80f0b0, 0xfa80f030),
+	/* ???			1111 1010 1x11 xxxx 1111 xxxx 0xxx xxxx */
+	DECODE_REJECT	(0xffb0f080, 0xfab0f000),
+
+	/* SADD16		1111 1010 1001 xxxx 1111 xxxx 0000 xxxx */
+	/* SASX			1111 1010 1010 xxxx 1111 xxxx 0000 xxxx */
+	/* SSAX			1111 1010 1110 xxxx 1111 xxxx 0000 xxxx */
+	/* SSUB16		1111 1010 1101 xxxx 1111 xxxx 0000 xxxx */
+	/* SADD8		1111 1010 1000 xxxx 1111 xxxx 0000 xxxx */
+	/* SSUB8		1111 1010 1100 xxxx 1111 xxxx 0000 xxxx */
+
+	/* QADD16		1111 1010 1001 xxxx 1111 xxxx 0001 xxxx */
+	/* QASX			1111 1010 1010 xxxx 1111 xxxx 0001 xxxx */
+	/* QSAX			1111 1010 1110 xxxx 1111 xxxx 0001 xxxx */
+	/* QSUB16		1111 1010 1101 xxxx 1111 xxxx 0001 xxxx */
+	/* QADD8		1111 1010 1000 xxxx 1111 xxxx 0001 xxxx */
+	/* QSUB8		1111 1010 1100 xxxx 1111 xxxx 0001 xxxx */
+
+	/* SHADD16		1111 1010 1001 xxxx 1111 xxxx 0010 xxxx */
+	/* SHASX		1111 1010 1010 xxxx 1111 xxxx 0010 xxxx */
+	/* SHSAX		1111 1010 1110 xxxx 1111 xxxx 0010 xxxx */
+	/* SHSUB16		1111 1010 1101 xxxx 1111 xxxx 0010 xxxx */
+	/* SHADD8		1111 1010 1000 xxxx 1111 xxxx 0010 xxxx */
+	/* SHSUB8		1111 1010 1100 xxxx 1111 xxxx 0010 xxxx */
+
+	/* UADD16		1111 1010 1001 xxxx 1111 xxxx 0100 xxxx */
+	/* UASX			1111 1010 1010 xxxx 1111 xxxx 0100 xxxx */
+	/* USAX			1111 1010 1110 xxxx 1111 xxxx 0100 xxxx */
+	/* USUB16		1111 1010 1101 xxxx 1111 xxxx 0100 xxxx */
+	/* UADD8		1111 1010 1000 xxxx 1111 xxxx 0100 xxxx */
+	/* USUB8		1111 1010 1100 xxxx 1111 xxxx 0100 xxxx */
+
+	/* UQADD16		1111 1010 1001 xxxx 1111 xxxx 0101 xxxx */
+	/* UQASX		1111 1010 1010 xxxx 1111 xxxx 0101 xxxx */
+	/* UQSAX		1111 1010 1110 xxxx 1111 xxxx 0101 xxxx */
+	/* UQSUB16		1111 1010 1101 xxxx 1111 xxxx 0101 xxxx */
+	/* UQADD8		1111 1010 1000 xxxx 1111 xxxx 0101 xxxx */
+	/* UQSUB8		1111 1010 1100 xxxx 1111 xxxx 0101 xxxx */
+
+	/* UHADD16		1111 1010 1001 xxxx 1111 xxxx 0110 xxxx */
+	/* UHASX		1111 1010 1010 xxxx 1111 xxxx 0110 xxxx */
+	/* UHSAX		1111 1010 1110 xxxx 1111 xxxx 0110 xxxx */
+	/* UHSUB16		1111 1010 1101 xxxx 1111 xxxx 0110 xxxx */
+	/* UHADD8		1111 1010 1000 xxxx 1111 xxxx 0110 xxxx */
+	/* UHSUB8		1111 1010 1100 xxxx 1111 xxxx 0110 xxxx */
+	DECODE_OR	(0xff80f080, 0xfa80f000),
+
+	/* SXTAH		1111 1010 0000 xxxx 1111 xxxx 1xxx xxxx */
+	/* UXTAH		1111 1010 0001 xxxx 1111 xxxx 1xxx xxxx */
+	/* SXTAB16		1111 1010 0010 xxxx 1111 xxxx 1xxx xxxx */
+	/* UXTAB16		1111 1010 0011 xxxx 1111 xxxx 1xxx xxxx */
+	/* SXTAB		1111 1010 0100 xxxx 1111 xxxx 1xxx xxxx */
+	/* UXTAB		1111 1010 0101 xxxx 1111 xxxx 1xxx xxxx */
+	DECODE_OR	(0xff80f080, 0xfa00f080),
+
+	/* QADD			1111 1010 1000 xxxx 1111 xxxx 1000 xxxx */
+	/* QDADD		1111 1010 1000 xxxx 1111 xxxx 1001 xxxx */
+	/* QSUB			1111 1010 1000 xxxx 1111 xxxx 1010 xxxx */
+	/* QDSUB		1111 1010 1000 xxxx 1111 xxxx 1011 xxxx */
+	DECODE_OR	(0xfff0f0c0, 0xfa80f080),
+
+	/* SEL			1111 1010 1010 xxxx 1111 xxxx 1000 xxxx */
+	DECODE_OR	(0xfff0f0f0, 0xfaa0f080),
+
+	/* LSL			1111 1010 000x xxxx 1111 xxxx 0000 xxxx */
+	/* LSR			1111 1010 001x xxxx 1111 xxxx 0000 xxxx */
+	/* ASR			1111 1010 010x xxxx 1111 xxxx 0000 xxxx */
+	/* ROR			1111 1010 011x xxxx 1111 xxxx 0000 xxxx */
+	DECODE_EMULATEX	(0xff80f0f0, 0xfa00f000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, NOSPPC)),
+
+	/* CLZ			1111 1010 1010 xxxx 1111 xxxx 1000 xxxx */
+	DECODE_OR	(0xfff0f0f0, 0xfab0f080),
+
+	/* REV			1111 1010 1001 xxxx 1111 xxxx 1000 xxxx */
+	/* REV16		1111 1010 1001 xxxx 1111 xxxx 1001 xxxx */
+	/* RBIT			1111 1010 1001 xxxx 1111 xxxx 1010 xxxx */
+	/* REVSH		1111 1010 1001 xxxx 1111 xxxx 1011 xxxx */
+	DECODE_EMULATEX	(0xfff0f0c0, 0xfa90f080, t32_emulate_rd8rn16_noflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, SAMEAS16)),
+
+	/* Other unallocated instructions...				*/
+	DECODE_END
+};
+
 const union decode_item kprobe_decode_thumb32_table[] = {
 
 	/*
@@ -726,6 +828,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfe000000, 0xf8000000, t32_table_1111_100x),
 
 	/*
+	 * Data-processing (register)
+	 *			1111 1010 xxxx xxxx 1111 xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xff00f000, 0xfa00f000, t32_table_1111_1010___1111),
+
+	/*
 	 * Coprocessor instructions
 	 *			1111 11xx xxxx xxxx xxxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
