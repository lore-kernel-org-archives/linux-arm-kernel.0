From: tixy@yxit.co.uk (Tixy)
Date: Mon, 18 Apr 2011 08:53:54 +0100
Subject: [PATCH 1/5] ARM: kprobes: Reject probing of all coprocessor
	instructions
In-Reply-To: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
References: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303113238-23920-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The kernel doesn't currently support VFP or Neon code, and probing of
code with CP15 operations is fraught with bad consequences. Therefore we
don't need the ability to probe coprocessor instructions and the code to
support this can be removed.

The removed code also had at least two bugs:
 - MRC into R15 should set CPSR not trash PC
 - LDC and STC which use PC as base register needed the address offset by 8

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |  113 ++++----------------------------------
 1 files changed, 11 insertions(+), 102 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 43c2bf2..0b3d971 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -520,17 +520,6 @@ static void __kprobes simulate_mov_ipsp(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[12] = regs->uregs[13];
 }
 
-static void __kprobes emulate_ldcstc(struct kprobe *p, struct pt_regs *regs)
-{
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
-	kprobe_opcode_t insn = p->opcode;
-	int rn = (insn >> 16) & 0xf;
-	long rnv = regs->uregs[rn];
-
-	/* Save Rn in case of writeback. */
-	regs->uregs[rn] = insnslot_1arg_rflags(rnv, regs->ARM_cpsr, i_fn);
-}
-
 static void __kprobes emulate_ldrd(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
@@ -635,31 +624,6 @@ static void __kprobes emulate_str(struct kprobe *p, struct pt_regs *regs)
 		regs->uregs[rn] = rnv_wb;  /* Save Rn in case of writeback. */
 }
 
-static void __kprobes emulate_mrrc(struct kprobe *p, struct pt_regs *regs)
-{
-	insn_llret_0arg_fn_t *i_fn = (insn_llret_0arg_fn_t *)&p->ainsn.insn[0];
-	kprobe_opcode_t insn = p->opcode;
-	union reg_pair fnr;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-
-	fnr.dr = insnslot_llret_0arg_rflags(regs->ARM_cpsr, i_fn);
-	regs->uregs[rn] = fnr.r0;
-	regs->uregs[rd] = fnr.r1;
-}
-
-static void __kprobes emulate_mcrr(struct kprobe *p, struct pt_regs *regs)
-{
-	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
-	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	long rnv = regs->uregs[rn];
-	long rdv = regs->uregs[rd];
-
-	insnslot_2arg_rflags(rnv, rdv, regs->ARM_cpsr, i_fn);
-}
-
 static void __kprobes emulate_sat(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
@@ -693,24 +657,6 @@ static void __kprobes emulate_none(struct kprobe *p, struct pt_regs *regs)
 	insnslot_0arg_rflags(regs->ARM_cpsr, i_fn);
 }
 
