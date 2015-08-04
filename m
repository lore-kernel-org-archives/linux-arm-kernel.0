From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  4 Aug 2015 16:44:06 +0900
Subject: [RFC v2 1/4] ftrace: allow arch-specific check_stack()
In-Reply-To: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1438674249-3447-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A stack frame pointer may be used in a different way depending on
cpu architecture. Thus it is not always appropriate to slurp the stack
contents, as currently done in check_stack(), in order to calcurate
a stack index (height) at a given function call. At least not on arm64.

This patch extract potentially arch-specific code from check_stack()
and puts it into a new arch_check_stack(), which is declared as weak.
So we will be able to add arch-specific and most efficient way of
stack traversing Later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/stacktrace.h |    4 ++
 kernel/trace/trace_stack.c |   88 ++++++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 0a34489..bfae605 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -10,6 +10,10 @@ struct pt_regs;
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
+#ifdef CONFIG_STACK_TRACER
+	unsigned *index;
+	unsigned long *sp;
+#endif
 	int skip;	/* input argument: How many entries to skip */
 };
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 3d9356b..021b8c3 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -27,9 +27,10 @@ static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
  * us to remove most or all of the stack size overhead
  * added by the stack tracer itself.
  */
-static struct stack_trace max_stack_trace = {
+	struct stack_trace max_stack_trace = {
 	.max_entries		= STACK_TRACE_ENTRIES - 1,
 	.entries		= &stack_dump_trace[0],
+	.index			= &stack_dump_index[0],
 };
 
 static unsigned long max_stack_size;
@@ -65,42 +66,15 @@ static inline void print_max_stack(void)
 	}
 }
 
-static inline void
-check_stack(unsigned long ip, unsigned long *stack)
+void __weak
+arch_check_stack(unsigned long ip, unsigned long *stack,
+			unsigned long *max_size, unsigned int *tracer_size)
 {
-	unsigned long this_size, flags; unsigned long *p, *top, *start;
-	static int tracer_frame;
-	int frame_size = ACCESS_ONCE(tracer_frame);
+	unsigned long *p, *top, *start;
+	unsigned long this_size;
 	int i, x;
 
-	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
-	this_size = THREAD_SIZE - this_size;
-	/* Remove the frame of the tracer */
-	this_size -= frame_size;
-
-	if (this_size <= max_stack_size)
-		return;
-
-	/* we do not handle interrupt stacks yet */
-	if (!object_is_on_stack(stack))
-		return;
-
-	local_irq_save(flags);
-	arch_spin_lock(&max_stack_lock);
-
-	/* In case another CPU set the tracer_frame on us */
-	if (unlikely(!frame_size))
-		this_size -= tracer_frame;
-
-	/* a race could have already updated it */
-	if (this_size <= max_stack_size)
-		goto out;
-
-	max_stack_size = this_size;
-
-	max_stack_trace.nr_entries = 0;
 	max_stack_trace.skip = 3;
-
 	save_stack_trace(&max_stack_trace);
 
 	/* Skip over the overhead of the stack tracer itself */
@@ -116,6 +90,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	start = stack;
 	top = (unsigned long *)
 		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
+	this_size = *max_size;
 
 	/*
 	 * Loop through all the entries. One of the entries may
@@ -146,10 +121,10 @@ check_stack(unsigned long ip, unsigned long *stack)
 				 * out what that is, then figure it out
 				 * now.
 				 */
-				if (unlikely(!tracer_frame)) {
-					tracer_frame = (p - stack) *
+				if (unlikely(!*tracer_size)) {
+					*tracer_size = (p - stack) *
 						sizeof(unsigned long);
-					max_stack_size -= tracer_frame;
+					*max_size -= *tracer_size;
 				}
 			}
 		}
@@ -161,6 +136,47 @@ check_stack(unsigned long ip, unsigned long *stack)
 	max_stack_trace.nr_entries = x;
 	for (; x < i; x++)
 		stack_dump_trace[x] = ULONG_MAX;
+}
+
+static inline void
+check_stack(unsigned long ip, unsigned long *stack)
+{
+	unsigned long this_size, flags;
+	static int tracer_frame;
+	int frame_size = ACCESS_ONCE(tracer_frame);
+
+	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
+	this_size = THREAD_SIZE - this_size;
+	/* for safety, depending on arch_check_stack() */
+	if (this_size < frame_size)
+		return;
+
+	/* Remove the frame of the tracer */
+	this_size -= frame_size;
+
+	if (this_size <= max_stack_size)
+		return;
+
+	/* we do not handle interrupt stacks yet */
+	if (!object_is_on_stack(stack))
+		return;
+
+	local_irq_save(flags);
+	arch_spin_lock(&max_stack_lock);
+
+	/* In case another CPU set the tracer_frame on us */
+	if (unlikely(!frame_size))
+		this_size -= tracer_frame;
+
+	/* a race could have already updated it */
+	if (this_size <= max_stack_size)
+		goto out;
+
+	max_stack_size = this_size;
+
+	max_stack_trace.nr_entries = 0;
+
+	arch_check_stack(ip, stack, &max_stack_size, &tracer_frame);
 
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
-- 
1.7.9.5
