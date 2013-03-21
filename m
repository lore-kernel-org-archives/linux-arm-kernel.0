From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Mar 2013 17:02:00 -0700
Subject: [PATCH 3/4] ARM: context tracking: handle post exception/syscall/IRQ
 work
In-Reply-To: <1363824121-26169-1-git-send-email-khilman@linaro.org>
References: <1363824121-26169-1-git-send-email-khilman@linaro.org>
Message-ID: <1363824121-26169-4-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_work_pending() may be called on IRQ, exception or syscall exit (for
reschedule, signal handling, etc.) , but user_enter() may have already
been called (e.g. by syscall return path.)

Since do_work_pending() is still in kernel mode, keep context_tracker
up to date by using user_exit/user_enter.

Based on commit edf55fda35c7dc7f2d9241c3abaddaf759b457c6 (x86: Exit
RCU extended QS on notify resume)

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/kernel/signal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 296786b..42514fd 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -12,6 +12,7 @@
 #include <linux/personality.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
+#include <linux/context_tracking.h>
 
 #include <asm/elf.h>
 #include <asm/cacheflush.h>
@@ -575,12 +576,15 @@ static int do_signal(struct pt_regs *regs, int syscall)
 asmlinkage int
 do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 {
+	int retval = 0;
+
+	user_exit();
 	do {
 		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
 			schedule();
 		} else {
 			if (unlikely(!user_mode(regs)))
-				return 0;
+				break;
 			local_irq_enable();
 			if (thread_flags & _TIF_SIGPENDING) {
 				int restart = do_signal(regs, syscall);
@@ -590,7 +594,8 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 					 * Deal with it without leaving
 					 * the kernel space.
 					 */
-					return restart;
+					retval = restart;
+					break;
 				}
 				syscall = 0;
 			} else {
@@ -601,5 +606,6 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 		local_irq_disable();
 		thread_flags = current_thread_info()->flags;
 	} while (thread_flags & _TIF_WORK_MASK);
-	return 0;
+	user_enter();
+	return retval;
 }
-- 
1.8.2
