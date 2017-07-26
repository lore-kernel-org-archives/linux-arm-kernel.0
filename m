From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:30 +0100
Subject: [PATCHv2 7/7] arm64: unwind: remove sp from struct stackframe
In-Reply-To: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1501093110-3844-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The unwind code sets the sp member of struct stackframe to
'frame pointer + 0x10' unconditionally, without regard for whether
doing so produces a legal value. So let's simply remove it now that
we have stopped using it anyway.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/stacktrace.h | 1 -
 arch/arm64/kernel/perf_callchain.c  | 1 -
 arch/arm64/kernel/process.c         | 5 +----
 arch/arm64/kernel/return_address.c  | 1 -
 arch/arm64/kernel/stacktrace.c      | 4 ----
 arch/arm64/kernel/time.c            | 1 -
 arch/arm64/kernel/traps.c           | 2 --
 7 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 5b6eafc..3bebab3 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -20,7 +20,6 @@
 
 struct stackframe {
 	unsigned long fp;
-	unsigned long sp;
 	unsigned long pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned int graph;
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 713ca82..bcafd7d 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -162,7 +162,6 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 	}
 
 	frame.fp = regs->regs[29];
-	frame.sp = regs->sp;
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = current->curr_ret_stack;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 659ae80..85b953d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -382,15 +382,12 @@ unsigned long get_wchan(struct task_struct *p)
 		return 0;
 
 	frame.fp = thread_saved_fp(p);
-	frame.sp = thread_saved_sp(p);
 	frame.pc = thread_saved_pc(p);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = p->curr_ret_stack;
 #endif
 	do {
-		if (frame.sp < stack_page ||
-		    frame.sp >= stack_page + THREAD_SIZE ||
-		    unwind_frame(p, &frame))
+		if (unwind_frame(p, &frame))
 			goto out;
 		if (!in_sched_functions(frame.pc)) {
 			ret = frame.pc;
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 12a87f2..933adbc 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -42,7 +42,6 @@ void *return_address(unsigned int level)
 	data.addr = NULL;
 
 	frame.fp = (unsigned long)__builtin_frame_address(0);
-	frame.sp = current_stack_pointer;
 	frame.pc = (unsigned long)return_address; /* dummy */
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = current->curr_ret_stack;
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index b079af1..54f3463 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -58,7 +58,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	    !on_task_stack(tsk, fp))
 		return -EINVAL;
 
-	frame->sp = fp + 0x10;
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
@@ -127,7 +126,6 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	data.no_sched_functions = 0;
 
 	frame.fp = regs->regs[29];
-	frame.sp = regs->sp;
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = current->curr_ret_stack;
@@ -152,12 +150,10 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	if (tsk != current) {
 		data.no_sched_functions = 1;
 		frame.fp = thread_saved_fp(tsk);
-		frame.sp = thread_saved_sp(tsk);
 		frame.pc = thread_saved_pc(tsk);
 	} else {
 		data.no_sched_functions = 0;
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_stack_pointer;
 		frame.pc = (unsigned long)save_stack_trace_tsk;
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index da33c90..a439128 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -50,7 +50,6 @@ unsigned long profile_pc(struct pt_regs *regs)
 		return regs->pc;
 
 	frame.fp = regs->regs[29];
-	frame.sp = regs->sp;
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = -1; /* no task info */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index caf2f79..63cbfb0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -155,14 +155,12 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 
 	if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_stack_pointer;
 		frame.pc = (unsigned long)dump_backtrace;
 	} else {
 		/*
 		 * task blocked in __switch_to
 		 */
 		frame.fp = thread_saved_fp(tsk);
-		frame.sp = thread_saved_sp(tsk);
 		frame.pc = thread_saved_pc(tsk);
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-- 
1.9.1
