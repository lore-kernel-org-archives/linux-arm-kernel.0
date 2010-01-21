From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 21 Jan 2010 10:23:29 +0100
Subject: [PATCH/RFC] arm: Enable backtrace printing on oops when PC is
	corrupted
Message-ID: <1264065809-7893-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If PC points outside kernel text, start printing the backtrace at LR
instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/kernel/unwind.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 786ac2b..50292cd 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -359,7 +359,9 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.fp = regs->ARM_fp;
 		frame.sp = regs->ARM_sp;
 		frame.lr = regs->ARM_lr;
-		frame.pc = regs->ARM_pc;
+		/* PC might be corrupted, use LR in that case. */
+		frame.pc = kernel_text_address(regs->ARM_pc)
+			 ? regs->ARM_pc : regs->ARM_lr;
 	} else if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_sp;
-- 
1.6.4.4
