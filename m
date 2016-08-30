From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Tue, 30 Aug 2016 16:07:28 +0800
Subject: [PATCHV5 1/3] tracing: add a possibility of exporting function trace
 to other places instead of ring buffer only
In-Reply-To: <1472544450-9915-1-git-send-email-zhang.chunyan@linaro.org>
References: <1472544450-9915-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1472544450-9915-2-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently Function traces can be only exported to ring buffer, this
patch added trace_export concept which can process traces and export
them to a registered destination as an addition to the current only
output of Ftrace - i.e. ring buffer.

In this way, if we want Function traces to be sent to other destination
rather than ring buffer only, we just need to register a new
trace_export and implement its own .commit() callback or just use
'trace_generic_commit()' which this patch also added and hooks up its
own .write() function for writing traces to the storage.

With this patch, only Function trace (trace type is TRACE_FN)
is supported.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 include/linux/trace.h |  35 ++++++++++++
 kernel/trace/trace.c  | 155 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h  |   1 +
 3 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/trace.h

diff --git a/include/linux/trace.h b/include/linux/trace.h
new file mode 100644
index 0000000..30ded92
--- /dev/null
+++ b/include/linux/trace.h
@@ -0,0 +1,35 @@
+#ifndef _LINUX_TRACE_H
+#define _LINUX_TRACE_H
+
+#include <linux/ring_buffer.h>
+struct trace_array;
+
+#ifdef CONFIG_TRACING
+/*
+ * The trace export - an export of Ftrace. The trace_export can process
+ * traces and export them to a registered destination as an addition to
+ * the current only output of Ftrace - i.e. ring buffer.
+ *
+ * If you want traces to be sent to some other place rather than
+ * ring buffer only, just need to register a new trace_export and
+ * implement its own .commit() callback or just directly use
+ * 'trace_generic_commit()' and hooks up its own .write() function
+ * for writing traces to the storage.
+ *
+ * next		- pointer to the next trace_export
+ * commit	- commit the traces to the destination
+ * write	- copy traces which have been delt with ->commit() to
+ *		  the destination
+ */
+struct trace_export {
+	struct trace_export __rcu	*next;
+	void (*commit)(struct trace_array *, struct ring_buffer_event *);
+	void (*write)(const char *, unsigned int);
+};
+
+int register_ftrace_export(struct trace_export *export);
+int unregister_ftrace_export(struct trace_export *export);
+
+#endif	/* CONFIG_TRACING */
+
+#endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dade4c9..3163fa6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -40,6 +40,7 @@
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
+#include <linux/trace.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -2128,6 +2129,155 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 	ftrace_trace_userstack(buffer, flags, pc);
 }
 
