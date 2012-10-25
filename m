From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:55:38 +0530
Subject: [RFC PATCH 06/13] sched: Changing find_busiest_queue to use PJT's
 metric
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102537.21022.522.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additional parameters which decide the busiest cpu in the chosen sched group
calculated using PJT's metric are used

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fca6606..bb1c71b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5085,7 +5085,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 				     struct sched_group *group)
 {
 	struct rq *busiest = NULL, *rq;
-	unsigned long max_load = 0;
+	u64 max_cpu_load = 0;
 	int i;
 
 	for_each_cpu(i, sched_group_cpus(group)) {
@@ -5093,6 +5093,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		unsigned long capacity = DIV_ROUND_CLOSEST(power,
 							   SCHED_POWER_SCALE);
 		unsigned long wl;
+		u64 runnable_load;/* Equivalent of wl,calculated using PJT's metric */
 
 		if (!capacity)
 			capacity = fix_small_capacity(env->sd, group);
@@ -5102,12 +5103,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		rq = cpu_rq(i);
 		wl = weighted_cpuload(i);
+		runnable_load = cpu_rq(i)->cfs.runnable_load_avg;
 
 		/*
 		 * When comparing with imbalance, use weighted_cpuload()
 		 * which is not scaled with the cpu power.
+		 * The below decision is based on PJT's metric
 		 */
-		if (capacity && rq->nr_running == 1 && wl > env->imbalance)
+		if (capacity && rq->nr_running == 1 && runnable_load > env->load_imbalance)
 			continue;
 
 		/*
@@ -5117,9 +5120,11 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * running at a lower capacity.
 		 */
 		wl = (wl * SCHED_POWER_SCALE) / power;
+		runnable_load = (runnable_load * SCHED_POWER_SCALE) / power;
 
-		if (wl > max_load) {
-			max_load = wl;
+		/* Below decision has been changed to use PJT's metric */
+		if (runnable_load > max_cpu_load) {
+			max_cpu_load = runnable_load;
 			busiest = rq;
 		}
 	}
