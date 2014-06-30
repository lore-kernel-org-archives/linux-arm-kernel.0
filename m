From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 30 Jun 2014 18:05:32 +0200
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imbalance flag can stay set whereas there is no imbalance.

Let assume that we have 3 tasks that run on a dual cores /dual cluster system.
We will have some idle load balance which are triggered during tick.
Unfortunately, the tick is also used to queue background work so we can reach
the situation where short work has been queued on a CPU which already runs a
task. The load balance will detect this imbalance (2 tasks on 1 CPU and an idle
CPU) and will try to pull the waiting task on the idle CPU. The waiting task is
a worker thread that is pinned on a CPU so an imbalance due to pinned task is
detected and the imbalance flag is set.
Then, we will not be able to clear the flag because we have at most 1 task on
each CPU but the imbalance flag will trig to useless active load balance
between the idle CPU and the busy CPU.

We need to reset of the imbalance flag as soon as we have reached a balanced
state.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3c73122..0c48dff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6615,10 +6615,8 @@ more_balance:
 		if (sd_parent) {
 			int *group_imbalance = &sd_parent->groups->sgc->imbalance;
 
-			if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0) {
+			if ((env.flags & LBF_SOME_PINNED) && env.imbalance > 0)
 				*group_imbalance = 1;
-			} else if (*group_imbalance)
-				*group_imbalance = 0;
 		}
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
@@ -6703,6 +6701,16 @@ more_balance:
 	goto out;
 
 out_balanced:
+	/*
+	 * We reach balance although we may have faced some affinity
+	 * constraints. Clear the imbalance flag if it was set.
+	 */
+	if (sd_parent) {
+		int *group_imbalance = &sd_parent->groups->sgc->imbalance;
+		if (*group_imbalance)
+			*group_imbalance = 0;
+	}
+
 	schedstat_inc(sd, lb_balanced[idle]);
 
 	sd->nr_balance_failed = 0;
-- 
1.9.1
