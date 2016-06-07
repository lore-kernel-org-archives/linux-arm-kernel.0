From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 7 Jun 2016 19:04:27 +0200
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <5756FE9B.6020107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/05/16 05:19, HS Liao wrote:
> This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> CMDQ is used to help read/write registers with critical time limitation,
> such as updating display configuration during the vblank. It controls
> Global Command Engine (GCE) hardware to achieve this requirement.
> Currently, CMDQ only supports display related hardwares, but we expect
> it can be extended to other hardwares for future requirements.
>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---

[...]

> +static void cmdq_handle_error_done(struct cmdq *cmdq,
> +				   struct cmdq_thread *thread, u32 irq_flag)
> +{
> +	struct cmdq_task *task, *tmp, *curr_task = NULL;
> +	u32 curr_pa;
> +	struct cmdq_cb_data cmdq_cb_data;
> +	bool err;
> +
> +	if (irq_flag & CMDQ_THR_IRQ_ERROR)
> +		err = true;
> +	else if (irq_flag & CMDQ_THR_IRQ_DONE)
> +		err = false;
> +	else
> +		return;
> +
> +	curr_pa = cmdq_thread_readl(thread, CMDQ_THR_CURR_ADDR);
> +
> +	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
> +				 list_entry) {
> +		if (curr_pa >= task->pa_base &&
> +		    curr_pa < (task->pa_base + task->command_size))
> +			curr_task = task;
> +		if (task->cb.cb) {
> +			cmdq_cb_data.err = curr_task ? err : false;
> +			cmdq_cb_data.data = task->cb.data;
> +			task->cb.cb(cmdq_cb_data);
> +		}

I think this is not right. If we got an IRQ_DONE, then the current task 
is in execution, we should not call the callback until it has finished.

Regards,
Matthias
