From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 19 Sep 2017 20:57:54 +0800
Subject: [PATCH 1/1] ARM: add stacktrace support for non current tasks on SMP
Message-ID: <1505825874-9528-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. An invalid frame.xx can not lead kernel to crash, this should be
guaranteed by function unwind_frame itself. Otherwise, walk the stack
trace of current is also at risk.
2. There is no way to prevent the walked task becoming rq->curr during
walk_stackframe. This means some entries traced maybe inconsistent. But
it's better than none. Besides, we can dump it again.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/kernel/stacktrace.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 92b7237..80a0e9d 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -120,13 +120,20 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	if (tsk != current) {
 #ifdef CONFIG_SMP
 		/*
-		 * What guarantees do we have here that 'tsk' is not
-		 * running on another CPU?  For now, ignore it as we
-		 * can't guarantee we won't explode.
+		 * There is no way to prevent tsk becoming rq->curr during
+		 * walk_stackframe. frame.xx should be sanity checked in
+		 * function unwind_frame.
 		 */
-		if (trace->nr_entries < trace->max_entries)
-			trace->entries[trace->nr_entries++] = ULONG_MAX;
-		return;
+		if (!task_curr(tsk)) {
+			frame.fp = thread_saved_fp(tsk);
+			frame.sp = thread_saved_sp(tsk);
+			frame.lr = 0;		/* recovered from the stack */
+			frame.pc = thread_saved_pc(tsk);
+		} else {
+			if (trace->nr_entries < trace->max_entries)
+				trace->entries[trace->nr_entries++] = ULONG_MAX;
+			return;
+		}
 #else
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
-- 
2.5.0
