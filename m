From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Sun,  7 Oct 2012 09:43:56 +0200
Subject: [RFC 4/6] sched: secure access to other CPU statistics
In-Reply-To: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
References: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1349595838-31274-5-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atomic update of runnable_avg_sum and runnable_avg_period are ensured
by their size and the toolchain. But we must ensure to not read an old value
for one field and a newly updated value for the other field. As we don't
want to lock other CPU while reading these fields, we read twice each fields
and check that no change have occured in the middle.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8c9d3ed..6df53b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3133,13 +3133,28 @@ static int select_idle_sibling(struct task_struct *p, int target)
 static inline bool is_buddy_busy(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
+	volatile u32 *psum = &rq->avg.runnable_avg_sum;
+	volatile u32 *pperiod = &rq->avg.runnable_avg_period;
+	u32 sum, new_sum, period, new_period;
+	int timeout = 10;
+
+	while (timeout) {
+		sum = *psum;
+		period = *pperiod;
+		new_sum = *psum;
+		new_period = *pperiod;
+
+		if ((sum == new_sum) && (period == new_period))
+			break;
+
+		timeout--;
+	}
 
 	/*
 	 * A busy buddy is a CPU with a high load or a small load with a lot of
 	 * running tasks.
 	 */
-	return ((rq->avg.usage_avg_sum << rq->nr_running) >
-			rq->avg.runnable_avg_period);
+	return ((new_sum << rq->nr_running) > new_period);
 }
 
 static inline bool is_light_task(struct task_struct *p)
-- 
1.7.9.5
