From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Dec 2011 14:57:48 +0000
Subject: [RFC PATCH v2 1/6] sched: Introduce the
 finish_arch_post_lock_switch() scheduler hook
In-Reply-To: <1324306673-4282-1-git-send-email-catalin.marinas@arm.com>
References: <1324306673-4282-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1324306673-4282-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This hook is called by the scheduler after rq->lock has been released
and interrupts enabled. It will be used in subsequent patches on the ARM
architecture.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index d6b149c..35390bf 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -984,6 +984,9 @@ static inline u64 global_rt_runtime(void)
 #ifndef finish_arch_switch
 # define finish_arch_switch(prev)	do { } while (0)
 #endif
+#ifndef finish_arch_post_lock_switch
+# define finish_arch_post_lock_switch()	do { } while (0)
+#endif
 
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
@@ -3204,6 +3207,7 @@ static void finish_task_switch(struct rq *rq, struct task_struct *prev)
 	local_irq_enable();
 #endif /* __ARCH_WANT_INTERRUPTS_ON_CTXSW */
 	finish_lock_switch(rq, prev);
+	finish_arch_post_lock_switch();
 
 	fire_sched_in_preempt_notifiers(current);
 	if (mm)
