From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Fri, 30 May 2014 17:59:46 +0100
Subject: [PATCH v2 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
References: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
Message-ID: <1401469191-29232-3-git-send-email-nikolay.borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nikolay Borisov <Nikolay.Borisov@arm.com>

Currently there are numerous places where "struct pt_regs" are used to
populate "struct stackframe", however all of those location do not
consider the situation where the kernel might be compiled in THUMB2
mode, in which case the framepointer member of pt_regs become ARM_r7
instead of ARM_fp (r11). Document this idiosyncracy in the
definition of "struct stackframe"

The easiest solution is to introduce a new function (in the spirit of
https://groups.google.com/forum/#!topic/linux.kernel/dA2YuUcSpZ4)
which would hide the complexity of initializing the stackframe struct
from pt_regs.

Also implement a macro frame_pointer(regs) that would return the correct
register so that we can use it in cases where we just require the frame
pointer and not a whole struct stackframe

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/include/asm/ptrace.h     |  6 ++++++
 arch/arm/include/asm/stacktrace.h | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index c877654..601264d 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -84,6 +84,12 @@ static inline long regs_return_value(struct pt_regs *regs)
 
 #define instruction_pointer(regs)	(regs)->ARM_pc
 
+#ifdef CONFIG_THUMB2_KERNEL
+#define frame_pointer(regs) (regs)->ARM_r7
+#else
+#define frame_pointer(regs) (regs)->ARM_fp
+#endif
+
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
 {
diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 4d0a164..6a5b13e 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -2,12 +2,24 @@
 #define __ASM_STACKTRACE_H
 
 struct stackframe {
+	/* FP member should hold R7 when CONFIG_THUMB2_KERNEL is enabled.
+	 * and R11 otherwise
+	 */
 	unsigned long fp;
 	unsigned long sp;
 	unsigned long lr;
 	unsigned long pc;
 };
 
+static __always_inline
+void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
+{
+		frame->fp = frame_pointer(regs);
+		frame->sp = regs->ARM_sp;
+		frame->lr = regs->ARM_lr;
+		frame->pc = regs->ARM_pc;
+}
+
 extern int unwind_frame(struct stackframe *frame);
 extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
-- 
1.8.1.5
