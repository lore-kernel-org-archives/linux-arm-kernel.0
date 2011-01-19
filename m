From: rabin@rab.in (Rabin Vincent)
Date: Wed, 19 Jan 2011 22:01:15 +0530
Subject: [PATCH] ARM: disable preempt when unwinding another task's stack
Message-ID: <mailman.124.1295456618.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we don't want to expose the unwinder to a volatile stack, we
should make sure that we don't get preempted while doing the unwinding.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/process.c    |   15 +++++++++++----
 arch/arm/kernel/stacktrace.c |    5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 94bbedb..56f10e6 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -459,10 +459,13 @@ EXPORT_SYMBOL(kernel_thread);
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
+	unsigned long wchan = 0;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	preempt_disable();
+
 	frame.fp = thread_saved_fp(p);
 	frame.sp = thread_saved_sp(p);
 	frame.lr = 0;			/* recovered from the stack */
@@ -470,11 +473,15 @@ unsigned long get_wchan(struct task_struct *p)
 	do {
 		int ret = unwind_frame(&frame);
 		if (ret < 0)
-			return 0;
-		if (!in_sched_functions(frame.pc))
-			return frame.pc;
+			break;
+		if (!in_sched_functions(frame.pc)) {
+			wchan = frame.pc;
+			break;
+		}
 	} while (count ++ < 16);
-	return 0;
+
+	preempt_enable();
+	return wchan;
 }
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 381d23a..c6c9d2d 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -102,6 +102,8 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 			trace->entries[trace->nr_entries++] = ULONG_MAX;
 		return;
 #else
+		preempt_disable();
+
 		data.no_sched_functions = 1;
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
@@ -121,6 +123,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	walk_stackframe(&frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
+
+	if (tsk != current)
+		preempt_enable();
 }
 
 void save_stack_trace(struct stack_trace *trace)
-- 
1.7.2.3
