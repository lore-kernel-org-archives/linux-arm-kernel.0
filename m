From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Tue,  5 Nov 2013 14:15:43 +0530
Subject: [PATCH v4 1/4] arm64: support single-step and breakpoint handler hooks
In-Reply-To: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1383641146-27274-2-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>

AArch64 Single Steping and Breakpoint debug exceptions will be
used by multiple debug framworks like kprobes & kgdb.

This patch implements the hooks for those frameworks to register
their own handlers for handling breakpoint and single step events.

Reworked the debug exception handler in entry.S: do_dbg to route
software breakpoint (BRK64) exception to do_debug_exception()

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm64/include/asm/debug-monitors.h |   21 ++++++++
 arch/arm64/kernel/debug-monitors.c      |   86 ++++++++++++++++++++++++++++++-
 arch/arm64/kernel/entry.S               |    2 +
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index a2232d0..6231479 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -62,6 +62,27 @@ struct task_struct;
 
 #define DBG_ARCH_ID_RESERVED	0	/* In case of ptrace ABI updates. */
 
+#define DBG_HOOK_HANDLED	0
+#define DBG_HOOK_ERROR		1
+
+struct step_hook {
+	struct list_head node;
+	int (*fn)(struct pt_regs *regs, unsigned int esr);
+};
+
+void register_step_hook(struct step_hook *hook);
+void unregister_step_hook(struct step_hook *hook);
+
+struct break_hook {
+	struct list_head node;
+	u32 esr_val;
+	u32 esr_mask;
+	int (*fn)(struct pt_regs *regs, unsigned int esr);
+};
+
+void register_break_hook(struct break_hook *hook);
+void unregister_break_hook(struct break_hook *hook);
+
 u8 debug_monitors_arch(void);
 
 void enable_debug_monitors(enum debug_el el);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index cbfacf7..e42ad5f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -188,6 +188,48 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 	regs->pstate = spsr;
 }
 
+/* EL1 Single Step Handler hooks */
+static LIST_HEAD(step_hook);
+DEFINE_RWLOCK(step_hook_lock);
+
+void register_step_hook(struct step_hook *hook)
+{
+	write_lock(&step_hook_lock);
+	list_add(&hook->node, &step_hook);
+	write_unlock(&step_hook_lock);
+}
+
+void unregister_step_hook(struct step_hook *hook)
+{
+	write_lock(&step_hook_lock);
+	list_del(&hook->node);
+	write_unlock(&step_hook_lock);
+}
+
+/*
+ * Call registered single step handers
+ * There is no Syndrome info to check for determining the handler.
+ * So we call all the registered handlers, until the right handler is
+ * found which returns zero.
+ */
+static int call_step_hook(struct pt_regs *regs, unsigned int esr)
+{
+	struct step_hook *hook;
+	int retval = DBG_HOOK_ERROR;
+
+	read_lock(&step_hook_lock);
+
+	list_for_each_entry(hook, &step_hook, node)	{
+		retval = hook->fn(regs, esr);
+		if (retval == DBG_HOOK_HANDLED)
+			break;
+	}
+
+	read_unlock(&step_hook_lock);
+
+	return retval;
+}
+
 static int single_step_handler(unsigned long addr, unsigned int esr,
 			       struct pt_regs *regs)
 {
@@ -215,7 +257,10 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		 */
 		user_rewind_single_step(current);
 	} else {
-		/* TODO: route to KGDB */
+		/* call registered single step handlers */
+		if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
+			return 0;
+
 		pr_warning("Unexpected kernel single-step exception at EL1\n");
 		/*
 		 * Re-enable stepping since we know that we will be
@@ -227,11 +272,50 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 	return 0;
 }
 
+
+static LIST_HEAD(break_hook);
+DEFINE_RWLOCK(break_hook_lock);
+
+void register_break_hook(struct break_hook *hook)
+{
+	write_lock(&break_hook_lock);
+	list_add(&hook->node, &break_hook);
+	write_unlock(&break_hook_lock);
+}
+
+void unregister_break_hook(struct break_hook *hook)
+{
+	write_lock(&break_hook_lock);
+	list_del(&hook->node);
+	write_unlock(&break_hook_lock);
+}
+
+static int call_break_hook(struct pt_regs *regs, unsigned int esr)
+{
+	struct break_hook *hook;
+	int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
+
+	read_lock(&break_hook_lock);
+	list_for_each_entry(hook, &break_hook, node)
+		if ((esr & hook->esr_mask) == hook->esr_val)
+			fn = hook->fn;
+	read_unlock(&break_hook_lock);
+
+	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
+}
+
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
 {
 	siginfo_t info;
 
+	/* call the registered breakpoint handler */
+	if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
+		return 0;
+
+	pr_warn("unexpected brk exception at %lx, esr=0x%x\n",
+			(long)instruction_pointer(regs), esr);
+
 	if (!user_mode(regs))
 		return -EFAULT;
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 3881fd1..7fbc510 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -288,6 +288,8 @@ el1_dbg:
 	/*
 	 * Debug exception handling
 	 */
+	cmp	x24, #ESR_EL1_EC_BRK64		// if BRK64
+	cinc	x24, x24, eq			// set bit '0'
 	tbz	x24, #0, el1_inv		// EL1 only
 	mrs	x0, far_el1
 	mov	x2, sp				// struct pt_regs
-- 
1.7.9.5
