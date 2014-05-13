From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Tue, 13 May 2014 10:46:53 +0100
Subject: [PATCH 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1399974418-4995-3-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there are numerous places where "struct pt_regs" are used to
populate "struct stackframe", however all of those location do not
consider the situation where the kernel might be compiled in THUMB2
mode, in which case the framepointer member of pt_regs become ARM_r7
instead of ARM_fp (r11). 


The easiest solution is to introduce a new function (in the spirit of
https://groups.google.com/forum/#!topic/linux.kernel/dA2YuUcSpZ4)
which would hide the complexity of initializing the stackframe struct
from pt_regs. While we are at it, also document this idiosincratic 
behavior  of the frame pointer in the definition of 
"struct stackframe2. 

Also implement a macro frame_pointer(regs) that would return the correct
register so that we can use it in cases where we just require the frame
pointer and not a whole struct stackframe

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/include/asm/ptrace.h     | 3 +++
 arch/arm/include/asm/stacktrace.h | 5 +++++
 arch/arm/kernel/stacktrace.c      | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index c877654..cd5cff3 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -83,6 +83,9 @@ static inline long regs_return_value(struct pt_regs *regs)
 }
 
 #define instruction_pointer(regs)	(regs)->ARM_pc
+#define frame_pointer(regs)				\
+	IS_ENABLED(CONFIG_THUMB2_KERNEL) ? regs->ARM_r7 \
+	: regs->ARM_fp					\
 
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 4d0a164..9cbdf36 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -2,12 +2,17 @@
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
 
+extern void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe
+		*frame);
 extern int unwind_frame(struct stackframe *frame);
 extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index af4e8c8..5d6ac4d 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -43,6 +43,15 @@ int notrace unwind_frame(struct stackframe *frame)
 }
 #endif
 
+void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
+{
+		frame->fp = frame_pointer(regs);
+		frame->sp = regs->ARM_sp;
+		frame->lr = regs->ARM_lr;
+		frame->pc = regs->ARM_pc;
+}
+EXPORT_SYMBOL_GPL(arm_get_current_stackframe);
+
 void notrace walk_stackframe(struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
 {
-- 
1.8.1.5
