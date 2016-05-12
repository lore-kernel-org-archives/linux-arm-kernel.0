From: hs.liao@mediatek.com (HS Liao)
Date: Thu, 12 May 2016 15:13:30 +0800
Subject: [PATCH v6 4/4] CMDQ: suspend/resume protection
In-Reply-To: <1463037210-863-1-git-send-email-hs.liao@mediatek.com>
References: <1463037210-863-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1463037210-863-5-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend/resume protection mechanism to prevent active task(s) in
suspend.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq.c | 266 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 254 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
index 72afc3f..ab67a88 100644
--- a/drivers/soc/mediatek/mtk-cmdq.c
+++ b/drivers/soc/mediatek/mtk-cmdq.c
@@ -40,6 +40,7 @@
 #define CMDQ_CLK_NAME			"gce"
 
 #define CMDQ_CURR_IRQ_STATUS_OFFSET	0x010
+#define CMDQ_CURR_LOADED_THR_OFFSET	0x018
 #define CMDQ_THR_SLOT_CYCLES_OFFSET	0x030
 
 #define CMDQ_THR_BASE			0x100
@@ -134,6 +135,7 @@ enum cmdq_code {
 enum cmdq_task_state {
 	TASK_STATE_WAITING,	/* allocated but waiting for available thread */
 	TASK_STATE_BUSY,	/* task running on a thread */
+	TASK_STATE_KILLED,	/* task process being killed */
 	TASK_STATE_ERROR,	/* task execution error */
 	TASK_STATE_DONE,	/* task finished */
 };
@@ -169,6 +171,8 @@ struct cmdq_thread {
 
 struct cmdq {
 	struct device		*dev;
+	struct notifier_block	pm_notifier;
+
 	void __iomem		*base;
 	u32			irq;
 
@@ -186,9 +190,12 @@ struct cmdq {
 
 	struct cmdq_thread	thread[CMDQ_THR_MAX_COUNT];
 	struct mutex		task_mutex;	/* for task list */
+	atomic_t		thread_usage;
 	spinlock_t		exec_lock;	/* for exec task */
 	wait_queue_head_t	thread_dispatch_queue;
 	struct clk		*clock;
+	atomic_t		suspending;
+	bool			suspended;
 };
 
 struct cmdq_subsys {
@@ -241,14 +248,24 @@ static int cmdq_eng_get_thread(u64 flag)
 		return CMDQ_THR_DISP_MISC_IDX;
 }
 
-static void cmdq_task_release_internal(struct cmdq_task *task)
+static void cmdq_task_release_unlocked(struct cmdq_task *task)
 {
 	struct cmdq *cmdq = task->cmdq;
 
-	mutex_lock(&cmdq->task_mutex);
+	/* This func should be inside cmdq->task_mutex mutex */
+	lockdep_assert_held(&cmdq->task_mutex);
+
 	dma_free_coherent(cmdq->dev, task->command_size, task->va_base,
 			  task->mva_base);
 	kmem_cache_free(cmdq->task_cache, task);
+}
+
+static void cmdq_task_release_internal(struct cmdq_task *task)
+{
+	struct cmdq *cmdq = task->cmdq;
+
+	mutex_lock(&cmdq->task_mutex);
+	cmdq_task_release_unlocked(task);
 	mutex_unlock(&cmdq->task_mutex);
 }
 
@@ -300,6 +317,7 @@ static struct cmdq_thread *cmdq_thread_get(struct cmdq *cmdq, int tid)
 	struct cmdq_thread *thread = &cmdq->thread[tid];
 
 	cmdq_clk_enable(cmdq);
+	atomic_inc(&cmdq->thread_usage);
 	return thread;
 }
 
@@ -308,6 +326,7 @@ static void cmdq_thread_put(struct cmdq *cmdq, struct cmdq_thread *thread)
 	if (WARN_ON(thread == NULL))
 		return;
 	cmdq_clk_disable(cmdq);
+	atomic_dec(&cmdq->thread_usage);
 }
 
 static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
@@ -580,6 +599,18 @@ static void cmdq_handle_irq(struct cmdq *cmdq, int tid)
 	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
 }
 
