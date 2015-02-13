From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:10 +0800
Subject: [RFC PATCH v3 22/26] early kprobes: introduce
 arch_fix_ftrace_early_kprobe().
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806070-62398-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is for futher use. arch_fix_ftrace_early_kprobe() will be
called when ftrace trying to convert ftrace entries to nop and fail. For
x86 it should adjust the saved nop instruction here because it doesn't
know what nop ftrace will choose when early probing.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 31 +++++++++++++++++++++++++++++++
 include/linux/kprobes.h       |  5 +++++
 kernel/kprobes.c              |  6 ++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 21847ab..f3ea954 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -456,3 +456,34 @@ int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter)
 	return 0;
 }
 NOKPROBE_SYMBOL(setup_detour_execution);
+
+#ifdef CONFIG_EARLY_KPROBES
+void arch_fix_ftrace_early_kprobe(struct optimized_kprobe *op)
+{
+	const unsigned char *correct_nop5 = ideal_nops[NOP_ATOMIC5];
+	struct kprobe *list_p;
+
+	u32 mask = KPROBE_FLAG_EARLY |
+		KPROBE_FLAG_OPTIMIZED |
+		KPROBE_FLAG_FTRACE;
+
+	if ((op->kp.flags & mask) != mask)
+		return;
+
+	/*
+	 * For early kprobe on ftrace, use right nop instruction.
+	 * See x86 ftrace_make_nop and ftrace_nop_replace. Note that
+	 * ideal_nops used by ftrace_nop_replace is setupt after early
+	 * kprobe registration.
+	 */
+
+	memcpy(&op->kp.opcode, correct_nop5, sizeof(kprobe_opcode_t));
+	memcpy(op->optinsn.copied_insn, correct_nop5 + INT3_SIZE,
+			RELATIVE_ADDR_SIZE);
+
+	/* Fix all kprobes connected to it */
+	list_for_each_entry_rcu(list_p, &op->kp.list, list)
+		memcpy(&list_p->opcode, correct_nop5, sizeof(kprobe_opcode_t));
+
+}
+#endif
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0c64df8..e483f1b 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -459,6 +459,11 @@ struct early_kprobe_slot {
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct pt_regs *regs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+
+#ifdef CONFIG_EARLY_KPROBES
+extern void arch_fix_ftrace_early_kprobe(struct optimized_kprobe *p);
+#endif
+
 #endif
 
 int arch_check_ftrace_location(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 131a71a..0bbb510 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2536,6 +2536,12 @@ EXPORT_SYMBOL_GPL(jprobe_return);
 
 #ifdef CONFIG_EARLY_KPROBES
 
+#ifdef CONFIG_KPROBES_ON_FTRACE
+void __weak arch_fix_ftrace_early_kprobe(struct optimized_kprobe *p)
+{
+}
+#endif
+
 static int register_early_kprobe(struct kprobe *p)
 {
 	struct early_kprobe_slot *slot;
-- 
1.8.4
