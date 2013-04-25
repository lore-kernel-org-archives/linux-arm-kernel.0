From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 25 Apr 2013 19:23:27 +0200
Subject: [PATCH 11/14] sched: filter task pull request
In-Reply-To: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1366910611-20048-12-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only CPUs that participates to the packing effort can pull tasks on a busiest
group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28f8ea7..6f63fb9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3494,6 +3494,12 @@ static bool is_buddy_full(int cpu)
 	return (sum * 1024 >= period * 1000);
 }
 
+static bool is_my_buddy(int cpu, int buddy)
+{
+	int my_buddy = per_cpu(sd_pack_buddy, cpu);
+	return (my_buddy == -1) || (buddy == my_buddy);
+}
+
 static bool is_light_task(struct task_struct *p)
 {
 	/* A light task runs less than 20% in average */
@@ -4688,8 +4694,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		/* Bias balancing toward cpus of our domain */
 		if (local_group) {
-			if (idle_cpu(i) && !first_idle_cpu &&
-					cpumask_test_cpu(i, sched_group_mask(group))) {
+			if (is_my_buddy(i, i) && idle_cpu(i) && !first_idle_cpu
+			 && cpumask_test_cpu(i, sched_group_mask(group))) {
 				first_idle_cpu = 1;
 				balance_cpu = i;
 			}
@@ -4817,6 +4823,10 @@ static void update_plb_buddy(int cpu, int *balance, struct sd_lb_stats *sds,
 
 	/* Get my new buddy */
 	buddy = per_cpu(sd_pack_buddy, cpu);
+
+	/* This CPU doesn't act for agressive packing */
+	if (buddy != cpu)
+		sds->busiest = 0;
 }
 
 /**
-- 
1.7.9.5
