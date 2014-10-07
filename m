From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue,  7 Oct 2014 14:13:35 +0200
Subject: [PATCH v7 5/7] sched: get CPU's usage statistic
In-Reply-To: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1412684017-16595-6-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Monitor the usage level of each group of each sched_domain level. The usage is
the amount of cpu_capacity that is currently used on a CPU or group of CPUs.
We use the utilization_load_avg to evaluate the usage level of each group.

The utilization_avg_contrib only takes into account the running time but not
the uArch so the utilization_load_avg is in the range [0..SCHED_LOAD_SCALE]
to reflect the running load on the CPU. We have to scale the utilization with
the capacity of the CPU to get the usage of the latter. The usage can then be
compared with the available capacity.

The frequency scaling invariance is not taken into account in this patchset,
it will be solved in another patchset

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3e9067..7364ed4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4551,6 +4551,17 @@ static int select_idle_sibling(struct task_struct *p, int target)
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
@@ -5679,6 +5690,7 @@ struct sg_lb_stats {
 	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
 	unsigned long load_per_task;
 	unsigned long group_capacity;
+	unsigned long group_usage; /* Total usage of the group */
 	unsigned int sum_nr_running; /* Nr tasks running in the group */
 	unsigned int group_capacity_factor;
 	unsigned int idle_cpus;
@@ -6053,6 +6065,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
+		sgs->group_usage += get_cpu_usage(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		if (rq->nr_running > 1)
-- 
1.9.1
