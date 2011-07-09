From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:13 +0100
Subject: [PATCH 26/51] ARM: kprobes: Decode 16-bit Thumb load and store
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-27-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Most of these instructions only operate on the low registers R0-R7
so they can make use of t16_emulate_loregs_rwflags.

The instructions which use SP or PC for addressing have their own
simulation functions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   60 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index cd4d03d..632a5e8 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -51,6 +51,29 @@ t16_simulate_bxblx(struct kprobe *p, struct pt_regs *regs)
 	bx_write_pc(rmv, regs);
 }
 
+static void __kprobes
+t16_simulate_ldr_literal(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long* base = (unsigned long *)(thumb_probe_pc(p) & ~3);
+	long index = insn & 0xff;
+	int rt = (insn >> 8) & 0x7;
+	regs->uregs[rt] = base[index];
+}
+
+static void __kprobes
+t16_simulate_ldrstr_sp_relative(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long* base = (unsigned long *)regs->ARM_sp;
+	long index = insn & 0xff;
+	int rt = (insn >> 8) & 0x7;
+	if (insn & 0x800) /* LDR */
+		regs->uregs[rt] = base[index];
+	else /* STR */
+		base[index] = regs->uregs[rt];
+}
+
 static unsigned long __kprobes
 t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
 {
@@ -218,11 +241,48 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 	DECODE_CUSTOM	(0xfc00, 0x4400, t16_decode_hiregs),
 
 	/*
+	 * Load from Literal Pool
+	 * LDR (literal)		0100 1xxx xxxx xxxx
+	 */
+	DECODE_SIMULATE	(0xf800, 0x4800, t16_simulate_ldr_literal),
+
+	/*
+	 * 16-bit Thumb Load/store instructions
+	 *				0101 xxxx xxxx xxxx
+	 *				011x xxxx xxxx xxxx
+	 *				100x xxxx xxxx xxxx
+	 */
+
+	/* STR (register)		0101 000x xxxx xxxx */
+	/* STRH (register)		0101 001x xxxx xxxx */
+	/* STRB (register)		0101 010x xxxx xxxx */
+	/* LDRSB (register)		0101 011x xxxx xxxx */
+	/* LDR (register)		0101 100x xxxx xxxx */
+	/* LDRH (register)		0101 101x xxxx xxxx */
+	/* LDRB (register)		0101 110x xxxx xxxx */
+	/* LDRSH (register)		0101 111x xxxx xxxx */
+	/* STR (immediate, Thumb)	0110 0xxx xxxx xxxx */
+	/* LDR (immediate, Thumb)	0110 1xxx xxxx xxxx */
+	/* STRB (immediate, Thumb)	0111 0xxx xxxx xxxx */
+	/* LDRB (immediate, Thumb)	0111 1xxx xxxx xxxx */
+	DECODE_EMULATE	(0xc000, 0x4000, t16_emulate_loregs_rwflags),
+	/* STRH (immediate, Thumb)	1000 0xxx xxxx xxxx */
+	/* LDRH (immediate, Thumb)	1000 1xxx xxxx xxxx */
+	DECODE_EMULATE	(0xf000, 0x8000, t16_emulate_loregs_rwflags),
+	/* STR (immediate, Thumb)	1001 0xxx xxxx xxxx */
+	/* LDR (immediate, Thumb)	1001 1xxx xxxx xxxx */
+	DECODE_SIMULATE	(0xf000, 0x9000, t16_simulate_ldrstr_sp_relative),
+
+	/*
 	 * Miscellaneous 16-bit instructions
 	 *				1011 xxxx xxxx xxxx
 	 */
 	DECODE_TABLE	(0xf000, 0xb000, t16_table_1011),
 
+	/* STM				1100 0xxx xxxx xxxx */
+	/* LDM				1100 1xxx xxxx xxxx */
+	DECODE_EMULATE	(0xf000, 0xc000, t16_emulate_loregs_rwflags),
+
 	DECODE_END
 };
 
-- 
1.7.2.5
