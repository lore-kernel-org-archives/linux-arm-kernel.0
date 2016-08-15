From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 15 Aug 2016 19:50:01 +0800
Subject: [PATCH V4 1/3] tracing: add a possibility of exporting function trace
 to other places instead of ring buffer only
In-Reply-To: <1471261803-1186-1-git-send-email-zhang.chunyan@linaro.org>
References: <1471261803-1186-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ring buffer is the only one output of Function traces, this patch
added trace_export concept which would process the traces and export
traces to a registered destination which can be ring buffer or some other
storage, in this way if we want Function traces to be sent to other
destination rather than ring buffer only, we just need to register a new
trace_export and implement its own .commit() callback or just use
'trace_generic_commit()' which this patch also added and hooks up its
own .write() functio for writing traces to the storage.

Currently, only Function trace (TRACE_FN) is supported.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 include/linux/trace.h |  33 ++++++++++++++
 kernel/trace/trace.c  | 124 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h  |  31 +++++++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/trace.h

diff --git a/include/linux/trace.h b/include/linux/trace.h
new file mode 100644
index 0000000..4d4f0e1
--- /dev/null
+++ b/include/linux/trace.h
@@ -0,0 +1,33 @@
+#ifndef _LINUX_TRACE_H
+#define _LINUX_TRACE_H
+
+#include <linux/ring_buffer.h>
+struct trace_array;
+
+#ifdef CONFIG_TRACING
+/*
+ * The trace export - an export of function traces.  Every ftrace_ops
+ * has at least one export which would output function traces to ring
+ * buffer.
+ *
+ * name		- the name of this export
+ * next		- pointer to the next trace_export
+ * tr		- the trace_array this export belongs to
+ * commit	- commit the traces to ring buffer and/or some other places
+ * write	- copy traces which have been delt with ->commit() to
+ *		  the destination
+ */
+struct trace_export {
+	char name[16];
+	struct trace_export	*next;
+	struct trace_array	*tr;
+	void (*commit)(struct trace_array *, struct ring_buffer_event *);
+	void (*write)(const char *, unsigned int);
+};
+
+int register_trace_export(struct trace_export *export);
+int unregister_trace_export(struct trace_export *export);
+
+#endif	/* CONFIG_TRACING */
+
+#endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dade4c9..0247ac2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -40,6 +40,7 @@
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
+#include <linux/trace.h>
 #include <linux/sched/rt.h>
 
 #include "trace.h"
@@ -2128,6 +2129,127 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 	ftrace_trace_userstack(buffer, flags, pc);
 }
 