-static void __kprobes emulate_rd12(struct kprobe *p, struct pt_regs *regs)
-{
-	insn_0arg_fn_t *i_fn = (insn_0arg_fn_t *)&p->ainsn.insn[0];
-	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-
-	regs->uregs[rd] = insnslot_0arg_rflags(regs->ARM_cpsr, i_fn);
-}
-
-static void __kprobes emulate_ird12(struct kprobe *p, struct pt_regs *regs)
-{
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
-	kprobe_opcode_t insn = p->opcode;
-	int ird = (insn >> 12) & 0xf;
-
-	insnslot_1arg_rflags(regs->uregs[ird], regs->ARM_cpsr, i_fn);
-}
-
 static void __kprobes emulate_rn16(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
@@ -1010,40 +956,22 @@ space_1111(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	}
 
 	/* SETEND : 1111 0001 0000 0001 xxxx xxxx 0000 xxxx */
-	/* CDP2   : 1111 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
-	if ((insn & 0xffff00f0) == 0xf1010000 ||
-	    (insn & 0xff000010) == 0xfe000000) {
+	if ((insn & 0xffff00f0) == 0xf1010000) {
 		asi->insn[0] = insn;
 		asi->insn_handler = emulate_none;
 		return INSN_GOOD;
 	}
 
+	/* Coprocessor instructions... */
 	/* MCRR2 : 1111 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd != Rn) */
 	/* MRRC2 : 1111 1100 0101 xxxx xxxx xxxx xxxx xxxx : (Rd != Rn) */
-	if ((insn & 0xffe00000) == 0xfc400000) {
-		insn &= 0xfff00fff;	/* Rn = r0 */
-		insn |= 0x00001000;	/* Rd = r1 */
-		asi->insn[0] = insn;
-		asi->insn_handler =
-			(insn & (1 << 20)) ? emulate_mrrc : emulate_mcrr;
-		return INSN_GOOD;
-	}
+	/* LDC2  : 1111 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
+	/* STC2  : 1111 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
+	/* CDP2  : 1111 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
+	/* MCR2  : 1111 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
+	/* MRC2  : 1111 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
 
-	/* LDC2 : 1111 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
-	/* STC2 : 1111 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
-	if ((insn & 0xfe000000) == 0xfc000000) {
-		insn &= 0xfff0ffff;      /* Rn = r0 */
-		asi->insn[0] = insn;
-		asi->insn_handler = emulate_ldcstc;
-		return INSN_GOOD;
-	}
-
-	/* MCR2 : 1111 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
-	/* MRC2 : 1111 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
-	insn &= 0xffff0fff;	/* Rd = r0 */
-	asi->insn[0]      = insn;
-	asi->insn_handler = (insn & (1 << 20)) ? emulate_rd12 : emulate_ird12;
-	return INSN_GOOD;
+	return INSN_REJECTED;
 }
 
 static enum kprobe_insn __kprobes
@@ -1504,14 +1432,7 @@ space_cccc_1100_010x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	/* MCRR : cccc 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
 	/* MRRC : cccc 1100 0101 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
-	if (is_r15(insn, 16) || is_r15(insn, 12))
-		return INSN_REJECTED;	/* Rn or Rd is PC */
-
-	insn &= 0xfff00fff;
-	insn |= 0x00001000;	/* Rn = r0, Rd = r1 */
-	asi->insn[0] = insn;
-	asi->insn_handler = (insn & (1 << 20)) ? emulate_mrrc : emulate_mcrr;
-	return INSN_GOOD;
+	return INSN_REJECTED;
 }
 
 static enum kprobe_insn __kprobes
@@ -1519,10 +1440,7 @@ space_cccc_110x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	/* LDC : cccc 110x xxx1 xxxx xxxx xxxx xxxx xxxx */
 	/* STC : cccc 110x xxx0 xxxx xxxx xxxx xxxx xxxx */
-	insn &= 0xfff0ffff;	/* Rn = r0 */
-	asi->insn[0] = insn;
-	asi->insn_handler = emulate_ldcstc;
-	return INSN_GOOD;
+	return INSN_REJECTED;
 }
 
 static enum kprobe_insn __kprobes
@@ -1535,18 +1453,9 @@ space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		return INSN_REJECTED;
 
 	/* CDP : cccc 1110 xxxx xxxx xxxx xxxx xxx0 xxxx */
-	if ((insn & 0x0f000010) == 0x0e000000) {
-		asi->insn[0] = insn;
-		asi->insn_handler = emulate_none;
-		return INSN_GOOD;
-	}
-
 	/* MCR : cccc 1110 xxx0 xxxx xxxx xxxx xxx1 xxxx */
 	/* MRC : cccc 1110 xxx1 xxxx xxxx xxxx xxx1 xxxx */
-	insn &= 0xffff0fff;	/* Rd = r0 */
-	asi->insn[0] = insn;
-	asi->insn_handler = (insn & (1 << 20)) ? emulate_rd12 : emulate_ird12;
-	return INSN_GOOD;
+	return INSN_REJECTED;
 }
 
 static unsigned long __kprobes __check_eq(unsigned long cpsr)
-- 
1.7.2.5
