From: ccross@android.com (Colin Cross)
Date: Tue, 29 Jan 2013 17:55:45 -0800
Subject: [PATCH v3 1/3] ARM: stacktrace: harden FP stacktraces against invalid
 stacks
In-Reply-To: <1359510947-3950-1-git-send-email-ccross@android.com>
References: <1359510947-3950-1-git-send-email-ccross@android.com>
Message-ID: <1359510947-3950-2-git-send-email-ccross@android.com>
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

Add additional validations to the version of unwind_frame used when
CONFIG_FRAME_POINTER=y:

Verify that the stack is in a mapped region of kernel memory.
Fixes crashes seen in unwind_frame on real systems, although
stack corruption caused by memory instability is likely the cause
of the invalid sp and fp values.

Fix address comparison to catch fp >= 0xfffffffc correctly.
Fixes crash reported by Todd Poynor.

Ensure the stack pointer moves to a higher address between each
frame to make sure repeated calls to unwind_frame can't loop
forever.

Includes ideas from Dave Martin.

Signed-off-by: Colin Cross <ccross@android.com>
---
v2:
   verify that initial sp value is in mapped lowmem
   verify that stack offsets are in the range
      [sizeof(struct thread_info), THREAD_START_SP)
   export stack validation functions for use by unwind

v3:
   avoid using page structs to convert vaddr to pfn

 arch/arm/include/asm/stacktrace.h |   4 ++
 arch/arm/kernel/stacktrace.c      | 105 +++++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 4d0a164..6909056 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -12,4 +12,8 @@ struct stackframe {
 extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 
+bool sp_addr_valid(unsigned long sp);
+bool addr_in_stack(unsigned long orig_sp, unsigned long vsp);
+bool sp_in_stack(unsigned long orig_sp, unsigned long vsp);
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 00f79e5..aba76d5 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -1,9 +1,89 @@
 #include <linux/export.h>
+#include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
 #include <asm/stacktrace.h>
 
+#define STACK_MAX(sp) (round_down(sp, THREAD_SIZE) + THREAD_START_SP)
+
+/**
+ * sp_addr_valid - verify a stack pointer
+ * @sp: current stack pointer
+ *
+ * Returns true if sp is a pointer inside a memory area that could be a stack.
+ * Does not verify that sp is inside an actual stack (i.e. does not check for
+ * STACK_MAGIC).
+ *
+ * If sp_addr_valid(sp) returns true, then the kernel will not fault if it
+ * accesses memory in the range
+ * [sp, round_down(sp, THREAD_SIZE) + THREAD_START_SP)
+ */
+bool sp_addr_valid(unsigned long sp)
+{
+	unsigned long high;
+	unsigned long offset;
+	unsigned int pfn;
+	unsigned int start_pfn;
+	unsigned int end_pfn;
+
+	if (!IS_ALIGNED(sp, 4))
+		return false;
+
+	offset = sp & (THREAD_SIZE - 1);
+
+	if (offset > THREAD_START_SP)
+		return false;
+
+	if (offset < sizeof(struct thread_info))
+		return false;
+
+	high = STACK_MAX(sp);
+
+	if (!virt_addr_valid(sp) || !virt_addr_valid(high))
+		return false;
+
+	start_pfn = __phys_to_pfn(__virt_to_phys(sp));
+	end_pfn = __phys_to_pfn(__virt_to_phys(high));
+	for (pfn = start_pfn; pfn <= end_pfn; pfn++)
+		if (!pfn_valid(pfn))
+			return false;
+
+	return true;
+}
+
+/**
+ * addr_in_stack - verify a pointer is inside a specified stack
+ * @orig_sp: stack pointer at the bottom of the stack
+ * @sp: address to be verified
+ *
+ * Returns true if sp is in the stack bounded@the bottom by orig_sp, in the
+ * range [orig_sp, round_down(orig_sp, THREAD_SIZE) + THREAD_START_SP)
+ *
+ * If orig_sp is valid (see sp_addr_valid), then the kernel will not fault if it
+ * accesses a pointer where ptr_in_stack returns true.
+ */
+bool addr_in_stack(unsigned long orig_sp, unsigned long sp)
+{
+	return (sp >= orig_sp && sp < STACK_MAX(orig_sp) && IS_ALIGNED(sp, 4));
+}
+
+/**
+ * sp_in_stack - verify a stack pointer is inside a specified stack
+ * @orig_sp: stack pointer at the bottom of the stack
+ * @sp: stack pointer to be verified
+ *
+ * Returns true if sp is in the stack bounded@the bottom by orig_sp, in the
+ * range [orig_sp, round_down(orig_sp, THREAD_SIZE) + THREAD_START_SP]
+ *
+ * If sp_in_stack returns true,
+ * addr_in_stack(vsp, x) == addr_in_stack(orig_sp, x)
+ */
+bool sp_in_stack(unsigned long orig_sp, unsigned long sp)
+{
+	return (sp >= orig_sp && sp <= STACK_MAX(orig_sp) && IS_ALIGNED(sp, 4));
+}
+
 #if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
 /*
  * Unwind the current stack frame and store the new register values in the
@@ -23,15 +103,17 @@
  */
 int notrace unwind_frame(struct stackframe *frame)
 {
-	unsigned long high, low;
 	unsigned long fp = frame->fp;
+	unsigned long sp = frame->sp;
+
+	if (!sp_addr_valid(sp))
+		return -EINVAL;
 
-	/* only go to a higher address on the stack */
-	low = frame->sp;
-	high = ALIGN(low, THREAD_SIZE);
+	/* Check current frame pointer is within the stack bounds. */
+	if (!addr_in_stack(sp, fp))
+		return -EINVAL;
 
-	/* check current frame pointer is within bounds */
-	if (fp < (low + 12) || fp + 4 >= high)
+	if (fp < 12 || !addr_in_stack(sp, fp - 12))
 		return -EINVAL;
 
 	/* restore the registers from the stack frame */
@@ -39,6 +121,17 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
 
+	/* Ensure the next stack pointer is in the same stack */
+	if (!sp_in_stack(sp, frame->sp))
+		return -EINVAL;
+
+	/*
+	 * Ensure the next stack pointer is above this frame to guarantee
+	 * bounded execution.
+	 */
+	if (frame->sp < fp)
+		return -EINVAL;
+
 	return 0;
 }
 #endif
-- 
1.8.1
