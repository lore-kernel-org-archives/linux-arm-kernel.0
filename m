From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:14 +0100
Subject: [PATCH 27/51] ARM: kprobes: Decode 16-bit Thumb PC- and SP-relative
	address instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-28-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 632a5e8..2b30828 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -74,6 +74,28 @@ t16_simulate_ldrstr_sp_relative(struct kprobe *p, struct pt_regs *regs)
 		base[index] = regs->uregs[rt];
 }
 
+static void __kprobes
+t16_simulate_reladr(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long base = (insn & 0x800) ? regs->ARM_sp
+					    : (thumb_probe_pc(p) & ~3);
+	long offset = insn & 0xff;
+	int rt = (insn >> 8) & 0x7;
+	regs->uregs[rt] = base + offset * 4;
+}
+
+static void __kprobes
+t16_simulate_add_sp_imm(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long imm = insn & 0x7f;
+	if (insn & 0x80) /* SUB */
+		regs->ARM_sp -= imm * 4;
+	else /* ADD */
+		regs->ARM_sp += imm * 4;
+}
+
 static unsigned long __kprobes
 t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
 {
@@ -154,6 +176,10 @@ t16_decode_hiregs(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 static const union decode_item t16_table_1011[] = {
 	/* Miscellaneous 16-bit instructions		    */
 
+	/* ADD (SP plus immediate)	1011 0000 0xxx xxxx */
+	/* SUB (SP minus immediate)	1011 0000 1xxx xxxx */
+	DECODE_SIMULATE	(0xff00, 0xb000, t16_simulate_add_sp_imm),
+
 	/*
 	 * If-Then, and hints
 	 *				1011 1111 xxxx xxxx
@@ -274,6 +300,13 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 	DECODE_SIMULATE	(0xf000, 0x9000, t16_simulate_ldrstr_sp_relative),
 
 	/*
+	 * Generate PC-/SP-relative address
+	 * ADR (literal)		1010 0xxx xxxx xxxx
+	 * ADD (SP plus immediate)	1010 1xxx xxxx xxxx
+	 */
+	DECODE_SIMULATE	(0xf000, 0xa000, t16_simulate_reladr),
+
+	/*
 	 * Miscellaneous 16-bit instructions
 	 *				1011 xxxx xxxx xxxx
 	 */
-- 
1.7.2.5
