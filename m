From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:08 +0800
Subject: [RFC PATCH v4 30/34] early kprobes: convert early kprobes on ftrace
 to ftrace.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-31-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts early kprobes on ftrace to ftrace after
ftrace_init() is done. It calls arm_kprobe_ftrace() for such kprobes.
This ftrace call will trigger mechanism introduced by previous patches,
replaces them with ftrace.

After that, for each early kprobe, 3 cases are dealed differently: for
independent kprobe, simply release its resources by
arch_remove_kprobe(). For aggr kprobe with single kprobed, free the
aggr kprobe and replace the original kprobe in hash table. Note that
some flags must be inherited. For aggr kprobes linked with more than
one kprobe, free resources of each kprobe.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c504c1c..95754f6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2657,8 +2657,70 @@ kprobe_on_ftrace_get_old_insn(struct dyn_ftrace *rec,
 	return ret;
 }
 
+static void convert_early_kprobes_on_ftrace(void)
+{
+	struct hlist_head *head;
+	struct kprobe *p;
+	int i;
+
+	/*
+	 * arm_kprobe_ftrace --> kprobe_on_ftrace_get_old_insn require
+	 * kprobe_mutex, and we also need it to protect kprobe table.
+	 */
+	mutex_lock(&kprobe_mutex);
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		head = &kprobe_table[i];
+		hlist_for_each_entry_rcu(p, head, hlist) {
+			if (!(p->flags & KPROBE_FLAG_FTRACE_EARLY))
+				continue;
+
+			p->flags |= KPROBE_FLAG_FTRACE;
+			arm_kprobe_ftrace(p);
+			p->flags &= ~KPROBE_FLAG_FTRACE_EARLY;
+			p->flags &= ~KPROBE_FLAG_OPTIMIZED;
+
+			/* Now we are able to free resources. */
+			if (!kprobe_aggrprobe(p)) {
+				/*
+				 * This is an independent kprobe. arch_remove_kprobe()
+				 * only free resources.
+				 */
+				arch_remove_kprobe(p);
+				arch_prepare_kprobe_ftrace(p);
+			} else if (list_is_singular(&p->list)) {
+				struct kprobe *kp;
+
+				/*
+				 * Different from __unregister_kprobe_bottom,
+				 * this time p is aggr kprobe. Replace the original
+				 * 'struct kprobe' with aggr kprobe and free aggr_kprobe.
+				 */
+				kp = list_entry(p->list.next, struct kprobe, list);
+
+				/* Inherit flags. */
+				kp->flags |= (p->flags &
+					(KPROBE_FLAG_DISABLED | KPROBE_FLAG_FTRACE));
+				hlist_replace_rcu(&p->hlist, &kp->hlist);
+
+				list_del(&p->list);
+				free_aggr_kprobe(p);
+				arch_prepare_kprobe_ftrace(kp);
+			} else {
+				struct kprobe *list_p;
+
+				list_for_each_entry_rcu(list_p, &p->list, list) {
+					arch_remove_kprobe(p);
+					arch_prepare_kprobe_ftrace(list_p);
+				}
+			}
+		}
+	}
+	mutex_unlock(&kprobe_mutex);
+}
+
 void init_kprobes_on_ftrace(void)
 {
 	kprobes_on_ftrace_initialized = true;
+	convert_early_kprobes_on_ftrace();
 }
 #endif
-- 
1.8.4
