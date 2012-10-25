From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 25 Oct 2012 15:55:43 +0530
Subject: [RFC PATCH 07/13] sched: Change move_tasks to use PJT's metric
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <20121025102543.21022.97196.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make decisions based on PJT's metrics and the dependent metrics
about which tasks to move to reduce the imbalance.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bb1c71b..bd7b69d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3957,7 +3957,7 @@ static int move_tasks(struct lb_env *env)
 	unsigned long load;
 	int pulled = 0;
 
-	if (env->imbalance <= 0)
+	if (env->load_imbalance <= 0)
 		return 0;
 
 again:
@@ -3984,7 +3984,8 @@ again:
 		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
 			goto next;
 
-		if ((load / 2) > env->imbalance)
+		/* The below being changed to use the PJT's metric */
+		if ((load / 2) > env->load_imbalance)
 			goto next;
 
 		if (!can_migrate_task(p, env))
@@ -3992,7 +3993,8 @@ again:
 
 		move_task(p, env);
 		pulled++;
-		env->imbalance -= load;
+		/* Using PJT's metric */
+		env->load_imbalance -= load;
 
 #ifdef CONFIG_PREEMPT
 		/*
@@ -4007,8 +4009,9 @@ again:
 		/*
 		 * We only want to steal up to the prescribed amount of
 		 * weighted load.
+		 * But the below modification is to use PJT's metric
 		 */
-		if (env->imbalance <= 0)
+		if (env->load_imbalance <= 0)
 			goto out;
 
 		continue;
@@ -4145,7 +4148,8 @@ static inline void update_h_load(long cpu)
 
 static unsigned long task_h_load(struct task_struct *p)
 {
-	return p->se.load.weight;
+	/* The below is changed to use PJT's metric*/
+	return p->se.avg.load_avg_contrib;
 }
 #endif
 
