From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 28 Jul 2014 19:51:37 +0200
Subject: [PATCH v4 03/12] sched: fix avg_load computation
In-Reply-To: <1406569906-9763-1-git-send-email-vincent.guittot@linaro.org>
References: <1406569906-9763-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1406569906-9763-4-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The computation of avg_load and avg_load_per_task should only takes into
account the number of cfs tasks. The non cfs task are already taken into
account by decreasing the cpu's capacity and they will be tracked in the
CPU's utilization (group_utilization) of the next patches

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57f8d8c..647d0a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4095,7 +4095,7 @@ static unsigned long capacity_of(int cpu)
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long nr_running = ACCESS_ONCE(rq->nr_running);
+	unsigned long nr_running = ACCESS_ONCE(rq->cfs.h_nr_running);
 	unsigned long load_avg = rq->cfs.runnable_load_avg;
 
 	if (nr_running)
@@ -5909,7 +5909,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
-		sgs->sum_nr_running += rq->nr_running;
+		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		if (rq->nr_running > 1)
 			*overload = true;
-- 
1.9.1
