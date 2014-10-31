From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 31 Oct 2014 09:47:27 +0100
Subject: [PATCH v8 05/10] sched: Track group sched_entity usage contributions
In-Reply-To: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1414745252-4895-6-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

Adds usage contribution tracking for group entities. Unlike
se->avg.load_avg_contrib, se->avg.utilization_avg_contrib for group
entities is the sum of se->avg.utilization_avg_contrib for all entities on the
group runqueue. It is _not_ influenced in any way by the task group
h_load. Hence it is representing the actual cpu usage of the group, not
its intended load contribution which may differ significantly from the
utilization on lightly utilized systems.

cc: Paul Turner <pjt@google.com>
cc: Ben Segall <bsegall@google.com>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c | 2 ++
 kernel/sched/fair.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f384452..efb47ed 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -94,8 +94,10 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	P(se->load.weight);
 #ifdef CONFIG_SMP
 	P(se->avg.runnable_avg_sum);
+	P(se->avg.running_avg_sum);
 	P(se->avg.avg_period);
 	P(se->avg.load_avg_contrib);
+	P(se->avg.utilization_avg_contrib);
 	P(se->avg.decay_count);
 #endif
 #undef PN
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 36a882f..9ab5233 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2529,6 +2529,9 @@ static long __update_entity_utilization_avg_contrib(struct sched_entity *se)
 
 	if (entity_is_task(se))
 		__update_task_entity_utilization(se);
+	else
+		se->avg.utilization_avg_contrib =
+					group_cfs_rq(se)->utilization_load_avg;
 
 	return se->avg.utilization_avg_contrib - old_contrib;
 }
-- 
1.9.1
