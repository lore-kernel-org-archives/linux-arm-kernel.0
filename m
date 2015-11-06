From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  6 Nov 2015 15:44:42 +0900
Subject: [PATCH v5 3/6] ftrace: allow arch-specific stack tracer
In-Reply-To: <1446792285-1154-1-git-send-email-takahiro.akashi@linaro.org>
References: <1446792285-1154-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1446792285-1154-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A stack frame may be used in a different way depending on cpu architecture.
Thus it is not always appropriate to slurp the stack contents, as current
check_stack() does, in order to calcurate a stack index (height) at a given
function call. At least not on arm64.
In addition, there is a possibility that we will mistakenly detect a stale
stack frame which has not been overwritten.

This patch makes check_stack() a weak function so as to later implement
arch-specific version.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/ftrace.h     |   10 ++++++
 kernel/trace/trace_stack.c |   80 ++++++++++++++++++++++++--------------------
 2 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6cd8c0e..fdc2ca5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -263,7 +263,17 @@ static inline void ftrace_kill(void) { }
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_STACK_TRACER
+#define STACK_TRACE_ENTRIES 500
+
+struct stack_trace;
+
+extern unsigned stack_trace_index[];
+extern struct stack_trace stack_trace_max;
+extern unsigned long stack_trace_max_size;
+extern arch_spinlock_t max_stack_lock;
+
 extern int stack_tracer_enabled;
