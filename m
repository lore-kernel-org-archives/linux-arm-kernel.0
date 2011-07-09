From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:16 +0100
Subject: [PATCH 29/51] ARM: kprobes: Decode 16-bit Thumb PUSH and POP
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-30-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These instructions are equivalent to

	stmdb sp!,{r0-r7,lr}
	ldmdb sp!,{r0-r7,pc}

and we emulate them by transforming them into the 32-bit Thumb
instructions

	stmdb r9!,{r0-r7,r8}
	ldmdb r9!,{r0-r7,r8}

This is simpler, and almost certainly executes faster, than writing
simulation functions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   86 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index a5bdb2d..e028949 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -187,6 +187,87 @@ t16_decode_hiregs(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return INSN_GOOD;
 }
 
+static void __kprobes
+t16_emulate_push(struct kprobe *p, struct pt_regs *regs)
+{
+	__asm__ __volatile__ (
+		"ldr	r9, [%[regs], #13*4]	\n\t"
+		"ldr	r8, [%[regs], #14*4]	\n\t"
+		"ldmia	%[regs], {r0-r7}	\n\t"
+		"blx	%[fn]			\n\t"
+		"str	r9, [%[regs], #13*4]	\n\t"
+		:
+		: [regs] "r" (regs), [fn] "r" (p->ainsn.insn_fn)
+		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9",
+		  "lr", "memory", "cc"
+		);
+}
+
+static enum kprobe_insn __kprobes
+t16_decode_push(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	/*
+	 * To simulate a PUSH we use a Thumb-2 "STMDB R9!, {registers}"
+	 * and call it with R9=SP and LR in the register list represented
+	 * by R8.
+	 */
+	((u16 *)asi->insn)[0] = 0xe929;		/* 1st half STMDB R9!,{} */
+	((u16 *)asi->insn)[1] = insn & 0x1ff;	/* 2nd half (register list) */
+	asi->insn_handler = t16_emulate_push;
+	return INSN_GOOD;
+}
+
+static void __kprobes
+t16_emulate_pop_nopc(struct kprobe *p, struct pt_regs *regs)
+{
+	__asm__ __volatile__ (
+		"ldr	r9, [%[regs], #13*4]	\n\t"
+		"ldmia	%[regs], {r0-r7}	\n\t"
+		"blx	%[fn]			\n\t"
+		"stmia	%[regs], {r0-r7}	\n\t"
+		"str	r9, [%[regs], #13*4]	\n\t"
+		:
+		: [regs] "r" (regs), [fn] "r" (p->ainsn.insn_fn)
+		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r9",
+		  "lr", "memory", "cc"
+		);
+}
+
+static void __kprobes
+t16_emulate_pop_pc(struct kprobe *p, struct pt_regs *regs)
+{
+	register unsigned long pc asm("r8");
+
+	__asm__ __volatile__ (
+		"ldr	r9, [%[regs], #13*4]	\n\t"
+		"ldmia	%[regs], {r0-r7}	\n\t"
+		"blx	%[fn]			\n\t"
+		"stmia	%[regs], {r0-r7}	\n\t"
+		"str	r9, [%[regs], #13*4]	\n\t"
+		: "=r" (pc)
+		: [regs] "r" (regs), [fn] "r" (p->ainsn.insn_fn)
+		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r9",
+		  "lr", "memory", "cc"
+		);
+
+	bx_write_pc(pc, regs);
+}
+
+static enum kprobe_insn __kprobes
+t16_decode_pop(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	/*
+	 * To simulate a POP we use a Thumb-2 "LDMDB R9!, {registers}"
+	 * and call it with R9=SP and PC in the register list represented
+	 * by R8.
+	 */
+	((u16 *)asi->insn)[0] = 0xe8b9;		/* 1st half LDMIA R9!,{} */
+	((u16 *)asi->insn)[1] = insn & 0x1ff;	/* 2nd half (register list) */
+	asi->insn_handler = insn & 0x100 ? t16_emulate_pop_pc
+					 : t16_emulate_pop_nopc;
+	return INSN_GOOD;
+}
+
 static const union decode_item t16_table_1011[] = {
 	/* Miscellaneous 16-bit instructions		    */
 
@@ -209,6 +290,11 @@ static const union decode_item t16_table_1011[] = {
 	DECODE_REJECT	(0xffc0, 0xba80),
 	DECODE_EMULATE	(0xf500, 0xb000, t16_emulate_loregs_rwflags),
 
+	/* PUSH				1011 010x xxxx xxxx */
+	DECODE_CUSTOM	(0xfe00, 0xb400, t16_decode_push),
+	/* POP				1011 110x xxxx xxxx */
+	DECODE_CUSTOM	(0xfe00, 0xbc00, t16_decode_pop),
+
 	/*
 	 * If-Then, and hints
 	 *				1011 1111 xxxx xxxx
-- 
1.7.2.5
