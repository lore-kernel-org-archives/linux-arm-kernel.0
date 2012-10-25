From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:55:14 +0530
Subject: [RFC PATCH 03/13] sched:Decide whether there be transfer of loads
 based on the PJT's metric
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102513.21022.10437.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additional parameters relevant to sched group load balancing statistics and
sched domain's load balancing statistics which are calculated using the per
entity load tracking are used.

The intention is to begin to use PJT's metric in the first level of load
balancing to see if the current sched group is capable of pulling tasks upon itself.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aafa3c1..67a916d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4157,12 +4157,16 @@ struct sd_lb_stats {
 	struct sched_group *busiest; /* Busiest group in this sd */
 	struct sched_group *this;  /* Local group in this sd */
 	unsigned long total_load;  /* Total load of all groups in sd */
+	u64 total_sgs_load;	 /* Equivalent to total_load except using PJT's metrics */
 	unsigned long total_pwr;   /*	Total power of all groups in sd */
 	unsigned long avg_load;	   /* Average load across all groups in sd */
+	u64 avg_sgs_load;	  /* Equivalent to avg_load but calculated with PJT's metrics */
 
 	/** Statistics of this group */
 	unsigned long this_load;
+	u64 this_sg_load;	/* Equivalent to this_load but calculated using PJT's metric*/
 	unsigned long this_load_per_task;
+	u64 this_sg_load_per_task; /* Equivalent to this_load_per_task but using PJT's metric*/
 	unsigned long this_nr_running;
 	unsigned long this_has_capacity;
 	unsigned int  this_idle_cpus;
@@ -4170,8 +4174,9 @@ struct sd_lb_stats {
 	/* Statistics of the busiest group */
 	unsigned int  busiest_idle_cpus;
 	unsigned long max_load;
-	u64 max_sg_load; /* Equivalent of max_load but calculated using pjt's metric*/
+	u64 max_sg_load; /* Equivalent of max_load but calculated using PJT's metric*/
 	unsigned long busiest_load_per_task;
+	u64 busiest_sg_load_per_task; /*Equivalent of busiest_load_per_task but using PJT's metric*/
 	unsigned long busiest_nr_running;
 	unsigned long busiest_group_capacity;
 	unsigned long busiest_has_capacity;
@@ -4192,6 +4197,7 @@ struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	u64 avg_cfs_runnable_load; /* Equivalent of avg_load but calculated using PJT's metric */
 	unsigned long group_load; /* Total load over the CPUs of the group */
+	u64 group_cfs_runnable_load; /* Equivalent of group_load but calculated using PJT's metric */
 	unsigned long sum_nr_running; /* Nr tasks running in the group */
 	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
 	unsigned long group_capacity;
@@ -4507,7 +4513,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	unsigned long load, max_cpu_load, min_cpu_load;
 	unsigned int balance_cpu = -1, first_idle_cpu = 0;
 	unsigned long avg_load_per_task = 0;
-	u64 group_load = 0; /* computed using PJT's metric */
 	int i;
 
 	if (local_group)
@@ -4552,7 +4557,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (idle_cpu(i))
 			sgs->idle_cpus++;
 
-		group_load += cpu_rq(i)->cfs.runnable_load_avg;
+		/* Tracking load using PJT's metric */
+		sgs->group_cfs_runnable_load += cpu_rq(i)->cfs.runnable_load_avg;
 		update_sg_numa_stats(sgs, rq);
 	}
 
@@ -4585,8 +4591,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	 *
 	 * The below condition is included as a tunable to meet performance and power needs
 	 */
-	sgs->avg_cfs_runnable_load = (group_load * SCHED_POWER_SCALE) / group->sgp->power;
-	if (sgs->avg_cfs_runnable_load <= 1178 && sgs->sum_nr_running <= 2)
+	sgs->avg_cfs_runnable_load = (sgs->group_cfs_runnable_load * SCHED_POWER_SCALE) / group->sgp->power;
+	if (sgs->avg_cfs_runnable_load <= 1178 && sgs->sum_nr_running <= 2 && !local_group)
 		sgs->avg_cfs_runnable_load = 0;
 
 	/*
@@ -4702,6 +4708,8 @@ static inline void update_sd_lb_stats(struct lb_env *env,
 			return;
 
 		sds->total_load += sgs.group_load;
+		/* Tracking load using PJT's metrics */
+		sds->total_sgs_load += sgs.group_cfs_runnable_load;
 		sds->total_pwr += sg->sgp->power;
 
 		/*
@@ -4719,9 +4727,11 @@ static inline void update_sd_lb_stats(struct lb_env *env,
 
 		if (local_group) {
 			sds->this_load = sgs.avg_load;
+			sds->this_sg_load = sgs.avg_cfs_runnable_load;
 			sds->this = sg;
 			sds->this_nr_running = sgs.sum_nr_running;
 			sds->this_load_per_task = sgs.sum_weighted_load;
+			sds->this_sg_load_per_task = sgs.group_cfs_runnable_load;
 			sds->this_has_capacity = sgs.group_has_capacity;
 			sds->this_idle_cpus = sgs.idle_cpus;
 		} else if (update_sd_pick_busiest(env, sds, sg, &sgs)) {
@@ -4732,6 +4742,7 @@ static inline void update_sd_lb_stats(struct lb_env *env,
 			sds->busiest_idle_cpus = sgs.idle_cpus;
 			sds->busiest_group_capacity = sgs.group_capacity;
 			sds->busiest_load_per_task = sgs.sum_weighted_load;
+			sds->busiest_sg_load_per_task = sgs.group_cfs_runnable_load;
 			sds->busiest_has_capacity = sgs.group_has_capacity;
 			sds->busiest_group_weight = sgs.group_weight;
 			sds->group_imb = sgs.group_imb;
@@ -4972,6 +4983,7 @@ find_busiest_group(struct lb_env *env, int *balance)
 		goto out_balanced;
 
 	sds.avg_load = (SCHED_POWER_SCALE * sds.total_load) / sds.total_pwr;
+	sds.avg_sgs_load = (SCHED_POWER_SCALE * sds.total_sgs_load) / sds.total_pwr;
 
 	/*
 	 * If the busiest group is imbalanced the below checks don't
@@ -4990,14 +5002,16 @@ find_busiest_group(struct lb_env *env, int *balance)
 	 * If the local group is more busy than the selected busiest group
 	 * don't try and pull any tasks.
 	 */
-	if (sds.this_load >= sds.max_load)
+	/* The following metrics has been changed to test PJT's metric */
+	if (sds.this_sg_load >= sds.max_sg_load)
 		goto out_balanced;
 
 	/*
 	 * Don't pull any tasks if this group is already above the domain
 	 * average load.
 	 */
-	if (sds.this_load >= sds.avg_load)
+	/* The following metrics has been changed to test PJT's metric */
+	if (sds.this_sg_load >= sds.avg_sgs_load)
 		goto out_balanced;
 
 	if (env->idle == CPU_IDLE) {
@@ -5015,7 +5029,10 @@ find_busiest_group(struct lb_env *env, int *balance)
 		 * In the CPU_NEWLY_IDLE, CPU_NOT_IDLE cases, use
 		 * imbalance_pct to be conservative.
 		 */
-		if (100 * sds.max_load <= env->sd->imbalance_pct * sds.this_load)
+		/* The following metrics has been changed to test PJT's
+		 * metric
+		 */
+		if (100 * sds.max_sg_load <= env->sd->imbalance_pct * sds.this_sg_load)
 			goto out_balanced;
 	}
 
