From: ccross@android.com (Colin Cross)
Date: Tue, 29 Jan 2013 17:55:46 -0800
Subject: [PATCH v3 2/3] ARM: unwind: harden unwinding against invalid stacks
In-Reply-To: <1359510947-3950-1-git-send-email-ccross@android.com>
References: <1359510947-3950-1-git-send-email-ccross@android.com>
Message-ID: <1359510947-3950-3-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unwinding with CONFIG_ARM_UNWIND is much more complicated than
unwinding with CONFIG_FRAME_POINTER, but there are only a few points
that require validation in order to avoid faults or infinite loops.
Avoiding faults is easy by adding checks to verify that the stack
bounds are in lowmem, and that all accesses relative to the stack
pointer remain inside the stack.

When CONFIG_FRAME_POINTER is not set it is possible for a leaf frame
to have the same SP as its caller, but otherwise the SP of the caller
should always be higher than the SP of the callee.  Add a depth
parameter to unwind_frame to allow it to distinguish leaf frames
from non-leaf frames, and return an error if a caller has the same
sp as a non-leaf frame callee.

Signed-off-by: Colin Cross <ccross@android.com>
---
v2:
   add depth parameter to unwind_frame
   verify that sp changes for non-leaf frames
   verify that initial sp value is in mapped lowmem
   verify that stack offsets are in the range
      [sizeof(struct thread_info), THREAD_START_SP)

v3:
   no changes

arch/arm/include/asm/stacktrace.h |  2 +-
 arch/arm/kernel/process.c         |  2 +-
 arch/arm/kernel/stacktrace.c      |  6 +++--
 arch/arm/kernel/time.c            |  3 ++-
 arch/arm/kernel/unwind.c          | 46 +++++++++++++++++++++++++++++----------
 5 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 6909056..cc48971 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -8,7 +8,7 @@ struct stackframe {
 	unsigned long pc;
 };
 
