From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:30 +0100
Subject: [PATCH 43/51] ARM: kprobes: Decode 32-bit Thumb data-processing
	(plain binary immediate) instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-44-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   95 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index cf83448..1fbeba8 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -124,6 +124,46 @@ t32_emulate_rd8rn16rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
 	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
 }
 
+static void __kprobes
+t32_emulate_rd8pc16_noflags(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+	int rd = (insn >> 8) & 0xf;
+
+	register unsigned long rdv asm("r1") = regs->uregs[rd];
+	register unsigned long rnv asm("r2") = pc & ~3;
+
+	__asm__ __volatile__ (
+		"blx    %[fn]"
+		: "=r" (rdv)
+		: "0" (rdv), "r" (rnv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rd] = rdv;
+}
+
+static void __kprobes
+t32_emulate_rd8rn16_noflags(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 8) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+
+	register unsigned long rdv asm("r1") = regs->uregs[rd];
+	register unsigned long rnv asm("r2") = regs->uregs[rn];
+
+	__asm__ __volatile__ (
+		"blx    %[fn]"
+		: "=r" (rdv)
+		: "0" (rdv), "r" (rnv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rd] = rdv;
+}
+
 static const union decode_item t32_table_1110_100x_x0xx[] = {
 	/* Load/store multiple instructions */
 
@@ -293,6 +333,55 @@ static const union decode_item t32_table_1111_0x0x___0[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_0x1x___0[] = {
+	/* Data-processing (plain binary immediate)			*/
+
+	/* ADDW Rd, PC, #imm	1111 0x10 0000 1111 0xxx xxxx xxxx xxxx */
+	DECODE_OR	(0xfbff8000, 0xf20f0000),
+	/* SUBW	Rd, PC, #imm	1111 0x10 1010 1111 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfbff8000, 0xf2af0000, t32_emulate_rd8pc16_noflags,
+						 REGS(PC, 0, NOSPPC, 0, 0)),
+
+	/* ADDW SP, SP, #imm	1111 0x10 0000 1101 0xxx 1101 xxxx xxxx */
+	DECODE_OR	(0xfbff8f00, 0xf20d0d00),
+	/* SUBW	SP, SP, #imm	1111 0x10 1010 1101 0xxx 1101 xxxx xxxx */
+	DECODE_EMULATEX	(0xfbff8f00, 0xf2ad0d00, t32_emulate_rd8rn16_noflags,
+						 REGS(SP, 0, SP, 0, 0)),
+
+	/* ADDW			1111 0x10 0000 xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_OR	(0xfbf08000, 0xf2000000),
+	/* SUBW			1111 0x10 1010 xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfbf08000, 0xf2a00000, t32_emulate_rd8rn16_noflags,
+						 REGS(NOPCX, 0, NOSPPC, 0, 0)),
+
+	/* MOVW			1111 0x10 0100 xxxx 0xxx xxxx xxxx xxxx */
+	/* MOVT			1111 0x10 1100 xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfb708000, 0xf2400000, t32_emulate_rd8rn16_noflags,
+						 REGS(0, 0, NOSPPC, 0, 0)),
+
+	/* SSAT16		1111 0x11 0010 xxxx 0000 xxxx 00xx xxxx */
+	/* SSAT			1111 0x11 00x0 xxxx 0xxx xxxx xxxx xxxx */
+	/* USAT16		1111 0x11 1010 xxxx 0000 xxxx 00xx xxxx */
+	/* USAT			1111 0x11 10x0 xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfb508000, 0xf3000000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, 0)),
+
+	/* SFBX			1111 0x11 0100 xxxx 0xxx xxxx xxxx xxxx */
+	/* UFBX			1111 0x11 1100 xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfb708000, 0xf3400000, t32_emulate_rd8rn16_noflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, 0)),
+
+	/* BFC			1111 0x11 0110 1111 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfbff8000, 0xf36f0000, t32_emulate_rd8rn16_noflags,
+						 REGS(0, 0, NOSPPC, 0, 0)),
+
+	/* BFI			1111 0x11 0110 xxxx 0xxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfbf08000, 0xf3600000, t32_emulate_rd8rn16_noflags,
+						 REGS(NOSPPCX, 0, NOSPPC, 0, 0)),
+
+	DECODE_END
+};
+
 static const union decode_item t32_table_1111_0xxx___1[] = {
 	/* Branches and miscellaneous control				*/
 
@@ -335,6 +424,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfa008000, 0xf0000000, t32_table_1111_0x0x___0),
 
 	/*
+	 * Data-processing (plain binary immediate)
+	 *			1111 0x1x xxxx xxxx 0xxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfa008000, 0xf2000000, t32_table_1111_0x1x___0),
+
+	/*
 	 * Branches and miscellaneous control
 	 *			1111 0xxx xxxx xxxx 1xxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
