From: hs.liao@mediatek.com (HS Liao)
Date: Wed, 4 May 2016 20:32:17 +0800
Subject: [RFC v5 4/4] CMDQ: suspend/resume protection
In-Reply-To: <1462365137-715-1-git-send-email-hs.liao@mediatek.com>
References: <1462365137-715-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1462365137-715-5-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend/resume protection mechanism to prevent active task(s) in
suspend.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq.c | 295 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 289 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
index d3e9a4c..7599a5b 100644
--- a/drivers/soc/mediatek/mtk-cmdq.c
+++ b/drivers/soc/mediatek/mtk-cmdq.c
@@ -50,6 +50,7 @@
 #define CMDQ_CLK_NAME			"gce"
 
 #define CMDQ_CURR_IRQ_STATUS_OFFSET	0x010
+#define CMDQ_CURR_LOADED_THR_OFFSET	0x018
 #define CMDQ_THR_SLOT_CYCLES_OFFSET	0x030
 
 #define CMDQ_THR_BASE			0x100
@@ -143,6 +144,7 @@ enum cmdq_code {
 enum cmdq_task_state {
 	TASK_STATE_IDLE,	/* free task */
 	TASK_STATE_BUSY,	/* task running on a thread */
+	TASK_STATE_KILLED,	/* task process being killed */
 	TASK_STATE_ERROR,	/* task execution error */
 	TASK_STATE_DONE,	/* task finished */
 	TASK_STATE_WAITING,	/* allocated but waiting for available thread */
@@ -182,6 +184,8 @@ struct cmdq_thread {
 
 struct cmdq {
 	struct device		*dev;
+	struct notifier_block	pm_notifier;
+
 	void __iomem		*base;
 	u32			irq;
 
@@ -201,9 +205,12 @@ struct cmdq {
 
 	struct cmdq_thread	thread[CMDQ_MAX_THREAD_COUNT];
 	struct mutex		task_mutex;	/* for task list */
+	atomic_t		thread_usage;
 	spinlock_t		exec_lock;	/* for exec task */
 	wait_queue_head_t	thread_dispatch_queue;
 	struct clk		*clock;
+	atomic_t		suspending;
+	bool			suspended;
 };
 
 struct cmdq_subsys {
@@ -292,14 +299,24 @@ static struct cmdq_task *cmdq_task_create(struct cmdq *cmdq, size_t size)
 	return task;
 }
 
-static void cmdq_task_release_internal(struct cmdq_task *task)
+static void cmdq_task_release_unlocked(struct cmdq_task *task)
 {
 	struct cmdq *cmdq = task->cmdq;
 
-	mutex_lock(&cmdq->task_mutex);
+	/* This func should be inside cmdq->task_mutex mutex */
+	lockdep_assert_held(&cmdq->task_mutex);
+
 	cmdq_task_free_command_buffer(task);
 	list_del(&task->list_entry);
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
 
@@ -393,6 +410,7 @@ static struct cmdq_thread *cmdq_thread_get(struct cmdq *cmdq, u64 flag)
 	if (thread->cur_task[next_cookie])
 		return NULL;
 	cmdq_clk_enable(cmdq);
+	atomic_inc(&cmdq->thread_usage);
 	return thread;
 }
 
@@ -401,6 +419,7 @@ static void cmdq_thread_put(struct cmdq *cmdq, struct cmdq_thread *thread)
 	if (WARN_ON(thread == NULL))
 		return;
 	cmdq_clk_disable(cmdq);
+	atomic_dec(&cmdq->thread_usage);
 }
 
 static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
@@ -492,6 +511,80 @@ static int cmdq_thread_remove_task_by_index(struct cmdq_thread *thread,
 	return 0;
 }
 
+static int cmdq_thread_force_remove_task(struct cmdq_task *task)
+{
+	struct cmdq *cmdq = task->cmdq;
+	struct cmdq_thread *thread = task->thread;
+	int err;
+	int cookie;
+	struct cmdq_task *exec_task;
+
+	err = cmdq_thread_suspend(cmdq, thread);
+
+	cmdq_thread_writel(thread, CMDQ_THR_NO_TIMEOUT,
+			   CMDQ_THR_INST_CYCLES_OFFSET);
+
+	/* The cookie of the task currently being processed */
+	cookie = cmdq_thread_get_cookie(thread) + 1;
+
+	exec_task = thread->cur_task[cookie % CMDQ_MAX_TASK_IN_THREAD];
+	if (exec_task == task) {
+		dma_addr_t eoc_pa = task->mva_base + task->command_size - 16;
+
+		/* The task is executed now, set the PC to EOC for bypass */
+		cmdq_thread_writel(thread, eoc_pa, CMDQ_THR_CURR_ADDR_OFFSET);
+
+		thread->cur_task[cookie % CMDQ_MAX_TASK_IN_THREAD] = NULL;
+		task->task_state = TASK_STATE_KILLED;
+	} else {
+		int i, j;
+		u32 *task_base, *exec_task_base;
+
+		j = thread->task_count;
+		for (i = cookie; j > 0; j--, i++) {
+			i %= CMDQ_MAX_TASK_IN_THREAD;
+
+			exec_task = thread->cur_task[i];
+			if (!exec_task)
+				continue;
+
+			task_base = task->va_base;
+			exec_task_base = exec_task->va_base;
+			if ((exec_task_base[exec_task->num_cmd - 1] ==
+			     CMDQ_JUMP_BY_OFFSET) &&
+			    (exec_task_base[exec_task->num_cmd - 2] ==
+			     CMDQ_JUMP_PASS)) {
+				/* reached the last task */
+				break;
+			}
+
+			if (exec_task_base[exec_task->num_cmd - 2] ==
+			    task->mva_base) {
+				/* fake EOC command */
+				exec_task_base[exec_task->num_cmd - 2] =
+					CMDQ_EOC_IRQ_EN;
+				exec_task_base[exec_task->num_cmd - 1] =
+					CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT;
+
+				/* bypass the task */
+				exec_task_base[exec_task->num_cmd] =
+					task_base[task->num_cmd - 2];
+				exec_task_base[exec_task->num_cmd + 1] =
+					task_base[task->num_cmd - 1];
+
+				i = (i + 1) % CMDQ_MAX_TASK_IN_THREAD;
+
+				thread->cur_task[i] = NULL;
+				task->task_state = TASK_STATE_KILLED;
+				err = 0;
+				break;
+			}
+		}
+	}
+
+	return err;
+}
+
 static struct cmdq_task *cmdq_thread_search_task_by_pc(
 		const struct cmdq_thread *thread, u32 pc)
 {
@@ -790,6 +883,18 @@ static void cmdq_handle_irq(struct cmdq *cmdq, int tid)
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
@@ -797,6 +902,12 @@ static void cmdq_consume_waiting_list(struct work_struct *work)
 	struct device *dev = cmdq->dev;
 	struct cmdq_task *task, *tmp;
 
+	/* do not execute any task after suspended */
+	if (cmdq->suspended) {
+		dev_warn(dev, "task is consumed after suspended\n");
+		return;
+	}
+
 	mutex_lock(&cmdq->task_mutex);
 
 	if (list_empty(&cmdq->task_wait_list)) {
@@ -960,6 +1071,14 @@ static int cmdq_task_wait_result(struct cmdq_task *task)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cmdq->exec_lock, flags);
+
+	/* suspend, so just return */
+	if (atomic_read(&cmdq->suspending) &&
+	    task->task_state == TASK_STATE_KILLED) {
+		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
+		return 0;
+	}
+
 	if (task->task_state != TASK_STATE_DONE)
 		err = cmdq_task_handle_error_result(task);
 	if (thread->task_count <= 0)
@@ -1019,7 +1138,8 @@ static int cmdq_task_wait_and_release(struct cmdq_task *task)
 
 	/* release regardless of success or not */
 	cmdq_thread_put(task->cmdq, task->thread);
-	cmdq_task_release_internal(task);
+	if (!atomic_read(&task->cmdq->suspending))
+		cmdq_task_release_internal(task);
 	return err;
 }
 
@@ -1074,7 +1194,7 @@ static int cmdq_task_submit(struct cmdq_command *command)
 	return err;
 }
 
-static int cmdq_remove(struct platform_device *pdev)
+static void cmdq_deinitialize(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 	struct cmdq_task *task, *tmp;
@@ -1094,7 +1214,6 @@ static int cmdq_remove(struct platform_device *pdev)
 
 	kmem_cache_destroy(cmdq->task_cache);
 	cmdq->task_cache = NULL;
-	return 0;
 }
 
 static irqreturn_t cmdq_irq_handler(int irq, void *dev)
@@ -1316,6 +1435,13 @@ int cmdq_rec_flush(struct cmdq_rec *rec)
 	int err;
 	struct cmdq_command command;
 
+	/* do not allow flush after suspended */
+	if (rec->cmdq->suspended) {
+		dev_err(rec->cmdq->dev,
+			"%s is called after suspended\n", __func__);
+		return -EPERM;
+	}
+
 	err = cmdq_rec_fill_command(rec, &command);
 	if (err < 0)
 		return err;
@@ -1331,6 +1457,13 @@ int cmdq_rec_flush_async(struct cmdq_rec *rec, cmdq_async_flush_cb cb,
 	struct cmdq_task *task;
 	struct cmdq_task_cb task_cb;
 
+	/* do not allow flush after suspended */
+	if (rec->cmdq->suspended) {
+		dev_err(rec->cmdq->dev,
+			"%s is called after suspended\n", __func__);
+		return -EPERM;
+	}
+
 	err = cmdq_rec_fill_command(rec, &command);
 	if (err < 0)
 		return err;
@@ -1351,6 +1484,127 @@ void cmdq_rec_destroy(struct cmdq_rec *rec)
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
+
+	/*
+	 * lock to prevent cmdq_core_consume_waiting_list() and
+	 * cmdq_core_acquire_task(), i.e. no new active tasks
+	 */
+	mutex_lock(&cmdq->task_mutex);
+
+	ref_count = atomic_read(&cmdq->thread_usage);
+	atomic_set(&cmdq->suspending, 1);
+
+	if (ref_count > 0 || exec_threads & CMDQ_THR_EXECUTING) {
+		struct cmdq_task *task, *tmp;
+		int i;
+
+		dev_err(dev, "suspend: other running, kill tasks.\n");
+		dev_err(dev, "threads:0x%08x, ref:%d, AL empty:%d, base:0x%p\n",
+			exec_threads, ref_count,
+			list_empty(&cmdq->task_active_list), cmdq->base);
+
+		/*
+		 * We need to ensure the system is ready to suspend,
+		 * so kill all running CMDQ tasks and release HW engines.
+		 */
+
+		/* remove all active task from thread */
+		list_for_each_entry_safe(task, tmp, &cmdq->task_active_list,
+					 list_entry) {
+			bool already_done = false;
+
+			if (!task->thread)
+				continue;
+
+			spin_lock_irqsave(&cmdq->exec_lock, flags);
+			if (task->task_state == TASK_STATE_BUSY) {
+				/* still wait_event */
+				cmdq_thread_force_remove_task(task);
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
+		dev_err(dev, "suspend: AL empty:%d\n",
+			list_empty(&cmdq->task_active_list));
+
+		/* disable all HW thread */
+		dev_err(dev, "suspend: disable all HW threads\n");
+		for (i = 0; i < CMDQ_MAX_THREAD_COUNT; i++)
+			cmdq_thread_disable(cmdq, &cmdq->thread[i]);
+
+		/* reset all cmdq_thread */
+		memset(&cmdq->thread[0], 0, sizeof(cmdq->thread));
+	}
+
+	cmdq->suspended = true;
+	atomic_set(&cmdq->suspending, 0);
+
+	mutex_unlock(&cmdq->task_mutex);
+
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
@@ -1401,12 +1655,40 @@ static int cmdq_probe(struct platform_device *pdev)
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
@@ -1418,6 +1700,7 @@ static struct platform_driver cmdq_drv = {
 	.driver = {
 		.name = CMDQ_DRIVER_DEVICE_NAME,
 		.owner = THIS_MODULE,
+		.pm = &cmdq_pm_ops,
 		.of_match_table = cmdq_of_ids,
 	}
 };
-- 
1.9.1
