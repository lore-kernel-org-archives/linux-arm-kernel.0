From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:10:06 +0530
Subject: [PATCH v6 13/46] sched/migration: Use raw_spin_lock/unlock since
 interrupts are already disabled
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124006.26245.88872.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need not use the raw_spin_lock_irqsave/restore primitives because
all CPU_DYING notifiers run with interrupts disabled. So just use
raw_spin_lock/unlock.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ead8af6..71741d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4870,9 +4870,7 @@ static void calc_load_migrate(struct rq *rq)
  * Migrate all tasks from the rq, sleeping tasks will be migrated by
  * try_to_wake_up()->select_task_rq().
  *
- * Called with rq->lock held even though we'er in stop_machine() and
- * there's no concurrency possible, we hold the required locks anyway
- * because of lock validation efforts.
+ * Called with rq->lock held.
  */
 static void migrate_tasks(unsigned int dead_cpu)
 {
@@ -4884,8 +4882,8 @@ static void migrate_tasks(unsigned int dead_cpu)
 	 * Fudge the rq selection such that the below task selection loop
 	 * doesn't get stuck on the currently eligible stop task.
 	 *
-	 * We're currently inside stop_machine() and the rq is either stuck
-	 * in the stop_machine_cpu_stop() loop, or we're executing this code,
+	 * We're currently inside stop_one_cpu() and the rq is either stuck
+	 * in the cpu_stopper_thread(), or we're executing this code,
 	 * either way we should never end up calling schedule() until we're
 	 * done here.
 	 */
@@ -5154,14 +5152,14 @@ migration_call(struct notifier_block *nfb, unsigned long action, void *hcpu)
 	case CPU_DYING:
 		sched_ttwu_pending();
 		/* Update our root-domain */
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_lock(&rq->lock); /* Interrupts already disabled */
 		if (rq->rd) {
 			BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 			set_rq_offline(rq);
 		}
 		migrate_tasks(cpu);
 		BUG_ON(rq->nr_running != 1); /* the migration thread */
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_unlock(&rq->lock);
 		break;
 
 	case CPU_DEAD:
