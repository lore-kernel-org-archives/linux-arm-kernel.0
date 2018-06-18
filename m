From: zsm@chromium.org (Zubin Mithra)
Date: Mon, 18 Jun 2018 08:30:53 -0700
Subject: [RFC v2 4/4] arm: add refcounting for task stacks
In-Reply-To: <20180618153053.186224-1-zsm@chromium.org>
References: <20180618153053.186224-1-zsm@chromium.org>
Message-ID: <20180618153053.186224-5-zsm@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_THREAD_INFO_IN_TASK is enabled, thread stacks may be freed
before a stack is destroyed. This patch adds in refcounting to ensure
freed stacks are not used. If CONFIG_THREAD_INFO_IN_TASK is not used, no
refcounting is performed.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/arm/kernel/process.c    | 21 +++++++++++++++------
 arch/arm/kernel/stacktrace.c |  7 +++++++
 arch/arm/kernel/traps.c      | 13 +++++++++++--
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 225d1c58d2de..588003e25a75 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -297,7 +297,7 @@ EXPORT_SYMBOL(dump_fpu);
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
-	unsigned long stack_page;
+	unsigned long stack_page, ret = 0;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
@@ -306,16 +306,25 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.sp = thread_saved_sp(p);
 	frame.lr = 0;			/* recovered from the stack */
 	frame.pc = thread_saved_pc(p);
-	stack_page = (unsigned long)task_stack_page(p);
+
+	stack_page = (unsigned long)try_get_task_stack(p);
+	if (!stack_page)
+		return 0;
+
 	do {
 		if (frame.sp < stack_page ||
 		    frame.sp >= stack_page + THREAD_SIZE ||
 		    unwind_frame(&frame) < 0)
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
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index d519b8e0797f..ff20d5941724 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -1,6 +1,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 
 #include <asm/sections.h>
@@ -105,6 +106,9 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	struct stack_trace_data data;
 	struct stackframe frame;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	data.trace = trace;
 	data.skip = trace->skip;
 	data.no_sched_functions = nosched;
@@ -118,6 +122,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		 */
 		if (trace->nr_entries < trace->max_entries)
 			trace->entries[trace->nr_entries++] = ULONG_MAX;
+		put_task_stack(tsk);
 		return;
 #else
 		frame.fp = thread_saved_fp(tsk);
@@ -137,6 +142,8 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	walk_stackframe(&frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
+
+	put_task_stack(tsk);
 }
 
 void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index badf02ca3693..ec128854016a 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -217,6 +217,9 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	if (!tsk)
 		tsk = current;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	if (regs) {
 		fp = frame_pointer(regs);
 		mode = processor_mode(regs);
@@ -240,6 +243,8 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 
 	if (ok)
 		c_backtrace(fp, mode);
+
+	put_task_stack(tsk);
 }
 #endif
 
@@ -285,8 +290,12 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+		unsigned long stack_page = try_get_task_stack(tsk);
+		if (stack_page) {
+			dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
+				 THREAD_SIZE + stack_page);
+			put_task_stack(tsk);
+		}
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
 	}
-- 
2.18.0.rc1.244.gcf134e6275-goog
