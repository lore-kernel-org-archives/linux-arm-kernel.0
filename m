From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:07 +0100
Subject: [PATCH 20/51] ARM: kprobes: Decode 16-bit Thumb hint instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-21-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

For hints which may have observable effects, like SEV (send event), we
use kprobe_emulate_none which emulates the hint by executing the
original instruction.

For NOP we simulate the instruction using kprobe_simulate_nop, which
does nothing. As probes execute with interrupts disabled this is also
used for hints which may block for an indefinite time, like WFE (wait
for event).

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |    3 +++
 arch/arm/kernel/kprobes-common.c |    9 +++++++++
 arch/arm/kernel/kprobes-thumb.c  |   35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index c00681c..36e0768 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -95,6 +95,9 @@ static inline unsigned long it_advance(unsigned long cpsr)
 	return cpsr;
 }
 
+void __kprobes kprobe_simulate_nop(struct kprobe *p, struct pt_regs *regs);
+void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs);
+
 /*
  * Test if load/store instructions writeback the address register.
  * if P (bit 24) == 0 or W (bit 21) == 1
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 4074806..84c0c74 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -142,6 +142,15 @@ kprobe_check_cc * const kprobe_condition_checks[16] = {
 };
 
 
+void __kprobes kprobe_simulate_nop(struct kprobe *p, struct pt_regs *regs)
+{
+}
+
+void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs)
+{
+	p->ainsn.insn_fn();
+}
+
 /*
  * Prepare an instruction slot to receive an instruction for emulating.
  * This is done by placing a subroutine return after the location where the
diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 973c3eb..7dcf6df 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -26,6 +26,39 @@
  */
 #define current_cond(cpsr)	((cpsr >> 12) & 0xf)
 
+static const union decode_item t16_table_1011[] = {
+	/* Miscellaneous 16-bit instructions		    */
+
+	/*
+	 * If-Then, and hints
+	 *				1011 1111 xxxx xxxx
+	 */
+
+	/* YIELD			1011 1111 0001 0000 */
+	DECODE_OR	(0xffff, 0xbf10),
+	/* SEV				1011 1111 0100 0000 */
+	DECODE_EMULATE	(0xffff, 0xbf40, kprobe_emulate_none),
+	/* NOP				1011 1111 0000 0000 */
+	/* WFE				1011 1111 0010 0000 */
+	/* WFI				1011 1111 0011 0000 */
+	DECODE_SIMULATE	(0xffcf, 0xbf00, kprobe_simulate_nop),
+	/* Unassigned hints		1011 1111 xxxx 0000 */
+	DECODE_REJECT	(0xff0f, 0xbf00),
+
+	DECODE_END
+};
+
+const union decode_item kprobe_decode_thumb16_table[] = {
+
+	/*
+	 * Miscellaneous 16-bit instructions
+	 *				1011 xxxx xxxx xxxx
+	 */
+	DECODE_TABLE	(0xf000, 0xb000, t16_table_1011),
+
+	DECODE_END
+};
+
 static unsigned long __kprobes thumb_check_cc(unsigned long cpsr)
 {
 	if (unlikely(in_it_block(cpsr)))
@@ -52,7 +85,7 @@ thumb16_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	asi->insn_singlestep = thumb16_singlestep;
 	asi->insn_check_cc = thumb_check_cc;
-	return INSN_REJECTED;
+	return kprobe_decode_insn(insn, asi, kprobe_decode_thumb16_table, true);
 }
 
 enum kprobe_insn __kprobes
-- 
1.7.2.5
