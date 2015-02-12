From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:21:15 +0800
Subject: [RFC PATCH v2 22/26] early kprobes: introduce
 arch_fix_ftrace_early_kprobe().
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743675-12986-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gives arch code a chance to fix ftrace entry.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 31 +++++++++++++++++++++++++++++++
 include/linux/kprobes.h       |  6 +++++-
 kernel/kprobes.c              |  6 ++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

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
index 0c64df8..990d04b 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -330,7 +330,6 @@ extern kprobe_opcode_t __early_kprobes_code_area_start[];
 extern kprobe_opcode_t __early_kprobes_code_area_end[];
 extern kprobe_opcode_t __early_kprobes_insn_slot_start[];
 extern kprobe_opcode_t __early_kprobes_insn_slot_end[];
-
 #else
 #define __DEFINE_EKPROBE_ALLOC_OPS(__t, __name)				\
 static inline __t *__ek_alloc_##__name(__t *__s, __t *__e, unsigned long *__b)\
@@ -459,6 +458,11 @@ struct early_kprobe_slot {
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
