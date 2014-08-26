From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:47 +0100
Subject: [PATCH 3/6] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1409048930-21598-4-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to register hooks for undefined instructions. The handlers
will be called when the undefined instruction and the processor state
(as contained in pstate) match criteria used at registration.

Note: The patch only deals with ARM instruction encodings and needs
fixing to handle thumb instructions as well.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/include/asm/traps.h |   16 ++++++++++
 arch/arm64/kernel/traps.c      |   66 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 10ca8ff..4faaf03 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -18,6 +18,22 @@
 #ifndef __ASM_TRAP_H
 #define __ASM_TRAP_H
 
+#include <linux/list.h>
+
+struct pt_regs;
+
+struct undef_hook {
+	struct list_head node;
+	u32 instr_mask;
+	u32 instr_val;
+	u64 pstate_mask;
+	u64 pstate_val;
+	int (*fn)(struct pt_regs *regs, u32 instr);
+};
+
+int register_undef_hook(struct undef_hook *hook);
+void unregister_undef_hook(struct undef_hook *hook);
+
 static inline int in_exception_text(unsigned long ptr)
 {
 	extern char __exception_text_start[];
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ffaddd..6cc8fce 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -257,6 +257,69 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		die(str, regs, err);
 }
 
+static LIST_HEAD(undef_hook);
+static DEFINE_RAW_SPINLOCK(undef_lock);
+
+int register_undef_hook(struct undef_hook *hook)
+{
+	unsigned long flags;
+
+	/*
+	 * We currently don't support handling undefined Thumb mode
+	 * instructions.
+	 */
+	if (hook->pstate_mask & COMPAT_PSR_T_BIT) {
+		pr_warn("Thumb mode not supported for undefined instruction hooks\n");
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_add(&hook->node, &undef_hook);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+
+	return 0;
+}
+
+void unregister_undef_hook(struct undef_hook *hook)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_del(&hook->node);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+}
+
+static int call_undef_hook(struct pt_regs *regs)
+{
+	struct undef_hook *hook;
+	unsigned long flags;
+	u32 instr;
+	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
+	void __user *pc = (void __user *)instruction_pointer(regs);
+
+	/*
+	 * Currently, undefined instruction patching is only supported
+	 * for user mode. Also, as we're not emulating any thumb
+	 * instructions lets not add thumb instruction decoding until
+	 * it is needed.
+	 */
+	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
+		return 1;
+
+	get_user(instr, (u32 __user *)pc);
+	instr = le32_to_cpu(instr);
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_for_each_entry(hook, &undef_hook, node)
+		if ((instr & hook->instr_mask) == hook->instr_val &&
+			(regs->pstate & hook->pstate_mask) == hook->pstate_val)
+			fn = hook->fn;
+
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+
+	return fn ? fn(regs, instr) : 1;
+}
+
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -266,6 +329,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (!aarch32_break_handler(regs))
 		return;
 
+	if (call_undef_hook(regs) == 0)
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(current, SIGILL) &&
 	    printk_ratelimit()) {
 		pr_info("%s[%d]: undefined instruction: pc=%p\n",
-- 
1.7.10.4
