From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 12 Dec 2012 14:31:27 +0100
Subject: RFC PATCH v2 1/6] Revert "sched: introduce temporary FAIR_GROUP_SCHED
 dependency for load-tracking"
In-Reply-To: <1355319092-30980-1-git-send-email-vincent.guittot@linaro.org>
References: <1355319092-30980-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1355319092-30980-2-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit f4e26b120b9de84cb627bc7361ba43cfdc51341f

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |    8 +-------
 kernel/sched/core.c   |    7 +------
 kernel/sched/fair.c   |    3 +--
 kernel/sched/sched.h  |    9 +--------
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fd17ca3..046e39a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1195,13 +1195,7 @@ struct sched_entity {
 	/* rq "owned" by this entity/group: */
 	struct cfs_rq		*my_q;
 #endif
-/*
- * Load-tracking only depends on SMP, FAIR_GROUP_SCHED dependency below may be
- * removed when useful for applications beyond shares distribution (e.g.
- * load-balance).
- */
-#if defined(CONFIG_SMP) && defined(CONFIG_FAIR_GROUP_SCHED)
-	/* Per-entity load-tracking */
+#ifdef CONFIG_SMP
 	struct sched_avg	avg;
 #endif
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8482628..c25c75d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1544,12 +1544,7 @@ static void __sched_fork(struct task_struct *p)
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
-/*
- * Load-tracking only depends on SMP, FAIR_GROUP_SCHED dependency below may be
- * removed when useful for applications beyond shares distribution (e.g.
- * load-balance).
- */
-#if defined(CONFIG_SMP) && defined(CONFIG_FAIR_GROUP_SCHED)
+#ifdef CONFIG_SMP
 	p->se.avg.runnable_avg_period = 0;
 	p->se.avg.runnable_avg_sum = 0;
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61c7a10..9916d41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2820,8 +2820,7 @@ static inline void update_cfs_shares(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-/* Only depends on SMP, FAIR_GROUP_SCHED may be removed when useful in lb */
-#if defined(CONFIG_SMP) && defined(CONFIG_FAIR_GROUP_SCHED)
+#ifdef CONFIG_SMP
 /*
  * We choose a half-life close to 1 scheduling period.
  * Note: The tables below are dependent on this value.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f00eb80..92ba891 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -226,12 +226,6 @@ struct cfs_rq {
 #endif
 
 #ifdef CONFIG_SMP
-/*
- * Load-tracking only depends on SMP, FAIR_GROUP_SCHED dependency below may be
- * removed when useful for applications beyond shares distribution (e.g.
- * load-balance).
- */
-#ifdef CONFIG_FAIR_GROUP_SCHED
 	/*
 	 * CFS Load tracking
 	 * Under CFS, load is tracked on a per-entity basis and aggregated up.
@@ -241,8 +235,7 @@ struct cfs_rq {
 	u64 runnable_load_avg, blocked_load_avg;
 	atomic64_t decay_counter, removed_load;
 	u64 last_decay;
-#endif /* CONFIG_FAIR_GROUP_SCHED */
-/* These always depend on CONFIG_FAIR_GROUP_SCHED */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	u32 tg_runnable_contrib;
 	u64 tg_load_contrib;
-- 
1.7.9.5