+static int cmdq_resumed_notifier(struct cmdq *cmdq)
+{
+	/*
+	 * during suspended, there may be queued tasks.
+	 * we should process them if any.
+	 */
+	queue_work(cmdq->task_consume_wq,
+		   &cmdq->task_consume_wait_queue_item);
+
+	return 0;
+}
+
 static void cmdq_consume_waiting_list(struct work_struct *work)
 {
 	struct cmdq *cmdq = container_of(work, struct cmdq,
@@ -591,6 +622,12 @@ static void cmdq_consume_waiting_list(struct work_struct *work)
 			      BIT(CMDQ_THR_DISP_SUB_IDX) |
 			      BIT(CMDQ_THR_DISP_MISC_IDX);
 
+	/* do not execute any task after suspended */
+	if (cmdq->suspended) {
+		dev_warn(dev, "task is consumed after suspended\n");
+		return;
+	}
+
 	mutex_lock(&cmdq->task_mutex);
 
 	if (list_empty(&cmdq->task_wait_list)) {
@@ -740,6 +777,14 @@ static int cmdq_task_wait_result(struct cmdq_task *task)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cmdq->exec_lock, flags);
+
+	/* suspending, so just return */
+	if (atomic_read(&cmdq->suspending) &&
+	    task->task_state == TASK_STATE_KILLED) {
+		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
+		return 0;
+	}
+
 	if (task->task_state != TASK_STATE_DONE)
 		err = cmdq_task_handle_error_result(task);
 	if (thread->task_count <= 0)
@@ -748,6 +793,18 @@ static int cmdq_task_wait_result(struct cmdq_task *task)
 	return err;
 }
 
+static void cmdq_lock_task_mutex(struct cmdq *cmdq)
+{
+	if (!atomic_read(&cmdq->suspending))
+		mutex_lock(&cmdq->task_mutex);
+}
+
+static void cmdq_unlock_task_mutex(struct cmdq *cmdq)
+{
+	if (!atomic_read(&cmdq->suspending))
+		mutex_unlock(&cmdq->task_mutex);
+}
+
 static int cmdq_task_wait_done(struct cmdq_task *task)
 {
 	struct cmdq *cmdq = task->cmdq;
@@ -761,7 +818,7 @@ static int cmdq_task_wait_done(struct cmdq_task *task)
 			cmdq->thread_dispatch_queue,
 			task->thread, timeout);
 	if (!wait_q) {
-		mutex_lock(&cmdq->task_mutex);
+		cmdq_lock_task_mutex(cmdq);
 		/* Check if task was just consumed. */
 		if (!task->thread) {
 			dev_err(dev,
@@ -772,11 +829,11 @@ static int cmdq_task_wait_done(struct cmdq_task *task)
 			 * so it won't be consumed in the future.
 			 */
 			list_del_init(&task->list_entry);
-			mutex_unlock(&cmdq->task_mutex);
+			cmdq_unlock_task_mutex(cmdq);
 			return -EINVAL;
 		}
 		/* valid thread, so we keep going */
-		mutex_unlock(&cmdq->task_mutex);
+		cmdq_unlock_task_mutex(cmdq);
 	}
 
 	/* wait for execution */
@@ -797,7 +854,9 @@ static int cmdq_task_wait_and_release(struct cmdq_task *task)
 
 	/* release regardless of success or not */
 	cmdq_thread_put(task->cmdq, task->thread);
-	cmdq_task_release_internal(task);
+	if (!(atomic_read(&task->cmdq->suspending) &&
+	      task->task_state == TASK_STATE_KILLED))
+		cmdq_task_release_internal(task);
 	return err;
 }
 
@@ -823,9 +882,22 @@ static void cmdq_auto_release(struct work_struct *work_item)
 			   &cmdq->task_consume_wait_queue_item);
 }
 
-static void cmdq_task_auto_release(struct cmdq_task *task)
+static void cmdq_task_auto_release(struct cmdq *cmdq, struct cmdq_task *task)
 {
-	struct cmdq *cmdq = task->cmdq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmdq->exec_lock, flags);
+
+	if (atomic_read(&cmdq->suspending) || cmdq->suspended) {
+		/*
+		 * This means system is suspened between
+		 * cmdq_task_submit_async() and cmdq_task_auto_release(),
+		 * so return immediately.
+		 * This task should be forced to remove by suspend flow.
+		 */
+		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
+		return;
+	}
 
 	/*
 	 * the work item is embeded in task already
@@ -833,6 +905,8 @@ static void cmdq_task_auto_release(struct cmdq_task *task)
 	 */
 	INIT_WORK(&task->auto_release_work, cmdq_auto_release);
 	queue_work(cmdq->task_auto_release_wq, &task->auto_release_work);
