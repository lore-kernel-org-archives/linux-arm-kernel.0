From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue,  8 Jul 2014 13:16:16 -0700
Subject: [PATCH 6/6] arm: LLVMLinux: Use current_stack_pointer in
 unwind_backtrace
In-Reply-To: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
References: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
Message-ID: <1404850576-2006-7-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to get the value of the stack pointer.
This change supports being able to compile the kernel with both gcc and clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M??ller <dl9pf@gmx.de>
---
 arch/arm/kernel/unwind.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index e67682f..e20e8dc 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -471,7 +471,6 @@ int unwind_frame(struct stackframe *frame)
 void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
-	register unsigned long current_sp asm ("sp");
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -487,7 +486,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 			 ? regs->ARM_pc : regs->ARM_lr;
 	} else if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_sp;
+		frame.sp = current_stack_pointer;
 		frame.lr = (unsigned long)__builtin_return_address(0);
 		frame.pc = (unsigned long)unwind_backtrace;
 	} else {
-- 
1.9.1
