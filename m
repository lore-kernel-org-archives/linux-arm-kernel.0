From: roger.lu@mediatek.com (Roger Lu)
Date: Fri, 1 Jul 2016 11:05:02 +0800
Subject: [PATCH v2] PM / suspend: show workqueue state in suspend flow
Message-ID: <1467342302-16129-1-git-send-email-roger.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If freezable workqueue aborts suspend flow, show
workqueue state for debug purpose.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
Changes in v2:
- remove prints in show_workqueue_state().
---
 kernel/power/process.c | 3 +++
 kernel/workqueue.c     | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index df058be..6eef250 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -89,6 +89,9 @@ static int try_to_freeze_tasks(bool user_only)
 		       elapsed_msecs / 1000, elapsed_msecs % 1000,
 		       todo - wq_busy, wq_busy);
 
+		if (wq_busy)
+			show_workqueue_state();
+
 		if (!wakeup) {
 			read_lock(&tasklist_lock);
 			for_each_process_thread(g, p) {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e1c0e99..619e80c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4369,8 +4369,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 /**
  * show_workqueue_state - dump workqueue state
  *
- * Called from a sysrq handler and prints out all busy workqueues and
- * pools.
+ * Called from a sysrq handler or try_to_freeze_tasks() and prints out
+ * all busy workqueues and pools.
  */
 void show_workqueue_state(void)
 {
-- 
2.6.4
