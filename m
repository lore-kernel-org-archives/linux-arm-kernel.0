From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:54 +0100
Subject: [PATCH 07/51] ARM: kprobes: Move find_str_pc_offset into
	kprobes-common.c
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-8-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Move str_pc_offset into kprobes-common.c as it will be needed by common
code later.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |    2 ++
 arch/arm/kernel/kprobes-arm.c    |   28 ----------------------------
 arch/arm/kernel/kprobes-common.c |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 4de2f37..43f630d 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -36,6 +36,8 @@ void __init arm_kprobe_decode_init(void);
 
 extern kprobe_check_cc * const kprobe_condition_checks[16];
 
+extern int str_pc_offset;
+
 /*
  * Test if load/store instructions writeback the address register.
  * if P (bit 24) == 0 or W (bit 21) == 1
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 3c4678e..0262b29 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -92,29 +92,6 @@ union reg_pair {
 };
 
 /*
- * For STR and STM instructions, an ARM core may choose to use either
- * a +8 or a +12 displacement from the current instruction's address.
- * Whichever value is chosen for a given core, it must be the same for
- * both instructions and may not change.  This function measures it.
- */
-
-static int str_pc_offset;
-
-static void __init find_str_pc_offset(void)
-{
-	int addr, scratch, ret;
-
-	__asm__ (
-		"sub	%[ret], pc, #4		\n\t"
-		"str	pc, %[addr]		\n\t"
-		"ldr	%[scr], %[addr]		\n\t"
-		"sub	%[ret], %[scr], %[ret]	\n\t"
-		: [ret] "=r" (ret), [scr] "=r" (scratch), [addr] "+m" (addr));
-
-	str_pc_offset = ret;
-}
-
-/*
  * The insnslot_?arg_r[w]flags() functions below are to keep the
  * msr -> *fn -> mrs instruction sequences indivisible so that
  * the state of the CPSR flags aren't inadvertently modified
@@ -1569,8 +1546,3 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	return space_cccc_11xx(insn, asi);
 }
-
-void __init arm_kprobe_decode_init(void)
-{
-	find_str_pc_offset();
-}
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 794827e..e18576c 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
  *
+ * Some contents moved here from arch/arm/include/asm/kprobes-arm.c which is
+ * Copyright (C) 2006, 2007 Motorola Inc.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -14,6 +17,36 @@
 #include "kprobes.h"
 
 
+/*
+ * For STR and STM instructions, an ARM core may choose to use either
+ * a +8 or a +12 displacement from the current instruction's address.
+ * Whichever value is chosen for a given core, it must be the same for
+ * both instructions and may not change.  This function measures it.
+ */
+
+int str_pc_offset;
+
+void __init find_str_pc_offset(void)
+{
+	int addr, scratch, ret;
+
+	__asm__ (
+		"sub	%[ret], pc, #4		\n\t"
+		"str	pc, %[addr]		\n\t"
+		"ldr	%[scr], %[addr]		\n\t"
+		"sub	%[ret], %[scr], %[ret]	\n\t"
+		: [ret] "=r" (ret), [scr] "=r" (scratch), [addr] "+m" (addr));
+
+	str_pc_offset = ret;
+}
+
+
+void __init arm_kprobe_decode_init(void)
+{
+	find_str_pc_offset();
+}
+
+
 static unsigned long __kprobes __check_eq(unsigned long cpsr)
 {
 	return cpsr & PSR_Z_BIT;
-- 
1.7.2.5
