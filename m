From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:35 +0100
Subject: [PATCH 48/51] ARM: kprobes: Decode 32-bit Thumb load/store single
	data item instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-49-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

We will reject probing of unprivileged load and store instructions.
These rarely occur and writing test cases for them is difficult.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |  153 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index bf1113c..9be8bea 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -118,6 +118,44 @@ t32_simulate_branch(struct kprobe *p, struct pt_regs *regs)
 	regs->ARM_pc = pc + (offset * 2);
 }
 
+static void __kprobes
+t32_simulate_ldr_literal(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long addr = thumb_probe_pc(p) & ~3;
+	int rt = (insn >> 12) & 0xf;
+	unsigned long rtv;
+
+	long offset = insn & 0xfff;
+	if (insn & 0x00800000)
+		addr += offset;
+	else
+		addr -= offset;
+
+	if (insn & 0x00400000) {
+		/* LDR */
+		rtv = *(unsigned long *)addr;
+		if (rt == 15) {
+			bx_write_pc(rtv, regs);
+			return;
+		}
+	} else if (insn & 0x00200000) {
+		/* LDRH */
+		if (insn & 0x01000000)
+			rtv = *(s16 *)addr;
+		else
+			rtv = *(u16 *)addr;
+	} else {
+		/* LDRB */
+		if (insn & 0x01000000)
+			rtv = *(s8 *)addr;
+		else
+			rtv = *(u8 *)addr;
+	}
+
+	regs->uregs[rt] = rtv;
+}
+
 static enum kprobe_insn __kprobes
 t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
@@ -159,6 +197,32 @@ t32_emulate_ldrdstrd(struct kprobe *p, struct pt_regs *regs)
 }
 
 static void __kprobes
