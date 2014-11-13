From: chanho.min@lge.com (Chanho Min)
Date: Thu, 13 Nov 2014 16:29:53 +0900
Subject: [PATCH] ARM: cacheflush: disallow pending signals during cacheflush
Message-ID: <1415863793-6219-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 28256d612726 ("ARM: cacheflush: split user cache-flushing
into interruptible chunks"), cacheflush can be interrupted by signal.

But, cacheflush doesn't resume from where we left off if process has
user-defined signal handlers. It returns -EINTR then cacheflush
should be re-invoked from the start of address until cache-flushing
of whole address ranges is completed (restart_syscall isn't available
in userspace). It may cause regression. So I suggest to disallow
pending signals during cacheflush.

This partially reverts commit 28256d612726a28a8b9d3c49f2b74198c4423d6a.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/kernel/traps.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index abd2fc0..275e086 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -521,25 +521,6 @@ __do_cache_op(unsigned long start, unsigned long end)
 	do {
 		unsigned long chunk = min(PAGE_SIZE, end - start);
 
-		if (signal_pending(current)) {
-			struct thread_info *ti = current_thread_info();
-
-			ti->restart_block = (struct restart_block) {
-				.fn	= do_cache_op_restart,
-			};
-
-			ti->arm_restart_block = (struct arm_restart_block) {
-				{
-					.cache = {
-						.start	= start,
-						.end	= end,
-					},
-				},
-			};
-
-			return -ERESTART_RESTARTBLOCK;
-		}
-
 		ret = flush_cache_user_range(start, start + chunk);
 		if (ret)
 			return ret;
-- 
1.7.9.5
