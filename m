From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Aug 2014 13:06:50 +0200
Subject: [PATCH v5 07/12] sched: test the cpu's capacity in wake affine
In-Reply-To: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1409051215-16788-8-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the task always wakes affine on this_cpu if the latter is idle.
Before waking up the task on this_cpu, we check that this_cpu capacity is not
significantly reduced because of RT tasks or irq activity.

Use case where the number of irq and/or the time spent under irq is important
will take benefit of this because the task that is woken up by irq or softirq
will not use the same CPU than irq (and softirq) but a idle one.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 17c16cc..18db43e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4281,6 +4281,7 @@ static int wake_wide(struct task_struct *p)
 static int wake_affine(struct sched_domain *sd, struct task_struct *p, int sync)
 {
 	s64 this_load, load;
+	s64 this_eff_load, prev_eff_load;
 	int idx, this_cpu, prev_cpu;
 	struct task_group *tg;
 	unsigned long weight;
@@ -4324,21 +4325,21 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p, int sync)
 	 * Otherwise check if either cpus are near enough in load to allow this
 	 * task to be woken on this_cpu.
 	 */
-	if (this_load > 0) {
-		s64 this_eff_load, prev_eff_load;
+	this_eff_load = 100;
+	this_eff_load *= capacity_of(prev_cpu);
+
+	prev_eff_load = 100 + (sd->imbalance_pct - 100) / 2;
+	prev_eff_load *= capacity_of(this_cpu);
 
-		this_eff_load = 100;
-		this_eff_load *= capacity_of(prev_cpu);
+	if (this_load > 0) {
 		this_eff_load *= this_load +
 			effective_load(tg, this_cpu, weight, weight);
 
-		prev_eff_load = 100 + (sd->imbalance_pct - 100) / 2;
-		prev_eff_load *= capacity_of(this_cpu);
 		prev_eff_load *= load + effective_load(tg, prev_cpu, 0, weight);
+	}
+
+	balanced = this_eff_load <= prev_eff_load;
 
-		balanced = this_eff_load <= prev_eff_load;
-	} else
-		balanced = true;
 	schedstat_inc(p, se.statistics.nr_wakeups_affine_attempts);
 
 	if (!balanced)
-- 
1.9.1
