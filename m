From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 23 Sep 2014 18:08:03 +0200
Subject: [PATCH v6 4/6] sched: get CPU's usage statistic
In-Reply-To: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1411488485-10025-5-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Monitor the usage level of each group of each sched_domain level. The usage is
the amount of cpu_capacity that is currently used on a CPU or group of CPUs.
We use the utilization_load_avg to evaluate the usage level of each group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2cf153d..4097e3f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4523,6 +4523,17 @@ static int select_idle_sibling(struct task_struct *p, int target)
 	return target;
 }
 
+static int get_cpu_usage(int cpu)
+{
+	unsigned long usage = cpu_rq(cpu)->cfs.utilization_load_avg;
+	unsigned long capacity = capacity_orig_of(cpu);
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
@@ -5663,6 +5674,7 @@ struct sg_lb_stats {
 	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
 	unsigned long load_per_task;
 	unsigned long group_capacity;
+	unsigned long group_usage; /* Total usage of the group */
 	unsigned int sum_nr_running; /* Nr tasks running in the group */
 	unsigned int group_capacity_factor;
 	unsigned int idle_cpus;
@@ -6037,6 +6049,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
+		sgs->group_usage += get_cpu_usage(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		if (rq->nr_running > 1)
-- 
1.9.1
