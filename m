From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Fri, 30 May 2014 17:59:49 +0100
Subject: [PATCH v2 5/7] ARM: unwind: Use arm_get_current_stackframe
In-Reply-To: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
References: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
Message-ID: <1401469191-29232-6-git-send-email-nikolay.borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nikolay Borisov <Nikolay.Borisov@arm.com>

Make the unwind code use the correct API so that the frame pointer
is extracted from the correct register.

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/kernel/unwind.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 3c21769..7aaec44 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -479,12 +479,10 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		tsk = current;
 
 	if (regs) {
-		frame.fp = regs->ARM_fp;
-		frame.sp = regs->ARM_sp;
-		frame.lr = regs->ARM_lr;
+		arm_get_current_stackframe(regs, &frame);
 		/* PC might be corrupted, use LR in that case. */
-		frame.pc = kernel_text_address(regs->ARM_pc)
-			 ? regs->ARM_pc : regs->ARM_lr;
+		if (!kernel_text_address(regs->ARM_pc))
+			frame.pc = regs->ARM_lr;
 	} else if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_sp;
-- 
1.8.1.5
