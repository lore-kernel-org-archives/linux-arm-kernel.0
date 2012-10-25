From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:55:03 +0530
Subject: [RFC PATCH 02/13] sched:Pick the apt busy sched group during load
 balancing
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102503.21022.35291.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a sched group has passed the test for sufficient load in
update_sg_lb_stats,to qualify for load balancing,then PJT's
metrics has to be used to qualify the right sched group as the busiest group.

The scenario which led to this patch is shown below:
Consider Task1 and Task2 to be a long running task
and Tasks 3,4,5,6 to be short running tasks

			Task3
			Task4
Task1			Task5
Task2			Task6
------			------
SCHED_GRP1		SCHED_GRP2

Normal load calculator would qualify SCHED_GRP2 as
the candidate for sd->busiest due to the following loads
that it calculates.

SCHED_GRP1:2048
SCHED_GRP2:4096

Load calculator would probably qualify SCHED_GRP1 as the candidate
for sd->busiest due to the following loads that it calculates

SCHED_GRP1:3200
SCHED_GRP2:1156

This patch aims to strike a balance between the loads of the
group and the number of tasks running on the group to decide the
busiest group in the sched_domain.

This means we will need to use the PJT's metrics but with an
additional constraint.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e02dad4..aafa3c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -165,7 +165,8 @@ void sched_init_granularity(void)
 #else
 # define WMULT_CONST	(1UL << 32)
 #endif
-
+#define NR_THRESHOLD 2
+#define LOAD_THRESHOLD 1
 #define WMULT_SHIFT	32
 
 /*
@@ -4169,6 +4170,7 @@ struct sd_lb_stats {
 	/* Statistics of the busiest group */
 	unsigned int  busiest_idle_cpus;
 	unsigned long max_load;
+	u64 max_sg_load; /* Equivalent of max_load but calculated using pjt's metric*/
 	unsigned long busiest_load_per_task;
 	unsigned long busiest_nr_running;
 	unsigned long busiest_group_capacity;
@@ -4628,8 +4630,24 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 				   struct sched_group *sg,
 				   struct sg_lb_stats *sgs)
 {
-	if (sgs->avg_load <= sds->max_load)
-		return false;
+	/* Use PJT's metrics to qualify a sched_group as busy
+ 	 *
+ 	 * But a low load sched group may be queueing up many tasks
+ 	 * So before dismissing a sched group with lesser load,ensure
+ 	 * that the number of processes on it is checked if it is
+ 	 * not too less loaded than the max load so far
+ 	 *
+ 	 * But as of now as LOAD_THRESHOLD is 1,this check is a nop.
+ 	 * But we could vary LOAD_THRESHOLD suitably to bring in this check
+ 	 */
+	if (sgs->avg_cfs_runnable_load <= sds->max_sg_load) {
+		if (sgs->avg_cfs_runnable_load > LOAD_THRESHOLD * sds->max_sg_load) {
+			if (sgs->sum_nr_running <= (NR_THRESHOLD + sds->busiest_nr_running))
+				return false;
+		} else {
+			return false;
+		}
+	}
 
 	if (sgs->sum_nr_running > sgs->group_capacity)
 		return true;
@@ -4708,6 +4726,7 @@ static inline void update_sd_lb_stats(struct lb_env *env,
 			sds->this_idle_cpus = sgs.idle_cpus;
 		} else if (update_sd_pick_busiest(env, sds, sg, &sgs)) {
 			sds->max_load = sgs.avg_load;
+			sds->max_sg_load = sgs.avg_cfs_runnable_load;
 			sds->busiest = sg;
 			sds->busiest_nr_running = sgs.sum_nr_running;
 			sds->busiest_idle_cpus = sgs.idle_cpus;
