From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:52 +0100
Subject: [PATCH 05/51] ARM: kprobes: Add kprobes-common.c
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-6-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This file will contain the instruction decoding and emulation code
which is common to both ARM and Thumb instruction sets.

For now, we will just move over condition_checks from kprobes-arm.c
This table is also renamed to kprobe_condition_checks to avoid polluting
the public namespace with a too generic name.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/Makefile         |    2 +-
 arch/arm/kernel/kprobes.h        |    2 +
 arch/arm/kernel/kprobes-arm.c    |   92 +---------------------------------
 arch/arm/kernel/kprobes-common.c |  105 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 92 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 914c7a6..a22b8f1 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
-obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-common.o
 obj-$(CONFIG_KPROBES)		+= kprobes-arm.o
 obj-$(CONFIG_ATAGS_PROC)	+= atags.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 87a5241..792f231 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -34,4 +34,6 @@ enum kprobe_insn arm_kprobe_decode_insn(kprobe_opcode_t,
 
 void __init arm_kprobe_decode_init(void);
 
+extern kprobe_check_cc * const kprobe_condition_checks[16];
+
 #endif /* _ARM_KERNEL_KPROBES_H */
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 976ce14..8d4464f 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1523,96 +1523,6 @@ space_cccc_11xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return INSN_REJECTED;
 }
 
-static unsigned long __kprobes __check_eq(unsigned long cpsr)
-{
-	return cpsr & PSR_Z_BIT;
-}
-
-static unsigned long __kprobes __check_ne(unsigned long cpsr)
-{
-	return (~cpsr) & PSR_Z_BIT;
-}
-
-static unsigned long __kprobes __check_cs(unsigned long cpsr)
-{
-	return cpsr & PSR_C_BIT;
-}
-
-static unsigned long __kprobes __check_cc(unsigned long cpsr)
-{
-	return (~cpsr) & PSR_C_BIT;
-}
-
-static unsigned long __kprobes __check_mi(unsigned long cpsr)
-{
-	return cpsr & PSR_N_BIT;
-}
-
-static unsigned long __kprobes __check_pl(unsigned long cpsr)
-{
-	return (~cpsr) & PSR_N_BIT;
-}
-
-static unsigned long __kprobes __check_vs(unsigned long cpsr)
-{
-	return cpsr & PSR_V_BIT;
-}
-
-static unsigned long __kprobes __check_vc(unsigned long cpsr)
-{
-	return (~cpsr) & PSR_V_BIT;
-}
-
-static unsigned long __kprobes __check_hi(unsigned long cpsr)
-{
-	cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
-	return cpsr & PSR_C_BIT;
-}
-
-static unsigned long __kprobes __check_ls(unsigned long cpsr)
-{
-	cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
-	return (~cpsr) & PSR_C_BIT;
-}
-
-static unsigned long __kprobes __check_ge(unsigned long cpsr)
-{
-	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-	return (~cpsr) & PSR_N_BIT;
-}
-
-static unsigned long __kprobes __check_lt(unsigned long cpsr)
-{
-	cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-	return cpsr & PSR_N_BIT;
-}
-
-static unsigned long __kprobes __check_gt(unsigned long cpsr)
-{
-	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
-	return (~temp) & PSR_N_BIT;
-}
-
-static unsigned long __kprobes __check_le(unsigned long cpsr)
-{
-	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
-	return temp & PSR_N_BIT;
-}
-
-static unsigned long __kprobes __check_al(unsigned long cpsr)
-{
-	return true;
-}
-
-static kprobe_check_cc * const condition_checks[16] = {
-	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
-	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
-	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
-	&__check_gt, &__check_le, &__check_al, &__check_al
-};
-
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD         If instruction is supported and uses instruction slot,
@@ -1628,7 +1538,7 @@ static kprobe_check_cc * const condition_checks[16] = {
 enum kprobe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
-	asi->insn_check_cc = condition_checks[insn>>28];
+	asi->insn_check_cc = kprobe_condition_checks[insn>>28];
 	asi->insn[1] = KPROBE_RETURN_INSTRUCTION;
 
 	if ((insn & 0xf0000000) == 0xf0000000)
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
new file mode 100644
index 0000000..794827e
--- /dev/null
+++ b/arch/arm/kernel/kprobes-common.c
@@ -0,0 +1,105 @@
+/*
+ * arch/arm/kernel/kprobes-common.c
+ *
+ * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+
+#include "kprobes.h"
+
+
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
+	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
+	return (~temp) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_le(unsigned long cpsr)
+{
+	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
+	return temp & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_al(unsigned long cpsr)
+{
+	return true;
+}
+
+kprobe_check_cc * const kprobe_condition_checks[16] = {
+	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
+	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
+	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
+	&__check_gt, &__check_le, &__check_al, &__check_al
+};
-- 
1.7.2.5