+t32_emulate_ldrstr(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rt = (insn >> 12) & 0xf;
+	int rn = (insn >> 16) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rtv asm("r0") = regs->uregs[rt];
+	register unsigned long rnv asm("r2") = regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		"blx    %[fn]"
+		: "=r" (rtv), "=r" (rnv)
+		: "0" (rtv), "1" (rnv), "r" (rmv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rn] = rnv; /* Writeback base register */
+	if (rt == 15) /* Can't be true for a STR as they aren't allowed */
+		bx_write_pc(rtv, regs);
+	else
+		regs->uregs[rt] = rtv;
+}
+
+static void __kprobes
 t32_emulate_rd8rn16rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
 {
 	kprobe_opcode_t insn = p->opcode;
@@ -516,6 +580,87 @@ static const union decode_item t32_table_1111_100x_x0x1__1111[] = {
 	DECODE_END
 };
 
+static const union decode_item t32_table_1111_100x[] = {
+	/* Store/Load single data item					*/
+
+	/* ???			1111 100x x11x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfe600000, 0xf8600000),
+
+	/* ???			1111 1001 0101 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xfff00000, 0xf9500000),
+
+	/* ???			1111 100x 0xxx xxxx xxxx 10x0 xxxx xxxx */
+	DECODE_REJECT	(0xfe800d00, 0xf8000800),
+
+	/* STRBT		1111 1000 0000 xxxx xxxx 1110 xxxx xxxx */
+	/* STRHT		1111 1000 0010 xxxx xxxx 1110 xxxx xxxx */
+	/* STRT			1111 1000 0100 xxxx xxxx 1110 xxxx xxxx */
+	/* LDRBT		1111 1000 0001 xxxx xxxx 1110 xxxx xxxx */
+	/* LDRSBT		1111 1001 0001 xxxx xxxx 1110 xxxx xxxx */
+	/* LDRHT		1111 1000 0011 xxxx xxxx 1110 xxxx xxxx */
+	/* LDRSHT		1111 1001 0011 xxxx xxxx 1110 xxxx xxxx */
+	/* LDRT			1111 1000 0101 xxxx xxxx 1110 xxxx xxxx */
+	DECODE_REJECT	(0xfe800f00, 0xf8000e00),
+
+	/* STR{,B,H} Rn,[PC...]	1111 1000 xxx0 1111 xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0xff1f0000, 0xf80f0000),
+
+	/* STR{,B,H} PC,[Rn...]	1111 1000 xxx0 xxxx 1111 xxxx xxxx xxxx */
+	DECODE_REJECT	(0xff10f000, 0xf800f000),
+
+	/* LDR (literal)	1111 1000 x101 1111 xxxx xxxx xxxx xxxx */
+	DECODE_SIMULATEX(0xff7f0000, 0xf85f0000, t32_simulate_ldr_literal,
+						 REGS(PC, ANY, 0, 0, 0)),
+
+	/* STR (immediate)	1111 1000 0100 xxxx xxxx 1xxx xxxx xxxx */
+	/* LDR (immediate)	1111 1000 0101 xxxx xxxx 1xxx xxxx xxxx */
+	DECODE_OR	(0xffe00800, 0xf8400800),
+	/* STR (immediate)	1111 1000 1100 xxxx xxxx xxxx xxxx xxxx */
+	/* LDR (immediate)	1111 1000 1101 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xffe00000, 0xf8c00000, t32_emulate_ldrstr,
+						 REGS(NOPCX, ANY, 0, 0, 0)),
+
+	/* STR (register)	1111 1000 0100 xxxx xxxx 0000 00xx xxxx */
+	/* LDR (register)	1111 1000 0101 xxxx xxxx 0000 00xx xxxx */
+	DECODE_EMULATEX	(0xffe00fc0, 0xf8400000, t32_emulate_ldrstr,
+						 REGS(NOPCX, ANY, 0, 0, NOSPPC)),
+
+	/* LDRB (literal)	1111 1000 x001 1111 xxxx xxxx xxxx xxxx */
+	/* LDRSB (literal)	1111 1001 x001 1111 xxxx xxxx xxxx xxxx */
+	/* LDRH (literal)	1111 1000 x011 1111 xxxx xxxx xxxx xxxx */
+	/* LDRSH (literal)	1111 1001 x011 1111 xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfe5f0000, 0xf81f0000, t32_simulate_ldr_literal,
+						 REGS(PC, NOSPPCX, 0, 0, 0)),
+
+	/* STRB (immediate)	1111 1000 0000 xxxx xxxx 1xxx xxxx xxxx */
+	/* STRH (immediate)	1111 1000 0010 xxxx xxxx 1xxx xxxx xxxx */
+	/* LDRB (immediate)	1111 1000 0001 xxxx xxxx 1xxx xxxx xxxx */
+	/* LDRSB (immediate)	1111 1001 0001 xxxx xxxx 1xxx xxxx xxxx */
+	/* LDRH (immediate)	1111 1000 0011 xxxx xxxx 1xxx xxxx xxxx */
+	/* LDRSH (immediate)	1111 1001 0011 xxxx xxxx 1xxx xxxx xxxx */
+	DECODE_OR	(0xfec00800, 0xf8000800),
+	/* STRB (immediate)	1111 1000 1000 xxxx xxxx xxxx xxxx xxxx */
+	/* STRH (immediate)	1111 1000 1010 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRB (immediate)	1111 1000 1001 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRSB (immediate)	1111 1001 1001 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRH (immediate)	1111 1000 1011 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRSH (immediate)	1111 1001 1011 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0xfec00000, 0xf8800000, t32_emulate_ldrstr,
+						 REGS(NOPCX, NOSPPCX, 0, 0, 0)),
+
+	/* STRB (register)	1111 1000 0000 xxxx xxxx 0000 00xx xxxx */
+	/* STRH (register)	1111 1000 0010 xxxx xxxx 0000 00xx xxxx */
+	/* LDRB (register)	1111 1000 0001 xxxx xxxx 0000 00xx xxxx */
+	/* LDRSB (register)	1111 1001 0001 xxxx xxxx 0000 00xx xxxx */
+	/* LDRH (register)	1111 1000 0011 xxxx xxxx 0000 00xx xxxx */
+	/* LDRSH (register)	1111 1001 0011 xxxx xxxx 0000 00xx xxxx */
+	DECODE_EMULATEX	(0xfe800fc0, 0xf8000000, t32_emulate_ldrstr,
+						 REGS(NOPCX, NOSPPCX, 0, 0, NOSPPC)),
+
+	/* Other unallocated instructions...				*/
+	DECODE_END
+};
+
 const union decode_item kprobe_decode_thumb32_table[] = {
 
 	/*
@@ -573,6 +718,14 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfe50f000, 0xf810f000, t32_table_1111_100x_x0x1__1111),
 
 	/*
+	 * Store single data item
+	 *			1111 1000 xxx0 xxxx xxxx xxxx xxxx xxxx
+	 * Load single data items
+	 *			1111 100x xxx1 xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xfe000000, 0xf8000000, t32_table_1111_100x),
+
+	/*
 	 * Coprocessor instructions
 	 *			1111 11xx xxxx xxxx xxxx xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
