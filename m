From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:29 +0100
Subject: [PATCH 05/10] arm64: prep stack walkers for THREAD_INFO_IN_TASK
In-Reply-To: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1476904234-9511-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_THREAD_INFO_IN_TASK is selected, task stacks may be freed
before a task is destroyed. To account for this, the stacks are
refcounted, and when manipulating the stack of another task, it is
necessary to get/put the stack to ensure it isn't freed and/or re-used
while we do so.

This patch reworks the arm64 stack walking code to account for this.
When CONFIG_THREAD_INFO_IN_TASK is not selected these perform no
refcounting, and this should only be a structural change that does not
affect behaviour.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/process.c    | 20 ++++++++++++++------
 arch/arm64/kernel/stacktrace.c |  5 +++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 27b2f13..2f39036 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -340,27 +340,35 @@ struct task_struct *__switch_to(struct task_struct *prev,
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
-	unsigned long stack_page;
+	unsigned long stack_page, ret = 0;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	stack_page = (unsigned long)try_get_task_stack(p);
+	if (!stack_page)
+		return 0;
+
 	frame.fp = thread_saved_fp(p);
 	frame.sp = thread_saved_sp(p);
 	frame.pc = thread_saved_pc(p);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = p->curr_ret_stack;
 #endif
-	stack_page = (unsigned long)task_stack_page(p);
 	do {
 		if (frame.sp < stack_page ||
 		    frame.sp >= stack_page + THREAD_SIZE ||
 		    unwind_frame(p, &frame))
-			return 0;
-		if (!in_sched_functions(frame.pc))
-			return frame.pc;
+			goto out;
+		if (!in_sched_functions(frame.pc)) {
+			ret = frame.pc;
+			goto out;
+		}
 	} while (count ++ < 16);
-	return 0;
+
+out:
+	put_task_stack(p);
+	return ret;
 }
 
 unsigned long arch_align_stack(unsigned long sp)
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 5b80068..c77e5b6 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -182,6 +182,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	struct stack_trace_data data;
 	struct stackframe frame;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	data.trace = trace;
 	data.skip = trace->skip;
 
@@ -203,6 +206,8 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	walk_stackframe(tsk, &frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
+
+	put_task_stack(tsk);
 }
 
 void save_stack_trace(struct stack_trace *trace)
-- 
1.9.1
