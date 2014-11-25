From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 25 Nov 2014 15:18:57 +0000
Subject: [PATCH] arm: cacheflush: get rid of restarting block
Message-ID: <1416928737-29723-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot restart cacheflush safely if a process provides user-defined
signal handler and signal is pending. In this case -EINTR is returned
and it is expected that process re-invokes syscall. However, there are
a few problems with that:
 * looks like nobody bothers checking return value from cacheflush
 * but if it did, we don't provide the restart address for that, so the
   process has to use the same range again
 * ...and again, what might lead to looping forever

So, remove cacheflush restarting code and terminate cache flushing
as early as fatal signal is pending.

Cc: stable at vger.kernel.org # 3.12+
Reported-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
Hi,

There is my proposal for the problem reported in [1]. Since that
thread has not been progressing much, I'm addressing the problem in
separate patch.

Comments?

[1] https://lkml.org/lkml/2014/11/13/29

 arch/arm/include/asm/thread_info.h |   11 -----------
 arch/arm/kernel/traps.c            |   31 ++-----------------------------
 2 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index fc44d37..ce73ab6 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -44,16 +44,6 @@ struct cpu_context_save {
 	__u32	extra[2];		/* Xscale 'acc' register, etc */
 };
 
-struct arm_restart_block {
-	union {
-		/* For user cache flushing */
-		struct {
-			unsigned long start;
-			unsigned long end;
-		} cache;
-	};
-};
-
 /*
  * low level task data that entry.S needs immediate access to.
  * __switch_to() assumes cpu_context follows immediately after cpu_domain.
@@ -79,7 +69,6 @@ struct thread_info {
 	unsigned long		thumbee_state;	/* ThumbEE Handler Base register */
 #endif
 	struct restart_block	restart_block;
-	struct arm_restart_block	arm_restart_block;
 };
 
 #define INIT_THREAD_INFO(tsk)						\
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 0c8b108..8dd03ee 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -533,8 +533,6 @@ static int bad_syscall(int n, struct pt_regs *regs)
 	return regs->ARM_r0;
 }
 
-static long do_cache_op_restart(struct restart_block *);
-
 static inline int
 __do_cache_op(unsigned long start, unsigned long end)
 {
@@ -543,24 +541,8 @@ __do_cache_op(unsigned long start, unsigned long end)
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
+		if (fatal_signal_pending(current))
+			return 0;
 
 		ret = flush_cache_user_range(start, start + chunk);
 		if (ret)
@@ -573,15 +555,6 @@ __do_cache_op(unsigned long start, unsigned long end)
 	return 0;
 }
 
-static long do_cache_op_restart(struct restart_block *unused)
-{
-	struct arm_restart_block *restart_block;
-
-	restart_block = &current_thread_info()->arm_restart_block;
-	return __do_cache_op(restart_block->cache.start,
-			     restart_block->cache.end);
-}
-
 static inline int
 do_cache_op(unsigned long start, unsigned long end, int flags)
 {
-- 
1.7.9.5
