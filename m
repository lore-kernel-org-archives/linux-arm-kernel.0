From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 25 Apr 2013 19:23:30 +0200
Subject: [PATCH 14/14] sched: force migration on buddy CPU
In-Reply-To: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1366910611-20048-15-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a CPU that doesn't participate to the packing effort, has at least one
running task, it means that its group is imbalanced and the CPUs can pull this
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54c1541..f87aed2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4729,6 +4729,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				max_nr_running = nr_running;
 			if (min_nr_running > nr_running)
 				min_nr_running = nr_running;
+
+			if (!is_my_buddy(i, i) && nr_running > 0)
+				sgs->group_imb = 1;
 		}
 
 		sgs->group_load += load;
-- 
1.7.9.5
