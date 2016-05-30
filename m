From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 May 2016 17:31:11 +0200
Subject: [PATCH v8 2/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
References: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
 <1464578397-29743-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <574C5CBF.7060002@gmail.com>
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
>   drivers/soc/mediatek/Kconfig    |  10 +
>   drivers/soc/mediatek/Makefile   |   1 +
>   drivers/soc/mediatek/mtk-cmdq.c | 943 ++++++++++++++++++++++++++++++++++++++++
>   include/soc/mediatek/cmdq.h     | 197 +++++++++
>   4 files changed, 1151 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
>   create mode 100644 include/soc/mediatek/cmdq.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 0a4ea80..c4ad75c 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -1,6 +1,16 @@
>   #
>   # MediaTek SoC drivers
>   #
> +config MTK_CMDQ
> +	bool "MediaTek CMDQ Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select MTK_INFRACFG
> +	help
> +	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> +	  driver. The CMDQ is used to help read/write registers with critical
> +	  time limitation, such as updating display configuration during the
> +	  vblank.
> +
>   config MTK_INFRACFG
>   	bool "MediaTek INFRACFG Support"
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 12998b0..f7397ef 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq.o
>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
> new file mode 100644
> index 0000000..e9d6e1c
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-cmdq.c
> @@ -0,0 +1,943 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/suspend.h>
> +#include <linux/workqueue.h>
> +#include <soc/mediatek/cmdq.h>
> +
> +#define CMDQ_INITIAL_CMD_BLOCK_SIZE	PAGE_SIZE
> +#define CMDQ_INST_SIZE			8 /* instruction is 64-bit */
> +#define CMDQ_TIMEOUT_MS			1000
> +#define CMDQ_IRQ_MASK			0xffff
> +#define CMDQ_DRIVER_DEVICE_NAME		"mtk_cmdq"
> +#define CMDQ_CLK_NAME			"gce"

We can put the names in directly to un-bloat the defines.

> +
> +#define CMDQ_CURR_IRQ_STATUS		0x010
> +#define CMDQ_CURR_LOADED_THR		0x018
> +#define CMDQ_THR_SLOT_CYCLES		0x030
> +
> +#define CMDQ_THR_BASE			0x100
> +#define CMDQ_THR_SHIFT			0x080

Wouldn't be CMDQ_THR_SIZE more accurate?

> +#define CMDQ_THR_WARM_RESET		0x00
> +#define CMDQ_THR_ENABLE_TASK		0x04
> +#define CMDQ_THR_SUSPEND_TASK		0x08
> +#define CMDQ_THR_CURR_STATUS		0x0c
> +#define CMDQ_THR_IRQ_STATUS		0x10
> +#define CMDQ_THR_IRQ_ENABLE		0x14
> +#define CMDQ_THR_CURR_ADDR		0x20
> +#define CMDQ_THR_END_ADDR		0x24
> +#define CMDQ_THR_CFG			0x40
> +
> +#define CMDQ_THR_ENABLED		0x1
> +#define CMDQ_THR_DISABLED		0x0
> +#define CMDQ_THR_SUSPEND		0x1
> +#define CMDQ_THR_RESUME			0x0
> +#define CMDQ_THR_STATUS_SUSPENDED	BIT(1)
> +#define CMDQ_THR_DO_WARM_RESET		BIT(0)
> +#define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
> +#define CMDQ_THR_PRIORITY		3
> +#define CMDQ_THR_IRQ_DONE		0x1
> +#define CMDQ_THR_IRQ_ERROR		0x12
> +#define CMDQ_THR_IRQ_EN			0x13 /* done + error */

#define CMDQ_THR_IRQ_EN (CMDQ_THR_IRQ_ERROR | CMDQ_THR_IRQ_DONE)

> +#define CMDQ_THR_IRQ_MASK		0x13

never used.

> +#define CMDQ_THR_EXECUTING		BIT(31)
> +
> +#define CMDQ_ARG_A_WRITE_MASK		0xffff
> +#define CMDQ_SUBSYS_MASK		0x1f
> +#define CMDQ_OP_CODE_MASK		0xff000000
> +
> +#define CMDQ_OP_CODE_SHIFT		24

Couldn't we connect the mask with the shift, or aren't they related?

#define CMDQ_OP_CODE_MASK (0xff << CMDQ_OP_CODE_SHIFT)

> +#define CMDQ_SUBSYS_SHIFT		16
> +
> +#define CMDQ_WRITE_ENABLE_MASK		BIT(0)
> +#define CMDQ_JUMP_BY_OFFSET		0x10000000
> +#define CMDQ_JUMP_BY_PA			0x10000001
> +#define CMDQ_JUMP_PASS			CMDQ_INST_SIZE
> +#define CMDQ_WFE_UPDATE			BIT(31)
> +#define CMDQ_WFE_WAIT			BIT(15)
> +#define CMDQ_WFE_WAIT_VALUE		0x1
> +#define CMDQ_EOC_IRQ_EN			BIT(0)
> +
> +enum cmdq_thread_index {
> +	CMDQ_THR_DISP_MAIN_IDX,	/* main */
> +	CMDQ_THR_DISP_SUB_IDX,	/* sub */
> +	CMDQ_THR_DISP_MISC_IDX,	/* misc */
> +	CMDQ_THR_MAX_COUNT,	/* max */
> +};
> +
> +/*
> + * CMDQ_CODE_MOVE:
> + *   move value into internal register as mask
> + *   format: op mask
> + * CMDQ_CODE_WRITE:
> + *   write value into target register
> + *   format: op subsys address value
> + * CMDQ_CODE_JUMP:
> + *   jump by offset
> + *   format: op offset
> + * CMDQ_CODE_WFE:
> + *   wait for event and clear
> + *   it is just clear if no wait
> + *   format: [wait]  op event update:1 to_wait:1 wait:1
> + *           [clear] op event update:1 to_wait:0 wait:0
> + * CMDQ_CODE_EOC:
> + *   end of command
> + *   format: op irq_flag
> + */

I think we need more documentation of how this command queue engine is 
working. If not, I think it will be really complicated to understand how 
to use this.

> +enum cmdq_code {
> +	CMDQ_CODE_MOVE = 0x02,
> +	CMDQ_CODE_WRITE = 0x04,
> +	CMDQ_CODE_JUMP = 0x10,
> +	CMDQ_CODE_WFE = 0x20,
> +	CMDQ_CODE_EOC = 0x40,
> +};
> +
> +enum cmdq_task_state {
> +	TASK_STATE_BUSY, /* running on a GCE thread */
> +	TASK_STATE_ERROR,
> +	TASK_STATE_DONE,
> +};
> +
> +struct cmdq_task_cb {
> +	cmdq_async_flush_cb	cb;
> +	void			*data;
> +};
> +
> +struct cmdq_thread {
> +	void __iomem		*base;
> +	struct list_head	task_busy_list;
> +	wait_queue_head_t	wait_task_done;
> +};
> +
> +struct cmdq_task {
> +	struct cmdq		*cmdq;
> +	struct list_head	list_entry;
> +	enum cmdq_task_state	task_state;
> +	void			*va_base;
> +	dma_addr_t		pa_base;
> +	u64			engine_flag;
> +	size_t			command_size;
> +	u32			num_cmd;

num_cmd is directly connected to command_size. I prefer to just keep 
num_cmd and calculate the command_size where necessary.

> +	struct cmdq_thread	*thread;
> +	struct cmdq_task_cb	cb;
> +	struct work_struct	release_work;
> +};
> +
> +struct cmdq {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	u32			irq;
> +	struct workqueue_struct	*task_release_wq;
> +	struct cmdq_thread	thread[CMDQ_THR_MAX_COUNT];
> +	struct mutex		task_mutex;	/* for task */
> +	spinlock_t		exec_lock;	/* for exec */
> +	struct clk		*clock;
> +	bool			suspended;
> +};
> +
> +struct cmdq_subsys {
> +	u32	base;
> +	int	id;
> +};
> +
> +static const struct cmdq_subsys gce_subsys[] = {
> +	{0x1400, 1},
> +	{0x1401, 2},
> +	{0x1402, 3},
> +};
> +
> +static int cmdq_subsys_base_to_id(u32 base)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gce_subsys); i++)
> +		if (gce_subsys[i].base == base)
> +			return gce_subsys[i].id;
> +	return -EFAULT;
> +}
> +
> +static int cmdq_eng_get_thread(u64 flag)
> +{
> +	if (flag & BIT_ULL(CMDQ_ENG_DISP_DSI0))
> +		return CMDQ_THR_DISP_MAIN_IDX;
> +	else if (flag & BIT_ULL(CMDQ_ENG_DISP_DPI0))
> +		return CMDQ_THR_DISP_SUB_IDX;
> +	else
> +		return CMDQ_THR_DISP_MISC_IDX;
> +}
> +
> +static void cmdq_task_release(struct cmdq_task *task)
> +{
> +	struct cmdq *cmdq = task->cmdq;
> +
> +	dma_free_coherent(cmdq->dev, task->command_size, task->va_base,
> +			  task->pa_base);
> +	kfree(task);
> +}
> +
> +static struct cmdq_task *cmdq_task_acquire(struct cmdq_rec *rec,
> +					   struct cmdq_task_cb cb)
> +{
> +	struct cmdq *cmdq = rec->cmdq;
> +	struct device *dev = cmdq->dev;
> +	struct cmdq_task *task;
> +
> +	task = kzalloc(sizeof(*task), GFP_KERNEL);
> +	INIT_LIST_HEAD(&task->list_entry);
> +	task->va_base = dma_alloc_coherent(dev, rec->command_size,
> +					   &task->pa_base, GFP_KERNEL);
> +	if (!task->va_base) {
> +		dev_err(dev, "allocate command buffer failed\n");
> +		kfree(task);
> +		return NULL;
> +	}
> +
> +	task->cmdq = cmdq;
> +	task->command_size = rec->command_size;
> +	task->engine_flag = rec->engine_flag;
> +	task->task_state = TASK_STATE_BUSY;
> +	task->cb = cb;
> +	memcpy(task->va_base, rec->buf, rec->command_size);
> +	task->num_cmd = task->command_size / CMDQ_INST_SIZE;
> +	return task;
> +}
> +
> +static void cmdq_thread_writel(struct cmdq_thread *thread, u32 value,
> +			       u32 offset)
> +{
> +	writel(value, thread->base + offset);
> +}
> +
> +static u32 cmdq_thread_readl(struct cmdq_thread *thread, u32 offset)
> +{
> +	return readl(thread->base + offset);
> +}

