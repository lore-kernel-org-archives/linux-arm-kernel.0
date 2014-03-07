From: dave.long@linaro.org (David Long)
Date: Fri,  7 Mar 2014 15:10:29 -0500
Subject: [PATCH v7 04/15] ARM: move shared uprobe/kprobe definitions into new
 include file
In-Reply-To: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
References: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
Message-ID: <1394223040-17129-5-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Separate the kprobe-only definitions from the definitions needed by
both kprobes and uprobes.

Signed-off-by: David A. Long <dave.long@linaro.org>
Acked-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/include/asm/kprobes.h               | 15 +---------
 arch/arm/include/asm/{kprobes.h => probes.h} | 44 +++++-----------------------
 2 files changed, 8 insertions(+), 51 deletions(-)
 copy arch/arm/include/asm/{kprobes.h => probes.h} (52%)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index fd2e5ca..6e10466 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -28,21 +28,8 @@
 #define kretprobe_blacklist_size	0
 
 typedef u32 kprobe_opcode_t;
-
 struct kprobe;
-typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
-typedef unsigned long (kprobe_check_cc)(unsigned long);
-typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
-typedef void (kprobe_insn_fn_t)(void);
-
-/* Architecture specific copy of original instruction. */
-struct arch_specific_insn {
-	kprobe_opcode_t			*insn;
-	kprobe_insn_handler_t		*insn_handler;
-	kprobe_check_cc			*insn_check_cc;
-	kprobe_insn_singlestep_t	*insn_singlestep;
-	kprobe_insn_fn_t		*insn_fn;
-};
+#include <asm/probes.h>
 
 struct prev_kprobe {
 	struct kprobe *kp;
diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/probes.h
similarity index 52%
copy from arch/arm/include/asm/kprobes.h
copy to arch/arm/include/asm/probes.h
index fd2e5ca..90c5f54 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/probes.h
@@ -1,5 +1,8 @@
 /*
- * arch/arm/include/asm/kprobes.h
+ * arch/arm/include/asm/probes.h
+ *
+ * Original contents copied from arch/arm/include/asm/kprobes.h
+ * which contains the following notice...
  *
  * Copyright (C) 2006, 2007 Motorola Inc.
  *
@@ -13,23 +16,9 @@
  * General Public License for more details.
  */
 
-#ifndef _ARM_KPROBES_H
-#define _ARM_KPROBES_H
-
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/notifier.h>
-
-#define __ARCH_WANT_KPROBES_INSN_SLOT
-#define MAX_INSN_SIZE			2
-#define MAX_STACK_SIZE			64	/* 32 would probably be OK */
+#ifndef _ASM_PROBES_H
+#define _ASM_PROBES_H
 
-#define flush_insn_slot(p)		do { } while (0)
-#define kretprobe_blacklist_size	0
-
-typedef u32 kprobe_opcode_t;
-
-struct kprobe;
 typedef void (kprobe_insn_handler_t)(struct kprobe *, struct pt_regs *);
 typedef unsigned long (kprobe_check_cc)(unsigned long);
 typedef void (kprobe_insn_singlestep_t)(struct kprobe *, struct pt_regs *);
@@ -44,23 +33,4 @@ struct arch_specific_insn {
 	kprobe_insn_fn_t		*insn_fn;
 };
 
-struct prev_kprobe {
-	struct kprobe *kp;
-	unsigned int status;
-};
-
-/* per-cpu kprobe control block */
-struct kprobe_ctlblk {
-	unsigned int kprobe_status;
-	struct prev_kprobe prev_kprobe;
-	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
-};
-
-void arch_remove_kprobe(struct kprobe *);
-int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
-int kprobe_exceptions_notify(struct notifier_block *self,
-			     unsigned long val, void *data);
-
-
-#endif /* _ARM_KPROBES_H */
+#endif
-- 
1.8.1.2
