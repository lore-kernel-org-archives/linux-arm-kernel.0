From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 27 Oct 2014 18:40:03 +0000
Subject: [PATCHv3 1/5] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1414435207-30240-3-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to register hooks for undefined instructions. The handlers
will be called when the undefined instruction and the processor state
(as contained in pstate) match criteria used at registration.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/include/asm/insn.h  |  2 ++
 arch/arm64/include/asm/traps.h | 16 ++++++++++
 arch/arm64/kernel/insn.c       |  5 ++++
 arch/arm64/kernel/traps.c      | 68 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 56a9e63..2bffdc3 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -354,6 +354,8 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
+
+bool aarch32_insn_is_wide_instruction(u32 insn);
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
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
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index e007714..9766a56 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -959,3 +959,8 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn, shift);
 }
+
+bool aarch32_insn_is_wide_instruction(u32 insn)
+{
+	return insn >= 0xe800;
+}
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index de1b085..16dd73f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -259,6 +259,71 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 	}
 }
 
+static LIST_HEAD(undef_hook);
+static DEFINE_RAW_SPINLOCK(undef_lock);
+
+int register_undef_hook(struct undef_hook *hook)
+{
+	unsigned long flags;
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
+	if (!user_mode(regs))
+		return 1;
+
+	if (compat_thumb_mode(regs)) {
+		/* 16-bit Thumb instruction */
+		if (get_user(instr, (u16 __user *)pc))
+			goto exit;
+		instr = le16_to_cpu(instr);
+		if (aarch32_insn_is_wide_instruction(instr)) {
+			u32 instr2;
+
+			if (get_user(instr2, (u16 __user *)(pc + 2)))
+				goto exit;
+			instr2 = le16_to_cpu(instr2);
+			instr = (instr << 16) | instr2;
+		}
+	} else {
+		/* 32-bit ARM instruction */
+		if (get_user(instr, (u32 __user *)pc))
+			goto exit;
+		instr = le32_to_cpu(instr);
+	}
+
+	raw_spin_lock_irqsave(&undef_lock, flags);
+	list_for_each_entry(hook, &undef_hook, node)
+		if ((instr & hook->instr_mask) == hook->instr_val &&
+			(regs->pstate & hook->pstate_mask) == hook->pstate_val)
+			fn = hook->fn;
+
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
+exit:
+	return fn ? fn(regs, instr) : 1;
+}
+
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -268,6 +333,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (!aarch32_break_handler(regs))
 		return;
 
+	if (call_undef_hook(regs) == 0)
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(current, SIGILL) &&
 	    printk_ratelimit()) {
 		pr_info("%s[%d]: undefined instruction: pc=%p\n",
-- 
2.1.1
