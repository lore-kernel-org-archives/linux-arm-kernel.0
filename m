From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 25 Apr 2013 19:23:29 +0200
Subject: [PATCH 13/14] sched: update the cpu_power
In-Reply-To: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1366910611-20048-14-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu_power is updated for CPUs that don't participate to the packing
effort. We consider that their cpu_power is allocated to idleness as it could
be allocated by rt. So the cpu_power that remains available for cfs, is set to
min value (i.e. 1)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 756b1e3..54c1541 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -224,12 +224,12 @@ void update_packing_domain(int cpu)
 
 		/* loop the sched groups to find the best one */
 		for (tmp = sg->next; tmp != sg; tmp = tmp->next) {
-			if (tmp->sgp->power * pack->group_weight >
-					pack->sgp->power * tmp->group_weight)
+			if (tmp->sgp->power_available * pack->group_weight >
+				pack->sgp->power_available * tmp->group_weight)
 				continue;
 
-			if ((tmp->sgp->power * pack->group_weight ==
-					pack->sgp->power * tmp->group_weight)
+			if ((tmp->sgp->power_available * pack->group_weight ==
+				pack->sgp->power_available * tmp->group_weight)
 			 && (cpumask_first(sched_group_cpus(tmp)) >= id))
 				continue;
 
@@ -269,12 +269,12 @@ void update_packing_buddy(int cpu, int activity)
 
 	/* loop the sched groups to find the best one */
 	for (tmp = sg->next; tmp != sg; tmp = tmp->next) {
-		if ((tmp->sgp->power * pack->group_weight) >
+		if ((tmp->sgp->power_available * pack->group_weight) >
 			(pack->sgp->power_available * tmp->group_weight))
 			continue;
 
-		if (((tmp->sgp->power * pack->group_weight) ==
-			 (pack->sgp->power * tmp->group_weight))
+		if (((tmp->sgp->power_available * pack->group_weight) ==
+			 (pack->sgp->power_available * tmp->group_weight))
 		 && (cpumask_first(sched_group_cpus(tmp)) >= id))
 			continue;
 
@@ -285,20 +285,20 @@ void update_packing_buddy(int cpu, int activity)
 		id = cpumask_first(sched_group_cpus(pack));
 	}
 
-	if ((cpu == id) || (activity <= power_of(id))) {
+	if ((cpu == id) || (activity <= available_of(id))) {
 		per_cpu(sd_pack_buddy, cpu) = id;
 		return;
 	}
 
 	for (tmp = pack; activity > 0; tmp = tmp->next) {
-		if (tmp->sgp->power > activity) {
+		if (tmp->sgp->power_available > activity) {
 			id = cpumask_first(sched_group_cpus(tmp));
-			activity -= power_of(id);
+			activity -= available_of(id);
 			if (cpu == id)
 				activity = 0;
 			while ((activity > 0) && (id < nr_cpu_ids)) {
 				id = cpumask_next(id, sched_group_cpus(tmp));
-				activity -= power_of(id);
+				activity -= available_of(id);
 				if (cpu == id)
 					activity = 0;
 			}
@@ -306,7 +306,7 @@ void update_packing_buddy(int cpu, int activity)
 			id = cpu;
 			activity = 0;
 		} else {
-			activity -= tmp->sgp->power;
+			activity -= tmp->sgp->power_available;
 		}
 	}
 
@@ -3369,7 +3369,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		}
 
 		/* Adjust by relative CPU power of the group */
-		avg_load = (avg_load * SCHED_POWER_SCALE) / group->sgp->power;
+		avg_load = (avg_load * SCHED_POWER_SCALE)
+				/ group->sgp->power_available;
 
 		if (local_group) {
 			this_load = avg_load;
@@ -3551,10 +3552,10 @@ static int get_cpu_activity(int cpu)
 
 	if (sum == period) {
 		u32 overload = rq->nr_running > 1 ? 1 : 0;
-		return power_of(cpu) + overload;
+		return available_of(cpu) + overload;
 	}
 
-	return (sum * power_of(cpu)) / period;
+	return (sum * available_of(cpu)) / period;
 }
 
 /*
@@ -4596,8 +4597,12 @@ static void update_cpu_power(struct sched_domain *sd, int cpu)
 	cpu_rq(cpu)->cpu_available = power;
 	sdg->sgp->power_available = power;
 
+	if (!is_my_buddy(cpu, cpu))
+		power = 1;
+
 	cpu_rq(cpu)->cpu_power = power;
 	sdg->sgp->power = power;
+
 }
 
 void update_group_power(struct sched_domain *sd, int cpu)
-- 
1.7.9.5