+void stack_trace_print(void);
 int
 stack_trace_sysctl(struct ctl_table *table, int write,
 		   void __user *buffer, size_t *lenp,
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 8abf1ba..e34392e 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -16,24 +16,22 @@
 
 #include "trace.h"
 
-#define STACK_TRACE_ENTRIES 500
-
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
-static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
+unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
 /*
  * Reserve one entry for the passed in ip. This will allow
  * us to remove most or all of the stack size overhead
  * added by the stack tracer itself.
  */
-static struct stack_trace max_stack_trace = {
+struct stack_trace stack_trace_max = {
 	.max_entries		= STACK_TRACE_ENTRIES - 1,
 	.entries		= &stack_dump_trace[0],
 };
 
-static unsigned long max_stack_size;
-static arch_spinlock_t max_stack_lock =
+unsigned long stack_trace_max_size;
+arch_spinlock_t max_stack_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 static DEFINE_PER_CPU(int, trace_active);
@@ -42,30 +40,38 @@ static DEFINE_MUTEX(stack_sysctl_mutex);
 int stack_tracer_enabled;
 static int last_stack_tracer_enabled;
 
-static inline void print_max_stack(void)
+void stack_trace_print(void)
 {
 	long i;
 	int size;
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries);
+			   stack_trace_max.nr_entries);
 
-	for (i = 0; i < max_stack_trace.nr_entries; i++) {
+	for (i = 0; i < stack_trace_max.nr_entries; i++) {
 		if (stack_dump_trace[i] == ULONG_MAX)
 			break;
-		if (i+1 == max_stack_trace.nr_entries ||
+		if (i+1 == stack_trace_max.nr_entries ||
 				stack_dump_trace[i+1] == ULONG_MAX)
-			size = stack_dump_index[i];
+			size = stack_trace_index[i];
 		else
-			size = stack_dump_index[i] - stack_dump_index[i+1];
+			size = stack_trace_index[i] - stack_trace_index[i+1];
 
-		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_dump_index[i],
+		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_trace_index[i],
 				size, (void *)stack_dump_trace[i]);
 	}
 }
 
-static inline void
+/*
+ * When arch-specific code overides this function, the following
+ * data should be filled up, assuming max_stack_lock is held to
+ * prevent concurrent updates.
+ *     stack_trace_index[]
+ *     stack_trace_max
+ *     stack_trace_max_size
+ */
+void __weak
 check_stack(unsigned long ip, unsigned long *stack)
 {
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
@@ -78,7 +84,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	/* Remove the frame of the tracer */
 	this_size -= frame_size;
 
-	if (this_size <= max_stack_size)
+	if (this_size <= stack_trace_max_size)
 		return;
 
 	/* we do not handle interrupt stacks yet */
@@ -103,18 +109,18 @@ check_stack(unsigned long ip, unsigned long *stack)
 		this_size -= tracer_frame;
 
 	/* a race could have already updated it */
-	if (this_size <= max_stack_size)
+	if (this_size <= stack_trace_max_size)
 		goto out;
 
-	max_stack_size = this_size;
+	stack_trace_max_size = this_size;
 
-	max_stack_trace.nr_entries = 0;
-	max_stack_trace.skip = 3;
+	stack_trace_max.nr_entries = 0;
+	stack_trace_max.skip = 3;
 
-	save_stack_trace(&max_stack_trace);
+	save_stack_trace(&stack_trace_max);
 
 	/* Skip over the overhead of the stack tracer itself */
-	for (i = 0; i < max_stack_trace.nr_entries; i++) {
+	for (i = 0; i < stack_trace_max.nr_entries; i++) {
 		if (stack_dump_trace[i] == ip)
 			break;
 	}
@@ -134,18 +140,18 @@ check_stack(unsigned long ip, unsigned long *stack)
 	 * loop will only happen once. This code only takes place
 	 * on a new max, so it is far from a fast path.
 	 */
-	while (i < max_stack_trace.nr_entries) {
+	while (i < stack_trace_max.nr_entries) {
 		int found = 0;
 
-		stack_dump_index[x] = this_size;
+		stack_trace_index[x] = this_size;
 		p = start;
 
-		for (; p < top && i < max_stack_trace.nr_entries; p++) {
+		for (; p < top && i < stack_trace_max.nr_entries; p++) {
 			if (stack_dump_trace[i] == ULONG_MAX)
 				break;
 			if (*p == stack_dump_trace[i]) {
 				stack_dump_trace[x] = stack_dump_trace[i++];
-				this_size = stack_dump_index[x++] =
+				this_size = stack_trace_index[x++] =
 					(top - p) * sizeof(unsigned long);
 				found = 1;
 				/* Start the search from here */
@@ -160,7 +166,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 				if (unlikely(!tracer_frame)) {
 					tracer_frame = (p - stack) *
 						sizeof(unsigned long);
-					max_stack_size -= tracer_frame;
+					stack_trace_max_size -= tracer_frame;
 				}
 			}
 		}
@@ -169,12 +175,12 @@ check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
-	max_stack_trace.nr_entries = x;
+	stack_trace_max.nr_entries = x;
 	for (; x < i; x++)
 		stack_dump_trace[x] = ULONG_MAX;
 
 	if (task_stack_end_corrupted(current)) {
-		print_max_stack();
+		stack_trace_print();
 		BUG();
 	}
 
@@ -273,7 +279,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n > max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
@@ -343,9 +349,9 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries);
+			   stack_trace_max.nr_entries);
 
-		if (!stack_tracer_enabled && !max_stack_size)
+		if (!stack_tracer_enabled && !stack_trace_max_size)
 			print_disabled(m);
 
 		return 0;
@@ -353,17 +359,17 @@ static int t_show(struct seq_file *m, void *v)
 
 	i = *(long *)v;
 
-	if (i >= max_stack_trace.nr_entries ||
+	if (i >= stack_trace_max.nr_entries ||
 	    stack_dump_trace[i] == ULONG_MAX)
 		return 0;
 
-	if (i+1 == max_stack_trace.nr_entries ||
+	if (i+1 == stack_trace_max.nr_entries ||
 	    stack_dump_trace[i+1] == ULONG_MAX)
-		size = stack_dump_index[i];
+		size = stack_trace_index[i];
 	else
-		size = stack_dump_index[i] - stack_dump_index[i+1];
+		size = stack_trace_index[i] - stack_trace_index[i+1];
 
-	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_dump_index[i], size);
+	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_trace_index[i], size);
 
 	trace_lookup_stack(m, i);
 
@@ -453,7 +459,7 @@ static __init int stack_trace_init(void)
 		return 0;
 
 	trace_create_file("stack_max_size", 0644, d_tracer,
-			&max_stack_size, &stack_max_size_fops);
+			&stack_trace_max_size, &stack_max_size_fops);
 
 	trace_create_file("stack_trace", 0444, d_tracer,
 			NULL, &stack_trace_fops);
-- 
1.7.9.5
