From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:56:00 +0530
Subject: [RFC PATCH 10/13] sched: Modify fix_small_imbalance to use PJT's
 metric
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102559.21022.88893.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additional parameters which aid in taking the decisions in
fix_small_imbalance which are calculated using PJT's metric are used.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   54 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b18f5f..a5affbc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2936,8 +2936,9 @@ static unsigned long cpu_avg_load_per_task(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long nr_running = ACCESS_ONCE(rq->nr_running);
 
-	if (nr_running)
+	if (nr_running) {
 		return rq->load.weight / nr_running;
+	}
 
 	return 0;
 }
@@ -4830,27 +4831,38 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 static inline
 void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	unsigned long tmp, pwr_now = 0, pwr_move = 0;
+	/* Parameters introduced to use PJT's metrics */
+	u64 tmp, pwr_now = 0, pwr_move = 0;
 	unsigned int imbn = 2;
 	unsigned long scaled_busy_load_per_task;
+	u64 scaled_busy_sg_load_per_task; /* Parameter to use PJT's metric */
+	unsigned long nr_running = ACCESS_ONCE(cpu_rq(env->dst_cpu)->nr_running);
 
 	if (sds->this_nr_running) {
-		sds->this_load_per_task /= sds->this_nr_running;
-		if (sds->busiest_load_per_task >
-				sds->this_load_per_task)
+		sds->this_sg_load_per_task /= sds->this_nr_running;
+		if (sds->busiest_sg_load_per_task >
+				sds->this_sg_load_per_task)
 			imbn = 1;
 	} else {
-		sds->this_load_per_task =
-			cpu_avg_load_per_task(env->dst_cpu);
+		if (nr_running) {
+			sds->this_sg_load_per_task =
+			/* The below decision based on PJT's metric */
+			cpu_rq(env->dst_cpu)->cfs.runnable_load_avg / nr_running;
+		} else {
+			sds->this_sg_load_per_task = 0;
+		}
 	}
 
 	scaled_busy_load_per_task = sds->busiest_load_per_task
 					 * SCHED_POWER_SCALE;
+	scaled_busy_sg_load_per_task = sds->busiest_sg_load_per_task
+					 * SCHED_POWER_SCALE;
 	scaled_busy_load_per_task /= sds->busiest->sgp->power;
+	scaled_busy_sg_load_per_task /= sds->busiest->sgp->power;
 
-	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >=
-			(scaled_busy_load_per_task * imbn)) {
-		env->imbalance = sds->busiest_load_per_task;
+	if (sds->max_sg_load - sds->this_sg_load + scaled_busy_sg_load_per_task >=
+			(scaled_busy_sg_load_per_task * imbn)) {
+		env->load_imbalance = sds->busiest_sg_load_per_task;
 		return;
 	}
 
@@ -4861,33 +4873,33 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	 */
 
 	pwr_now += sds->busiest->sgp->power *
-			min(sds->busiest_load_per_task, sds->max_load);
+			min(sds->busiest_sg_load_per_task, sds->max_sg_load);
 	pwr_now += sds->this->sgp->power *
-			min(sds->this_load_per_task, sds->this_load);
+			min(sds->this_sg_load_per_task, sds->this_sg_load);
 	pwr_now /= SCHED_POWER_SCALE;
 
 	/* Amount of load we'd subtract */
-	tmp = (sds->busiest_load_per_task * SCHED_POWER_SCALE) /
+	tmp = (sds->busiest_sg_load_per_task * SCHED_POWER_SCALE) /
 		sds->busiest->sgp->power;
-	if (sds->max_load > tmp)
+	if (sds->max_sg_load > tmp)
 		pwr_move += sds->busiest->sgp->power *
-			min(sds->busiest_load_per_task, sds->max_load - tmp);
+			min(sds->busiest_sg_load_per_task, sds->max_sg_load - tmp);
 
 	/* Amount of load we'd add */
-	if (sds->max_load * sds->busiest->sgp->power <
-		sds->busiest_load_per_task * SCHED_POWER_SCALE)
-		tmp = (sds->max_load * sds->busiest->sgp->power) /
+	if (sds->max_sg_load * sds->busiest->sgp->power <
+		sds->busiest_sg_load_per_task * SCHED_POWER_SCALE)
+		tmp = (sds->max_sg_load * sds->busiest->sgp->power) /
 			sds->this->sgp->power;
 	else
-		tmp = (sds->busiest_load_per_task * SCHED_POWER_SCALE) /
+		tmp = (sds->busiest_sg_load_per_task * SCHED_POWER_SCALE) /
 			sds->this->sgp->power;
 	pwr_move += sds->this->sgp->power *
-			min(sds->this_load_per_task, sds->this_load + tmp);
+			min(sds->this_sg_load_per_task, sds->this_sg_load + tmp);
 	pwr_move /= SCHED_POWER_SCALE;
 
 	/* Move if we gain throughput */
 	if (pwr_move > pwr_now)
-		env->imbalance = sds->busiest_load_per_task;
+		env->load_imbalance = sds->busiest_sg_load_per_task;
 }
 
 /**
