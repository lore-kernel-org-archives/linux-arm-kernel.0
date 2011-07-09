From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:12 +0100
Subject: [PATCH 25/51] ARM: kprobes: Decode 16-bit Thumb special data
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-26-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These data-processing instructions operate on the full range of CPU
registers, so to simulate them we have to modify the registers used
by the instruction. We can't make use of the decoding table framework to
do this because the registers aren't encoded cleanly in separate
nibbles, therefore we need a custom decode function.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   49 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index b457da0..cd4d03d 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -87,6 +87,47 @@ t16_emulate_loregs_noitrwflags(struct kprobe *p, struct pt_regs *regs)
 		regs->ARM_cpsr = cpsr;
 }
 
+static void __kprobes
+t16_emulate_hiregs(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+	int rdn = (insn & 0x7) | ((insn & 0x80) >> 4);
+	int rm = (insn >> 3) & 0xf;
+
+	register unsigned long rdnv asm("r1");
+	register unsigned long rmv asm("r0");
+	unsigned long cpsr = regs->ARM_cpsr;
+
+	rdnv = (rdn == 15) ? pc : regs->uregs[rdn];
+	rmv = (rm == 15) ? pc : regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[cpsr]	\n\t"
+		"blx    %[fn]			\n\t"
+		"mrs	%[cpsr], cpsr		\n\t"
+		: "=r" (rdnv), [cpsr] "=r" (cpsr)
+		: "0" (rdnv), "r" (rmv), "1" (cpsr), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	if (rdn == 15)
+		rdnv &= ~1;
+
+	regs->uregs[rdn] = rdnv;
+	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
+}
+
+static enum kprobe_insn __kprobes
+t16_decode_hiregs(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	insn &= ~0x00ff;
+	insn |= 0x001; /* Set Rdn = R1 and Rm = R0 */
+	((u16 *)asi->insn)[0] = insn;
+	asi->insn_handler = t16_emulate_hiregs;
+	return INSN_GOOD;
+}
+
 static const union decode_item t16_table_1011[] = {
 	/* Miscellaneous 16-bit instructions		    */
 
@@ -168,6 +209,14 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 	/* BLX (register)		0100 0111 1xxx xxxx */
 	DECODE_SIMULATE (0xff00, 0x4700, t16_simulate_bxblx),
 
+	/* ADD pc, pc			0100 0100 1111 1111 */
+	DECODE_REJECT	(0xffff, 0x44ff),
+
+	/* ADD (register)		0100 0100 xxxx xxxx */
+	/* CMP (register)		0100 0101 xxxx xxxx */
+	/* MOV (register)		0100 0110 xxxx xxxx */
+	DECODE_CUSTOM	(0xfc00, 0x4400, t16_decode_hiregs),
+
 	/*
 	 * Miscellaneous 16-bit instructions
 	 *				1011 xxxx xxxx xxxx
-- 
1.7.2.5
