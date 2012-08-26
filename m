From: ccross@android.com (Colin Cross)
Date: Sun, 26 Aug 2012 15:46:55 -0700
Subject: [PATCH 1/2] ARM: stacktrace: enable dumping stacks for SMP &&
 FRAME_POINTER
In-Reply-To: <1346021216-21979-1-git-send-email-ccross@android.com>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
Message-ID: <1346021216-21979-2-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dumping stacktraces is currently disabled in ARM SMP for all tasks
except the current task due to the worry that the task may be running
on another CPU and that the unwinder may be unstable when presented
with a stack that is being modified.

Unwinding with CONFIG_FRAME_POINTER is fairly simple compared to
when CONFIG_ARM_UNWIND is set.  The next frame's FP and SP registers
are read from the stack and can be validated against the current
values to ensure that they do not leave the stack and make progress
towards the upper end of the stack.  This guarantees that accesses
do not fault and that execution is bounded.

Add additional validations to unwind_frame and enable dumping
stacktraces when CONFIG_SMP is set if CONFIG_FRAME_POINTER is set.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/kernel/stacktrace.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 00f79e5..45e6b7e 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -34,11 +34,24 @@ int notrace unwind_frame(struct stackframe *frame)
 	if (fp < (low + 12) || fp + 4 >= high)
 		return -EINVAL;
 
+	if (fp % 4 != 0)
+		return -EINVAL;
+
 	/* restore the registers from the stack frame */
 	frame->fp = *(unsigned long *)(fp - 12);
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
 
+	/*
+	 * ensure the next stack pointer is above this one to guarantee
+	 * bounded execution
+	 */
+	if (frame->sp < fp || frame->sp > high)
+		return -EINVAL;
+
+	if (frame->sp % 4 != 0)
+		return -EINVAL;
+
 	return 0;
 }
 #endif
@@ -92,7 +105,8 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	data.skip = trace->skip;
 
 	if (tsk != current) {
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || \
+	(defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND))
 		/*
 		 * What guarantees do we have here that 'tsk' is not
 		 * running on another CPU?  For now, ignore it as we
-- 
1.7.7.3
