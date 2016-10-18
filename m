From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Tue, 18 Oct 2016 16:08:58 +0800
Subject: [PATCH V7 1/3] tracing: add a possibility of exporting function trace
 to other places instead of ring buffer only
In-Reply-To: <1476778140-10319-1-git-send-email-zhang.chunyan@linaro.org>
References: <1476778140-10319-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1476778140-10319-2-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently Function traces can be only exported to ring buffer, this
patch added trace_export concept which can process traces and export
them to a registered destination as an addition to the current only
one output of Ftrace - i.e. ring buffer.

In this way, if we want Function traces to be sent to other destination
rather than ring buffer only, we just need to register a new trace_export
and implement its own .write() function for writing traces to storage.

With this patch, only Function trace (trace type is TRACE_FN)
is supported.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 include/linux/trace.h |  28 +++++++++++
 kernel/trace/trace.c  | 132 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/trace.h

diff --git a/include/linux/trace.h b/include/linux/trace.h
new file mode 100644
index 0000000..eb1c5b8
--- /dev/null
+++ b/include/linux/trace.h
@@ -0,0 +1,28 @@
+#ifndef _LINUX_TRACE_H
+#define _LINUX_TRACE_H
+
+#ifdef CONFIG_TRACING
+/*
+ * The trace export - an export of Ftrace output. The trace_export
+ * can process traces and export them to a registered destination as
+ * an addition to the current only output of Ftrace - i.e. ring buffer.
+ *
+ * If you want traces to be sent to some other place rather than ring
+ * buffer only, just need to register a new trace_export and implement
+ * its own .write() function for writing traces to the storage.
+ *
+ * next		- pointer to the next trace_export
+ * write	- copy traces which have been delt with ->commit() to
+ *		  the destination
+ */
+struct trace_export {
+	struct trace_export __rcu	*next;
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
index 8696ce6..db94ec1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -40,6 +40,7 @@
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
+#include <linux/trace.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -2128,6 +2129,132 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 	ftrace_trace_userstack(buffer, flags, pc);
 }
 
+static void
+trace_process_export(struct trace_export *export,
+	       struct ring_buffer_event *event)
+{
+	struct trace_entry *entry;
+	unsigned int size = 0;
+
+	entry = ring_buffer_event_data(event);
+
+	size = ring_buffer_event_length(event);
+
+	if (export->write)
+		export->write((char *)entry, size);
+}
+
+static DEFINE_MUTEX(ftrace_export_lock);
+
+static struct trace_export __rcu *ftrace_exports_list __read_mostly;
+
+static DEFINE_STATIC_KEY_FALSE(ftrace_exports_enabled);
+
+static inline void ftrace_exports_enable(void)
+{
+	static_branch_enable(&ftrace_exports_enabled);
+}
+
+static inline void ftrace_exports_disable(void)
+{
+	static_branch_disable(&ftrace_exports_enabled);
+}
+
+void ftrace_exports(struct ring_buffer_event *event)
+{
+	struct trace_export *export;
+
+	preempt_disable_notrace();
+
+	export = rcu_dereference_raw_notrace(ftrace_exports_list);
+	while (export) {
+		trace_process_export(export, event);
+		export = rcu_dereference_raw_notrace(export->next);
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
@@ -2146,8 +2273,11 @@ trace_function(struct trace_array *tr,
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
+	if (!call_filter_check_discard(call, entry, buffer, event)) {
+		if (static_branch_unlikely(&ftrace_exports_enabled))
+			ftrace_exports(event);
 		__buffer_unlock_commit(buffer, event);
+	}
 }
 
 #ifdef CONFIG_STACKTRACE
-- 
2.7.4
