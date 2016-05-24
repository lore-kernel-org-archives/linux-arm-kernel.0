From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Tue, 24 May 2016 20:34:51 +0800
Subject: [PATCH v7 4/4] CMDQ: suspend/resume protection
In-Reply-To: <1464081410.30351.20.camel@mtksdaap41>
References: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
 <1464006190-344-5-git-send-email-hs.liao@mediatek.com>
 <1464081410.30351.20.camel@mtksdaap41>
Message-ID: <1464093291.19894.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Tue, 2016-05-24 at 17:16 +0800, CK Hu wrote:
> On Mon, 2016-05-23 at 20:23 +0800, HS Liao wrote:
...  
> > +static int cmdq_suspend(struct device *dev)
> > +{
> > +	struct cmdq *cmdq = dev_get_drvdata(dev);
> > +	u32 exec_threads;
> > +	int ref_count;
> > +	unsigned long flags;
> > +	struct cmdq_thread *thread;
> > +	struct cmdq_task *task, *tmp;
> > +	int i;
> > +
> > +	/* lock to prevent new tasks */
> > +	mutex_lock(&cmdq->task_mutex);
> > +	cmdq->suspending = true;
> > +
> > +	exec_threads = readl(cmdq->base + CMDQ_CURR_LOADED_THR);
> > +	ref_count = atomic_read(&cmdq->thread_usage);
> > +	if (ref_count <= 0 && !(exec_threads & CMDQ_THR_EXECUTING))
> > +		goto exit;
> > +
> > +	dev_err(dev, "suspend: kill running, tasks.\n");
> > +	dev_err(dev, "threads: 0x%08x, ref:%d\n", exec_threads, ref_count);
> > +
> > +	/*
> > +	 * We need to ensure the system is ready to suspend,
> > +	 * so kill all running CMDQ tasks and release HW engines.
> > +	 */
> > +
> > +	/* remove all active tasks from thread and disable thread */
> > +	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
> > +		thread = &cmdq->thread[i];
> > +
> > +		if (list_empty(&thread->task_busy_list))
> > +			continue;
> > +
> > +		/* prevent clk disable in release flow */
> > +		clk_prepare_enable(cmdq->clock);
> > +		cmdq_thread_suspend(cmdq, thread);
> > +
> > +		list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
> > +					 list_entry) {
> > +			bool already_done = false;
> > +
> > +			spin_lock_irqsave(&cmdq->exec_lock, flags);
> > +			if (task->task_state == TASK_STATE_BUSY) {
> > +				/* still wait_event */
> > +				list_del(&task->list_entry);
> > +				task->task_state = TASK_STATE_KILLED;
> > +			} else {
> > +				/* almost finish its work */
> > +				already_done = true;
> > +			}
> > +			spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > +
> > +			/*
> > +			 * TASK_STATE_KILLED will unlock
> > +			 * wait_event_timeout in cmdq_task_wait_and_release(),
> > +			 * so flush_work to wait auto release flow.
> > +			 *
> > +			 * We don't know processes running order,
> > +			 * so call cmdq_task_release_unlocked() here to
> > +			 * prevent releasing task before flush_work, and
> > +			 * also to prevent deadlock of task_mutex.
> > +			 */
> > +			if (!already_done) {
> > +				flush_work(&task->release_work);
> > +				cmdq_task_release_unlocked(task);
> > +			}
> > +		}
> > +
> > +		cmdq_thread_resume(thread);
> > +		cmdq_thread_disable(cmdq, &cmdq->thread[i]);
> > +		clk_disable_unprepare(cmdq->clock);
> > +	}
> 
> It's cmdq client's bug if there are some tasks have not been executed
> while cmdq is suspending. I think cmdq can simply wait these tasks to be
> done or timeout rather than killing them because it's unnecessary to
> speed up anything in error state. Just wait for cmdq client to fix this
> bug.
> 
> This 'for loop' can be simply replace by:
> 
> flush_workqueue(cmdq->task_release_wq);
> 
> But this does not wait for task which is created by cmdq_rec_flush().
> One solution for this is to re-write cmdq_rec_flush() as below:
> 
> struct cmdq_flush_completion {
> 	struct completion cmplt;
> 	bool err;
> };
> 
> static int cmdq_rec_flush_cb(struct cmdq_cb_data data)
> {
> 	struct cmdq_flush_completion *cmplt = data.data;
> 
> 	cmplt->err = data.err;
> 	complete(&cmplt->cmplt);
> 
> 	return 0;
> }
> 
> int cmdq_rec_flush(struct cmdq_rec *rec)
> {
> 	int err;
> 	struct cmdq_flush_completion cmplt;
> 
> 	init_completion(&cmplt.cmplt);
> 	err = cmdq_rec_flush_async(rec, cmdq_rec_flush_cb, &cmplt);
> 	if (err < 0)
> 		return err;
> 	wait_for_completion(&cmplt.cmplt);
> 	return cmplt.err ? -EFAULT : 0;
> }
> 

Will do and merge into CMDQ driver.

> > +
> > +exit:
> > +	cmdq->suspended = true;
> > +	cmdq->suspending = false;
> > +	mutex_unlock(&cmdq->task_mutex);
> > +	return 0; /* ALWAYS allow suspend */
> > +}
> > +
...

Thanks,
HS
