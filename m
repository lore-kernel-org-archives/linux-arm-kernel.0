From: hs.liao@mediatek.com (HS Liao)
Date: Tue, 1 Nov 2016 19:28:17 +0800
Subject: [PATCH v16 4/5] CMDQ: suspend and resume
In-Reply-To: <1477999698-6288-1-git-send-email-hs.liao@mediatek.com>
References: <1477999698-6288-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1477999698-6288-5-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

take suspend and resume into consideration

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d086fd8..747bcd3 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -81,6 +81,7 @@ struct cmdq {
 	u32			irq;
 	struct cmdq_thread	thread[CMDQ_THR_MAX_COUNT];
 	struct clk		*clock;
+	bool			suspended;
 };
 
 static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
@@ -206,6 +207,9 @@ static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
 
 	cmdq = dev_get_drvdata(thread->chan->mbox->dev);
 
+	/* Client should not flush new tasks if suspended. */
+	WARN_ON(cmdq->suspended);
+
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
 	task->cmdq = cmdq;
 	INIT_LIST_HEAD(&task->list_entry);
@@ -409,6 +413,39 @@ static void cmdq_thread_handle_timeout(unsigned long data)
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
+			task_running = true;
+			break;
+		}
+	}
+
+	if (task_running)
+		dev_warn(dev, "exist running task(s) in suspend\n");
+
+	clk_unprepare(cmdq->clock);
+	return 0;
+}
+
+static int cmdq_resume(struct device *dev)
+{
+	struct cmdq *cmdq = dev_get_drvdata(dev);
+
+	WARN_ON(clk_prepare(cmdq->clock) < 0);
+	cmdq->suspended = false;
+	return 0;
+}
+
 static int cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
@@ -532,9 +569,15 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cmdq);
 	WARN_ON(clk_prepare(cmdq->clock) < 0);
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
@@ -545,6 +588,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	.remove = cmdq_remove,
 	.driver = {
 		.name = "mtk_cmdq",
+		.pm = &cmdq_pm_ops,
 		.of_match_table = cmdq_of_ids,
 	}
 };
-- 
1.9.1