+
+	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
 }
 
 static int cmdq_task_submit(struct cmdq_command *command)
@@ -852,7 +926,7 @@ static int cmdq_task_submit(struct cmdq_command *command)
 	return err;
 }
 
-static int cmdq_remove(struct platform_device *pdev)
+static void cmdq_deinitialize(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 	struct cmdq_task *task, *tmp;
@@ -872,7 +946,6 @@ static int cmdq_remove(struct platform_device *pdev)
 
 	kmem_cache_destroy(cmdq->task_cache);
 	cmdq->task_cache = NULL;
-	return 0;
 }
 
 static irqreturn_t cmdq_irq_handler(int irq, void *dev)
@@ -1094,6 +1167,13 @@ int cmdq_rec_flush(struct cmdq_rec *rec)
 	int err;
 	struct cmdq_command command;
 
+	/* do not allow flush after suspending or suspended */
+	if (atomic_read(&rec->cmdq->suspending) || rec->cmdq->suspended) {
+		dev_err(rec->cmdq->dev,
+			"%s is called after suspending\n", __func__);
+		return -EPERM;
+	}
+
 	err = cmdq_rec_fill_command(rec, &command);
 	if (err < 0)
 		return err;
@@ -1109,6 +1189,13 @@ int cmdq_rec_flush_async(struct cmdq_rec *rec, cmdq_async_flush_cb cb,
 	struct cmdq_task *task;
 	struct cmdq_task_cb task_cb;
 
+	/* do not allow flush after suspending or suspended */
+	if (atomic_read(&rec->cmdq->suspending) || rec->cmdq->suspended) {
+		dev_err(rec->cmdq->dev,
+			"%s is called after suspending\n", __func__);
+		return -EPERM;
+	}
+
 	err = cmdq_rec_fill_command(rec, &command);
 	if (err < 0)
 		return err;
@@ -1117,7 +1204,13 @@ int cmdq_rec_flush_async(struct cmdq_rec *rec, cmdq_async_flush_cb cb,
 	err = cmdq_task_submit_async(&command, &task, &task_cb);
 	if (err < 0)
 		return err;
-	cmdq_task_auto_release(task);
+
+	/*
+	 * Task could be released in suspend flow,
+	 * so we have to pass cmdq as parameter.
+	 */
+	cmdq_task_auto_release(rec->cmdq, task);
+
 	return 0;
 }
 EXPORT_SYMBOL(cmdq_rec_flush_async);
@@ -1129,6 +1222,126 @@ void cmdq_rec_destroy(struct cmdq_rec *rec)
 }
 EXPORT_SYMBOL(cmdq_rec_destroy);
 
