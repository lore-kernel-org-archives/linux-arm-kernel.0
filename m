From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Aug 2014 13:06:53 +0200
Subject: [PATCH v5 10/12] sched: get CPU's utilization statistic
In-Reply-To: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1409051215-16788-11-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Monitor the utilization level of each group of each sched_domain level. The
utilization is the amount of cpu_capacity that is currently used on a CPU or
group of CPUs. We use the usage_load_avg to evaluate this utilization level.
In the special use case where the CPU is fully loaded by more than 1 task,
the activity level is set above the cpu_capacity in order to reflect the overload
of the CPU

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1fd2131..2f95d1c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4126,6 +4126,11 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
+static unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -4514,6 +4519,17 @@ static int select_idle_sibling(struct task_struct *p, int target)
 	return target;
 }
 
+static int get_cpu_utilization(int cpu)
+{
+	unsigned long usage = cpu_rq(cpu)->cfs.usage_load_avg;
+	unsigned long capacity = capacity_of(cpu);
+
+	if (usage >= SCHED_LOAD_SCALE)
+		return capacity + 1;
+
+	return (usage * capacity) >> SCHED_LOAD_SHIFT;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -5657,6 +5673,7 @@ struct sg_lb_stats {
 	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
 	unsigned long load_per_task;
 	unsigned long group_capacity;
+	unsigned long group_utilization; /* Total utilization of the group */
 	unsigned int sum_nr_running; /* Nr tasks running in the group */
 	unsigned int group_capacity_factor;
 	unsigned int idle_cpus;
@@ -6011,6 +6028,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
+		sgs->group_utilization += get_cpu_utilization(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		if (rq->nr_running > 1)
@@ -6188,7 +6206,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
-
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
-- 
1.9.1
