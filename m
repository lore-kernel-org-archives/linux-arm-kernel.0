From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:02 +0800
Subject: [RFC PATCH v4 24/34] early kprobes on ftrace: introduce x86
 arch_fix_ftrace_early_kprobe().
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-25-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_fix_ftrace_early_kprobe() will be called during ftrace converting
its entries into nops. This function is made for kprobe adjusting its
internal data.

To make as much as arch independent logic out of arch specific code,
arch_fix_ftrace_early_kprobe() doesn't iterate on kprobes in a aggr
kprobe. Such iteration should be done in kernel/kprobes.c.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/kprobes.h        |  9 +++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4e3d5a9..ead5b51 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1126,3 +1126,37 @@ int arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
+
+#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
+
+#define INT3_SIZE sizeof(kprobe_opcode_t)
+
+void arch_fix_ftrace_early_kprobe(struct kprobe *kp,
+		struct optimized_kprobe *op, int optimized)
+{
+	const unsigned char *ftrace_nop = ideal_nops[NOP_ATOMIC5];
+	const unsigned char *src = ftrace_nop + INT3_SIZE;
+	unsigned char *dest = kp->addr + INT3_SIZE;
+	size_t length = MCOUNT_INSN_SIZE - INT3_SIZE;
+
+	BUG_ON(op && (&op->kp != kp));
+	BUG_ON(optimized && op && (!(kp->flags & KPROBE_FLAG_OPTIMIZED)));
+
+	if ((!optimized) && (memcmp(dest, src, length) != 0))
+		text_poke_early(dest, src, length);
+
+	memcpy(&kp->opcode, ftrace_nop, INT3_SIZE);
+	if (op && op->kp.flags & KPROBE_FLAG_OPTIMIZED) {
+		/*
+		 * We are not allowed to use internal data of struct
+		 * optimized_kprobe if CONFIG_OPTPROBES is not defined.
+		 */
+#ifdef CONFIG_OPTPROBES
+		memcpy(op->optinsn.copied_insn, src, length);
+#else
+		BUG_ON(1);
+#endif
+	}
+}
+
+#endif
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 96dc842..f8f2ac2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -271,7 +271,16 @@ extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 
+/*
+ * Only when CONFIG_OPTPROBES struct optimized_kprobe is defined. Only use
+ * its pointer in function decl list.
+ */
+struct optimized_kprobe;
+
 #if defined(CONFIG_EARLY_KPROBES) && defined(CONFIG_KPROBES_ON_FTRACE)
+extern void arch_fix_ftrace_early_kprobe(struct kprobe *kp,
+		struct optimized_kprobe *op, int optimized);
+
 extern void init_kprobes_on_ftrace(void);
 #else
 static inline void init_kprobes_on_ftrace(void)
-- 
1.8.4
