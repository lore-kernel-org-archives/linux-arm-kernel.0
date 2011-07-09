From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:17 +0100
Subject: [PATCH 30/51] ARM: kprobes: Decode 16-bit Thumb IT instruction
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-31-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The normal Thumb singlestepping routine updates the IT state after
calling the instruction handler. We don't what this to happen after the
IT instruction simulation sets the IT state, therefore we need to
provide a custom singlestep routine.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index e028949..e496948 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -110,6 +110,37 @@ t16_simulate_cbz(struct kprobe *p, struct pt_regs *regs)
 	}
 }
 
+static void __kprobes
+t16_simulate_it(struct kprobe *p, struct pt_regs *regs)
+{
+	/*
+	 * The 8 IT state bits are split into two parts in CPSR:
+	 *	ITSTATE<1:0> are in CPSR<26:25>
+	 *	ITSTATE<7:2> are in CPSR<15:10>
+	 * The new IT state is in the lower byte of insn.
+	 */
+	kprobe_opcode_t insn = p->opcode;
+	unsigned long cpsr = regs->ARM_cpsr;
+	cpsr &= ~PSR_IT_MASK;
+	cpsr |= (insn & 0xfc) << 8;
+	cpsr |= (insn & 0x03) << 25;
+	regs->ARM_cpsr = cpsr;
+}
+
+static void __kprobes
+t16_singlestep_it(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->ARM_pc += 2;
+	t16_simulate_it(p, regs);
+}
+
+static enum kprobe_insn __kprobes
+t16_decode_it(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	asi->insn_singlestep = t16_singlestep_it;
+	return INSN_GOOD_NO_SLOT;
+}
+
 static unsigned long __kprobes
 t16_emulate_loregs(struct kprobe *p, struct pt_regs *regs)
 {
@@ -310,6 +341,8 @@ static const union decode_item t16_table_1011[] = {
 	DECODE_SIMULATE	(0xffcf, 0xbf00, kprobe_simulate_nop),
 	/* Unassigned hints		1011 1111 xxxx 0000 */
 	DECODE_REJECT	(0xff0f, 0xbf00),
+	/* IT				1011 1111 xxxx xxxx */
+	DECODE_CUSTOM	(0xff00, 0xbf00, t16_decode_it),
 
 	DECODE_END
 };
-- 
1.7.2.5