+static DEFINE_STATIC_KEY_FALSE(ftrace_exports_enabled);
+
+static void ftrace_exports_enable(void)
+{
+	static_branch_enable(&ftrace_exports_enabled);
+}
+
+static void ftrace_exports_disable(void)
+{
+	static_branch_disable(&ftrace_exports_enabled);
+}
+
+static size_t trace_size[] = {
+	[TRACE_FN]		= sizeof(struct ftrace_entry),
+	[TRACE_CTX]		= sizeof(struct ctx_switch_entry),
+	[TRACE_WAKE]		= sizeof(struct ctx_switch_entry),
+	[TRACE_STACK]		= sizeof(struct stack_entry),
+	[TRACE_PRINT]		= sizeof(struct print_entry),
+	[TRACE_BPRINT]		= sizeof(struct bprint_entry),
+	[TRACE_MMIO_RW]		= sizeof(struct trace_mmiotrace_rw),
+	[TRACE_MMIO_MAP]	= sizeof(struct trace_mmiotrace_map),
+	[TRACE_BRANCH]		= sizeof(struct trace_branch),
+	[TRACE_GRAPH_RET]	= sizeof(struct ftrace_graph_ret_entry),
+	[TRACE_GRAPH_ENT]	= sizeof(struct ftrace_graph_ent_entry),
+	[TRACE_USER_STACK]	= sizeof(struct userstack_entry),
+	[TRACE_BPUTS]		= sizeof(struct bputs_entry),
+};
+
+static void
+trace_generic_commit(struct trace_array *tr,
+	       struct ring_buffer_event *event)
+{
+	struct trace_entry *entry;
+	struct trace_export *export = tr->export;
+	unsigned int size = 0;
+
+	entry = ring_buffer_event_data(event);
+
+	size = trace_size[entry->type];
+	if (!size)
+		return;
+
+	if (export && export->write)
+		export->write((char *)entry, size);
+}
+
+static DEFINE_MUTEX(ftrace_export_lock);
+
+static struct trace_export __rcu *ftrace_exports_list __read_mostly;
+
+static inline void
+ftrace_exports(struct trace_array *tr, struct ring_buffer_event *event)
+{
+	struct trace_export *export;
+
+	preempt_disable_notrace();
+
+	for (export = rcu_dereference_raw_notrace(ftrace_exports_list);
+	     export && export->commit;
+	     export = rcu_dereference_raw_notrace(export->next)) {
+		tr->export = export;
+		export->commit(tr, event);
+	}
+
+	preempt_enable_notrace();
+}
+
+static inline void
+add_trace_export(struct trace_export **list, struct trace_export *export)
+{
+	rcu_assign_pointer(export->next, *list);
+	/*
+	 * We are entering export into the list but another
+	 * CPU might be walking that list. We need to make sure
+	 * the export->next pointer is valid before another CPU sees
+	 * the export pointer included into the list.
+	 */
+	rcu_assign_pointer(*list, export);
+}
+
+static inline int
+rm_trace_export(struct trace_export **list, struct trace_export *export)
+{
+	struct trace_export **p;
+
+	for (p = list; *p != NULL; p = &(*p)->next)
+		if (*p == export)
+			break;
+
+	if (*p != export)
+		return -1;
+
+	rcu_assign_pointer(*p, (*p)->next);
+
+	return 0;
+}
+
+static inline void
+add_ftrace_export(struct trace_export **list, struct trace_export *export)
+{
+	if (*list == NULL)
+		ftrace_exports_enable();
+
+	add_trace_export(list, export);
+}
+
+static inline int
+rm_ftrace_export(struct trace_export **list, struct trace_export *export)
+{
+	int ret;
+
+	ret = rm_trace_export(list, export);
+	if (*list == NULL)
+		ftrace_exports_disable();
+
+	return ret;
+}
+
+int register_ftrace_export(struct trace_export *export)
+{
+	if (WARN_ON_ONCE(!export->write))
+		return -1;
+
+	mutex_lock(&ftrace_export_lock);
+
+	export->commit = trace_generic_commit;
+
+	add_ftrace_export(&ftrace_exports_list, export);
+
+	mutex_unlock(&ftrace_export_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_export);
+
+int unregister_ftrace_export(struct trace_export *export)
+{
+	int ret;
+
+	mutex_lock(&ftrace_export_lock);
+
+	ret = rm_ftrace_export(&ftrace_exports_list, export);
+
+	mutex_unlock(&ftrace_export_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_export);
+
 void
 trace_function(struct trace_array *tr,
 	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
@@ -2146,8 +2296,11 @@ trace_function(struct trace_array *tr,
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
+	if (!call_filter_check_discard(call, entry, buffer, event)) {
+		if (static_branch_unlikely(&ftrace_exports_enabled))
+			ftrace_exports(tr, event);
 		__buffer_unlock_commit(buffer, event);
+	}
 }
 
 #ifdef CONFIG_STACKTRACE
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f783df4..26a3088 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -260,6 +260,7 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
+	struct trace_export	*export;
 };
 
 enum {
-- 
2.7.4
