From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Tue, 18 Nov 2014 19:50:29 +0400
Subject: [PATCH] ARM: enable stack trace dumping for all tasks
Message-ID: <20141118165029.9812.96216.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables CONFIG_STACKTRACE dumper for non-current tasks.
Both version of function unwind_frame() now check stack boundaries:
frame-pointer based after commit 3abb6671a9c04479c4bd026798a05f857393b7e2
("ARM: 7913/1: fix framepointer check in unwind_frame"),
unwind-table based after a51345770e519552e749ff457a2a9f83171a67b5
("ARM: 7987/1: ARM : unwinder : Prevent data abort due to stack overflow").

Now it's safe to dump stack trace for any task, not only for current.
If that task is running we could get garbage but kernel will not explode.
Actually, get_wchan() uses this code path for ages without any problems:
it calls unwind_frame() after racy check "task->state != TASK_RUNNING".

This feature already exposed into userspace via /proc/$PID/stack,
it's very useful for finding where task is stuck in the kernel.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Cc: Anurag Aggarwal <a.anurag@samsung.com>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/kernel/stacktrace.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index f065eb0..904070f 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -118,21 +118,10 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	data.no_sched_functions = nosched;
 
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
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
 		frame.lr = 0;		/* recovered from the stack */
 		frame.pc = thread_saved_pc(tsk);
-#endif
 	} else {
 		register unsigned long current_sp asm ("sp");
 
