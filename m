From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Tue, 24 May 2016 20:27:09 +0800
Subject: [PATCH v7 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464059159.7425.6.camel@mtksdaap41>
References: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
 <1464006190-344-3-git-send-email-hs.liao@mediatek.com>
 <1464059159.7425.6.camel@mtksdaap41>
Message-ID: <1464092829.19894.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

Reply in line.

On Tue, 2016-05-24 at 11:05 +0800, CK Hu wrote:
> Hi, HS:
> 
> Some comments below.
> 
> On Mon, 2016-05-23 at 20:23 +0800, HS Liao wrote:
...
> > +struct cmdq_task {
> > +	struct cmdq		*cmdq;
> > +	struct list_head	list_entry;
> > +	enum cmdq_task_state	task_state;
> > +	void			*va_base; /* va */
> 
> It's obviously that va_base is va, so the comment is redundant.

Will remove comment.

> > +	dma_addr_t		mva_base; /* pa */
> > +	u64			engine_flag;
> > +	size_t			command_size;
> > +	u32			num_cmd;
> > +	struct cmdq_thread	*thread;
> > +	struct cmdq_task_cb	cb;
> > +	struct work_struct	release_work;
> > +};
...
> > +static struct cmdq_task *cmdq_task_acquire(struct cmdq_rec *rec,
> > +					   struct cmdq_task_cb cb)
> > +{
> > +	struct cmdq *cmdq = rec->cmdq;
> > +	struct device *dev = cmdq->dev;
> > +	struct cmdq_task *task;
> > +
> > +	task = kzalloc(sizeof(*task), GFP_KERNEL);
> > +	INIT_LIST_HEAD(&task->list_entry);
> > +	task->va_base = dma_alloc_coherent(dev, rec->command_size,
> > +					   &task->mva_base, GFP_KERNEL);
> > +	if (!task->va_base) {
> > +		dev_err(dev, "allocate command buffer failed\n");
> > +		kfree(task);
> > +		return NULL;
> > +	}
> > +
> > +	task->cmdq = cmdq;
> > +	task->command_size = rec->command_size;
> > +	task->engine_flag = rec->engine_flag;
> > +	task->task_state = TASK_STATE_BUSY;
> > +	task->cb = cb;
> > +	memcpy(task->va_base, rec->buf, rec->command_size);
> > +	task->num_cmd = task->command_size / sizeof(u64);
> 
> Already define CMDQ_INST_SIZE, so use it and the readability is better.

Will use CMDQ_INST_SIZE.

> > +	return task;
> > +}
...
> > +static void cmdq_task_exec(struct cmdq_task *task, struct cmdq_thread *thread)
> > +{
> > +	struct cmdq *cmdq = task->cmdq;
> > +	unsigned long flags;
> > +	unsigned long curr_pa, end_pa;
> > +
> > +	WARN_ON(clk_prepare_enable(cmdq->clock) < 0);
> > +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> > +	task->thread = thread;
> > +	task->task_state = TASK_STATE_BUSY;
> 
> Once a task is created, its state is already BUSY, so this assignment is
> redundant.

I prefer to keep this because task may add, remove, or reorder states in
the future. If we remove this, it is easy to cause a bug here.

> > +	if (list_empty(&thread->task_busy_list)) {
> > +		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
> > +
> > +		cmdq_thread_writel(thread, task->mva_base, CMDQ_THR_CURR_ADDR);
> > +		cmdq_thread_writel(thread, task->mva_base + task->command_size,
> > +				   CMDQ_THR_END_ADDR);
> > +		cmdq_thread_writel(thread, CMDQ_THR_PRIORITY, CMDQ_THR_CFG);
> > +		cmdq_thread_writel(thread, CMDQ_THR_IRQ_EN,
> > +				   CMDQ_THR_IRQ_ENABLE);
> > +
> > +		list_move_tail(&task->list_entry,
> > +			       &thread->task_busy_list);
> 
> Moving this statement to just before spin_unlock_irqrestore() can reduce
> the duplicated code in else part.

Will do.

> > +
> > +		cmdq_thread_writel(thread, CMDQ_THR_ENABLED,
> > +				   CMDQ_THR_ENABLE_TASK);
> > +	} else {
> > +		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > +
> > +		/*
> > +		 * check boundary condition
> > +		 * PC = END - 8, EOC is executed
> > +		 * PC = END, all CMDs are executed
> > +		 */
> > +		curr_pa = cmdq_thread_readl(thread, CMDQ_THR_CURR_ADDR);
> > +		end_pa = cmdq_thread_readl(thread, CMDQ_THR_END_ADDR);
> > +		if (curr_pa == end_pa - 8 || curr_pa == end_pa) {
> > +			/* set to this task directly */
> > +			cmdq_thread_writel(thread, task->mva_base,
> > +					   CMDQ_THR_CURR_ADDR);
> > +		} else {
> > +			cmdq_task_insert_into_thread(task);
> > +
> > +			if (thread == &cmdq->thread[CMDQ_THR_DISP_MAIN_IDX] ||
> > +			    thread == &cmdq->thread[CMDQ_THR_DISP_SUB_IDX])
> > +				cmdq_task_remove_wfe(task);
> > +
> > +			smp_mb(); /* modify jump before enable thread */
> > +		}
> > +
> > +		cmdq_thread_writel(thread, task->mva_base + task->command_size,
> > +				   CMDQ_THR_END_ADDR);
> > +		list_move_tail(&task->list_entry, &thread->task_busy_list);
> > +		cmdq_thread_resume(thread);
> > +	}
> > +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > +}
...
> > +static void cmdq_thread_irq_handler(struct cmdq *cmdq, int tid)
> > +{
> > +	struct cmdq_thread *thread = &cmdq->thread[tid];
> > +	unsigned long flags = 0L;
> > +	int value;
> > +
> > +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> > +
> > +	/*
> > +	 * it is possible for another CPU core
> > +	 * to run "release task" right before we acquire the spin lock
> > +	 * and thus reset / disable this HW thread
> > +	 * so we check both the IRQ flag and the enable bit of this thread
> > +	 */
> > +	value = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> > +	if (!(value & CMDQ_THR_IRQ_MASK)) {
> > +		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > +		return;
> > +	}
> 
> If this case happen and just return without clearing irq status, the irq
> would keep triggering and system hang up. So just remove this checking
> and go down to clear irq status.

This case is safe because irq status is cleared.
But, next if condition has the problem which you mentioned.

I will change it as below.

	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
	      CMDQ_THR_ENABLED)) {
		cmdq_thread_writel(thread, ~value, CMDQ_THR_IRQ_STATUS);
		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
		return;
	}