We can get rid of cmdq_thread_readl/writel.

> +
> +static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
> +{
> +	u32 status;
> +
> +	cmdq_thread_writel(thread, CMDQ_THR_SUSPEND, CMDQ_THR_SUSPEND_TASK);
> +
> +	/* If already disabled, treat as suspended successful. */
> +	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
> +	      CMDQ_THR_ENABLED))
> +		return 0;
> +
> +	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_STATUS,
> +			status, status & CMDQ_THR_STATUS_SUSPENDED, 0, 10)) {
> +		dev_err(cmdq->dev, "suspend GCE thread 0x%x failed\n",
> +			(u32)(thread->base - cmdq->base));
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cmdq_thread_resume(struct cmdq_thread *thread)
> +{
> +	cmdq_thread_writel(thread, CMDQ_THR_RESUME, CMDQ_THR_SUSPEND_TASK);
> +}
> +
> +static int cmdq_thread_reset(struct cmdq *cmdq, struct cmdq_thread *thread)
> +{
> +	u32 warm_reset;
> +
> +	cmdq_thread_writel(thread, CMDQ_THR_DO_WARM_RESET, CMDQ_THR_WARM_RESET);
> +	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_WARM_RESET,
> +			warm_reset, !(warm_reset & CMDQ_THR_DO_WARM_RESET),
> +			0, 10)) {
> +		dev_err(cmdq->dev, "reset GCE thread 0x%x failed\n",
> +			(u32)(thread->base - cmdq->base));
> +		return -EFAULT;
> +	}
> +	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
> +	return 0;
> +}
> +
> +static void cmdq_thread_disable(struct cmdq *cmdq, struct cmdq_thread *thread)
> +{
> +	cmdq_thread_reset(cmdq, thread);
> +	cmdq_thread_writel(thread, CMDQ_THR_DISABLED, CMDQ_THR_ENABLE_TASK);
> +}
> +
> +/* notify GCE to re-fetch commands by setting GCE thread PC */
> +static void cmdq_thread_invalidate_fetched_data(struct cmdq_thread *thread)
> +{
> +	cmdq_thread_writel(thread,
> +			   cmdq_thread_readl(thread, CMDQ_THR_CURR_ADDR),
> +			   CMDQ_THR_CURR_ADDR);
> +}
> +
> +static void cmdq_task_insert_into_thread(struct cmdq_task *task)
> +{
> +	struct cmdq_thread *thread = task->thread;
> +	struct cmdq_task *prev_task = list_last_entry(
> +			&thread->task_busy_list, typeof(*task), list_entry);
> +	u64 *prev_task_base = prev_task->va_base;
> +
> +	/* let previous task jump to this task */
> +	prev_task_base[prev_task->num_cmd - 1] = (u64)CMDQ_JUMP_BY_PA << 32 |
> +						 task->pa_base;
> +
> +	cmdq_thread_invalidate_fetched_data(thread);
> +}
> +
> +/* we assume tasks in the same display GCE thread are waiting the same event. */
> +static void cmdq_task_remove_wfe(struct cmdq_task *task)
> +{
> +	u32 wfe_option = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> +	u32 wfe_op = CMDQ_CODE_WFE << CMDQ_OP_CODE_SHIFT;
> +	u32 *base = task->va_base;
> +	u32 num_cmd = task->num_cmd << 1;
> +	int i;
> +
> +	for (i = 0; i < num_cmd; i += 2)
> +		if (base[i] == wfe_option &&
> +		    (base[i + 1] & CMDQ_OP_CODE_MASK) == wfe_op) {
> +			base[i] = CMDQ_JUMP_PASS;
> +			base[i + 1] = CMDQ_JUMP_BY_OFFSET;
> +		}

After using the command buffer as a void pointer a u64 pointer, we now 
reference to it as u32. I would prefer to explain here, how the command 
looks like we are searching for and use a for loop passing task->num_cmd 
instead.

> +}
> +
> +static void cmdq_task_exec(struct cmdq_task *task, struct cmdq_thread *thread)
> +{
> +	struct cmdq *cmdq = task->cmdq;
> +	unsigned long flags;
> +	unsigned long curr_pa, end_pa;
> +
> +	WARN_ON(clk_prepare_enable(cmdq->clock) < 0);
> +	spin_lock_irqsave(&cmdq->exec_lock, flags);

cmdq_task_exec is called with cmdq->task_mutex held, so why do we need 
the spin_lock here? Can't we just use one of the two?

> +	task->thread = thread;
> +	task->task_state = TASK_STATE_BUSY;

That was already set in cmdq_task_acquire, why do we need to set it here 
again?

> +	if (list_empty(&thread->task_busy_list)) {
> +		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
> +
> +		cmdq_thread_writel(thread, task->pa_base, CMDQ_THR_CURR_ADDR);
> +		cmdq_thread_writel(thread, task->pa_base + task->command_size,
> +				   CMDQ_THR_END_ADDR);
> +		cmdq_thread_writel(thread, CMDQ_THR_PRIORITY, CMDQ_THR_CFG);
> +		cmdq_thread_writel(thread, CMDQ_THR_IRQ_EN,
> +				   CMDQ_THR_IRQ_ENABLE);
> +
> +		cmdq_thread_writel(thread, CMDQ_THR_ENABLED,
> +				   CMDQ_THR_ENABLE_TASK);
> +	} else {
> +		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> +
> +		/*
> +		 * check boundary condition
> +		 * PC = END - 8, EOC is executed
> +		 * PC = END, all CMDs are executed
> +		 */
> +		curr_pa = cmdq_thread_readl(thread, CMDQ_THR_CURR_ADDR);
> +		end_pa = cmdq_thread_readl(thread, CMDQ_THR_END_ADDR);
> +		if (curr_pa == end_pa - 8 || curr_pa == end_pa) {

8 refers to CMDQ_INST_SIZE, right?

> +			/* set to this task directly */
> +			cmdq_thread_writel(thread, task->pa_base,
> +					   CMDQ_THR_CURR_ADDR);
> +		} else {
> +			cmdq_task_insert_into_thread(task);
> +
> +			if (thread == &cmdq->thread[CMDQ_THR_DISP_MAIN_IDX] ||
> +			    thread == &cmdq->thread[CMDQ_THR_DISP_SUB_IDX])
> +				cmdq_task_remove_wfe(task);

We could do this check using the task->engine_flag, I suppose that's 
easier to undestand then.

> +
> +			smp_mb(); /* modify jump before enable thread */
> +		}
> +
> +		cmdq_thread_writel(thread, task->pa_base + task->command_size,
> +				   CMDQ_THR_END_ADDR);
> +		cmdq_thread_resume(thread);
> +	}
> +	list_move_tail(&task->list_entry, &thread->task_busy_list);
> +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> +}
> +
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

