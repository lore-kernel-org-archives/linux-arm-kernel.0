From: hs.liao@mediatek.com (HS Liao)
Date: Wed, 24 Aug 2016 11:27:32 +0800
Subject: [PATCH v13 4/4] CMDQ: save more energy in idle
In-Reply-To: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
References: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1472009252-1074-5-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_disable_unprepare instead of clk_disable to save more energy
when CMDQ is idle.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq.c | 54 +++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
index 7ca3113..a0fcbef 100644
--- a/drivers/soc/mediatek/mtk-cmdq.c
+++ b/drivers/soc/mediatek/mtk-cmdq.c
@@ -28,6 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <soc/mediatek/cmdq.h>
 
 #define CMDQ_THR_MAX_COUNT		3 /* main, sub, general(misc) */
@@ -128,10 +129,16 @@ struct cmdq_task {
 	struct cmdq_task_cb	cb;
 };
 
+struct cmdq_clk_release {
+	struct cmdq		*cmdq;
+	struct work_struct	release_work;
+};
+
 struct cmdq {
 	struct mbox_controller	mbox;
 	void __iomem		*base;
 	u32			irq;
+	struct workqueue_struct	*clk_release_wq;
 	struct cmdq_thread	thread[CMDQ_THR_MAX_COUNT];
 	struct mutex		task_mutex;
 	struct clk		*clock;
@@ -297,11 +304,19 @@ static void cmdq_thread_wait_end(struct cmdq_thread *thread,
 static void cmdq_task_exec(struct cmdq_task *task, struct cmdq_thread *thread)
 {
 	struct cmdq *cmdq = task->cmdq;
-	unsigned long curr_pa, end_pa;
+	unsigned long curr_pa, end_pa, flags;
 
 	task->thread = thread;
 	if (list_empty(&thread->task_busy_list)) {
-		WARN_ON(clk_enable(cmdq->clock) < 0);
+		/*
+		 * Unlock for clk prepare (sleeping function).
+		 * We are safe to do that since we have task_mutex and
+		 * only flush will add task.
+		 */
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+		WARN_ON(clk_prepare_enable(cmdq->clock) < 0);
+		spin_lock_irqsave(&thread->chan->lock, flags);
+
 		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
 
 		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
@@ -383,6 +398,26 @@ static void cmdq_task_handle_error(struct cmdq_task *task)
 	cmdq_thread_resume(thread);
 }
 
+static void cmdq_clk_release_work(struct work_struct *work_item)
+{
+	struct cmdq_clk_release *clk_release = container_of(work_item,
+			struct cmdq_clk_release, release_work);
+	struct cmdq *cmdq = clk_release->cmdq;
+
+	clk_disable_unprepare(cmdq->clock);
+	kfree(clk_release);
+}
+
+static void cmdq_clk_release_schedule(struct cmdq *cmdq)
+{
+	struct cmdq_clk_release *clk_release;
+
+	clk_release = kmalloc(sizeof(*clk_release), GFP_ATOMIC);
+	clk_release->cmdq = cmdq;
+	INIT_WORK(&clk_release->release_work, cmdq_clk_release_work);
+	queue_work(cmdq->clk_release_wq, &clk_release->release_work);
+}
+
 static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 				    struct cmdq_thread *thread)
 {
@@ -432,7 +467,7 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	if (list_empty(&thread->task_busy_list)) {
 		cmdq_thread_disable(cmdq, thread);
-		clk_disable(cmdq->clock);
+		cmdq_clk_release_schedule(cmdq);
 	} else {
 		mod_timer(&thread->timeout,
 			  jiffies + msecs_to_jiffies(CMDQ_TIMEOUT_MS));
@@ -491,7 +526,7 @@ static void cmdq_thread_handle_timeout(unsigned long data)
 
 	cmdq_thread_resume(thread);
 	cmdq_thread_disable(cmdq, thread);
-	clk_disable(cmdq->clock);
+	cmdq_clk_release_schedule(cmdq);
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 }
 
@@ -779,7 +814,7 @@ static int cmdq_suspend(struct device *dev)
 		msleep(20);
 	}
 
-	clk_unprepare(cmdq->clock);
+	flush_workqueue(cmdq->clk_release_wq);
 	return 0;
 }
 
@@ -787,7 +822,6 @@ static int cmdq_resume(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 
-	WARN_ON(clk_prepare(cmdq->clock) < 0);
 	cmdq->suspended = false;
 	return 0;
 }
@@ -796,8 +830,8 @@ static int cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
+	destroy_workqueue(cmdq->clk_release_wq);
 	mbox_controller_unregister(&cmdq->mbox);
-	clk_unprepare(cmdq->clock);
 	return 0;
 }
 
@@ -916,8 +950,12 @@ static int cmdq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	cmdq->clk_release_wq = alloc_ordered_workqueue(
+			"%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
+			"cmdq_clk_release");
+
 	platform_set_drvdata(pdev, cmdq);
-	WARN_ON(clk_prepare(cmdq->clock) < 0);
+
 	return 0;
 }
 
-- 
1.9.1