If thread is disabled, tasks must be all finished.
Therefore, just clear irq status and return.

> > +
> > +	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
> > +	      CMDQ_THR_ENABLED)) {
> > +		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > +		return;
> > +	}
> > +
> > +	cmdq_thread_writel(thread, ~value, CMDQ_THR_IRQ_STATUS);
> > +
> > +	if (value & CMDQ_THR_IRQ_ERROR)
> > +		cmdq_handle_error_done(cmdq, thread, true);
> > +	else if (value & CMDQ_THR_IRQ_DONE)
> > +		cmdq_handle_error_done(cmdq, thread, false);
> 
> These irq status checking and clearing code here is the same as those in
> cmdq_task_handle_error_result(). To move the checking and clearing code
> into cmdq_handle_error_done() and here just to call
> cmdq_handle_error_done(cmdq, thread) would reduce duplicated code.

Will do.

> > +
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
> > +	/* suspend HW thread to ensure consistency */
> > +	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
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
> > +
> > +	/*
> > +	 * Although IRQ is disabled, GCE continues to execute.
> > +	 * It may have pending IRQ before HW thread is suspended,
> > +	 * so check this condition again.
> > +	 */
> > +	irq_flag = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> > +	if (irq_flag & CMDQ_THR_IRQ_ERROR)
> > +		cmdq_handle_error_done(cmdq, thread, true);
> > +	else if (irq_flag & CMDQ_THR_IRQ_DONE)
> > +		cmdq_handle_error_done(cmdq, thread, false);
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
> > +			cmdq_thread_writel(thread, next_task->mva_base,
> > +					   CMDQ_THR_CURR_ADDR);
> > +		cmdq_thread_resume(thread);
> > +		return -ECANCELED;
> > +	}
> > +
> > +	/* If task is running, force to remove it. */
> > +	dev_err(dev, "task 0x%p timeout or killed\n", task);
> > +
> > +	if (task->task_state == TASK_STATE_BUSY)
> 
> The state must be BUSY here, so the checking is redundant.

Will remove.

> > +		task->task_state = TASK_STATE_ERROR;
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
> > +		cmdq_thread_writel(thread, next_task->mva_base,
> > +				   CMDQ_THR_CURR_ADDR);
> > +	}
> > +
> > +	list_del(&task->list_entry);
> > +	cmdq_thread_resume(thread);
> > +
> > +	/* call cb here to prevent lock */
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
> > +
> > +static int cmdq_task_wait_and_release(struct cmdq_task *task)
> > +{
> > +	struct cmdq *cmdq = task->cmdq;
> > +	struct device *dev = cmdq->dev;
> > +	struct cmdq_thread *thread = task->thread;
> > +	int wait_q;
> > +	int err = 0;
> > +	unsigned long flags;
> > +
> > +	wait_q = wait_event_timeout(thread->wait_queue,
> > +				    task->task_state != TASK_STATE_BUSY,
> > +				    msecs_to_jiffies(CMDQ_DEFAULT_TIMEOUT_MS));
> > +	if (!wait_q)
> > +		dev_dbg(dev, "timeout!\n");
> 
> Task state may be changed in cmdq_task_handle_error_result() and the
> actual time out message print is in cmdq_task_handle_error_result(), so
> this print should be removed.

Will remove.

> > +
> > +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> > +	if (task->task_state != TASK_STATE_DONE)
> > +		err = cmdq_task_handle_error_result(task);
> > +	if (list_empty(&thread->task_busy_list))
> > +		cmdq_thread_disable(cmdq, thread);
> > +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > +
> > +	/* release regardless of success or not */
> > +	clk_disable_unprepare(cmdq->clock);
> > +	cmdq_task_release(task);
> > +
> > +	return err;
> > +}
...
> 
> Regards,
> CK

Thanks,
HS
