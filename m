From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 15 Dec 2015 17:33:40 +0900
Subject: [PATCH v7 2/6] arm64: pass a task parameter to unwind_frame()
In-Reply-To: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
References: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1450168424-10010-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph tracer modifies a return address (LR) in a stack frame
to hook a function's return. This will result in many useless entries
(return_to_handler) showing up in a call stack list.
We will fix this problem in a later patch ("arm64: ftrace: fix a stack
tracer's output under function graph tracer"). But since real return
addresses are saved in ret_stack[] array in struct task_struct,
unwind functions need to be notified of, in addition to a stack pointer
address, which task is being traced in order to find out real return
addresses.

This patch extends unwind functions' interfaces by adding an extra
argument of a pointer to task_struct.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/stacktrace.h |    6 ++++--
 arch/arm64/kernel/perf_callchain.c  |    2 +-
 arch/arm64/kernel/process.c         |    2 +-
 arch/arm64/kernel/return_address.c  |    2 +-
 arch/arm64/kernel/stacktrace.c      |    8 ++++----
 arch/arm64/kernel/time.c            |    2 +-
 arch/arm64/kernel/traps.c           |    2 +-
 7 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 7318f6d..6fb61c5 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -16,14 +16,16 @@
 #ifndef __ASM_STACKTRACE_H
 #define __ASM_STACKTRACE_H
 
+struct task_struct;
+
 struct stackframe {
 	unsigned long fp;
 	unsigned long sp;
 	unsigned long pc;
 };
 
-extern int unwind_frame(struct stackframe *frame);
-extern void walk_stackframe(struct stackframe *frame,
+extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
+extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 3aa7483..797220d 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -165,7 +165,7 @@ void perf_callchain_kernel(struct perf_callchain_entry *entry,
 	frame.sp = regs->sp;
 	frame.pc = regs->pc;
 
-	walk_stackframe(&frame, callchain_trace, entry);
+	walk_stackframe(current, &frame, callchain_trace, entry);
 }
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f75b540..98bf546 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -348,7 +348,7 @@ unsigned long get_wchan(struct task_struct *p)
 	do {
 		if (frame.sp < stack_page ||
 		    frame.sp >= stack_page + THREAD_SIZE ||
-		    unwind_frame(&frame))
+		    unwind_frame(p, &frame))
 			return 0;
 		if (!in_sched_functions(frame.pc))
 			return frame.pc;
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 6c4fd28..07b37ac 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -44,7 +44,7 @@ void *return_address(unsigned int level)
 	frame.sp = current_stack_pointer;
 	frame.pc = (unsigned long)return_address; /* dummy */
 
-	walk_stackframe(&frame, save_return_addr, &data);
+	walk_stackframe(current, &frame, save_return_addr, &data);
 
 	if (!data.level)
 		return data.addr;
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index a159851..9c7acf8 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -36,7 +36,7 @@
  *	ldp	x29, x30, [sp]
  *	add	sp, sp, #0x10
  */
-int notrace unwind_frame(struct stackframe *frame)
+int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 {
 	unsigned long high, low;
 	unsigned long fp = frame->fp;
@@ -78,7 +78,7 @@ int notrace unwind_frame(struct stackframe *frame)
 	return 0;
 }
 
-void notrace walk_stackframe(struct stackframe *frame,
+void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
 {
 	while (1) {
@@ -86,7 +86,7 @@ void notrace walk_stackframe(struct stackframe *frame,
 
 		if (fn(frame, data))
 			break;
-		ret = unwind_frame(frame);
+		ret = unwind_frame(tsk, frame);
 		if (ret < 0)
 			break;
 	}
@@ -138,7 +138,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		frame.pc = (unsigned long)save_stack_trace_tsk;
 	}
 
-	walk_stackframe(&frame, save_trace, &data);
+	walk_stackframe(tsk, &frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 13339b6..6e5c521 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -53,7 +53,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 	frame.sp = regs->sp;
 	frame.pc = regs->pc;
 	do {
-		int ret = unwind_frame(&frame);
+		int ret = unwind_frame(NULL, &frame);
 		if (ret < 0)
 			return 0;
 	} while (in_lock_functions(frame.pc));
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cdfa2f9..da45224 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -177,7 +177,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		int ret;
 
 		dump_backtrace_entry(where);
-		ret = unwind_frame(&frame);
+		ret = unwind_frame(tsk, &frame);
 		if (ret < 0)
 			break;
 		stack = frame.sp;
-- 
1.7.9.5