-extern int unwind_frame(struct stackframe *frame);
+extern int unwind_frame(struct stackframe *frame, int depth);
 extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 41aad9e..10ea483 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -633,7 +633,7 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.lr = 0;			/* recovered from the stack */
 	frame.pc = thread_saved_pc(p);
 	do {
-		int ret = unwind_frame(&frame);
+		int ret = unwind_frame(&frame, count);
 		if (ret < 0)
 			return 0;
 		if (!in_sched_functions(frame.pc))
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index aba76d5..d897f4c 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -101,7 +101,7 @@ bool sp_in_stack(unsigned long orig_sp, unsigned long sp)
  * Note that with framepointer enabled, even the leaf functions have the same
  * prologue and epilogue, therefore we can ignore the LR value in this case.
  */
-int notrace unwind_frame(struct stackframe *frame)
+int notrace unwind_frame(struct stackframe *frame, int depth)
 {
 	unsigned long fp = frame->fp;
 	unsigned long sp = frame->sp;
@@ -139,12 +139,14 @@ int notrace unwind_frame(struct stackframe *frame)
 void notrace walk_stackframe(struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
 {
+	int depth = 0;
+
 	while (1) {
 		int ret;
 
 		if (fn(frame, data))
 			break;
-		ret = unwind_frame(frame);
+		ret = unwind_frame(frame, depth++);
 		if (ret < 0)
 			break;
 	}
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index fe31b22..5f0bf17 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -51,6 +51,7 @@
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	struct stackframe frame;
+	int depth = 0;
 
 	if (!in_lock_functions(regs->ARM_pc))
 		return regs->ARM_pc;
@@ -60,7 +61,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 	frame.lr = regs->ARM_lr;
 	frame.pc = regs->ARM_pc;
 	do {
-		int ret = unwind_frame(&frame);
+		int ret = unwind_frame(&frame, depth++);
 		if (ret < 0)
 			return 0;
 	} while (in_lock_functions(frame.pc));
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..529c36f 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -40,6 +40,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -235,12 +236,18 @@ static unsigned long unwind_get_byte(struct unwind_ctrl_block *ctrl)
 	return ret;
 }
 
+static bool ptr_in_stack(unsigned long orig_sp, void *vsp)
+{
+	return addr_in_stack(orig_sp, (unsigned long)vsp);
+}
+
 /*
  * Execute the current unwind instruction.
  */
 static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 {
 	unsigned long insn = unwind_get_byte(ctrl);
+	unsigned long orig_sp = ctrl->vrs[SP];
 
 	pr_debug("%s: insn = %08lx\n", __func__, insn);
 
@@ -264,8 +271,11 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		/* pop R4-R15 according to mask */
 		load_sp = mask & (1 << (13 - 4));
 		while (mask) {
-			if (mask & 1)
+			if (mask & 1) {
+				if (!ptr_in_stack(orig_sp, vsp))
+					return -URC_FAILURE;
 				ctrl->vrs[reg] = *vsp++;
+			}
 			mask >>= 1;
 			reg++;
 		}
@@ -279,10 +289,16 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		int reg;
 
 		/* pop R4-R[4+bbb] */
-		for (reg = 4; reg <= 4 + (insn & 7); reg++)
+		for (reg = 4; reg <= 4 + (insn & 7); reg++) {
+			if (!ptr_in_stack(orig_sp, vsp))
+				return -URC_FAILURE;
 			ctrl->vrs[reg] = *vsp++;
-		if (insn & 0x80)
+		}
+		if (insn & 0x80) {
+			if (!ptr_in_stack(orig_sp, vsp))
+				return -URC_FAILURE;
 			ctrl->vrs[14] = *vsp++;
+		}
 		ctrl->vrs[SP] = (unsigned long)vsp;
 	} else if (insn == 0xb0) {
 		if (ctrl->vrs[PC] == 0)
@@ -302,8 +318,11 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 
 		/* pop R0-R3 according to mask */
 		while (mask) {
-			if (mask & 1)
+			if (mask & 1) {
+				if (!ptr_in_stack(orig_sp, vsp))
+					return -URC_FAILURE;
 				ctrl->vrs[reg] = *vsp++;
+			}
 			mask >>= 1;
 			reg++;
 		}
@@ -327,19 +346,17 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
  * Unwind a single frame starting with *sp for the symbol at *pc. It
  * updates the *pc and *sp with the new values.
  */
-int unwind_frame(struct stackframe *frame)
+int unwind_frame(struct stackframe *frame, int depth)
 {
-	unsigned long high, low;
 	const struct unwind_idx *idx;
 	struct unwind_ctrl_block ctrl;
 
-	/* only go to a higher address on the stack */
-	low = frame->sp;
-	high = ALIGN(low, THREAD_SIZE);
-
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
 
+	if (!sp_addr_valid(frame->sp))
+		return -URC_FAILURE;
+
 	if (!kernel_text_address(frame->pc))
 		return -URC_FAILURE;
 
@@ -386,7 +403,7 @@ int unwind_frame(struct stackframe *frame)
 		int urc = unwind_exec_insn(&ctrl);
 		if (urc < 0)
 			return urc;
-		if (ctrl.vrs[SP] < low || ctrl.vrs[SP] >= high)
+		if (!sp_in_stack(frame->sp, ctrl.vrs[SP]))
 			return -URC_FAILURE;
 	}
 
@@ -397,6 +414,10 @@ int unwind_frame(struct stackframe *frame)
 	if (frame->pc == ctrl.vrs[PC])
 		return -URC_FAILURE;
 
+	/* only leaf functions can possibly not modify sp */
+	if (depth != 0 && frame->sp == ctrl.vrs[SP])
+		return -URC_FAILURE;
+
 	frame->fp = ctrl.vrs[FP];
 	frame->sp = ctrl.vrs[SP];
 	frame->lr = ctrl.vrs[LR];
@@ -409,6 +430,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
 	register unsigned long current_sp asm ("sp");
+	int depth = 0;
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -443,7 +465,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		int urc;
 		unsigned long where = frame.pc;
 
-		urc = unwind_frame(&frame);
+		urc = unwind_frame(&frame, depth++);
 		if (urc < 0)
 			break;
 		dump_backtrace_entry(where, frame.pc, frame.sp - 4);
-- 
1.8.1
