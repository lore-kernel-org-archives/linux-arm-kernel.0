From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Mon, 30 May 2016 17:38:03 +0800
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464590942.20547.22.camel@mtksdaap41>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
 <1464590942.20547.22.camel@mtksdaap41>
Message-ID: <1464601083.20071.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

Reply inline.

On Mon, 2016-05-30 at 14:49 +0800, CK Hu wrote:
> Hi, HS:
> 
> Some comments inline.
> 
> On Mon, 2016-05-30 at 11:19 +0800, HS Liao wrote:
...
> > +static void cmdq_thread_irq_handler(struct cmdq *cmdq, int tid)
> > +{
> > +	struct cmdq_thread *thread = &cmdq->thread[tid];
> > +	unsigned long flags = 0L;
> > +	u32 irq_flag;
> > +
> > +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> > +
> > +	irq_flag = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> > +	cmdq_thread_writel(thread, ~irq_flag, CMDQ_THR_IRQ_STATUS);
> > +
> > +	/*
> > +	 * Another CPU core could run "release task" right before we acquire
> > +	 * the spin lock, and thus reset / disable this GCE thread, so we
> > +	 * need to check the enable bit of this GCE thread.
> > +	 */
> > +	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
> > +	      CMDQ_THR_ENABLED))
> > +		irq_flag = 0;
> 
> These three statement (clear irq flag and detect thread enable) can be
> moved into cmdq_handle_error_done() and the duplicated part in
> cmdq_task_handle_error_result() can be removed. Even though
> cmdq_task_handle_error_result() need not check thread enable, it would
> not influence the flow.

Will do.

> > +
> > +	cmdq_handle_error_done(cmdq, thread, irq_flag);
> > +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > +}
...
> > +static int cmdq_task_handle_error_result(struct cmdq_task *task)
> > +{
> > +	struct cmdq *cmdq = task->cmdq;
> > +	struct device *dev = cmdq->dev;
> > +	struct cmdq_thread *thread = task->thread;
> > +	struct cmdq_task *next_task, *prev_task;
> > +	u32 irq_flag;
> > +
> > +	/* suspend GCE thread to ensure consistency */
> > +	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > +
> > +	/* ISR has handled this error task */
> > +	if (task->task_state == TASK_STATE_ERROR) {
> > +		next_task = list_first_entry_or_null(&thread->task_busy_list,
> > +				struct cmdq_task, list_entry);
> > +		if (next_task) /* move to next task */
> > +			cmdq_thread_writel(thread, next_task->pa_base,
> > +					   CMDQ_THR_CURR_ADDR);
> > +		cmdq_thread_resume(thread);
> > +		return -ECANCELED;
> > +	}
> > +
> > +	/*
> > +	 * Save next_task and prev_task in advance
> > +	 * since cmdq_handle_error_done will remove list_entry.
> > +	 */
> > +	next_task = prev_task = NULL;
> > +	if (task->list_entry.next != &thread->task_busy_list)
> > +		next_task = list_next_entry(task, list_entry);
> > +	if (task->list_entry.prev != &thread->task_busy_list)
> > +		prev_task = list_prev_entry(task, list_entry);
> 
> I think there is always no previous task because task order in
> thread->task_busy_list is the same as in cmdq->task_release_wq. So each
> task processed by release work should be the first item in
> thread->task_busy_list or be removed from thread->task_busy_list.

Will remove previous task.

> > +
> > +	/*
> > +	 * Although IRQ is disabled, GCE continues to execute.
> > +	 * It may have pending IRQ before GCE thread is suspended,
> > +	 * so check this condition again.
> > +	 */
> > +	irq_flag = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> > +	cmdq_handle_error_done(cmdq, thread, irq_flag);
> > +	cmdq_thread_writel(thread, ~irq_flag, CMDQ_THR_IRQ_STATUS);
> > +
> > +	if (task->task_state == TASK_STATE_DONE) {
> > +		cmdq_thread_resume(thread);
> > +		return 0;
> > +	}
> > +
> > +	if (task->task_state == TASK_STATE_ERROR) {
> > +		dev_err(dev, "task 0x%p error\n", task);
> > +		if (next_task) /* move to next task */
> > +			cmdq_thread_writel(thread, next_task->pa_base,
> > +					   CMDQ_THR_CURR_ADDR);
> > +		cmdq_thread_resume(thread);
> > +		return -ECANCELED;
> > +	}
> > +
> > +	/* Task is running, so we force to remove it. */
> > +	dev_err(dev, "task 0x%p timeout or killed\n", task);
> 
> No 'kill' state.

>From CMDQ v8, there is no killed task.
I will rewrite output message.

> > +	task->task_state = TASK_STATE_ERROR;
> > +
> > +	if (prev_task) {
> > +		u64 *prev_va = prev_task->va_base;
> > +		u64 *curr_va = task->va_base;
> > +
> > +		/* copy JUMP instruction */
> > +		prev_va[prev_task->num_cmd - 1] = curr_va[task->num_cmd - 1];
> > +
> > +		cmdq_thread_invalidate_fetched_data(thread);
> > +	} else if (next_task) { /* move to next task */
> > +		cmdq_thread_writel(thread, next_task->pa_base,
> > +				   CMDQ_THR_CURR_ADDR);
> > +	}
> 
> Just one statement in 'else if' part. So remove the parentheses.

I think we should keep this parentheses.

Quote from CodingStyle document:

This does not apply if only one branch of a conditional statement is a
single
statement; in the latter case use braces in both branches:

if (condition) {
        do_this();
        do_that();
} else {
        otherwise();
}

> > +
> > +	list_del(&task->list_entry);
> > +	cmdq_thread_resume(thread);
> > +
> > +	/* call cb here to prevent lock */
> 
> I think these three statements should be place together and there should
> be no this comment.
> 
> 1. Change task state to DONE or ERROR.
> 2. Callback
> 3. Remove task from task_busy_list.

I will put these three statements together and wrap up them as a
function.

> > +	if (task->cb.cb) {
> > +		struct cmdq_cb_data cmdq_cb_data;
> > +
> > +		cmdq_cb_data.err = true;
> > +		cmdq_cb_data.data = task->cb.data;
> > +		task->cb.cb(cmdq_cb_data);
> > +	}
> > +
> > +	return -ECANCELED;
> > +}
...
> > +static int cmdq_suspend(struct device *dev)
> > +{
> > +	struct cmdq *cmdq = dev_get_drvdata(dev);
> > +	u32 exec_threads;
> > +
> > +	mutex_lock(&cmdq->task_mutex);
> > +	cmdq->suspended = true;
> > +	mutex_unlock(&cmdq->task_mutex);
> > +
> > +	exec_threads = readl(cmdq->base + CMDQ_CURR_LOADED_THR);
> > +	if ((exec_threads & CMDQ_THR_EXECUTING) && !cmdq_task_is_empty(cmdq)) {
> > +		dev_err(dev, "wait active tasks timeout.\n");
> > +		flush_workqueue(cmdq->task_release_wq);
> > +	}
> 
> Maybe it need not to check exec_threads, it may be written as:
> 
> 	if (!cmdq_task_is_empty(cmdq))
> 		dev_err(dev, "wait active tasks timeout.\n");
> 
> 	flush_workqueue(cmdq->task_release_wq);
> 
> Even though task_busy_list is empty, that does not mean every task in
> cmdq->task_release_wq is finished. So always do flush
> cmdq->task_release_wq.

Will do.

> > +	return 0;
> > +}
> > +
...
> 
> Regards,
> CK
> 

Thanks,
HS
