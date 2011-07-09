From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:28 +0100
Subject: [PATCH 41/51] ARM: kprobes: Decode 32-bit Thumb data-processing
	(shifted register) instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-42-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   93 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index dfaea25..eac945c 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -97,6 +97,33 @@ t32_emulate_ldrdstrd(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rt2] = rt2v;
 }
 
+static void __kprobes
+t32_emulate_rd8rn16rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 8) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rdv asm("r1") = regs->uregs[rd];
+	register unsigned long rnv asm("r2") = regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+	unsigned long cpsr = regs->ARM_cpsr;
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[cpsr]	\n\t"
+		"blx    %[fn]			\n\t"
+		"mrs	%[cpsr], cpsr		\n\t"
+		: "=r" (rdv), [cpsr] "=r" (cpsr)
+		: "0" (rdv), "r" (rnv), "r" (rmv),
+		  "1" (cpsr), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rd] = rdv;
+	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
+}
+
 static const union decode_item t32_table_1110_100x_x0xx[] = {
 	/* Load/store multiple instructions */
 
@@ -154,6 +181,66 @@ static const union decode_item t32_table_1110_100x_x1xx[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1110_101x[] = {
+	/* Data-processing (shifted register)				*/
+
+	/* TST			1110 1010 0001 xxxx xxxx 1111 xxxx xxxx */
+	/* TEQ			1110 1010 1001 xxxx xxxx 1111 xxxx xxxx */
+	DECODE_EMULATEX	(0xff700f00, 0xea100f00, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, 0, 0, NOSPPC)),
+
+	/* CMN			1110 1011 0001 xxxx xxxx 1111 xxxx xxxx */
+	DECODE_OR	(0xfff00f00, 0xeb100f00),
+	/* CMP			1110 1011 1011 xxxx xxxx 1111 xxxx xxxx */
+	DECODE_EMULATEX	(0xfff00f00, 0xebb00f00, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOPC, 0, 0, 0, NOSPPC)),
+
+	/* MOV			1110 1010 010x 1111 xxxx xxxx xxxx xxxx */
+	/* MVN			1110 1010 011x 1111 xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xffcf0000, 0xea4f0000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(0, 0, NOSPPC, 0, NOSPPC)),
+
+	/* ???			1110 1010 101x xxxx xxxx xxxx xxxx xxxx */
+	/* ???			1110 1010 111x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xffa00000, 0xeaa00000),
+	/* ???			1110 1011 001x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xffe00000, 0xeb200000),
+	/* ???			1110 1011 100x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xffe00000, 0xeb800000),
+	/* ???			1110 1011 111x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xffe00000, 0xebe00000),
+
+	/* ADD/SUB SP, SP, Rm, LSL #0..3				*/
+	/*			1110 1011 x0xx 1101 x000 1101 xx00 xxxx */
+	DECODE_EMULATEX	(0xff4f7f30, 0xeb0d0d00, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(SP, 0, SP, 0, NOSPPC)),
+
+	/* ADD/SUB SP, SP, Rm, shift					*/
+	/*			1110 1011 x0xx 1101 xxxx 1101 xxxx xxxx */
+	DECODE_REJECT	(0xff4f0f00, 0xeb0d0d00),
+
+	/* ADD/SUB Rd, SP, Rm, shift					*/
+	/*			1110 1011 x0xx 1101 xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xff4f0000, 0xeb0d0000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(SP, 0, NOPC, 0, NOSPPC)),
+
+	/* AND			1110 1010 000x xxxx xxxx xxxx xxxx xxxx */
+	/* BIC			1110 1010 001x xxxx xxxx xxxx xxxx xxxx */
+	/* ORR			1110 1010 010x xxxx xxxx xxxx xxxx xxxx */
+	/* ORN			1110 1010 011x xxxx xxxx xxxx xxxx xxxx */
+	/* EOR			1110 1010 100x xxxx xxxx xxxx xxxx xxxx */
+	/* PKH			1110 1010 110x xxxx xxxx xxxx xxxx xxxx */
+	/* ADD			1110 1011 000x xxxx xxxx xxxx xxxx xxxx */
+	/* ADC			1110 1011 010x xxxx xxxx xxxx xxxx xxxx */
+	/* SBC			1110 1011 011x xxxx xxxx xxxx xxxx xxxx */
+	/* SUB			1110 1011 101x xxxx xxxx xxxx xxxx xxxx */
+	/* RSB			1110 1011 110x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfe000000, 0xea000000, t32_emulate_rd8rn16rm0_rwflags,
+						 REGS(NOSPPC, 0, NOSPPC, 0, NOSPPC)),
+
+	DECODE_END
+};
+
 static const union decode_item t32_table_1111_0xxx___1[] = {
 	/* Branches and miscellaneous control				*/
 
@@ -184,6 +271,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfe400000, 0xe8400000, t32_table_1110_100x_x1xx),
 
 	/*
+	 * Data-processing (shifted register)
+	 *			1110 101x xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfe000000, 0xea000000, t32_table_1110_101x),
+
+	/*
 	 * Branches and miscellaneous control
 	 *			1111 0xxx xxxx xxxx 1xxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