What are you checking here? It seems as if you make some implcit 
assumptions about pa_base and the order of execution of commands in the 
thread. Is it save to do so? Does dma_alloc_coherent give any guarantees 
about dma_handle?

> +			curr_task = task;
> +		if (task->cb.cb) {
> +			cmdq_cb_data.err = curr_task ? err : false;
> +			cmdq_cb_data.data = task->cb.data;
> +			task->cb.cb(cmdq_cb_data);
> +		}
> +		task->task_state = (curr_task && err) ? TASK_STATE_ERROR :
> +				TASK_STATE_DONE;
> +		list_del(&task->list_entry);
> +		if (curr_task)
> +			break;
> +	}
> +
> +	wake_up(&thread->wait_task_done);
> +}
> +
> +static void cmdq_thread_irq_handler(struct cmdq *cmdq, int tid)
> +{
> +	struct cmdq_thread *thread = &cmdq->thread[tid];
> +	unsigned long flags = 0L;
> +	u32 irq_flag;
> +
> +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> +
> +	irq_flag = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> +	cmdq_thread_writel(thread, ~irq_flag, CMDQ_THR_IRQ_STATUS);
> +
> +	/*
> +	 * Another CPU core could run "release task" right before we acquire
> +	 * the spin lock, and thus reset / disable this GCE thread, so we
> +	 * need to check the enable bit of this GCE thread.
> +	 */
> +	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
> +	      CMDQ_THR_ENABLED))
> +		irq_flag = 0;

