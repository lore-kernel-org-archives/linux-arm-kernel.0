From: ccross@android.com (Colin Cross)
Date: Tue, 29 Jan 2013 17:55:47 -0800
Subject: [PATCH v3 3/3] ARM: stacktrace: enable save_stack_trace_tsk for
 CONFIG_SMP
In-Reply-To: <1359510947-3950-1-git-send-email-ccross@android.com>
References: <1359510947-3950-1-git-send-email-ccross@android.com>
Message-ID: <1359510947-3950-4-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that unwind_frame has been hardened against invalid stacks
for CONFIG_ARM_UNWIND or CONFIG_FRAME_POINTER, enable dumping
the stack on non-current threads for CONFIG_SMP.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/kernel/stacktrace.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index d897f4c..c6e6477 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -187,22 +187,11 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	data.skip = trace->skip;
 
 	if (tsk != current) {
-#ifdef CONFIG_SMP
-		/*
-		 * What guarantees do we have here that 'tsk' is not
-		 * running on another CPU?  For now, ignore it as we
-		 * can't guarantee we won't explode.
-		 */
-		if (trace->nr_entries < trace->max_entries)
-			trace->entries[trace->nr_entries++] = ULONG_MAX;
-		return;
-#else
 		data.no_sched_functions = 1;
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
 		frame.lr = 0;		/* recovered from the stack */
 		frame.pc = thread_saved_pc(tsk);
-#endif
 	} else {
 		register unsigned long current_sp asm ("sp");
 
-- 
1.8.1
