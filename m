From: tixy@yxit.co.uk (Tixy)
Date: Wed,  6 Apr 2011 11:17:09 +0100
Subject: [PATCH v2 1/4] ARM: kprobes: Fix probing of conditionally executed
	instructions
In-Reply-To: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
References: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302085032-30415-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

When a kprobe is placed onto conditionally executed ARM instructions,
many of the emulation routines used to single step them produce corrupt
register results. Rather than fix all of these cases we modify the
framework which calls them to test the relevant condition flags and, if
the test fails, skip calling the emulation code.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/include/asm/kprobes.h   |    3 +
 arch/arm/kernel/kprobes-decode.c |   91 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes.c        |    3 +-
 3 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index bb8a19b..e46bdd0 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -39,10 +39,13 @@ typedef u32 kprobe_opcode_t;
 struct kprobe;
 typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
 
+typedef unsigned long (kprobe_check_cc)(unsigned long);
+
 /* Architecture specific copy of original instruction. */
 struct arch_specific_insn {
 	kprobe_opcode_t		*insn;
 	kprobe_insn_handler_t	*insn_handler;
+	kprobe_check_cc		*insn_check_cc;
 };
 
 struct prev_kprobe {
diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 3b0cf90..3e313e5 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1396,6 +1396,96 @@ space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return INSN_GOOD;
 }
 
+static unsigned long __kprobes __check_eq(unsigned long cpsr)
+{
+	return cpsr & PSR_Z_BIT;
+}
+
+static unsigned long __kprobes __check_ne(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_Z_BIT;
+}
+
+static unsigned long __kprobes __check_cs(unsigned long cpsr)
+{
+	return cpsr & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_cc(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_mi(unsigned long cpsr)
+{
+	return cpsr & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_pl(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_vs(unsigned long cpsr)
+{
+	return cpsr & PSR_V_BIT;
+}
+
+static unsigned long __kprobes __check_vc(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_V_BIT;
+}
+
+static unsigned long __kprobes __check_hi(unsigned long cpsr)
+{
+	cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
+	return cpsr & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_ls(unsigned long cpsr)
+{
+	cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
+	return (~cpsr) & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_ge(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	return (~cpsr) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_lt(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	return cpsr & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_gt(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	cpsr |= (cpsr << 1); /* PSR_N_BIT |= PSR_Z_BIT */
+	return (~cpsr) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_le(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	cpsr |= (cpsr << 1); /* PSR_N_BIT |= PSR_Z_BIT */
+	return cpsr & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_al(unsigned long cpsr)
+{
+	return true;
+}
+
+static kprobe_check_cc * const condition_checks[16] = {
+	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
+	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
+	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
+	&__check_gt, &__check_le, &__check_al, &__check_al
+};
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD         If instruction is supported and uses instruction slot,
@@ -1411,6 +1501,7 @@ space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 enum kprobe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	asi->insn_check_cc = condition_checks[insn>>28];
 	asi->insn[1] = KPROBE_RETURN_INSTRUCTION;
 
 	if ((insn & 0xf0000000) == 0xf0000000) {
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 2ba7deb..1656c87 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -134,7 +134,8 @@ static void __kprobes singlestep(struct kprobe *p, struct pt_regs *regs,
 				 struct kprobe_ctlblk *kcb)
 {
 	regs->ARM_pc += 4;
-	p->ainsn.insn_handler(p, regs);
+	if (p->ainsn.insn_check_cc(regs->ARM_cpsr))
+		p->ainsn.insn_handler(p, regs);
 }
 
 /*
-- 
1.7.2.5
