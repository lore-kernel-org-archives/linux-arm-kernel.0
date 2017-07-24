From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jul 2017 12:26:23 +0100
Subject: [PATCH 4/4] arm64: unwind: remove sp from struct stackframe
In-Reply-To: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
References: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
Message-ID: <20170724112623.26109-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unwind code sets the sp member of struct stackframe to
'frame pointer + 0x10' unconditionally, without regard for whether
doing so produces a legal value. So let's simply remove it now that
we have stopped using it anyway.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/stacktrace.h | 1 -
 arch/arm64/kernel/perf_callchain.c  | 1 -
 arch/arm64/kernel/process.c         | 5 +----
 arch/arm64/kernel/return_address.c  | 1 -
 arch/arm64/kernel/stacktrace.c      | 1 -
 arch/arm64/kernel/time.c            | 1 -
 arch/arm64/kernel/traps.c           | 2 --
 7 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 5b6eafccc5d8..3bebab378c72 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -20,7 +20,6 @@ struct task_struct;
 
 struct stackframe {
 	unsigned long fp;
-	unsigned long sp;
 	unsigned long pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned int graph;
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 713ca824f266..bcafd7dcfe8b 100644
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
index 659ae8094ed5..85b953dd023a 100644
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
index 12a87f2600f2..933adbc0f654 100644
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
index b079af1ad145..cd5771d4e2d2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -58,7 +58,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	    !on_task_stack(tsk, fp))
 		return -EINVAL;
 
-	frame->sp = fp + 0x10;
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index da33c90248e9..a4391280fba9 100644
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
index f2b284669587..9ba060b62837 100644
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
2.9.3
