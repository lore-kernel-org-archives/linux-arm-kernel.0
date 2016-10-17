From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 17 Oct 2016 18:11:57 +0800
Subject: [PATCH v15 4/4] CMDQ: save energy
In-Reply-To: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
References: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1476699117-3001-5-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. take suspend/resume into consideration
2. use clk_disable_unprepare instead of clk_disable to save more energy
   when CMDQ is idle.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 94 +++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d086fd8..f235249 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -22,6 +22,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 
 #define CMDQ_THR_MAX_COUNT		3 /* main, sub, general(misc) */
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
@@ -75,12 +76,19 @@ struct cmdq_task {
 	struct cmdq_pkt		*pkt; /* the packet sent from mailbox client */
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
 	struct clk		*clock;
+	bool			suspended;
 };
 
 static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
@@ -202,10 +210,13 @@ static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
 {
 	struct cmdq *cmdq;
 	struct cmdq_task *task;
-	unsigned long curr_pa, end_pa;
+	unsigned long curr_pa, end_pa, flags;
 
 	cmdq = dev_get_drvdata(thread->chan->mbox->dev);
 
+	/* Client should not flush new tasks if suspended. */
+	WARN_ON(cmdq->suspended);
+
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
 	task->cmdq = cmdq;
 	INIT_LIST_HEAD(&task->list_entry);
@@ -215,7 +226,14 @@ static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
 	task->pkt = pkt;
 
 	if (list_empty(&thread->task_busy_list)) {
-		WARN_ON(clk_enable(cmdq->clock) < 0);
+		/*
+		 * Unlock for clk prepare (sleeping function).
+		 * This is safe since clk_prepare_enable has internal locks.
+		 */
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+		WARN_ON(clk_prepare_enable(cmdq->clock) < 0);
+		spin_lock_irqsave(&thread->chan->lock, flags);
+
 		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
 
 		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
@@ -297,6 +315,26 @@ static void cmdq_task_handle_error(struct cmdq_task *task)
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
@@ -346,7 +384,7 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	if (list_empty(&thread->task_busy_list)) {
 		cmdq_thread_disable(cmdq, thread);
-		clk_disable(cmdq->clock);
+		cmdq_clk_release_schedule(cmdq);
 	} else {
 		mod_timer(&thread->timeout,
 			  jiffies + msecs_to_jiffies(CMDQ_TIMEOUT_MS));
@@ -405,16 +443,50 @@ static void cmdq_thread_handle_timeout(unsigned long data)
 
 	cmdq_thread_resume(thread);
 	cmdq_thread_disable(cmdq, thread);
-	clk_disable(cmdq->clock);
+	cmdq_clk_release_schedule(cmdq);
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 }
 
+static int cmdq_suspend(struct device *dev)
+{
+	struct cmdq *cmdq = dev_get_drvdata(dev);
+	struct cmdq_thread *thread;
+	int i;
+	bool task_running = false;
+
+	cmdq->suspended = true;
+
+	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
+		thread = &cmdq->thread[i];
+		if (!list_empty(&thread->task_busy_list)) {
+			mod_timer(&thread->timeout, jiffies + 1);
+			task_running = true;
+		}
+	}
+
+	if (task_running) {
+		dev_warn(dev, "exist running task(s) in suspend\n");
+		schedule();
+	}
+
+	flush_workqueue(cmdq->clk_release_wq);
+	return 0;
+}
+
+static int cmdq_resume(struct device *dev)
+{
+	struct cmdq *cmdq = dev_get_drvdata(dev);
+
+	cmdq->suspended = false;
+	return 0;
+}
+
 static int cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
+	destroy_workqueue(cmdq->clk_release_wq);
 	mbox_controller_unregister(&cmdq->mbox);
-	clk_unprepare(cmdq->clock);
 	return 0;
 }
 
@@ -530,11 +602,20 @@ static int cmdq_probe(struct platform_device *pdev)
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
 
+static const struct dev_pm_ops cmdq_pm_ops = {
+	.suspend = cmdq_suspend,
+	.resume = cmdq_resume,
+};
+
 static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt8173-gce",},
 	{}
@@ -545,6 +626,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	.remove = cmdq_remove,
 	.driver = {
 		.name = "mtk_cmdq",
+		.pm = &cmdq_pm_ops,
 		.of_match_table = cmdq_of_ids,
 	}
 };
-- 
1.9.1
