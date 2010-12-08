From: venki@google.com (Venkatesh Pallipadi)
Date: Wed,  8 Dec 2010 15:31:19 -0800
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <20101208142814.GE9777@n2100.arm.linux.org.uk>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
Message-ID: <1291851079-27061-1-git-send-email-venki@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I mentioned earlier in this thread, there are other places in
the scheduler, where we do curr_sched_clock - prev_sched_clock kind of math
in u64 and this 32 bit wraparound will cause problems there as well. Example-
accounting a big positive number as exec_time for some task. So, we
need a generic fix for sched_clock. This particular code happened to cause
an easy to notice failure.

Anyways, here's the patch that should resolve the wraparound problem with
this particular piece of code. I haven't been able to test this with latest
git as my test systems fail to boot with divide error in
select_task_rq_fair+0x5dd/0x70a
with vanilla git. Thats an unrelated bug that has been reported earlier.

I have only tested with older known to work kernel with this sched irq changes.

Peter: Also, this change will cause some conflict with pending IRQ time
reporting changeset. Let me know how you want to deal with this patch and that
pending patchset.

Thanks,
Venki

[PATCH] update_rq_clock() with irq_time should handle 64 bit wraparound

update_rq_clock with IRQ_TIME_ACCOUNTING assumed 64 bit sched_clock that
practically will not wraparound. Change to code to handle wraparounds,
still preventing rq->clock_task from going backwards.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 kernel/sched.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index dc91a4d..29ce549 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -636,21 +636,13 @@ static inline struct task_group *task_group(struct task_struct *p)
 
 #endif /* CONFIG_CGROUP_SCHED */
 
-static u64 irq_time_cpu(int cpu);
-static void sched_irq_time_avg_update(struct rq *rq, u64 irq_time);
+static void update_rq_clock_irqtime(struct rq *rq, int cpu);
 
 inline void update_rq_clock(struct rq *rq)
 {
 	if (!rq->skip_clock_update) {
 		int cpu = cpu_of(rq);
-		u64 irq_time;
-
-		rq->clock = sched_clock_cpu(cpu);
-		irq_time = irq_time_cpu(cpu);
-		if (rq->clock - irq_time > rq->clock_task)
-			rq->clock_task = rq->clock - irq_time;
-
-		sched_irq_time_avg_update(rq, irq_time);
+		update_rq_clock_irqtime(rq, cpu);
 	}
 }
 
@@ -1983,24 +1975,43 @@ void account_system_vtime(struct task_struct *curr)
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
 
-static void sched_irq_time_avg_update(struct rq *rq, u64 curr_irq_time)
+/*
+ * Update rq->clock_task making sure that it does not go backwards due to
+ * irq_time subtraction, allowing for possible wraparound.
+ */
+static void update_rq_clock_irqtime(struct rq *rq, int cpu)
 {
-	if (sched_clock_irqtime && sched_feat(NONIRQ_POWER)) {
-		u64 delta_irq = curr_irq_time - rq->prev_irq_time;
-		rq->prev_irq_time = curr_irq_time;
-		sched_rt_avg_update(rq, delta_irq);
+	u64 curr_rq_clock = sched_clock_cpu(cpu);
+	u64 curr_irq_time = irq_time_cpu(cpu);
+
+	if (!sched_clock_irqtime) {
+		rq->clock = sched_clock_cpu(cpu);
+		rq->clock_task = rq->clock;
+		return;
 	}
+
+	if (unlikely(curr_irq_time - rq->prev_irq_time >
+		     curr_rq_clock - rq->clock)) {
+		curr_irq_time = rq->prev_irq_time + curr_rq_clock - rq->clock;
+	}
+
+	rq->clock = curr_rq_clock;
+	rq->clock_task = rq->clock - curr_irq_time;
+
+	if (sched_feat(NONIRQ_POWER))
+		sched_rt_avg_update(rq, curr_irq_time - rq->prev_irq_time);
+
+	rq->prev_irq_time = curr_irq_time;
 }
 
 #else
 
-static u64 irq_time_cpu(int cpu)
+static void update_rq_clock_irqtime(struct rq *rq, int cpu)
 {
-	return 0;
+	rq->clock = sched_clock_cpu(cpu);
+	rq->clock_task = rq->clock;
 }
 
-static void sched_irq_time_avg_update(struct rq *rq, u64 curr_irq_time) { }
-
 #endif
 
 #include "sched_idletask.c"
-- 
1.7.3.1