cmdq_handle_error_done just retuns in this case. Programming this way 
just makes things confusing. What about:

if (cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
	      CMDQ_THR_ENABLED)
	cmdq_handle_error_done(cmdq, thread, irq_flag);
else
		irq_flag = 0;

spin_unlock_irqrestore(&cmdq->exec_lock, flags);

> +
> +	cmdq_handle_error_done(cmdq, thread, irq_flag);
> +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> +}
> +
> +static irqreturn_t cmdq_irq_handler(int irq, void *dev)
> +{
> +	struct cmdq *cmdq = dev;
> +	u32 irq_status;
> +	int i;
> +
> +	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS);
> +	irq_status &= CMDQ_IRQ_MASK;
> +	irq_status ^= CMDQ_IRQ_MASK;

irq_status can be much bigger then 3, which is the number of threads in 
the system (CMDQ_THR_MAX_COUNT). So why we use this mask here isn't 
clear to me.

> +
> +	if (!irq_status)
> +		return IRQ_NONE;
> +
> +	while (irq_status) {
> +		i = ffs(irq_status) - 1;
> +		irq_status &= ~BIT(i);
> +		cmdq_thread_irq_handler(cmdq, i);
> +	}

Can you explain how the irq status register looks like, that would it 
make much easier to understand what happens here.

> +
> +	return IRQ_HANDLED;	
> +}
> +
> +static int cmdq_task_handle_error_result(struct cmdq_task *task)

We never check the return values, why do we have them?

> +{
> +	struct cmdq *cmdq = task->cmdq;
> +	struct device *dev = cmdq->dev;
> +	struct cmdq_thread *thread = task->thread;
> +	struct cmdq_task *next_task, *prev_task;
> +	u32 irq_flag;
> +
> +	/* suspend GCE thread to ensure consistency */
> +	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> +
> +	/* ISR has handled this error task */
> +	if (task->task_state == TASK_STATE_ERROR) {
> +		next_task = list_first_entry_or_null(&thread->task_busy_list,
> +				struct cmdq_task, list_entry);
> +		if (next_task) /* move to next task */
> +			cmdq_thread_writel(thread, next_task->pa_base,
> +					   CMDQ_THR_CURR_ADDR);

We have to do this, as we suppose that the thread did not reach the jump 
instruction we put into it's command queue, right?

> +		cmdq_thread_resume(thread);
> +		return -ECANCELED;
> +	}
> +

if task_state != ERROR and != DONE. This means that the timeout of 
task_release_wq has timed out, right?

> +	/*
> +	 * Save next_task and prev_task in advance
> +	 * since cmdq_handle_error_done will remove list_entry.
> +	 */
> +	next_task = prev_task = NULL;
> +	if (task->list_entry.next != &thread->task_busy_list)
> +		next_task = list_next_entry(task, list_entry);
> +	if (task->list_entry.prev != &thread->task_busy_list)
> +		prev_task = list_prev_entry(task, list_entry);
> +
> +	/*
> +	 * Although IRQ is disabled, GCE continues to execute.
> +	 * It may have pending IRQ before GCE thread is suspended,
> +	 * so check this condition again.
> +	 */

The first thing we did in this function was suspending the thread. Why 
do we need this then?
To be honest this whole functions looks really like a design error. We 
have to sperate the states much clearer so that it is possible to 
understand what is happening in the GCE. Isn't it for example posible to 
have worker queues for timed out tasks and tasks with an error? I'm not 
sure how to do this, actually I'm not sure if I really understood how 
this is supposed to work.

How much do we win, when we patch the thread command queue for every 
task we add, instead of just taking one task after another from the 
task_busy_list?

> +	irq_flag = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> +	cmdq_handle_error_done(cmdq, thread, irq_flag);
> +	cmdq_thread_writel(thread, ~irq_flag, CMDQ_THR_IRQ_STATUS);
> +
> +	if (task->task_state == TASK_STATE_DONE) {
> +		cmdq_thread_resume(thread);
> +		return 0;
> +	}
> +
> +	if (task->task_state == TASK_STATE_ERROR) {
> +		dev_err(dev, "task 0x%p error\n", task);
> +		if (next_task) /* move to next task */
> +			cmdq_thread_writel(thread, next_task->pa_base,
> +					   CMDQ_THR_CURR_ADDR);
> +		cmdq_thread_resume(thread);
> +		return -ECANCELED;
> +	}
> +
> +	/* Task is running, so we force to remove it. */
> +	dev_err(dev, "task 0x%p timeout or killed\n", task);
> +	task->task_state = TASK_STATE_ERROR;
> +
> +	if (prev_task) {
> +		u64 *prev_va = prev_task->va_base;
> +		u64 *curr_va = task->va_base;
> +
> +		/* copy JUMP instruction */
> +		prev_va[prev_task->num_cmd - 1] = curr_va[task->num_cmd - 1];
> +
> +		cmdq_thread_invalidate_fetched_data(thread);
> +	} else if (next_task) { /* move to next task */
> +		cmdq_thread_writel(thread, next_task->pa_base,
> +				   CMDQ_THR_CURR_ADDR);
> +	}
> +
> +	list_del(&task->list_entry);
> +	cmdq_thread_resume(thread);
> +
> +	/* call cb here to prevent lock */
> +	if (task->cb.cb) {
> +		struct cmdq_cb_data cmdq_cb_data;
> +
> +		cmdq_cb_data.err = true;
> +		cmdq_cb_data.data = task->cb.data;
> +		task->cb.cb(cmdq_cb_data);
> +	}
> +
> +	return -ECANCELED;
> +}
> +
> +static void cmdq_task_wait_release_work(struct work_struct *work_item)
> +{
> +	struct cmdq_task *task = container_of(work_item, struct cmdq_task,
> +					      release_work);
> +	struct cmdq *cmdq = task->cmdq;
> +	struct cmdq_thread *thread = task->thread;
> +	unsigned long flags;
> +
> +	wait_event_timeout(thread->wait_task_done,
> +			   task->task_state != TASK_STATE_BUSY,
> +			   msecs_to_jiffies(CMDQ_TIMEOUT_MS));
> +
> +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> +	if (task->task_state != TASK_STATE_DONE)
> +		cmdq_task_handle_error_result(task);
> +	if (list_empty(&thread->task_busy_list))
> +		cmdq_thread_disable(cmdq, thread);
> +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> +
> +	/* release regardless of success or not */
> +	clk_disable_unprepare(cmdq->clock);
> +	cmdq_task_release(task);
> +}
> +
> +static void cmdq_task_wait_release_schedule(struct cmdq_task *task)
> +{
> +	struct cmdq *cmdq = task->cmdq;
> +
> +	INIT_WORK(&task->release_work, cmdq_task_wait_release_work);
> +	queue_work(cmdq->task_release_wq, &task->release_work);
> +}
> +
> +static int cmdq_rec_realloc_cmd_buffer(struct cmdq_rec *rec, size_t size)
> +{
> +	void *new_buf;
> +
> +	new_buf = krealloc(rec->buf, size, GFP_KERNEL | __GFP_ZERO);
> +	if (!new_buf)
> +		return -ENOMEM;
> +	rec->buf = new_buf;
> +	rec->buf_size = size;
> +	return 0;
> +}
> +
> +struct cmdq_base *cmdq_register_device(struct device *dev)
> +{
> +	struct cmdq_base *cmdq_base;
> +	struct resource res;
> +	int subsys;
> +	u32 base;
> +
> +	if (of_address_to_resource(dev->of_node, 0, &res))
> +		return NULL;
> +	base = (u32)res.start;
> +
> +	subsys = cmdq_subsys_base_to_id(base >> 16);
> +	if (subsys < 0)
> +		return NULL;
> +
> +	cmdq_base = devm_kmalloc(dev, sizeof(*cmdq_base), GFP_KERNEL);
> +	if (!cmdq_base)
> +		return NULL;
> +	cmdq_base->subsys = subsys;
> +	cmdq_base->base = base;
> +
> +	return cmdq_base;
> +}
> +EXPORT_SYMBOL(cmdq_register_device);
> +
> +int cmdq_rec_create(struct device *dev, u64 engine_flag,
> +		    struct cmdq_rec **rec_ptr)
> +{
> +	struct cmdq_rec *rec;
> +	int err;
> +
> +	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
> +	if (!rec)
> +		return -ENOMEM;
> +	rec->cmdq = dev_get_drvdata(dev);
> +	rec->engine_flag = engine_flag;
> +	err = cmdq_rec_realloc_cmd_buffer(rec, CMDQ_INITIAL_CMD_BLOCK_SIZE);

Just pass PAGE_SIZE here, no need for CMDQ_INITIAL_CMD_BLOCK_SIZE.

> +	if (err < 0) {
> +		kfree(rec);
> +		return err;
> +	}
> +	*rec_ptr = rec;
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_rec_create);
> +
> +static int cmdq_rec_append_command(struct cmdq_rec *rec, enum cmdq_code code,
> +				   u32 arg_a, u32 arg_b)
> +{
> +	u64 *cmd_ptr;
> +	int err;
> +
> +	if (WARN_ON(rec->finalized))
> +		return -EBUSY;
> +	if (code < CMDQ_CODE_MOVE || code > CMDQ_CODE_EOC)
> +		return -EINVAL;

cmdq_rec_append_command is just called from inside this driver and code 
is a enum. We can expect it to be correct, no need for this check.

> +	if (unlikely(rec->command_size + CMDQ_INST_SIZE > rec->buf_size)) {

command_size is the offset into the buffer to which a new command is 
written, so this name is highly confusing. I wonder if this would be 
easier to understand if we redefine command_size to something like the 
number of commands and divide/multiply CMDQ_INST_SIZE where this is needed.

> +		err = cmdq_rec_realloc_cmd_buffer(rec, rec->buf_size * 2);
> +		if (err < 0)
> +			return err;
> +	}
> +	cmd_ptr = rec->buf + rec->command_size;
> +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> +	rec->command_size += CMDQ_INST_SIZE;
> +	return 0;
> +}
> +
> +int cmdq_rec_write(struct cmdq_rec *rec, u32 value, struct cmdq_base *base,
> +		   u32 offset)
> +{
> +	u32 arg_a = ((base->base + offset) & CMDQ_ARG_A_WRITE_MASK) |
> +		    ((base->subsys & CMDQ_SUBSYS_MASK) << CMDQ_SUBSYS_SHIFT);

base->subsys is the id from gce_sybsys, so we can expect it to be 
correct, no need to mask with CMDQ_SUBSYS_MASK.

> +	return cmdq_rec_append_command(rec, CMDQ_CODE_WRITE, arg_a, value);
> +}
> +EXPORT_SYMBOL(cmdq_rec_write);
> +
> +int cmdq_rec_write_mask(struct cmdq_rec *rec, u32 value,
> +			struct cmdq_base *base, u32 offset, u32 mask)
> +{
> +	u32 offset_mask = offset;
> +	int err;
> +
> +	if (mask != 0xffffffff) {
> +		err = cmdq_rec_append_command(rec, CMDQ_CODE_MOVE, 0, ~mask);
> +		if (err < 0)
> +			return err;
> +		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> +	}
> +	return cmdq_rec_write(rec, value, base, offset_mask);
> +}
> +EXPORT_SYMBOL(cmdq_rec_write_mask);
> +
> +int cmdq_rec_wfe(struct cmdq_rec *rec, enum cmdq_event event)
> +{
> +	u32 arg_b;
> +
> +	if (event >= CMDQ_MAX_HW_EVENT_COUNT || event < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * bit 0-11: wait value
> +	 * bit 15: 1 - wait, 0 - no wait
> +	 * bit 16-27: update value
> +	 * bit 31: 1 - update, 0 - no update
> +	 */

I don't understand this comments. What are they for?

> +	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> +	return cmdq_rec_append_command(rec, CMDQ_CODE_WFE, event, arg_b);
> +}
> +EXPORT_SYMBOL(cmdq_rec_wfe);
> +
> +int cmdq_rec_clear_event(struct cmdq_rec *rec, enum cmdq_event event)
> +{
> +	if (event >= CMDQ_MAX_HW_EVENT_COUNT || event < 0)
> +		return -EINVAL;
> +
> +	return cmdq_rec_append_command(rec, CMDQ_CODE_WFE, event,
> +				       CMDQ_WFE_UPDATE);
> +}
> +EXPORT_SYMBOL(cmdq_rec_clear_event);
> +
> +static int cmdq_rec_finalize(struct cmdq_rec *rec)
> +{
> +	int err;
> +
> +	if (rec->finalized)
> +		return 0;
> +
> +	/* insert EOC and generate IRQ for each command iteration */
> +	err = cmdq_rec_append_command(rec, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> +	if (err < 0)
> +		return err;
> +
> +	/* JUMP to end */
> +	err = cmdq_rec_append_command(rec, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +	if (err < 0)
> +		return err;
> +

Does this need to be atomic?
What happens if after CODE_EOC and before CODE_JUMP some 
write/read/event gets added?
What happens if more commands get added to the queue after CODE_JUMP, 
but before finalized is set to true. Why don't you use atomic functions 
to access finalized?

> +	rec->finalized = true;
> +	return 0;
> +}
> +
> +int cmdq_rec_flush_async(struct cmdq_rec *rec, cmdq_async_flush_cb cb,
> +			 void *data)
> +{
> +	struct cmdq *cmdq = rec->cmdq;
> +	struct cmdq_task *task;
> +	struct cmdq_task_cb task_cb;
> +	struct cmdq_thread *thread;
> +	int err;
> +
> +	mutex_lock(&cmdq->task_mutex);
> +	if (cmdq->suspended) {
> +		dev_err(cmdq->dev, "%s is called after suspended\n", __func__);
> +		mutex_unlock(&cmdq->task_mutex);
> +		return -EPERM;
> +	}
> +
> +	err = cmdq_rec_finalize(rec);
> +	if (err < 0) {
> +		mutex_unlock(&cmdq->task_mutex);
> +		return err;
> +	}
> +
> +	task_cb.cb = cb;
> +	task_cb.data = data;
> +	task = cmdq_task_acquire(rec, task_cb);
> +	if (!task) {
> +		mutex_unlock(&cmdq->task_mutex);
> +		return -EFAULT;
> +	}
> +
> +	thread = &cmdq->thread[cmdq_eng_get_thread(task->engine_flag)];
> +	cmdq_task_exec(task, thread);
> +	cmdq_task_wait_release_schedule(task);
> +	mutex_unlock(&cmdq->task_mutex);
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_rec_flush_async);
> +
> +struct cmdq_flush_completion {
> +	struct completion cmplt;
> +	bool err;
> +};
> +
> +static int cmdq_rec_flush_cb(struct cmdq_cb_data data)
> +{
> +	struct cmdq_flush_completion *cmplt = data.data;
> +
> +	cmplt->err = data.err;
> +	complete(&cmplt->cmplt);
> +	return 0;
> +}
> +
> +int cmdq_rec_flush(struct cmdq_rec *rec)
> +{
> +	struct cmdq_flush_completion cmplt;
> +	int err;
> +
> +	init_completion(&cmplt.cmplt);
> +	err = cmdq_rec_flush_async(rec, cmdq_rec_flush_cb, &cmplt);
> +	if (err < 0)
> +		return err;
> +	wait_for_completion(&cmplt.cmplt);
> +	return cmplt.err ? -EFAULT : 0;
> +}
> +EXPORT_SYMBOL(cmdq_rec_flush);
> +
> +void cmdq_rec_destroy(struct cmdq_rec *rec)
> +{
> +	kfree(rec->buf);
> +	kfree(rec);
> +}
> +EXPORT_SYMBOL(cmdq_rec_destroy);
> +
> +static bool cmdq_task_is_empty(struct cmdq *cmdq)
> +{
> +	struct cmdq_thread *thread;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
> +		thread = &cmdq->thread[i];
> +		if (!list_empty(&thread->task_busy_list))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static int cmdq_suspend(struct device *dev)
> +{
> +	struct cmdq *cmdq = dev_get_drvdata(dev);
> +	u32 exec_threads;
> +
> +	mutex_lock(&cmdq->task_mutex);
> +	cmdq->suspended = true;
> +	mutex_unlock(&cmdq->task_mutex);
> +
> +	exec_threads = readl(cmdq->base + CMDQ_CURR_LOADED_THR);
> +	if ((exec_threads & CMDQ_THR_EXECUTING) && !cmdq_task_is_empty(cmdq)) {
> +		dev_err(dev, "wait active tasks timeout.\n");
> +		flush_workqueue(cmdq->task_release_wq);
> +	}
> +	return 0;
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
> +static int cmdq_remove(struct platform_device *pdev)
> +{
> +	struct cmdq *cmdq = platform_get_drvdata(pdev);
> +
> +	destroy_workqueue(cmdq->task_release_wq);
> +	cmdq->task_release_wq = NULL;
> +	return 0;
> +}
> +
> +static int cmdq_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct resource *res;
> +	struct cmdq *cmdq;
> +	int err, i;
> +
> +	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
> +	if (!cmdq)
> +		return -ENOMEM;
> +	cmdq->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cmdq->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(cmdq->base)) {
> +		dev_err(dev, "failed to ioremap gce\n");
> +		return PTR_ERR(cmdq->base);
> +	}
> +
> +	cmdq->irq = irq_of_parse_and_map(node, 0);
> +	if (!cmdq->irq) {
> +		dev_err(dev, "failed to get irq\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
> +		dev, cmdq->base, cmdq->irq);
> +
> +	mutex_init(&cmdq->task_mutex);
> +	spin_lock_init(&cmdq->exec_lock);
> +	cmdq->task_release_wq = alloc_ordered_workqueue(
> +			"%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
> +			"cmdq_task_wait_release");
> +
> +	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
> +		cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
> +				CMDQ_THR_SHIFT * i;
> +		init_waitqueue_head(&cmdq->thread[i].wait_task_done);
> +		INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
> +	}
> +
> +	platform_set_drvdata(pdev, cmdq);
> +
> +	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
> +			       CMDQ_DRIVER_DEVICE_NAME, cmdq);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register ISR (%d)\n", err);
> +		goto fail;
> +	}
> +
> +	cmdq->clock = devm_clk_get(dev, CMDQ_CLK_NAME);
> +	if (IS_ERR(cmdq->clock)) {
> +		dev_err(dev, "failed to get clk:%s\n", CMDQ_CLK_NAME);
> +		err = PTR_ERR(cmdq->clock);
> +		goto fail;
> +	}
> +	return 0;
> +
> +fail:
> +	cmdq_remove(pdev);
> +	return err;
> +}
> +
> +static const struct dev_pm_ops cmdq_pm_ops = {
> +	.suspend = cmdq_suspend,
> +	.resume = cmdq_resume,
> +};
> +
> +static const struct of_device_id cmdq_of_ids[] = {
> +	{.compatible = "mediatek,mt8173-gce",},
> +	{}
> +};
> +
> +static struct platform_driver cmdq_drv = {
> +	.probe = cmdq_probe,
> +	.remove = cmdq_remove,
> +	.driver = {
> +		.name = CMDQ_DRIVER_DEVICE_NAME,
> +		.owner = THIS_MODULE,
> +		.pm = &cmdq_pm_ops,
> +		.of_match_table = cmdq_of_ids,
> +	}
> +};
> +
> +builtin_platform_driver(cmdq_drv);
> diff --git a/include/soc/mediatek/cmdq.h b/include/soc/mediatek/cmdq.h
> new file mode 100644
> index 0000000..60eef3d
> --- /dev/null
> +++ b/include/soc/mediatek/cmdq.h
> @@ -0,0 +1,197 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MTK_CMDQ_H__
> +#define __MTK_CMDQ_H__
> +
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +enum cmdq_eng {
> +	CMDQ_ENG_DISP_AAL,
> +	CMDQ_ENG_DISP_COLOR0,
> +	CMDQ_ENG_DISP_COLOR1,
> +	CMDQ_ENG_DISP_DPI0,
> +	CMDQ_ENG_DISP_DSI0,
> +	CMDQ_ENG_DISP_DSI1,
> +	CMDQ_ENG_DISP_GAMMA,
> +	CMDQ_ENG_DISP_OD,
> +	CMDQ_ENG_DISP_OVL0,
> +	CMDQ_ENG_DISP_OVL1,
> +	CMDQ_ENG_DISP_PWM0,
> +	CMDQ_ENG_DISP_PWM1,
> +	CMDQ_ENG_DISP_RDMA0,
> +	CMDQ_ENG_DISP_RDMA1,
> +	CMDQ_ENG_DISP_RDMA2,
> +	CMDQ_ENG_DISP_UFOE,
> +	CMDQ_ENG_DISP_WDMA0,
> +	CMDQ_ENG_DISP_WDMA1,
> +	CMDQ_ENG_MAX,
> +};
> +
> +/* events for CMDQ and display */
> +enum cmdq_event {
> +	/* Display start of frame(SOF) events */
> +	CMDQ_EVENT_DISP_OVL0_SOF = 11,
> +	CMDQ_EVENT_DISP_OVL1_SOF = 12,
> +	CMDQ_EVENT_DISP_RDMA0_SOF = 13,
> +	CMDQ_EVENT_DISP_RDMA1_SOF = 14,
> +	CMDQ_EVENT_DISP_RDMA2_SOF = 15,
> +	CMDQ_EVENT_DISP_WDMA0_SOF = 16,
> +	CMDQ_EVENT_DISP_WDMA1_SOF = 17,
> +	/* Display end of frame(EOF) events */
> +	CMDQ_EVENT_DISP_OVL0_EOF = 39,
> +	CMDQ_EVENT_DISP_OVL1_EOF = 40,
> +	CMDQ_EVENT_DISP_RDMA0_EOF = 41,
> +	CMDQ_EVENT_DISP_RDMA1_EOF = 42,
> +	CMDQ_EVENT_DISP_RDMA2_EOF = 43,
> +	CMDQ_EVENT_DISP_WDMA0_EOF = 44,
> +	CMDQ_EVENT_DISP_WDMA1_EOF = 45,
> +	/* Mutex end of frame(EOF) events */
> +	CMDQ_EVENT_MUTEX0_STREAM_EOF = 53,
> +	CMDQ_EVENT_MUTEX1_STREAM_EOF = 54,
> +	CMDQ_EVENT_MUTEX2_STREAM_EOF = 55,
> +	CMDQ_EVENT_MUTEX3_STREAM_EOF = 56,
> +	CMDQ_EVENT_MUTEX4_STREAM_EOF = 57,
> +	/* Display underrun events */
> +	CMDQ_EVENT_DISP_RDMA0_UNDERRUN = 63,
> +	CMDQ_EVENT_DISP_RDMA1_UNDERRUN = 64,
> +	CMDQ_EVENT_DISP_RDMA2_UNDERRUN = 65,
> +	/* Keep this at the end of HW events */
> +	CMDQ_MAX_HW_EVENT_COUNT = 260,
> +};
> +
> +struct cmdq_cb_data {
> +	bool	err;
> +	void	*data;
> +};
> +
> +typedef int (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
> +
> +struct cmdq_task;
> +struct cmdq;
> +
> +struct cmdq_rec {
> +	struct cmdq		*cmdq;
> +	u64			engine_flag;
> +	size_t			command_size;
> +	void			*buf;
> +	size_t			buf_size;
> +	bool			finalized;
> +};
> +
> +struct cmdq_base {
> +	int	subsys;
> +	u32	base;

subsys can always be calculated via cmdq_subsys_base_to_id(base >> 16) 
so we can get rid of the struct, right?

> +};
> +
> +/**
> + * cmdq_register_device() - register device which needs CMDQ
> + * @dev:		device
> + *
> + * Return: cmdq_base pointer or NULL for failed
> + */
> +struct cmdq_base *cmdq_register_device(struct device *dev);
> +
> +/**
> + * cmdq_rec_create() - create command queue record
> + * @dev:		device
> + * @engine_flag:	command queue engine flag
> + * @rec_ptr:		command queue record pointer to retrieve cmdq_rec
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_rec_create(struct device *dev, u64 engine_flag,
> +		    struct cmdq_rec **rec_ptr);
> +
> +/**
> + * cmdq_rec_write() - append write command to the command queue record
> + * @rec:	the command queue record
> + * @value:	the specified target register value
> + * @base:	the command queue base
> + * @offset:	register offset from module base
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_rec_write(struct cmdq_rec *rec, u32 value,
> +		   struct cmdq_base *base, u32 offset);
> +
> +/**
> + * cmdq_rec_write_mask() - append write command with mask to the command
> + *			   queue record
> + * @rec:	the command queue record
> + * @value:	the specified target register value
> + * @base:	the command queue base
> + * @offset:	register offset from module base
> + * @mask:	the specified target register mask
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_rec_write_mask(struct cmdq_rec *rec, u32 value,
> +			struct cmdq_base *base, u32 offset, u32 mask);
> +
> +/**
> + * cmdq_rec_wfe() - append wait for event command to the command queue reco	rd

reco rd -> record

Regards,
Matthias

> + * @rec:	the command queue record
> + * @event:	the desired event type to "wait and CLEAR"
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_rec_wfe(struct cmdq_rec *rec, enum cmdq_event event);
> +
> +/**
> + * cmdq_rec_clear_event() - append clear event command to the command queue
> + *			    record
> + * @rec:	the command queue record
> + * @event:	the desired event to be cleared
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_rec_clear_event(struct cmdq_rec *rec, enum cmdq_event event);
> +
> +/**
> + * cmdq_rec_flush() - trigger CMDQ to execute the recorded commands
> + * @rec:	the command queue record
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Trigger CMDQ to execute the recorded commands. Note that this is a
> + * synchronous flush function. When the function returned, the recorded
> + * commands have been done.
> + */
> +int cmdq_rec_flush(struct cmdq_rec *rec);
> +
> +/**
> + * cmdq_rec_flush_async() - trigger CMDQ to asynchronously execute the recorded
> + *			    commands and call back after ISR is finished
> + * @rec:	the command queue record
> + * @cb:		called in the end of CMDQ ISR
> + * @data:	this data will pass back to cb
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Trigger CMDQ to asynchronously execute the recorded commands and call back
> + * after ISR is finished. Note that this is an ASYNC function. When the function
> + * returned, it may or may not be finished. The ISR callback function is called
> + * in the end of ISR.
> + */
> +int cmdq_rec_flush_async(struct cmdq_rec *rec, cmdq_async_flush_cb cb,
> +			 void *data);
> +
> +/**
> + * cmdq_rec_destroy() - destroy command queue record
> + * @rec:	the command queue record
> + */
> +void cmdq_rec_destroy(struct cmdq_rec *rec);
> +
> +#endif	/* __MTK_CMDQ_H__ */
>
