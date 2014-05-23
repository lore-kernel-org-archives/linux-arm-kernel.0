From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 23 May 2014 17:53:04 +0200
Subject: [PATCH v2 10/11] sched: move cfs task on a CPU with higher capacity
In-Reply-To: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the CPU is used for handling lot of IRQs, trig a load balance to check if
it's worth moving its tasks on another CPU that has more capacity

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8a30f9..2501e49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5948,6 +5948,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (sgs->sum_nr_running > sgs->group_capacity)
 		return true;
 
+	/*
+	 * The group capacity is reduced probably because of activity from other
+	 * sched class or interrupts which use part of the available capacity
+	 */
+	if ((sg->sgp->power_orig * 100) > (sgs->group_power * env->sd->imbalance_pct))
+		return true;
+
 	if (sgs->group_imb)
 		return true;
 
@@ -7282,6 +7289,12 @@ static inline int nohz_kick_needed(struct rq *rq)
 
 		if (nr_busy > 1)
 			goto need_kick_unlock;
+
+		if ((rq->cfs.h_nr_running >= 1)
+		 && ((rq->cpu_power * sd->imbalance_pct) <
+					(rq->cpu_power_orig * 100)))
+			goto need_kick_unlock;
+
 	}
 
 	sd = rcu_dereference(per_cpu(sd_asym, cpu));
-- 
1.9.1
