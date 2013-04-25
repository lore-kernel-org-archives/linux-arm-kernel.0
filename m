From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 25 Apr 2013 19:23:23 +0200
Subject: [PATCH 07/14] sched: agressively pack at wake/fork/exec
In-Reply-To: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1366910611-20048-8-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the packing policy, the scheduler can pack tasks at different
step:
-SCHED_PACKING_NONE level: we don't pack any task.
-SCHED_PACKING_DEFAULT: we only pack small tasks at wake up when system is not
busy.
-SCHED_PACKING_FULL: we pack tasks at wake up until a CPU becomes full. During
a fork or a exec, we assume that the new task is a full running one and we
look for an idle CPU close to the buddy CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |   47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 98166aa..874f330 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3259,13 +3259,16 @@ static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		  int this_cpu, int load_idx)
 {
-	struct sched_group *idlest = NULL, *group = sd->groups;
+	struct sched_group *idlest = NULL, *group = sd->groups, *buddy = NULL;
 	unsigned long min_load = ULONG_MAX, this_load = 0;
 	int imbalance = 100 + (sd->imbalance_pct-100)/2;
+	int buddy_cpu = per_cpu(sd_pack_buddy, this_cpu);
+	int get_buddy = ((sysctl_sched_packing_mode == SCHED_PACKING_FULL) &&
+		!(sd->flags & SD_SHARE_POWERDOMAIN) && (buddy_cpu != -1));
 
 	do {
 		unsigned long load, avg_load;
-		int local_group;
+		int local_group, buddy_group = 0;
 		int i;
 
 		/* Skip over this group if it has no CPUs allowed */
@@ -3276,6 +3279,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_cpus(group));
 
+		if (get_buddy) {
+			buddy_group = cpumask_test_cpu(buddy_cpu,
+						sched_group_cpus(group));
+		}
+
 		/* Tally up the load of all CPUs in the group */
 		avg_load = 0;
 
@@ -3287,6 +3295,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 				load = target_load(i, load_idx);
 
 			avg_load += load;
+
+			if ((buddy_group) && idle_cpu(i))
+				buddy = group;
 		}
 
 		/* Adjust by relative CPU power of the group */
@@ -3300,6 +3311,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		}
 	} while (group = group->next, group != sd->groups);
 
+	if (buddy)
+		return buddy;
+
 	if (!idlest || 100*this_load < imbalance*min_load)
 		return NULL;
 	return idlest;
@@ -3402,6 +3416,21 @@ static bool is_buddy_busy(int cpu)
 	return (sum > (period / (rq->nr_running + 2)));
 }
 
+static bool is_buddy_full(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	u32 sum = rq->avg.runnable_avg_sum;
+	u32 period = rq->avg.runnable_avg_period;
+
+	sum = min(sum, period);
+
+	/*
+	 * A full buddy is a CPU with a sum greater or equal to period
+	 * We keep a margin of 2.4%
+	 */
+	return (sum * 1024 >= period * 1000);
+}
+
 static bool is_light_task(struct task_struct *p)
 {
 	/* A light task runs less than 20% in average */
@@ -3413,6 +3442,9 @@ static int check_pack_buddy(int cpu, struct task_struct *p)
 {
 	int buddy = per_cpu(sd_pack_buddy, cpu);
 
+	if (sysctl_sched_packing_mode == SCHED_PACKING_NONE)
+		return false;
+
 	/* No pack buddy for this CPU */
 	if (buddy == -1)
 		return false;
@@ -3421,14 +3453,19 @@ static int check_pack_buddy(int cpu, struct task_struct *p)
 	if (!cpumask_test_cpu(buddy, tsk_cpus_allowed(p)))
 		return false;
 
+	/* We agressively pack at wake up */
+	if ((sysctl_sched_packing_mode == SCHED_PACKING_FULL)
+	 && !is_buddy_full(buddy))
+		return true;
 	/*
 	 * If the task is a small one and the buddy is not overloaded,
 	 * we use buddy cpu
 	 */
-	if (!is_light_task(p) || is_buddy_busy(buddy))
-		return false;
+	if (is_light_task(p) && !is_buddy_busy(buddy))
+		return true;
+
+	return false;
 
-	return true;
 }
 
 /*
-- 
1.7.9.5
