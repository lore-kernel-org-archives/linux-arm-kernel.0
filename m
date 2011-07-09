From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:25 +0100
Subject: [PATCH 38/51] ARM: kprobes: Decode 32-bit Thumb load/store multiple
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-39-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   48 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 27f83a3..d25e5cb 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -37,6 +37,48 @@ static inline unsigned long __kprobes thumb_probe_pc(struct kprobe *p)
 	return (unsigned long)p->addr - 1 + 4;
 }
 
+static enum kprobe_insn __kprobes
+t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	enum kprobe_insn ret = kprobe_decode_ldmstm(insn, asi);
+
+	/* Fixup modified instruction to have halfwords in correct order...*/
+	insn = asi->insn[0];
+	((u16 *)asi->insn)[0] = insn >> 16;
+	((u16 *)asi->insn)[1] = insn & 0xffff;
+
+	return ret;
+}
+
+static const union decode_item t32_table_1110_100x_x0xx[] = {
+	/* Load/store multiple instructions */
+
+	/* Rn is PC		1110 100x x0xx 1111 xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfe4f0000, 0xe80f0000),
+
+	/* SRS			1110 1000 00x0 xxxx xxxx xxxx xxxx xxxx */
+	/* RFE			1110 1000 00x1 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xffc00000, 0xe8000000),
+	/* SRS			1110 1001 10x0 xxxx xxxx xxxx xxxx xxxx */
+	/* RFE			1110 1001 10x1 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xffc00000, 0xe9800000),
+
+	/* STM Rn, {...pc}	1110 100x x0x0 xxxx 1xxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfe508000, 0xe8008000),
+	/* LDM Rn, {...lr,pc}	1110 100x x0x1 xxxx 11xx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfe50c000, 0xe810c000),
+	/* LDM/STM Rn, {...sp}	1110 100x x0xx xxxx xx1x xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfe402000, 0xe8002000),
+
+	/* STMIA		1110 1000 10x0 xxxx xxxx xxxx xxxx xxxx */
+	/* LDMIA		1110 1000 10x1 xxxx xxxx xxxx xxxx xxxx */
+	/* STMDB		1110 1001 00x0 xxxx xxxx xxxx xxxx xxxx */
+	/* LDMDB		1110 1001 00x1 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_CUSTOM	(0xfe400000, 0xe8000000, t32_decode_ldmstm),
+
+	DECODE_END
+};
+
 static const union decode_item t32_table_1111_0xxx___1[] = {
 	/* Branches and miscellaneous control				*/
 
@@ -55,6 +97,12 @@ static const union decode_item t32_table_1111_0xxx___1[] = {
 const union decode_item kprobe_decode_thumb32_table[] = {
 
 	/*
+	 * Load/store multiple instructions
+	 *			1110 100x x0xx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfe400000, 0xe8000000, t32_table_1110_100x_x0xx),
+
+	/*
 	 * Branches and miscellaneous control
 	 *			1111 0xxx xxxx xxxx 1xxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
