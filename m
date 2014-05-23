From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 23 May 2014 17:53:00 +0200
Subject: [PATCH v2 06/11] sched: add per rq cpu_power_orig
In-Reply-To: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1400860385-14555-7-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new field cpu_power_orig reflects the available capacity of a CPUs unlike
the cpu_power which reflects the current capacity that can be altered by
frequency and rt tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 1 +
 kernel/sched/sched.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 240aa83..686c56f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6946,7 +6946,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
-		rq->cpu_power = SCHED_POWER_SCALE;
+		rq->cpu_power = rq->cpu_power_orig = SCHED_POWER_SCALE;
 		rq->post_schedule = 0;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6dc05f7..b3dc2b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5675,6 +5675,7 @@ static void update_cpu_power(struct sched_domain *sd, int cpu)
 
 	power >>= SCHED_POWER_SHIFT;
 
+	cpu_rq(cpu)->cpu_power_orig = power;
 	sdg->sgp->power_orig = power;
 
 	if (sched_feat(ARCH_POWER))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 600e229..4c74014 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -568,6 +568,7 @@ struct rq {
 	struct sched_domain *sd;
 
 	unsigned long cpu_power;
+	unsigned long cpu_power_orig;
 
 	unsigned char idle_balance;
 	/* For active balancing */
-- 
1.9.1
