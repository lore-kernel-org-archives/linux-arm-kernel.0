From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:09 +0100
Subject: [PATCH 22/51] ARM: kprobes: Decode 16-bit Thumb data-processing
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-23-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These instructions only operate on the low registers R0-R7, therefore
it is possible to emulate them by executing the original instruction
unaltered if we restore and save these registers. This is what
t16_emulate_loregs does.

Some of these instructions don't update the PSR when they execute in an
IT block, so there are two flavours of emulation functions:
t16_emulate_loregs_{noit}rwflags

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   81 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 7dcf6df..e1cef82 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -26,6 +26,42 @@
  */
 #define current_cond(cpsr)	((cpsr >> 12) & 0xf)
 
+static unsigned long __kprobes
+t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long oldcpsr = regs->ARM_cpsr;
+	unsigned long newcpsr;
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[oldcpsr]	\n\t"
+		"ldmia	%[regs], {r0-r7}	\n\t"
+		"blx	%[fn]			\n\t"
+		"stmia	%[regs], {r0-r7}	\n\t"
+		"mrs	%[newcpsr], cpsr	\n\t"
+		: [newcpsr] "=r" (newcpsr)
+		: [oldcpsr] "r" (oldcpsr), [regs] "r" (regs),
+		  [fn] "r" (p->ainsn.insn_fn)
+		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
+		  "lr", "memory", "cc"
+		);
+
+	return (oldcpsr & ~APSR_MASK) | (newcpsr & APSR_MASK);
+}
+
+static void __kprobes
+t16_emulate_loregs_rwflags(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->ARM_cpsr = t16_emulate_loregs(p, regs);
+}
+
+static void __kprobes
+t16_emulate_loregs_noitrwflags(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long cpsr = t16_emulate_loregs(p, regs);
+	if (!in_it_block(cpsr))
+		regs->ARM_cpsr = cpsr;
+}
+
 static const union decode_item t16_table_1011[] = {
 	/* Miscellaneous 16-bit instructions		    */
 
@@ -51,6 +87,51 @@ static const union decode_item t16_table_1011[] = {
 const union decode_item kprobe_decode_thumb16_table[] = {
 
 	/*
+	 * Shift (immediate), add, subtract, move, and compare
+	 *				00xx xxxx xxxx xxxx
+	 */
+
+	/* CMP (immediate)		0010 1xxx xxxx xxxx */
+	DECODE_EMULATE	(0xf800, 0x2800, t16_emulate_loregs_rwflags),
+
+	/* ADD (register)		0001 100x xxxx xxxx */
+	/* SUB (register)		0001 101x xxxx xxxx */
+	/* LSL (immediate)		0000 0xxx xxxx xxxx */
+	/* LSR (immediate)		0000 1xxx xxxx xxxx */
+	/* ASR (immediate)		0001 0xxx xxxx xxxx */
+	/* ADD (immediate, Thumb)	0001 110x xxxx xxxx */
+	/* SUB (immediate, Thumb)	0001 111x xxxx xxxx */
+	/* MOV (immediate)		0010 0xxx xxxx xxxx */
+	/* ADD (immediate, Thumb)	0011 0xxx xxxx xxxx */
+	/* SUB (immediate, Thumb)	0011 1xxx xxxx xxxx */
+	DECODE_EMULATE	(0xc000, 0x0000, t16_emulate_loregs_noitrwflags),
+
+	/*
+	 * 16-bit Thumb data-processing instructions
+	 *				0100 00xx xxxx xxxx
+	 */
+
+	/* TST (register)		0100 0010 00xx xxxx */
+	DECODE_EMULATE	(0xffc0, 0x4200, t16_emulate_loregs_rwflags),
+	/* CMP (register)		0100 0010 10xx xxxx */
+	/* CMN (register)		0100 0010 11xx xxxx */
+	DECODE_EMULATE	(0xff80, 0x4280, t16_emulate_loregs_rwflags),
+	/* AND (register)		0100 0000 00xx xxxx */
+	/* EOR (register)		0100 0000 01xx xxxx */
+	/* LSL (register)		0100 0000 10xx xxxx */
+	/* LSR (register)		0100 0000 11xx xxxx */
+	/* ASR (register)		0100 0001 00xx xxxx */
+	/* ADC (register)		0100 0001 01xx xxxx */
+	/* SBC (register)		0100 0001 10xx xxxx */
+	/* ROR (register)		0100 0001 11xx xxxx */
+	/* RSB (immediate)		0100 0010 01xx xxxx */
+	/* ORR (register)		0100 0011 00xx xxxx */
+	/* MUL				0100 0011 00xx xxxx */
+	/* BIC (register)		0100 0011 10xx xxxx */
+	/* MVN (register)		0100 0011 10xx xxxx */
+	DECODE_EMULATE	(0xfc00, 0x4000, t16_emulate_loregs_noitrwflags),
+
+	/*
 	 * Miscellaneous 16-bit instructions
 	 *				1011 xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
