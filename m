From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Nov 2011 12:22:27 +0000
Subject: [RFC PATCH 1/6] sched: Introduce the finish_arch_post_lock_switch()
 scheduler hook
In-Reply-To: <1322569352-23584-1-git-send-email-catalin.marinas@arm.com>
References: <1322569352-23584-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1322569352-23584-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This hook is called by the scheduler after rq->lock has been released
and interrupts enabled. It will be used in subsequent patches on the ARM
architecture.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 0e9344a..7b46a39 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -983,6 +983,9 @@ static inline u64 global_rt_runtime(void)
 #ifndef finish_arch_switch
 # define finish_arch_switch(prev)	do { } while (0)
 #endif
+#ifndef finish_arch_post_lock_switch
+# define finish_arch_post_lock_switch()	do { } while (0)
+#endif
 
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
@@ -3203,6 +3206,7 @@ static void finish_task_switch(struct rq *rq, struct task_struct *prev)
 	local_irq_enable();
 #endif /* __ARCH_WANT_INTERRUPTS_ON_CTXSW */
 	finish_lock_switch(rq, prev);
+	finish_arch_post_lock_switch();
 
 	fire_sched_in_preempt_notifiers(current);
 	if (mm)
