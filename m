From: ji.zhang@mediatek.com (Ji Zhang)
Date: Fri, 20 Apr 2018 13:38:33 +0800
Subject: [PATCH] arm64: avoid potential infinity loop in dump_backtrace
Message-ID: <1524202713-31024-1-git-send-email-ji.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we dump the backtrace of some tasks there is a potential infinity
loop if the content of the stack changed, no matter the change is
because the task is running or other unexpected cases.

This patch add stronger check on frame pointer and set the max number
of stack spanning to avoid infinity loop.

Signed-off-by: Ji Zhang <ji.zhang@mediatek.com>
---
 arch/arm64/include/asm/stacktrace.h | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c      |  8 ++++++++
 arch/arm64/kernel/traps.c           |  1 +
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 902f9ed..f235b86 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -24,9 +24,18 @@
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
+#ifndef CONFIG_VMAP_STACK
+#define MAX_NR_STACKS	2
+#elif !defined(CONFIG_ARM_SDE_INTERFACE)
+#define MAX_NR_STACKS	3
+#else
+#define MAX_NR_STACKS	4
+#endif
+
 struct stackframe {
 	unsigned long fp;
 	unsigned long pc;
+	int nr_stacks;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
@@ -92,4 +101,20 @@ static inline bool on_accessible_stack(struct task_struct *tsk, unsigned long sp
 	return false;
 }
 
+
+static inline bool on_same_stack(struct task_struct *tsk,
+				unsigned long sp1, unsigned long sp2)
+{
+	if (on_task_stack(tsk, sp1) && on_task_stack(tsk, sp2))
+		return true;
+	if (on_irq_stack(sp1) && on_irq_stack(sp2))
+		return true;
+	if (on_overflow_stack(sp1) && on_overflow_stack(sp2))
+		return true;
+	if (on_sdei_stack(sp1) && on_sdei_stack(sp2))
+		return true;
+
+	return false;
+}
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a0..d75f59d 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,6 +43,7 @@
 int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 {
 	unsigned long fp = frame->fp;
+	bool same_stack;
 
 	if (fp & 0xf)
 		return -EINVAL;
@@ -56,6 +57,13 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
+	same_stack = on_same_stack(tsk, fp, frame->fp);
+
+	if (fp <= frame->fp && same_stack)
+		return -EINVAL;
+	if (!same_stack && ++frame->nr_stacks > MAX_NR_STACKS)
+		return -EINVAL;
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ba964da..ee0403d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -121,6 +121,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.fp = thread_saved_fp(tsk);
 		frame.pc = thread_saved_pc(tsk);
 	}
+	frame.nr_stacks = 1;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = tsk->curr_ret_stack;
 #endif
-- 
1.9.1
