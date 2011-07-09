From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:51 +0100
Subject: [PATCH 04/51] ARM: kprobes: Split out internal parts of kprobes.h
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Later, we will be adding a considerable amount of internal
implementation definitions to kprobe header files and it would be good
to have these in local header file along side the source code, rather
than pollute the existing header which is include by all users of
kprobes.

To this end, we add arch/arm/kernel/kprobes.h and move into this the
existing internal defintions from arch/arm/include/asm/kprobes.h

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/include/asm/kprobes.h |   17 -----------------
 arch/arm/kernel/kprobes.h      |   37 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes-arm.c  |    2 ++
 arch/arm/kernel/kprobes.c      |    2 ++
 4 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index e46bdd0..57d37d5 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -24,12 +24,6 @@
 #define MAX_INSN_SIZE			2
 #define MAX_STACK_SIZE			64	/* 32 would probably be OK */
 
-/*
- * This undefined instruction must be unique and
- * reserved solely for kprobes' use.
- */
-#define KPROBE_BREAKPOINT_INSTRUCTION	0xe7f001f8
-
 #define regs_return_value(regs)		((regs)->ARM_r0)
 #define flush_insn_slot(p)		do { } while (0)
 #define kretprobe_blacklist_size	0
@@ -62,20 +56,9 @@ struct kprobe_ctlblk {
 };
 
 void arch_remove_kprobe(struct kprobe *);
-void kretprobe_trampoline(void);
-
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
 int kprobe_exceptions_notify(struct notifier_block *self,
 			     unsigned long val, void *data);
 
-enum kprobe_insn {
-	INSN_REJECTED,
-	INSN_GOOD,
-	INSN_GOOD_NO_SLOT
-};
-
-enum kprobe_insn arm_kprobe_decode_insn(kprobe_opcode_t,
-					struct arch_specific_insn *);
-void __init arm_kprobe_decode_init(void);
 
 #endif /* _ARM_KPROBES_H */
diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
new file mode 100644
index 0000000..87a5241
--- /dev/null
+++ b/arch/arm/kernel/kprobes.h
@@ -0,0 +1,37 @@
+/*
+ * arch/arm/kernel/kprobes.h
+ *
+ * Contents moved from arch/arm/include/asm/kprobes.h which is
+ * Copyright (C) 2006, 2007 Motorola Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _ARM_KERNEL_KPROBES_H
+#define _ARM_KERNEL_KPROBES_H
+
+/*
+ * This undefined instruction must be unique and
+ * reserved solely for kprobes' use.
+ */
+#define KPROBE_BREAKPOINT_INSTRUCTION	0xe7f001f8
+
+enum kprobe_insn {
+	INSN_REJECTED,
+	INSN_GOOD,
+	INSN_GOOD_NO_SLOT
+};
+
+enum kprobe_insn arm_kprobe_decode_insn(kprobe_opcode_t,
+					struct arch_specific_insn *);
+
+void __init arm_kprobe_decode_init(void);
+
+#endif /* _ARM_KERNEL_KPROBES_H */
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 15eeff6..976ce14 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -61,6 +61,8 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 
+#include "kprobes.h"
+
 #define sign_extend(x, signbit) ((x) | (0 - ((x) & (1 << (signbit)))))
 
 #define branch_displacement(insn) sign_extend(((insn) & 0xffffff) << 2, 25)
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 1656c87..3ba5f8d 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -28,6 +28,8 @@
 #include <asm/traps.h>
 #include <asm/cacheflush.h>
 
+#include "kprobes.h"
+
 #define MIN_STACK_SIZE(addr) 				\
 	min((unsigned long)MAX_STACK_SIZE,		\
 	    (unsigned long)current_thread_info() + THREAD_START_SP - (addr))
-- 
1.7.2.5
