From: tixy@yxit.co.uk (Tixy)
Date: Mon,  4 Apr 2011 21:33:15 +0100
Subject: [PATCH 1/4] ARM: kprobes: Fix probing of conditionally executed
	instructions
In-Reply-To: <1301949198-31570-1-git-send-email-tixy@yxit.co.uk>
References: <1301949198-31570-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1301949198-31570-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

When a kprobe is placed onto conditionally executed ARM instructions,
many of the emulation routines used to single step them produce corrupt
register results. Rather than fix all of these cases we modify the
framework which calls them to test the relevant condition flags and, if
the test fails, step the PC onto the next instruction without calling
any emulation code.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/include/asm/kprobes.h   |    3 +
 arch/arm/kernel/kprobes-decode.c |    9 ++++
 arch/arm/kernel/kprobes-decode.h |   98 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes.c        |    3 +-
 4 files changed, 112 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/kernel/kprobes-decode.h

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
index 8f6ed43..c88c8d2 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -63,6 +63,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include "kprobes-decode.h"
 
 #define sign_extend(x, signbit) ((x) | (0 - ((x) & (1 << (signbit)))))
 
@@ -1384,6 +1385,13 @@ space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return INSN_GOOD;
 }
 
+static kprobe_check_cc* const condition_checks[16] = {
+	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
+	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
+	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
+	&__check_gt, &__check_le, &__check_al, &__check_al
+};
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD         If instruction is supported and uses instruction slot,
@@ -1399,6 +1407,7 @@ space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 enum kprobe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	asi->insn_check_cc = condition_checks[insn>>28];
 	asi->insn[1] = KPROBE_RETURN_INSTRUCTION;
 
 	if ((insn & 0xf0000000) == 0xf0000000) {
diff --git a/arch/arm/kernel/kprobes-decode.h b/arch/arm/kernel/kprobes-decode.h
new file mode 100644
index 0000000..d6b4337
--- /dev/null
+++ b/arch/arm/kernel/kprobes-decode.h
@@ -0,0 +1,98 @@
+/*
+ * arch/arm/kernel/kprobes-decode.h
+ *
+ * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+static inline unsigned long __kprobes __check_eq(unsigned long cpsr)
+{
+	return cpsr & PSR_Z_BIT;
+}
+
+static inline unsigned long __kprobes __check_ne(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_Z_BIT;
+}
+
+static inline unsigned long __kprobes __check_cs(unsigned long cpsr)
+{
+	return cpsr & PSR_C_BIT;
+}
+
+static inline unsigned long __kprobes __check_cc(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_C_BIT;
+}
+
+static inline unsigned long __kprobes __check_mi(unsigned long cpsr)
+{
+	return cpsr & PSR_N_BIT;
+}
+
+static inline unsigned long __kprobes __check_pl(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_N_BIT;
+}
+
+static inline unsigned long __kprobes __check_vs(unsigned long cpsr)
+{
+	return cpsr & PSR_V_BIT;
+}
+
+static inline unsigned long __kprobes __check_vc(unsigned long cpsr)
+{
+	return (~cpsr) & PSR_V_BIT;
+}
+
+static inline unsigned long __kprobes __check_hi(unsigned long cpsr)
+{
+	cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
+	return cpsr & PSR_C_BIT;
+}
+
+static inline unsigned long __kprobes __check_ls(unsigned long cpsr)
+{
+	cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
+	return (~cpsr) & PSR_C_BIT;
+}
+
+static inline unsigned long __kprobes __check_ge(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	return (~cpsr) & PSR_N_BIT;
+}
+
+static inline unsigned long __kprobes __check_lt(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	return cpsr & PSR_N_BIT;
+}
+
+static inline unsigned long __kprobes __check_gt(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	cpsr |= (cpsr << 1); /* PSR_N_BIT |= PSR_Z_BIT */
+	return (~cpsr) & PSR_N_BIT;
+}
+
+static inline unsigned long __kprobes __check_le(unsigned long cpsr)
+{
+	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	cpsr |= (cpsr << 1); /* PSR_N_BIT |= PSR_Z_BIT */
+	return cpsr & PSR_N_BIT;
+}
+
+static inline unsigned long __kprobes __check_al(unsigned long cpsr)
+{
+	return true;
+}
+
+static inline unsigned long __kprobes __check_nv(unsigned long cpsr)
+{
+	return false;
+}
+
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
