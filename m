From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 31 Oct 2014 09:47:23 +0100
Subject: [PATCH v8 01/10] sched: add per rq cpu_capacity_orig
In-Reply-To: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1414745252-4895-2-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new field cpu_capacity_orig reflects the original capacity of a CPU
before being altered by rt tasks and/or IRQ

The cpu_capacity_orig will be used:
- to detect when the capacity of a CPU has been noticeably reduced so we can
  trig load balance to look for a CPU with better capacity. As an example, we
  can detect when a CPU handles a significant amount of irq
  (with CONFIG_IRQ_TIME_ACCOUNTING) but this CPU is seen as an idle CPU by
  scheduler whereas CPUs, which are really idle, are available.
- evaluate the available capacity for CFS tasks

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 8 +++++++-
 kernel/sched/sched.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c84bdc0..45ae52d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7087,7 +7087,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
-		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
 		rq->post_schedule = 0;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bd61cff..c3674da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4089,6 +4089,11 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
+static unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -5776,6 +5781,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 
 	capacity >>= SCHED_CAPACITY_SHIFT;
 
+	cpu_rq(cpu)->cpu_capacity_orig = capacity;
 	sdg->sgc->capacity_orig = capacity;
 
 	if (sched_feat(ARCH_CAPACITY))
@@ -5837,7 +5843,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			 * Runtime updates will correct capacity_orig.
 			 */
 			if (unlikely(!rq->sd)) {
-				capacity_orig += capacity_of(cpu);
+				capacity_orig += capacity_orig_of(cpu);
 				capacity += capacity_of(cpu);
 				continue;
 			}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6130251..12483d8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -579,6 +579,7 @@ struct rq {
 	struct sched_domain *sd;
 
 	unsigned long cpu_capacity;
+	unsigned long cpu_capacity_orig;
 
 	unsigned char idle_balance;
 	/* For active balancing */
-- 
1.9.1
