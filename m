From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:19 +0100
Subject: [PATCH 32/51] ARM: kprobes: Decode 16-bit Thumb branch instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-33-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

We previously changed the behaviour of probes so that conditional
instructions don't fire when the condition isn't met. For ARM branches,
and Thumb branches in IT blocks, this means they don't fire if the
branch isn't taken.

For consistency, we implement the same for Thumb conditional branch
instructions. This involves setting up insn_check_cc to point to the
relevant condition checking function. As the emulation routine is only
called when this condition passes, it doesn't need to check again and
can unconditionally update PC.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 997fc6d..d3133fd 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -141,6 +141,35 @@ t16_decode_it(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return INSN_GOOD_NO_SLOT;
 }
 
+static void __kprobes
+t16_simulate_cond_branch(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+	long offset = insn & 0x7f;
+	offset -= insn & 0x80; /* Apply sign bit */
+	regs->ARM_pc = pc + (offset * 2);
+}
+
+static enum kprobe_insn __kprobes
+t16_decode_cond_branch(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	int cc = (insn >> 8) & 0xf;
+	asi->insn_check_cc = kprobe_condition_checks[cc];
+	asi->insn_handler = t16_simulate_cond_branch;
+	return INSN_GOOD_NO_SLOT;
+}
+
+static void __kprobes
+t16_simulate_branch(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long pc = thumb_probe_pc(p);
+	long offset = insn & 0x3ff;
+	offset -= insn & 0x400; /* Apply sign bit */
+	regs->ARM_pc = pc + (offset * 2);
+}
+
 static unsigned long __kprobes
 t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
 {
@@ -472,6 +501,15 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 	/* SVC				1101 1111 xxxx xxxx */
 	DECODE_REJECT	(0xfe00, 0xde00),
 
+	/* Conditional branch		1101 xxxx xxxx xxxx */
+	DECODE_CUSTOM	(0xf000, 0xd000, t16_decode_cond_branch),
+
+	/*
+	 * Unconditional branch
+	 * B				1110 0xxx xxxx xxxx
+	 */
+	DECODE_SIMULATE	(0xf800, 0xe000, t16_simulate_branch),
+
 	DECODE_END
 };
 
-- 
1.7.2.5
