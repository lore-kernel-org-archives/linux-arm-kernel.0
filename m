From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 24 May 2016 17:16:50 +0800
Subject: [PATCH v7 4/4] CMDQ: suspend/resume protection
In-Reply-To: <1464006190-344-5-git-send-email-hs.liao@mediatek.com>
References: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
 <1464006190-344-5-git-send-email-hs.liao@mediatek.com>
Message-ID: <1464081410.30351.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-05-23 at 20:23 +0800, HS Liao wrote:
> Add suspend/resume protection mechanism to prevent active task(s) in
> suspend.
> 
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq.c | 174 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 166 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
> index f8c5d02..1a51cfb 100644
> --- a/drivers/soc/mediatek/mtk-cmdq.c
> +++ b/drivers/soc/mediatek/mtk-cmdq.c
> @@ -39,6 +39,7 @@
>  #define CMDQ_CLK_NAME			"gce"
>  
>  #define CMDQ_CURR_IRQ_STATUS		0x010
> +#define CMDQ_CURR_LOADED_THR		0x018
>  #define CMDQ_THR_SLOT_CYCLES		0x030
>  
>  #define CMDQ_THR_BASE			0x100
> @@ -125,6 +126,7 @@ enum cmdq_code {
>  
>  enum cmdq_task_state {
>  	TASK_STATE_BUSY,	/* task running on a thread */
> +	TASK_STATE_KILLED,	/* task process being killed */
>  	TASK_STATE_ERROR,	/* task execution error */
>  	TASK_STATE_DONE,	/* task finished */
>  };
> @@ -161,8 +163,12 @@ struct cmdq {
>  	u32			irq;
>  	struct workqueue_struct	*task_release_wq;
>  	struct cmdq_thread	thread[CMDQ_THR_MAX_COUNT];
> -	spinlock_t		exec_lock;	/* for exec task */
> +	atomic_t		thread_usage;
> +	struct mutex		task_mutex;	/* for task */
> +	spinlock_t		exec_lock;	/* for exec */
>  	struct clk		*clock;
> +	bool			suspending;
> +	bool			suspended;
>  };
>  
>  struct cmdq_subsys {
> @@ -196,15 +202,27 @@ static int cmdq_eng_get_thread(u64 flag)
>  		return CMDQ_THR_DISP_MISC_IDX;
>  }
>  
> -static void cmdq_task_release(struct cmdq_task *task)
> +static void cmdq_task_release_unlocked(struct cmdq_task *task)
>  {
>  	struct cmdq *cmdq = task->cmdq;
>  
> +	/* This func should be inside cmdq->task_mutex mutex */
> +	lockdep_assert_held(&cmdq->task_mutex);
> +
>  	dma_free_coherent(cmdq->dev, task->command_size, task->va_base,
>  			  task->mva_base);
>  	kfree(task);
>  }
>  
> +static void cmdq_task_release(struct cmdq_task *task)
> +{
> +	struct cmdq *cmdq = task->cmdq;
> +
> +	mutex_lock(&cmdq->task_mutex);
> +	cmdq_task_release_unlocked(task);
> +	mutex_unlock(&cmdq->task_mutex);
> +}
> +
>  static struct cmdq_task *cmdq_task_acquire(struct cmdq_rec *rec,
>  					   struct cmdq_task_cb cb)
>  {
> @@ -576,6 +594,12 @@ static int cmdq_task_wait_and_release(struct cmdq_task *task)
>  		dev_dbg(dev, "timeout!\n");
>  
>  	spin_lock_irqsave(&cmdq->exec_lock, flags);
> +
> +	if (cmdq->suspending && task->task_state == TASK_STATE_KILLED) {
> +		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> +		return 0;
> +	}
> +
>  	if (task->task_state != TASK_STATE_DONE)
>  		err = cmdq_task_handle_error_result(task);
>  	if (list_empty(&thread->task_busy_list))
> @@ -584,7 +608,9 @@ static int cmdq_task_wait_and_release(struct cmdq_task *task)
>  
>  	/* release regardless of success or not */
>  	clk_disable_unprepare(cmdq->clock);
> -	cmdq_task_release(task);
> +	atomic_dec(&cmdq->thread_usage);
> +	if (!(task->cmdq->suspending && task->task_state == TASK_STATE_KILLED))
> +		cmdq_task_release(task);
>  
>  	return err;
>  }
> @@ -597,12 +623,28 @@ static void cmdq_task_wait_release_work(struct work_struct *work_item)
>  	cmdq_task_wait_and_release(task);
>  }
>  
> -static void cmdq_task_wait_release_schedule(struct cmdq_task *task)
> +static void cmdq_task_wait_release_schedule(struct cmdq *cmdq,
> +					    struct cmdq_task *task)
>  {
> -	struct cmdq *cmdq = task->cmdq;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> +
> +	if (cmdq->suspending || cmdq->suspended) {
> +		/*
> +		 * This means system is suspened between
> +		 * cmdq_task_submit_async() and
> +		 * cmdq_task_wait_release_schedule(), so return immediately.
> +		 * This task should be forced to remove by suspend flow.
> +		 */
> +		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> +		return;
> +	}
>  
>  	INIT_WORK(&task->release_work, cmdq_task_wait_release_work);
>  	queue_work(cmdq->task_release_wq, &task->release_work);
> +
> +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
>  }
>  
>  static int cmdq_rec_realloc_cmd_buffer(struct cmdq_rec *rec, size_t size)
> @@ -766,18 +808,31 @@ static int _cmdq_rec_flush(struct cmdq_rec *rec, struct cmdq_task **task_out,
>  	struct cmdq_thread *thread;
>  	int err;
>  
> +	mutex_lock(&cmdq->task_mutex);
> +	if (rec->cmdq->suspending || rec->cmdq->suspended) {
> +		dev_err(rec->cmdq->dev,
> +			"%s is called after suspending\n", __func__);
> +		mutex_unlock(&cmdq->task_mutex);
> +		return -EPERM;
> +	}
> +
>  	err = cmdq_rec_finalize(rec);
> -	if (err < 0)
> +	if (err < 0) {
> +		mutex_unlock(&cmdq->task_mutex);
>  		return err;
> +	}
>  
>  	task_cb.cb = cb;
>  	task_cb.data = data;
>  	*task_out = cmdq_task_acquire(rec, task_cb);
> -	if (!(*task_out))
> +	if (!(*task_out)) {
> +		mutex_unlock(&cmdq->task_mutex);
>  		return -EFAULT;
> +	}
>  
>  	thread = &cmdq->thread[cmdq_eng_get_thread((*task_out)->engine_flag)];
>  	cmdq_task_exec(*task_out, thread);
> +	mutex_unlock(&cmdq->task_mutex);
>  	return 0;
>  }
>  
> @@ -802,7 +857,13 @@ int cmdq_rec_flush_async(struct cmdq_rec *rec, cmdq_async_flush_cb cb,
>  	err = _cmdq_rec_flush(rec, &task, cb, data);
>  	if (err < 0)
>  		return err;
> -	cmdq_task_wait_release_schedule(task);
> +
> +	/*
> +	 * Task could be released in suspend flow,
> +	 * so we have to pass cmdq as parameter.
> +	 */
> +	cmdq_task_wait_release_schedule(rec->cmdq, task);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(cmdq_rec_flush_async);
> @@ -814,6 +875,95 @@ void cmdq_rec_destroy(struct cmdq_rec *rec)
>  }
>  EXPORT_SYMBOL(cmdq_rec_destroy);
>  
> +static int cmdq_suspend(struct device *dev)
> +{
> +	struct cmdq *cmdq = dev_get_drvdata(dev);
> +	u32 exec_threads;
> +	int ref_count;
> +	unsigned long flags;
> +	struct cmdq_thread *thread;
> +	struct cmdq_task *task, *tmp;
> +	int i;
> +
> +	/* lock to prevent new tasks */
> +	mutex_lock(&cmdq->task_mutex);
> +	cmdq->suspending = true;
> +
> +	exec_threads = readl(cmdq->base + CMDQ_CURR_LOADED_THR);
> +	ref_count = atomic_read(&cmdq->thread_usage);
> +	if (ref_count <= 0 && !(exec_threads & CMDQ_THR_EXECUTING))
> +		goto exit;
> +
> +	dev_err(dev, "suspend: kill running, tasks.\n");
> +	dev_err(dev, "threads: 0x%08x, ref:%d\n", exec_threads, ref_count);
> +
> +	/*
> +	 * We need to ensure the system is ready to suspend,
> +	 * so kill all running CMDQ tasks and release HW engines.
> +	 */
> +
> +	/* remove all active tasks from thread and disable thread */
> +	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
> +		thread = &cmdq->thread[i];
> +
> +		if (list_empty(&thread->task_busy_list))
> +			continue;
> +
> +		/* prevent clk disable in release flow */
> +		clk_prepare_enable(cmdq->clock);
> +		cmdq_thread_suspend(cmdq, thread);
> +
> +		list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
> +					 list_entry) {
> +			bool already_done = false;
> +
> +			spin_lock_irqsave(&cmdq->exec_lock, flags);
> +			if (task->task_state == TASK_STATE_BUSY) {
> +				/* still wait_event */
> +				list_del(&task->list_entry);
> +				task->task_state = TASK_STATE_KILLED;
> +			} else {
> +				/* almost finish its work */
> +				already_done = true;
> +			}
> +			spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> +
> +			/*
> +			 * TASK_STATE_KILLED will unlock
> +			 * wait_event_timeout in cmdq_task_wait_and_release(),
> +			 * so flush_work to wait auto release flow.
> +			 *
> +			 * We don't know processes running order,
> +			 * so call cmdq_task_release_unlocked() here to
> +			 * prevent releasing task before flush_work, and
> +			 * also to prevent deadlock of task_mutex.
> +			 */
> +			if (!already_done) {
> +				flush_work(&task->release_work);
> +				cmdq_task_release_unlocked(task);
> +			}
> +		}
> +
> +		cmdq_thread_resume(thread);
> +		cmdq_thread_disable(cmdq, &cmdq->thread[i]);
> +		clk_disable_unprepare(cmdq->clock);
> +	}

It's cmdq client's bug if there are some tasks have not been executed
while cmdq is suspending. I think cmdq can simply wait these tasks to be
done or timeout rather than killing them because it's unnecessary to
speed up anything in error state. Just wait for cmdq client to fix this
bug.

This 'for loop' can be simply replace by:

flush_workqueue(cmdq->task_release_wq);

But this does not wait for task which is created by cmdq_rec_flush().
One solution for this is to re-write cmdq_rec_flush() as below:

struct cmdq_flush_completion {
	struct completion cmplt;
	bool err;
};

static int cmdq_rec_flush_cb(struct cmdq_cb_data data)
{
	struct cmdq_flush_completion *cmplt = data.data;

	cmplt->err = data.err;
	complete(&cmplt->cmplt);

	return 0;
}

int cmdq_rec_flush(struct cmdq_rec *rec)
{
	int err;
	struct cmdq_flush_completion cmplt;

	init_completion(&cmplt.cmplt);
	err = cmdq_rec_flush_async(rec, cmdq_rec_flush_cb, &cmplt);
	if (err < 0)
		return err;
	wait_for_completion(&cmplt.cmplt);
	return cmplt.err ? -EFAULT : 0;
}


> +
> +exit:
> +	cmdq->suspended = true;
> +	cmdq->suspending = false;
> +	mutex_unlock(&cmdq->task_mutex);
> +	return 0; /* ALWAYS allow suspend */
> +}
> +
> +static int cmdq_resume(struct device *dev)
> +{
> +	struct cmdq *cmdq = dev_get_drvdata(dev);
> +
> +	cmdq->suspended = false;
> +	return 0;
> +}
> +
>  static int cmdq_remove(struct platform_device *pdev)
>  {
>  	struct cmdq *cmdq = platform_get_drvdata(pdev);
> @@ -852,6 +1002,7 @@ static int cmdq_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
>  		dev, cmdq->base, cmdq->irq);
>  
> +	mutex_init(&cmdq->task_mutex);
>  	spin_lock_init(&cmdq->exec_lock);
>  	cmdq->task_release_wq = alloc_ordered_workqueue(
>  			"%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
> @@ -879,6 +1030,7 @@ static int cmdq_probe(struct platform_device *pdev)
>  		err = PTR_ERR(cmdq->clock);
>  		goto fail;
>  	}
> +
>  	return 0;
>  
>  fail:
> @@ -886,6 +1038,11 @@ fail:
>  	return err;
>  }
>  
> +static const struct dev_pm_ops cmdq_pm_ops = {
> +	.suspend = cmdq_suspend,
> +	.resume = cmdq_resume,
> +};
> +
>  static const struct of_device_id cmdq_of_ids[] = {
>  	{.compatible = "mediatek,mt8173-gce",},
>  	{}
> @@ -897,6 +1054,7 @@ static struct platform_driver cmdq_drv = {
>  	.driver = {
>  		.name = CMDQ_DRIVER_DEVICE_NAME,
>  		.owner = THIS_MODULE,
> +		.pm = &cmdq_pm_ops,
>  		.of_match_table = cmdq_of_ids,
>  	}
>  };
