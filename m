From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 28 Jul 2014 19:51:40 +0200
Subject: [PATCH 06/12] sched: add per rq cpu_capacity_orig
In-Reply-To: <1406569906-9763-1-git-send-email-vincent.guittot@linaro.org>
References: <1406569906-9763-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1406569906-9763-7-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new field cpu_capacity_orig reflects the available capacity of a CPUs
unlike the cpu_capacity which reflects the current capacity that can be altered
by frequency and rt tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 1 +
 kernel/sched/sched.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1a2f31..fc5a275 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6976,7 +6976,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
-		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
 		rq->post_schedule = 0;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00ff5f3..f6258bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5693,6 +5693,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 
 	capacity >>= SCHED_CAPACITY_SHIFT;
 
+	cpu_rq(cpu)->cpu_capacity_orig = capacity;
 	sdg->sgc->capacity_orig = capacity;
 
 	if (sched_feat(ARCH_CAPACITY))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0191ed5..5a8ef50 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -571,6 +571,7 @@ struct rq {
 	struct sched_domain *sd;
 
 	unsigned long cpu_capacity;
+	unsigned long cpu_capacity_orig;
 
 	unsigned char idle_balance;
 	/* For active balancing */
-- 
1.9.1
