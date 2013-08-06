From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Tue,  6 Aug 2013 11:42:06 +0530
Subject: [PATCH] AArch64: Add single-step and breakpoint handler hooks
Message-ID: <1375769526-3526-1-git-send-email-sandeepa.prabhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AArch64 Single Steping and Breakpoint debug exceptions will be
used by multiple debug framworks like kprobes & kgdb.

This patch implements the hooks for those frameworks to register
their own handlers for handling breakpoint and single step events.

Reworked the debug exception handler in entry.S: do_dbg to
pass the correct break/step address to the handlers, i.e. FAR_EL1 if
exception is watchpoint, ELR_EL1 for all other debug exceptions.

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm64/include/asm/debug-monitors.h |  20 +++++++
 arch/arm64/kernel/debug-monitors.c      | 102 +++++++++++++++++++++++++++++++-
 arch/arm64/kernel/entry.S               |   6 +-
 3 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index a2232d0..aff3a76 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_DEBUG_MONITORS_H
 #define __ASM_DEBUG_MONITORS_H
 
+#include <linux/list.h>
+
 #ifdef __KERNEL__
 
 #define	DBG_ESR_EVT(x)		(((x) >> 27) & 0x7)
@@ -62,6 +64,24 @@ struct task_struct;
 
 #define DBG_ARCH_ID_RESERVED	0	/* In case of ptrace ABI updates. */
 
+struct step_hook {
+	struct list_head node;
+	int (*fn)(struct pt_regs *regs, unsigned int insn, unsigned long addr);
+};
+
+void register_step_hook(struct step_hook *hook);
+void unregister_step_hook(struct step_hook *hook);
+
+struct break_hook {
+	struct list_head node;
+	u32 esr_magic;
+	u32 esr_mask;
+	int (*fn)(struct pt_regs *regs, unsigned int insn, unsigned long addr);
+};
+
+void register_break_hook(struct break_hook *hook);
+void unregister_break_hook(struct break_hook *hook);
+
 u8 debug_monitors_arch(void);
 
 void enable_debug_monitors(enum debug_el el);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index cbfacf7..2846327 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -188,6 +188,54 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 	regs->pstate = spsr;
 }
 
+/* EL1 Single Step Handler hooks */
+static LIST_HEAD(step_hook);
+static DEFINE_RAW_SPINLOCK(step_lock);
+
+void register_step_hook(struct step_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&step_lock, flags);
+	list_add(&hook->node, &step_hook);
+	raw_spin_unlock_irqrestore(&step_lock, flags);
+}
+
+void unregister_step_hook(struct step_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&step_lock, flags);
+	list_del(&hook->node);
+	raw_spin_unlock_irqrestore(&step_lock, flags);
+}
+
+/*
+ * Call registered single step handers
+ * There is no Syndrome info to check for determining the handler.
+ * So we call all the registered handlers, until the right handler is
+ * found which returns zero.
+ */
+static int call_step_hook(struct pt_regs *regs,
+		unsigned int esr, unsigned long addr)
+{
+	struct step_hook *hook;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&step_lock, flags);
+	list_for_each_entry(hook, &step_hook, node)	{
+		raw_spin_unlock_irqrestore(&step_lock, flags);
+
+		if (hook->fn(regs, esr, addr) == 0)
+			return 0;
+
+		raw_spin_lock_irqsave(&step_lock, flags);
+	}
+	raw_spin_unlock_irqrestore(&step_lock, flags);
+
+	return 1;
+}
+
 static int single_step_handler(unsigned long addr, unsigned int esr,
 			       struct pt_regs *regs)
 {
@@ -215,8 +263,11 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		 */
 		user_rewind_single_step(current);
 	} else {
-		/* TODO: route to KGDB */
-		pr_warning("Unexpected kernel single-step exception at EL1\n");
+		/* Call single step handlers for kgdb/kprobes */
+		if (call_step_hook(regs, addr, esr) == 0)
+			return 0;
+
+		pr_warn("unexpected single step exception at %lx!\n", addr);
 		/*
 		 * Re-enable stepping since we know that we will be
 		 * returning to regs.
@@ -227,11 +278,56 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 	return 0;
 }
 
+
+static LIST_HEAD(break_hook);
+static DEFINE_RAW_SPINLOCK(break_lock);
+
+void register_break_hook(struct break_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&break_lock, flags);
+	list_add(&hook->node, &break_hook);
+	raw_spin_unlock_irqrestore(&break_lock, flags);
+}
+
+void unregister_break_hook(struct break_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&break_lock, flags);
+	list_del(&hook->node);
+	raw_spin_unlock_irqrestore(&break_lock, flags);
+}
+
+static int call_break_hook(struct pt_regs *regs,
+		unsigned int esr, unsigned long addr)
+{
+	struct break_hook *hook;
+	unsigned long flags;
+	int (*fn)(struct pt_regs *regs,
+		unsigned int esr, unsigned long addr) = NULL;
+
+	raw_spin_lock_irqsave(&break_lock, flags);
+	list_for_each_entry(hook, &break_hook, node)
+		if ((esr & hook->esr_mask) == hook->esr_magic)
+			fn = hook->fn;
+	raw_spin_unlock_irqrestore(&break_lock, flags);
+
+	return fn ? fn(regs, esr, addr) : 1;
+}
+
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
 {
 	siginfo_t info;
 
+	/* Call single step handlers for kgdb/kprobes */
+	if (call_break_hook(regs, esr, addr) == 0)
+		return 0;
+
+	pr_warn("unexpected brk exception at %lx, esr=0x%x\n", addr, esr);
+
 	if (!user_mode(regs))
 		return -EFAULT;
 
@@ -291,7 +387,7 @@ static int __init debug_traps_init(void)
 	hook_debug_fault_code(DBG_ESR_EVT_HWSS, single_step_handler, SIGTRAP,
 			      TRAP_HWBKPT, "single-step handler");
 	hook_debug_fault_code(DBG_ESR_EVT_BRK, brk_handler, SIGTRAP,
-			      TRAP_BRKPT, "ptrace BRK handler");
+			      TRAP_BRKPT, "AArch64 BRK handler");
 	return 0;
 }
 arch_initcall(debug_traps_init);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6ad781b..e7350bd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -288,8 +288,12 @@ el1_dbg:
 	/*
 	 * Debug exception handling
 	 */
+	mrs	x25, far_el1			//far for watchpt
+	cmp	x24, #ESR_EL1_EC_WATCHPT_EL1
+	csel	x0, x25, x22, eq	//addr: x25->far_el1, x22->elr_el1
+	b.ge	do_dbg
 	tbz	x24, #0, el1_inv		// EL1 only
-	mrs	x0, far_el1
+do_dbg:
 	mov	x2, sp				// struct pt_regs
 	bl	do_debug_exception
 
-- 
1.8.1.2
