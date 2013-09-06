From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:28:11 -0400
Subject: [PATCH 5/5] arm: LLVMLinux: Use current_stack_pointer in
 unwind_backtrace
In-Reply-To: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
Message-ID: <1378502899-1241-6-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The existing code uses named registers to get the value of the stack pointer.
The new current_stack_pointer macro is more readable and allows for a central
portable implementation of how to get the stack pointer with ASM.  This change
supports being able to compile the kernel with both gcc and Clang.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
---
 arch/arm/kernel/unwind.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..e7f1eec 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -408,7 +408,6 @@ int unwind_frame(struct stackframe *frame)
 void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
-	register unsigned long current_sp asm ("sp");
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -424,7 +423,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 			 ? regs->ARM_pc : regs->ARM_lr;
 	} else if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_sp;
+		frame.sp = current_stack_pointer;
 		frame.lr = (unsigned long)__builtin_return_address(0);
 		frame.pc = (unsigned long)unwind_backtrace;
 	} else {
-- 
1.8.1.2