+static inline void
+trace_generic_commit(struct trace_array *tr,
+	       struct ring_buffer_event *event)
+{
+	struct trace_entry *entry;
+	struct trace_export *export = tr->export;
+	unsigned int size = 0;
+
+	entry = ring_buffer_event_data(event);
+
+	trace_entry_size(size, entry->type);
+	if (!size)
+		return;
+
+	if (export->write)
+		export->write((char *)entry, size);
+}
+
+static inline void
+trace_rb_commit(struct trace_array *tr,
+	       struct ring_buffer_event *event)
+{
+	__buffer_unlock_commit(tr->trace_buffer.buffer, event);
+}
+
+static DEFINE_MUTEX(trace_export_lock);
+
+static struct trace_export trace_export_rb __read_mostly = {
+	.name		= "rb",
+	.commit	= trace_rb_commit,
+	.next		= NULL,
+};
+static struct trace_export *trace_exports_list __read_mostly = &trace_export_rb;
+
+inline void
+trace_exports(struct trace_array *tr, struct ring_buffer_event *event)
+{
+	struct trace_export *export;
+
+	preempt_disable_notrace();
+
+	for (export = rcu_dereference_raw_notrace(trace_exports_list);
+	     export && export->commit;
+	     export = rcu_dereference_raw_notrace(export->next)) {
+		tr->export = export;
+		export->commit(tr, event);
+	}
+
+	preempt_enable_notrace();
+}
+
+static void
+add_trace_export(struct trace_export **list, struct trace_export *export)
+{
+	export->next = *list;
+	/*
+	 * We are entering export into the list but another
+	 * CPU might be walking that list. We need to make sure
+	 * the export->next pointer is valid before another CPU sees
+	 * the export pointer included into the list.
+	 */
+	rcu_assign_pointer(*list, export);
+
+}
+
+static int
+rm_trace_export(struct trace_export **list, struct trace_export *export)
+{
+	struct trace_export **p;
+
+	for (p = list; *p != &trace_export_rb; p = &(*p)->next)
+		if (*p == export)
+			break;
+
+	if (*p != export)
+		return -1;
+
+	*p = (*p)->next;
+
+	return 0;
+}
+
+int register_trace_export(struct trace_export *export)
+{
+	if (!export->write) {
+		pr_warn("trace_export must have the write() call back.\n");
+		return -1;
+	}
+
+	if (!export->name) {
+		pr_warn("trace_export must have a name.\n");
+		return -1;
+	}
+
+	mutex_lock(&trace_export_lock);
+
+	export->tr = trace_exports_list->tr;
+	export->commit = trace_generic_commit;
+
+	add_trace_export(&trace_exports_list, export);
+
+	mutex_unlock(&trace_export_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_trace_export);
+
+int unregister_trace_export(struct trace_export *export)
+{
+	int ret;
+
+	mutex_lock(&trace_export_lock);
+
+	ret = rm_trace_export(&trace_exports_list, export);
+
+	mutex_unlock(&trace_export_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_trace_export);
+
 void
 trace_function(struct trace_array *tr,
 	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
@@ -2147,7 +2269,7 @@ trace_function(struct trace_array *tr,
 	entry->parent_ip		= parent_ip;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		__buffer_unlock_commit(buffer, event);
+		trace_exports(tr, event);
 }
 
 #ifdef CONFIG_STACKTRACE
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f783df4..a40f07c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -260,6 +260,7 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
+	struct trace_export	*export;
 };
 
 enum {
@@ -301,6 +302,13 @@ static inline struct trace_array *top_trace_array(void)
 		break;					\
 	}
 
+#undef IF_SIZE
+#define IF_SIZE(size, var, etype, id)		\
+		if (var == id) {		\
+			size = (sizeof(etype));	\
+			break;			\
+		}
+
 /* Will cause compile errors if type is not found. */
 extern void __ftrace_bad_type(void);
 
@@ -339,6 +347,29 @@ extern void __ftrace_bad_type(void);
 	} while (0)
 
 /*
+ * The trace_entry_size return the size of specific trace type
+ *
+ * IF_SIZE(size, var);
+ *
+ * Where "var" is just the given trace type.
+ */
+#define trace_entry_size(size, var)					\
+	do {								\
+		IF_SIZE(size, var, struct ftrace_entry, TRACE_FN);	\
+		IF_SIZE(size, var, struct stack_entry, TRACE_STACK);	\
+		IF_SIZE(size, var, struct userstack_entry,		\
+			TRACE_USER_STACK);				\
+		IF_SIZE(size, var, struct print_entry, TRACE_PRINT);	\
+		IF_SIZE(size, var, struct bprint_entry, TRACE_BPRINT);	\
+		IF_SIZE(size, var, struct bputs_entry, TRACE_BPUTS);	\
+		IF_SIZE(size, var, struct trace_branch, TRACE_BRANCH);	\
+		IF_SIZE(size, var, struct ftrace_graph_ent_entry,	\
+			TRACE_GRAPH_ENT);				\
+		IF_SIZE(size, var, struct ftrace_graph_ret_entry,	\
+			TRACE_GRAPH_RET);				\
+	} while (0)
+
+/*
  * An option specific to a tracer. This is a boolean value.
  * The bit is the bit index that sets its value on the
  * flags value in struct tracer_flags.
-- 
2.7.4
