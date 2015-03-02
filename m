From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:03 +0800
Subject: [RFC PATCH v4 25/34] ftrace: don't fire ftrace_bug if the instruction
 is taken by early kprobes.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-26-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During ftrace_init(), if an early kprobe has already probed at an
instruction, don't fire ftrace_bug(). Instead,
kprobe_fix_ftrace_make_nop() is for this fixing. It calls
arch_fix_ftrace_early_kprobe() to adjust arch specific data. Following
patches will convert such kprobes into ftrace.

It's kprobe's responsibility for setting and clearing
FTRACE_FL_EARLY_KPROBES flag. When ftrace try to makenop, set this flag.
When ftrace try to create call instruction on it, unset it.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/ftrace.h  |  5 +++--
 include/linux/kprobes.h |  7 +++++++
 kernel/kprobes.c        | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/trace/ftrace.c   | 17 ++++++++++++-----
 4 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8db315a..fe99166 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -341,10 +341,11 @@ enum {
 	FTRACE_FL_TRAMP		= (1UL << 28),
 	FTRACE_FL_TRAMP_EN	= (1UL << 27),
 	FTRACE_FL_IPMODIFY	= (1UL << 26),
+	FTRACE_FL_EARLY_KPROBES	= (1UL << 25),
 };
 
-#define FTRACE_REF_MAX_SHIFT	26
-#define FTRACE_FL_BITS		6
+#define FTRACE_REF_MAX_SHIFT	25
+#define FTRACE_FL_BITS		7
 #define FTRACE_FL_MASKED_BITS	((1UL << FTRACE_FL_BITS) - 1)
 #define FTRACE_FL_MASK		(FTRACE_FL_MASKED_BITS << FTRACE_REF_MAX_SHIFT)
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index f8f2ac2..ab1a330 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -282,10 +282,17 @@ extern void arch_fix_ftrace_early_kprobe(struct kprobe *kp,
 		struct optimized_kprobe *op, int optimized);
 
 extern void init_kprobes_on_ftrace(void);
+extern bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec);
 #else
 static inline void init_kprobes_on_ftrace(void)
 {
 }
+
+static inline bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *_unused)
+{
+
+	return false;
+}
 #endif // CONFIG_EARLY_KPROBES && CONFIG_KPROBES_ON_FTRACE
 
 #ifdef CONFIG_EARLY_KPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b5e13ba..20b6ab8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2584,6 +2584,45 @@ module_init(init_kprobes);
 EXPORT_SYMBOL_GPL(jprobe_return);
 
 #if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
+bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec)
+{
+	struct optimized_kprobe *op;
+	struct kprobe *kp;
+	int optimized;
+	void *addr;
+
+	if (kprobes_on_ftrace_initialized)
+		return false;
+
+	addr = (void *)rec->ip;
+	mutex_lock(&kprobe_mutex);
+	kp = get_kprobe(addr);
+
+	if (!kp || !(kp->flags & KPROBE_FLAG_FTRACE_EARLY)) {
+		mutex_unlock(&kprobe_mutex);
+		return false;
+	}
+
+	op = kprobe_aggrprobe(kp) ?
+		container_of(kp, struct optimized_kprobe, kp)
+		: NULL;
+
+	optimized = op ? op->kp.flags & KPROBE_FLAG_OPTIMIZED : 0;
+	arch_fix_ftrace_early_kprobe(kp, op, optimized);
+	if (op != NULL) {
+		struct kprobe *list_p;
+
+		/* Fix all kprobes connected to it */
+		list_for_each_entry_rcu(list_p, &op->kp.list, list)
+			arch_fix_ftrace_early_kprobe(list_p, NULL, optimized);
+	}
+
+	mutex_unlock(&kprobe_mutex);
+
+	rec->flags |= FTRACE_FL_EARLY_KPROBES;
+	return true;
+}
+
 void init_kprobes_on_ftrace(void)
 {
 	kprobes_on_ftrace_initialized = true;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5cb0269..78787d4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2387,11 +2387,18 @@ ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
 		return 0;
 
 	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
-	if (ret) {
-		ftrace_bug(ret, rec);
-		return 0;
-	}
-	return 1;
+
+	if (!ret)
+		return 1;
+
+#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
+	/* FTRACE_FL_EARLY_KPROBES should have been set for rec */
+	if (kprobe_fix_ftrace_make_nop(rec))
+		return 1;
+#endif
+
+	ftrace_bug(ret, rec);
+	return 0;
 }
 
 /*
-- 
1.8.4
