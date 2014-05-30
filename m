From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Fri, 30 May 2014 17:59:48 +0100
Subject: [PATCH v2 4/7] ARM: time: Make use of arm_get_current_stackframe
In-Reply-To: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
References: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
Message-ID: <1401469191-29232-5-git-send-email-nikolay.borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nikolay Borisov <Nikolay.Borisov@arm.com>

Make use of the arm_get_current_stackframe api so that
the frame pointer is correctly referenced in THUMB2 mode

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/kernel/time.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 829a96d..0cc7e58 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -50,10 +50,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 	if (!in_lock_functions(regs->ARM_pc))
 		return regs->ARM_pc;
 
-	frame.fp = regs->ARM_fp;
-	frame.sp = regs->ARM_sp;
-	frame.lr = regs->ARM_lr;
-	frame.pc = regs->ARM_pc;
+	arm_get_current_stackframe(regs, &frame);
 	do {
 		int ret = unwind_frame(&frame);
 		if (ret < 0)
-- 
1.8.1.5
