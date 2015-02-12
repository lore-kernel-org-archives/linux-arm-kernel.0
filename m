From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:21:25 +0800
Subject: [RFC PATCH v2 24/26] early kprobes: core logic to support early
 kprobe on ftrace.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743685-13072-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize previous introduced ftrace update notify chain to support early
kprobe on ftrace.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h |   1 +
 kernel/kprobes.c        | 213 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 197 insertions(+), 17 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 92aafa7..1c211e8 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -131,6 +131,7 @@ struct kprobe {
 				   */
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
 #define KPROBE_FLAG_EARLY	16 /* early kprobe */
+#define KPROBE_FLAG_RESTORED	32 /* temporarily restored to its original insn */
 
 /* Has this kprobe gone ? */
 static inline int kprobe_gone(struct kprobe *p)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0bbb510..c9cd46f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -48,6 +48,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/stop_machine.h>
 
 #include <asm-generic/sections.h>
 #include <asm/cacheflush.h>
@@ -2540,11 +2541,127 @@ EXPORT_SYMBOL_GPL(jprobe_return);
 void __weak arch_fix_ftrace_early_kprobe(struct optimized_kprobe *p)
 {
 }
+
+static int restore_optimized_kprobe(struct optimized_kprobe *op)
+{
+	/* If it already restored, pass it to other. */
+	if (op->kp.flags & KPROBE_FLAG_RESTORED)
+		return NOTIFY_DONE;
+
+	get_online_cpus();
+	mutex_lock(&text_mutex);
+	arch_restore_optimized_kprobe(op);
+	mutex_unlock(&text_mutex);
+	put_online_cpus();
+
+	op->kp.flags |= KPROBE_FLAG_RESTORED;
+	return NOTIFY_STOP;
+}
+
+static int ftrace_notifier_call(struct notifier_block *nb,
+		unsigned long val, void *param)
+{
+	struct ftrace_update_notifier_info *info = param;
+	struct optimized_kprobe *op;
+	struct dyn_ftrace *rec;
+	struct kprobe *kp;
+	int enable;
+	void *addr;
+	int ret = NOTIFY_DONE;
+
+	if (!info || !info->rec || !info->rec->ip)
+		return NOTIFY_DONE;
+
+	rec = info->rec;
+	enable = info->enable;
+	addr = (void *)rec->ip;
+
+	mutex_lock(&kprobe_mutex);
+	kp = get_kprobe(addr);
+	mutex_unlock(&kprobe_mutex);
+
+	if (!kp || !kprobe_aggrprobe(kp))
+		return NOTIFY_DONE;
+
+	op = container_of(kp, struct optimized_kprobe, kp);
+	/*
+	 * Ftrace is trying to convert ftrace entries to nop
+	 * instruction. This conversion should have already been done
+	 * at register_early_kprobe(). x86 needs fixing here.
+	 */
+	if (!(rec->flags & FTRACE_FL_ENABLED) && (!enable)) {
+		arch_fix_ftrace_early_kprobe(op);
+		return NOTIFY_STOP;
+	}
+
+	/*
+	 * Ftrace is trying to enable a trace entry. We temporary
+	 * restore the probed instruction.
+	 * We can continue using this kprobe as a ftrace-based kprobe,
+	 * but event between this restoring and early kprobe conversion
+	 * will get lost.
+	 */
+	if (!(rec->flags & FTRACE_FL_ENABLED) && enable) {
+		ret = restore_optimized_kprobe(op);
+
+		/* Let ftrace retry if restore is successful. */
+		if (ret == NOTIFY_STOP)
+			info->retry = true;
+		return ret;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ftrace_notifier_block = {
+	.notifier_call = ftrace_notifier_call,
+};
+static bool ftrace_notifier_registred = false;
+
+static int enable_early_kprobe_on_ftrace(struct kprobe *p)
+{
+	int err;
+
+	if (!ftrace_notifier_registred) {
+		err = register_ftrace_update_notifier(&ftrace_notifier_block);
+		if (err) {
+			pr_err("Failed to register ftrace update notifier\n");
+			return err;
+		}
+		ftrace_notifier_registred = true;
+	}
+
+	err = ftrace_process_loc_early((unsigned long)p->addr);
+	if (err)
+		pr_err("Failed to process ftrace entry at %p\n", p->addr);
+	return err;
+}
+
+/* Caller must ensure kprobe_aggrprobe(kp). */
+static void convert_early_ftrace_kprobe_top(struct optimized_kprobe *op)
+{
+	restore_optimized_kprobe(op);
+	arm_kprobe_ftrace(&op->kp);
+}
+
+#else
+static inline int enable_early_kprobe_on_ftrace(struct kprobe *__unused)
+{ return 0; }
+
+/*
+ * If CONFIG_KPROBES_ON_FTRACE is off this function should never get called,
+ * so let it trigger a warning.
+ */
+static inline void convert_early_ftrace_kprobe_top(struct optimized_kprobe *__unused)
+{
+	WARN_ON(1);
+}
 #endif
 
 static int register_early_kprobe(struct kprobe *p)
 {
 	struct early_kprobe_slot *slot;
+	struct module *probed_mod;
 	int err;
 
 	if (p->break_handler || p->post_handler)
@@ -2552,13 +2669,25 @@ static int register_early_kprobe(struct kprobe *p)
 	if (p->flags & KPROBE_FLAG_DISABLED)
 		return -EINVAL;
 
+	err = check_kprobe_address_safe(p, &probed_mod);
+	if (err)
+		return err;
+
+	BUG_ON(probed_mod);
+
+	if (kprobe_ftrace(p)) {
+		err = enable_early_kprobe_on_ftrace(p);
+		if (err)
+			return err;
+	}
+
 	slot = ek_alloc_early_kprobe();
 	if (!slot) {
 		pr_err("No enough early kprobe slots.\n");
 		return -ENOMEM;
 	}
 
-	p->flags &= KPROBE_FLAG_DISABLED;
+	p->flags &= KPROBE_FLAG_DISABLED | KPROBE_FLAG_FTRACE;
 	p->flags |= KPROBE_FLAG_EARLY;
 	p->nmissed = 0;
 
@@ -2599,43 +2728,93 @@ free_slot:
 }
 
 static void
-convert_early_kprobe(struct kprobe *kp)
+convert_early_kprobe_top(struct kprobe *kp)
 {
 	struct module *probed_mod;
+	struct optimized_kprobe *op;
 	int err;
 
 	BUG_ON(!kprobe_aggrprobe(kp));
+	op = container_of(kp, struct optimized_kprobe, kp);
 
 	err = check_kprobe_address_safe(kp, &probed_mod);
 	if (err)
 		panic("Insert kprobe at %p is not safe!", kp->addr);
+	BUG_ON(probed_mod);
 
-	/*
-	 * FIXME:
-	 * convert kprobe to ftrace if CONFIG_KPROBES_ON_FTRACE is on
-	 * and kp is on ftrace location.
-	 */
+	if (kprobe_ftrace(kp))
+		convert_early_ftrace_kprobe_top(op);
+}
 
-	mutex_lock(&kprobe_mutex);
-	hlist_del_rcu(&kp->hlist);
+static void
+convert_early_kprobes_top(void)
+{
+	struct kprobe *p;
+
+	hlist_for_each_entry(p, &early_kprobe_hlist, hlist)
+		convert_early_kprobe_top(p);
+}
+
+static LIST_HEAD(early_freeing_list);
+
+static void
+convert_early_kprobe_stop_machine(struct kprobe *kp)
+{
+	struct optimized_kprobe *op;
+
+	BUG_ON(!kprobe_aggrprobe(kp));
+	op = container_of(kp, struct optimized_kprobe, kp);
+
+	if ((kprobe_ftrace(kp)) && (list_is_singular(&op->kp.list))) {
+		/* Update kp */
+		kp = list_entry(op->kp.list.next, struct kprobe, list);
+
+		hlist_replace_rcu(&op->kp.hlist, &kp->hlist);
+		list_del_init(&kp->list);
+
+		op->kp.flags |= KPROBE_FLAG_DISABLED;
+		list_add(&op->list, &early_freeing_list);
+	}
 
+	hlist_del_rcu(&kp->hlist);
 	INIT_HLIST_NODE(&kp->hlist);
 	hlist_add_head_rcu(&kp->hlist,
-		       &kprobe_table[hash_ptr(kp->addr, KPROBE_HASH_BITS)]);
-	mutex_unlock(&kprobe_mutex);
-
-	if (probed_mod)
-		module_put(probed_mod);
+			&kprobe_table[hash_ptr(kp->addr, KPROBE_HASH_BITS)]);
 }
 
-static void
-convert_early_kprobes(void)
+static int
+convert_early_kprobes_stop_machine(void *__unused)
 {
 	struct kprobe *p;
 	struct hlist_node *tmp;
 
 	hlist_for_each_entry_safe(p, tmp, &early_kprobe_hlist, hlist)
-		convert_early_kprobe(p);
+		convert_early_kprobe_stop_machine(p);
+	return 0;
+}
+
+static void
+convert_early_kprobes(void)
+{
+	struct optimized_kprobe *op, *tmp;
+
+	mutex_lock(&kprobe_mutex);
+
+	convert_early_kprobes_top();
+
+	get_online_cpus();
+	mutex_lock(&text_mutex);
+
+	stop_machine(convert_early_kprobes_stop_machine, NULL, NULL);
+
+	mutex_unlock(&text_mutex);
+	put_online_cpus();
+	mutex_unlock(&kprobe_mutex);
+
+	list_for_each_entry_safe(op, tmp, &early_freeing_list, list) {
+		list_del_init(&op->list);
+		free_aggr_kprobe(&op->kp);
+	}
 };
 #else
 static int register_early_kprobe(struct kprobe *p) { return -ENOSYS; }
-- 
1.8.4
