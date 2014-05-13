From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Tue, 13 May 2014 10:46:58 +0100
Subject: [PATCH 7/7] ARM: oprofile: Use of arm_get_current_stackframe
In-Reply-To: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1399974418-4995-8-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly introduced API so that FP is correctly referenced from
either R7/R11 based on whether we are running in THUMB2 mode or not.

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/oprofile/common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 99c63d4b..e6a3c4c 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -107,10 +107,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
 
 	if (!user_mode(regs)) {
 		struct stackframe frame;
-		frame.fp = regs->ARM_fp;
-		frame.sp = regs->ARM_sp;
-		frame.lr = regs->ARM_lr;
-		frame.pc = regs->ARM_pc;
+		arm_get_current_stackframe(regs, &frame);
 		walk_stackframe(&frame, report_trace, &depth);
 		return;
 	}
-- 
1.8.1.5
