From: tixy@yxit.co.uk (Tixy)
Date: Tue, 19 Apr 2011 10:52:17 +0100
Subject: [PATCH 2/5] ARM: kprobes: Add emulation of MOVW and MOVT instructions
In-Reply-To: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303206740-10101-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The MOVW and MOVT instructions account for approximately 7% of all
instructions in a ARMv7 kernel as GCC uses them instead of a literal
pool.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index a50a68a..51e6957 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -661,6 +661,17 @@ static void __kprobes emulate_nop(struct kprobe *p, struct pt_regs *regs)
 {
 }
 
+static void __kprobes
+emulate_rd12_modify(struct kprobe *p, struct pt_regs *regs)
+{
+	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 12) & 0xf;
+	long rdv = regs->uregs[rd];
+
+	regs->uregs[rd] = insnslot_1arg_rflags(rdv, regs->ARM_cpsr, i_fn);
+}
+
 static void __kprobes emulate_rd12rm0(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
@@ -847,6 +858,18 @@ prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 }
 
 static enum kprobe_insn __kprobes
+prep_emulate_rd12_modify(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	if (is_r15(insn, 12))
+		return INSN_REJECTED;	/* Rd is PC */
+
+	insn &= 0xffff0fff;	/* Rd = r0 */
+	asi->insn[0] = insn;
+	asi->insn_handler = emulate_rd12_modify;
+	return INSN_GOOD;
+}
+
+static enum kprobe_insn __kprobes
 prep_emulate_rd12rm0(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	if (is_r15(insn, 12))
@@ -1170,14 +1193,17 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 static enum kprobe_insn __kprobes
 space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	/* MOVW  : cccc 0011 0000 xxxx xxxx xxxx xxxx xxxx */
+	/* MOVT  : cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx */
+	if ((insn & 0x0fb00000) == 0x03000000)
+		return prep_emulate_rd12_modify(insn, asi);
+
 	/*
 	 * MSR   : cccc 0011 0x10 xxxx xxxx xxxx xxxx xxxx
-	 * Undef : cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx
 	 * ALU op with S bit and Rd == 15 :
 	 *	   cccc 001x xxx1 xxxx 1111 xxxx xxxx xxxx
 	 */
 	if ((insn & 0x0fb00000) == 0x03200000 ||	/* MSR */
-	    (insn & 0x0ff00000) == 0x03400000 ||	/* Undef */
 	    (insn & 0x0e10f000) == 0x0210f000)		/* ALU s-bit, R15  */
 		return INSN_REJECTED;
 
-- 
1.7.2.5