+static int cmdq_pm_notifier_cb(struct notifier_block *nb, unsigned long event,
+			       void *ptr)
+{
+	struct cmdq *cmdq = container_of(nb, struct cmdq, pm_notifier);
+
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		/*
+		 * Going to suspend the system
+		 * The next stage is freeze process.
+		 * We will queue all request in suspend callback,
+		 * so don't care this stage
+		 */
+		return NOTIFY_DONE;
+	case PM_POST_SUSPEND:
+		/*
+		 * processes had resumed in previous stage
+		 * (system resume callback)
+		 * resume CMDQ driver to execute.
+		 */
+		cmdq_resumed_notifier(cmdq);
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+	return NOTIFY_DONE;
+}
+
+static int cmdq_suspend(struct device *dev)
+{
+	struct cmdq *cmdq = dev_get_drvdata(dev);
+	u32 exec_threads = readl(cmdq->base + CMDQ_CURR_LOADED_THR_OFFSET);
+	int ref_count;
+	unsigned long flags;
+	struct cmdq_thread *thread;
+	struct cmdq_task *task, *tmp;
+	int i;
+
+	atomic_set(&cmdq->suspending, 1);
+
+	/*
+	 * lock to prevent cmdq_consume_waiting_list() and
+	 * cmdq_acquire_task(), i.e. no new active tasks
+	 */
+	mutex_lock(&cmdq->task_mutex);
+
+	ref_count = atomic_read(&cmdq->thread_usage);
+	if (ref_count <= 0 && !(exec_threads & CMDQ_THR_EXECUTING))
+		goto exit;
+
+	dev_err(dev, "suspend: kill running, tasks.\n");
+	dev_err(dev, "threads: 0x%08x, ref:%d\n", exec_threads, ref_count);
+
+	/*
+	 * We need to ensure the system is ready to suspend,
+	 * so kill all running CMDQ tasks and release HW engines.
+	 */
+
+	/* remove all active task from thread and disable thread */
+	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
+		thread = &cmdq->thread[i];
+
+		if (thread->task_count <= 0)
+			continue;
+
+		cmdq_clk_enable(cmdq); /* prevent clk disable in release flow */
+		cmdq_thread_suspend(cmdq, thread);
+
+		list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
+					 list_entry) {
+			bool already_done = false;
+
+			spin_lock_irqsave(&cmdq->exec_lock, flags);
+			if (task->task_state == TASK_STATE_BUSY) {
+				/* still wait_event */
+				list_del(&task->list_entry);
+				task->task_state = TASK_STATE_KILLED;
+			} else {
+				/* almost finish its work */
+				already_done = true;
+			}
+			spin_unlock_irqrestore(&cmdq->exec_lock, flags);
+
+			/*
+			 * TASK_STATE_KILLED will unlock
+			 * wait_event_timeout in cmdq_task_wait_done(),
+			 * so flush_work to wait auto release flow.
+			 *
+			 * We don't know processes running order,
+			 * so call cmdq_task_release_unlocked() here to
+			 * prevent releasing task before flush_work, and
+			 * also to prevent deadlock of task_mutex.
+			 */
+			if (!already_done) {
+				flush_work(&task->auto_release_work);
+				cmdq_task_release_unlocked(task);
+			}
+		}
+
+		cmdq_thread_resume(thread);
+		cmdq_thread_disable(cmdq, &cmdq->thread[i]);
+		cmdq_clk_disable(cmdq);
+	}
+
+exit:
+	cmdq->suspended = true;
+	mutex_unlock(&cmdq->task_mutex);
+	atomic_set(&cmdq->suspending, 0);
+	/* ALWAYS allow suspend */
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
 static int cmdq_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1179,13 +1392,41 @@ static int cmdq_probe(struct platform_device *pdev)
 		err = PTR_ERR(cmdq->clock);
 		goto fail;
 	}
+
+	/* hibernation and suspend events */
+	cmdq->pm_notifier.notifier_call = cmdq_pm_notifier_cb;
+	cmdq->pm_notifier.priority = 5;
+	err = register_pm_notifier(&cmdq->pm_notifier);
+	if (err < 0) {
+		dev_err(dev, "failed to register cmdq pm notifier\n");
+		goto fail;
+	}
+
 	return 0;
 
 fail:
-	cmdq_remove(pdev);
+	cmdq_deinitialize(pdev);
 	return err;
 }
 
+static int cmdq_remove(struct platform_device *pdev)
+{
+	struct cmdq *cmdq = platform_get_drvdata(pdev);
+	int err;
+
+	err = unregister_pm_notifier(&cmdq->pm_notifier);
+	if (err < 0)
+		dev_err(&pdev->dev, "unregister pm notifier failed\n");
+
+	cmdq_deinitialize(pdev);
+	return 0;
+}
+
+static const struct dev_pm_ops cmdq_pm_ops = {
+	.suspend = cmdq_suspend,
+	.resume = cmdq_resume,
+};
+
 static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt8173-gce",},
 	{}
@@ -1197,6 +1438,7 @@ static struct platform_driver cmdq_drv = {
 	.driver = {
 		.name = CMDQ_DRIVER_DEVICE_NAME,
 		.owner = THIS_MODULE,
+		.pm = &cmdq_pm_ops,
 		.of_match_table = cmdq_of_ids,
 	}
 };
-- 
1.9.1
