From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 22 Nov 2013 19:26:06 +0000
Subject: [PATCH] ARM: unwind: Fix fp/r7 mishandling for Thumb-2
Message-ID: <1385148366-31492-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Thumb-2 ABI does not have a framepointer, but GCC sort-of-
always uses the old ATPCS Thumb framepointer register (r7) when
making non-trivial changes to a frame's sp.  EABI allows the sp to
be saved any old where, but GCC doesn't take advantage of this so
we get away with it.

The existing kernel backtrace implementation pretends that r7 is
really fp for the purpose of maintining struct stackframe.

However, this mapping is _not_ reflected in the way the unwinder
virtual registers are maintained.  This means that an unwinder
opcode that fetches r7 obtains uninitialised grabage instead of the
actual saved value of r7 (a.k.a.  stackframe->fp).

This results in failed backtraces when GCC saves a frame's sp in
r7, which now appears to happen often, at least for threads
sleeping in __switch_to.

This patch initialises the unwinder virtual registers consistently
so that the thread's saved r7 really does propagate into the
virtual r7, and so that the pseudo-framepointer is passed correctly
from one frame to the next.

A minor refactoring in thread_info.h is included to make it easier
to fetch an arbitrary saved register for a task.

These changes should mean that the Magic SysRq 't' command now
prints proper backtraces for sleeping threads with
CONFIG_THUMB2_KERNEL=y (among other things).

Someday this may need to be fixed more comprehensively, but for now
the r7-is-the-framepointer-even-though-there-is-no-framepointer
assumption seems to be fairly deeply hardwired into GCC for Thumb
code.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/thread_info.h |   12 ++++++------
 arch/arm/kernel/unwind.c           |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index df5e13d..24e0019 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -110,12 +110,12 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
 }
 
-#define thread_saved_pc(tsk)	\
-	((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
-#define thread_saved_sp(tsk)	\
-	((unsigned long)(task_thread_info(tsk)->cpu_context.sp))
-#define thread_saved_fp(tsk)	\
-	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
+#define thread_saved_reg(tsk, reg) \
+	((unsigned long)(task_thread_info(tsk)->cpu_context.reg))
+
+#define thread_saved_pc(tsk) thread_saved_reg(tsk, pc)
+#define thread_saved_sp(tsk) thread_saved_reg(tsk, sp)
+#define thread_saved_fp(tsk) thread_saved_reg(tsk, fp)
 
 extern void crunch_task_disable(struct thread_info *);
 extern void crunch_task_copy(struct thread_info *, void *);
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..cc619ff 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -74,8 +74,10 @@ struct unwind_ctrl_block {
 
 enum regs {
 #ifdef CONFIG_THUMB2_KERNEL
+#define FP_REG r7
 	FP = 7,
 #else
+#define FP_REG r11
 	FP = 11,
 #endif
 	SP = 13,
@@ -429,7 +431,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.pc = (unsigned long)unwind_backtrace;
 	} else {
 		/* task blocked in __switch_to */
-		frame.fp = thread_saved_fp(tsk);
+		frame.fp = thread_saved_reg(tsk, FP_REG);
 		frame.sp = thread_saved_sp(tsk);
 		/*
 		 * The function calling __switch_to cannot be a leaf function
-- 
1.7.9.5
