From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 17 Oct 2016 18:11:55 +0800
Subject: [PATCH v15 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
References: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1476699117-3001-3-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is first version of Mediatek Command Queue(CMDQ) driver. The
CMDQ is used to help write registers with critical time limitation,
such as updating display configuration during the vblank. It controls
Global Command Engine (GCE) hardware to achieve this requirement.
Currently, CMDQ only supports display related hardwares, but we expect
it can be extended to other hardwares for future requirements.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/Kconfig                  |  10 +
 drivers/mailbox/Makefile                 |   2 +
 drivers/mailbox/mtk-cmdq-mailbox.c       | 552 +++++++++++++++++++++++++++++++
 drivers/soc/mediatek/Kconfig             |  11 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 310 +++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  67 ++++
 include/linux/soc/mediatek/mtk-cmdq.h    | 182 ++++++++++
 8 files changed, 1135 insertions(+)
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 11eebfe..5a4af2d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -143,4 +143,14 @@ config BCM_PDC_MBOX
 	  Mailbox implementation for the Broadcom PDC ring manager,
 	  which provides access to various offload engines on Broadcom
 	  SoCs. Say Y here if you want to use the Broadcom PDC.
+
+config MTK_CMDQ_MBOX
+	bool "MediaTek CMDQ Mailbox Support"
+	depends on ARM64 && ( ARCH_MEDIATEK || COMPILE_TEST )
+	select MTK_INFRACFG
+	help
+	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
+	  mailbox driver. The CMDQ is used to help read/write registers with
+	  critical time limitation, such as updating display configuration
+	  during the vblank.
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index ace6fed..b904bed 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -29,3 +29,5 @@ obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
 obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
 
 obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
+
+obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
new file mode 100644
index 0000000..d086fd8
--- /dev/null
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -0,0 +1,552 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/mtk-cmdq-mailbox.h>
+#include <linux/timer.h>
+
+#define CMDQ_THR_MAX_COUNT		3 /* main, sub, general(misc) */
+#define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
+#define CMDQ_TIMEOUT_MS			1000
+#define CMDQ_IRQ_MASK			0xffff
+#define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
+
+#define CMDQ_CURR_IRQ_STATUS		0x10
+#define CMDQ_THR_SLOT_CYCLES		0x30
+
+#define CMDQ_THR_BASE			0x100
+#define CMDQ_THR_SIZE			0x80
+#define CMDQ_THR_WARM_RESET		0x00
+#define CMDQ_THR_ENABLE_TASK		0x04
+#define CMDQ_THR_SUSPEND_TASK		0x08
+#define CMDQ_THR_CURR_STATUS		0x0c
+#define CMDQ_THR_IRQ_STATUS		0x10
+#define CMDQ_THR_IRQ_ENABLE		0x14
+#define CMDQ_THR_CURR_ADDR		0x20
+#define CMDQ_THR_END_ADDR		0x24
+#define CMDQ_THR_WAIT_TOKEN		0x30
+
+#define CMDQ_THR_ENABLED		0x1
+#define CMDQ_THR_DISABLED		0x0
+#define CMDQ_THR_SUSPEND		0x1
+#define CMDQ_THR_RESUME			0x0
+#define CMDQ_THR_STATUS_SUSPENDED	BIT(1)
+#define CMDQ_THR_DO_WARM_RESET		BIT(0)
+#define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
+#define CMDQ_THR_IRQ_DONE		0x1
+#define CMDQ_THR_IRQ_ERROR		0x12
+#define CMDQ_THR_IRQ_EN			(CMDQ_THR_IRQ_ERROR | CMDQ_THR_IRQ_DONE)
+#define CMDQ_THR_IS_WAITING		BIT(31)
+
+#define CMDQ_JUMP_BY_OFFSET		0x10000000
+#define CMDQ_JUMP_BY_PA			0x10000001
+
+struct cmdq_thread {
+	struct mbox_chan	*chan;
+	void __iomem		*base;
+	struct list_head	task_busy_list;
+	struct timer_list	timeout;
+	bool			atomic_exec;
+};
+
+struct cmdq_task {
+	struct cmdq		*cmdq;
+	struct list_head	list_entry;
+	dma_addr_t		pa_base;
+	struct cmdq_thread	*thread;
+	struct cmdq_pkt		*pkt; /* the packet sent from mailbox client */
+};
+
+struct cmdq {
+	struct mbox_controller	mbox;
+	void __iomem		*base;
+	u32			irq;
+	struct cmdq_thread	thread[CMDQ_THR_MAX_COUNT];
+	struct clk		*clock;
+};
+
+static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
+{
+	u32 status;
+
+	writel(CMDQ_THR_SUSPEND, thread->base + CMDQ_THR_SUSPEND_TASK);
+
+	/* If already disabled, treat as suspended successful. */
+	if (!(readl(thread->base + CMDQ_THR_ENABLE_TASK) & CMDQ_THR_ENABLED))
+		return 0;
+
+	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_STATUS,
+			status, status & CMDQ_THR_STATUS_SUSPENDED, 0, 10)) {
+		dev_err(cmdq->mbox.dev, "suspend GCE thread 0x%x failed\n",
+			(u32)(thread->base - cmdq->base));
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void cmdq_thread_resume(struct cmdq_thread *thread)
+{
+	writel(CMDQ_THR_RESUME, thread->base + CMDQ_THR_SUSPEND_TASK);
+}
+
+static int cmdq_thread_reset(struct cmdq *cmdq, struct cmdq_thread *thread)
+{
+	u32 warm_reset;
+
+	writel(CMDQ_THR_DO_WARM_RESET, thread->base + CMDQ_THR_WARM_RESET);
+	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_WARM_RESET,
+			warm_reset, !(warm_reset & CMDQ_THR_DO_WARM_RESET),
+			0, 10)) {
+		dev_err(cmdq->mbox.dev, "reset GCE thread 0x%x failed\n",
+			(u32)(thread->base - cmdq->base));
+		return -EFAULT;
+	}
+	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
+	return 0;
+}
+
+static void cmdq_thread_disable(struct cmdq *cmdq, struct cmdq_thread *thread)
+{
+	cmdq_thread_reset(cmdq, thread);
+	writel(CMDQ_THR_DISABLED, thread->base + CMDQ_THR_ENABLE_TASK);
+}
+
+/* notify GCE to re-fetch commands by setting GCE thread PC */
+static void cmdq_thread_invalidate_fetched_data(struct cmdq_thread *thread)
+{
+	writel(readl(thread->base + CMDQ_THR_CURR_ADDR),
+	       thread->base + CMDQ_THR_CURR_ADDR);
+}
+
+static void cmdq_task_insert_into_thread(struct cmdq_task *task)
+{
+	struct device *dev = task->cmdq->mbox.dev;
+	struct cmdq_thread *thread = task->thread;
+	struct cmdq_task *prev_task = list_last_entry(
+			&thread->task_busy_list, typeof(*task), list_entry);
+	u64 *prev_task_base = prev_task->pkt->va_base;
+
+	/* let previous task jump to this task */
+	dma_sync_single_for_cpu(dev, prev_task->pa_base,
+				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
+	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
+		(u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
+	dma_sync_single_for_device(dev, prev_task->pa_base,
+				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
+
+	cmdq_thread_invalidate_fetched_data(thread);
+}
+
+static bool cmdq_command_is_wfe(u64 cmd)
+{
+	u64 wfe_option = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
+	u64 wfe_op = (u64)(CMDQ_CODE_WFE << CMDQ_OP_CODE_SHIFT) << 32;
+	u64 wfe_mask = (u64)CMDQ_OP_CODE_MASK << 32 | 0xffffffff;
+
+	return ((cmd & wfe_mask) == (wfe_op | wfe_option));
+}
+
+/* we assume tasks in the same display GCE thread are waiting the same event. */
+static void cmdq_task_remove_wfe(struct cmdq_task *task)
+{
+	struct device *dev = task->cmdq->mbox.dev;
+	u64 *base = task->pkt->va_base;
+	int i;
+
+	dma_sync_single_for_cpu(dev, task->pa_base, task->pkt->cmd_buf_size,
+				DMA_TO_DEVICE);
+	for (i = 0; i < CMDQ_NUM_CMD(task->pkt); i++)
+		if (cmdq_command_is_wfe(base[i]))
+			base[i] = (u64)CMDQ_JUMP_BY_OFFSET << 32 |
+				  CMDQ_JUMP_PASS;
+	dma_sync_single_for_device(dev, task->pa_base, task->pkt->cmd_buf_size,
+				   DMA_TO_DEVICE);
+}
+
+static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
+{
+	return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WAITING;
+}
+
+static void cmdq_thread_wait_end(struct cmdq_thread *thread,
+				 unsigned long end_pa)
+{
+	struct device *dev = thread->chan->mbox->dev;
+	unsigned long curr_pa;
+
+	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_ADDR,
+			curr_pa, curr_pa == end_pa, 1, 20))
+		dev_err(dev, "GCE thread cannot run to end.\n");
+}
+
+static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
+{
+	struct cmdq *cmdq;
+	struct cmdq_task *task;
+	unsigned long curr_pa, end_pa;
+
+	cmdq = dev_get_drvdata(thread->chan->mbox->dev);
+
+	task = kzalloc(sizeof(*task), GFP_ATOMIC);
+	task->cmdq = cmdq;
+	INIT_LIST_HEAD(&task->list_entry);
+	task->pa_base = dma_map_single(cmdq->mbox.dev, pkt->va_base,
+				       pkt->cmd_buf_size, DMA_TO_DEVICE);
+	task->thread = thread;
+	task->pkt = pkt;
+
+	if (list_empty(&thread->task_busy_list)) {
+		WARN_ON(clk_enable(cmdq->clock) < 0);
+		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
+
+		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
+		writel(task->pa_base + pkt->cmd_buf_size,
+		       thread->base + CMDQ_THR_END_ADDR);
+		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
+		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
+
+		mod_timer(&thread->timeout,
+			  jiffies + msecs_to_jiffies(CMDQ_TIMEOUT_MS));
+	} else {
+		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
+		end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
+
+		/*
+		 * Atomic execution should remove the following wfe, i.e. only
+		 * wait event at first task, and prevent to pause when running.
+		 */
+		if (thread->atomic_exec) {
+			/* GCE is executing if command is not WFE */
+			if (!cmdq_thread_is_in_wfe(thread)) {
+				cmdq_thread_resume(thread);
+				cmdq_thread_wait_end(thread, end_pa);
+				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+				/* set to this task directly */
+				writel(task->pa_base,
+				       thread->base + CMDQ_THR_CURR_ADDR);
+			} else {
+				cmdq_task_insert_into_thread(task);
+				cmdq_task_remove_wfe(task);
+				smp_mb(); /* modify jump before enable thread */
+			}
+		} else {
+			/* check boundary */
+			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
+			    curr_pa == end_pa) {
+				/* set to this task directly */
+				writel(task->pa_base,
+				       thread->base + CMDQ_THR_CURR_ADDR);
+			} else {
+				cmdq_task_insert_into_thread(task);
+				smp_mb(); /* modify jump before enable thread */
+			}
+		}
+		writel(task->pa_base + pkt->cmd_buf_size,
+		       thread->base + CMDQ_THR_END_ADDR);
+		cmdq_thread_resume(thread);
+	}
+	list_move_tail(&task->list_entry, &thread->task_busy_list);
+}
+
+static void cmdq_task_exec_done(struct cmdq_task *task, bool err)
+{
+	struct device *dev = task->cmdq->mbox.dev;
+	struct cmdq_cb_data cmdq_cb_data;
+
+	dma_unmap_single(dev, task->pa_base, task->pkt->cmd_buf_size,
+			 DMA_TO_DEVICE);
+	if (task->pkt->cb.cb) {
+		cmdq_cb_data.err = err;
+		cmdq_cb_data.data = task->pkt->cb.data;
+		task->pkt->cb.cb(cmdq_cb_data);
+	}
+	list_del(&task->list_entry);
+}
+
+static void cmdq_task_handle_error(struct cmdq_task *task)
+{
+	struct cmdq_thread *thread = task->thread;
+	struct cmdq_task *next_task;
+
+	dev_err(task->cmdq->mbox.dev, "task 0x%p error\n", task);
+	WARN_ON(cmdq_thread_suspend(task->cmdq, thread) < 0);
+	next_task = list_first_entry_or_null(&thread->task_busy_list,
+			struct cmdq_task, list_entry);
+	if (next_task)
+		writel(next_task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
+	cmdq_thread_resume(thread);
+}
+
+static void cmdq_thread_irq_handler(struct cmdq *cmdq,
+				    struct cmdq_thread *thread)
+{
+	struct cmdq_task *task, *tmp, *curr_task = NULL;
+	u32 curr_pa, irq_flag, task_end_pa;
+	bool err;
+
+	irq_flag = readl(thread->base + CMDQ_THR_IRQ_STATUS);
+	writel(~irq_flag, thread->base + CMDQ_THR_IRQ_STATUS);
+
+	/*
+	 * When ISR call this function, another CPU core could run
+	 * "release task" right before we acquire the spin lock, and thus
+	 * reset / disable this GCE thread, so we need to check the enable
+	 * bit of this GCE thread.
+	 */
+	if (!(readl(thread->base + CMDQ_THR_ENABLE_TASK) & CMDQ_THR_ENABLED))
+		return;
+
+	if (irq_flag & CMDQ_THR_IRQ_ERROR)
+		err = true;
+	else if (irq_flag & CMDQ_THR_IRQ_DONE)
+		err = false;
+	else
+		return;
+
+	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
+
+	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
+				 list_entry) {
+		task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
+		if (curr_pa >= task->pa_base && curr_pa < task_end_pa)
+			curr_task = task;
+
+		if (!curr_task || curr_pa == task_end_pa - CMDQ_INST_SIZE) {
+			cmdq_task_exec_done(task, false);
+			kfree(task);
+		} else if (err) {
+			cmdq_task_exec_done(task, true);
+			cmdq_task_handle_error(curr_task);
+			kfree(task);
+		}
+
+		if (curr_task)
+			break;
+	}
+
+	if (list_empty(&thread->task_busy_list)) {
+		cmdq_thread_disable(cmdq, thread);
+		clk_disable(cmdq->clock);
+	} else {
+		mod_timer(&thread->timeout,
+			  jiffies + msecs_to_jiffies(CMDQ_TIMEOUT_MS));
+	}
+}
+
+static irqreturn_t cmdq_irq_handler(int irq, void *dev)
+{
+	struct cmdq *cmdq = dev;
+	unsigned long irq_status, flags = 0L;
+	int bit;
+
+	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
+	if (!(irq_status ^ CMDQ_IRQ_MASK))
+		return IRQ_NONE;
+
+	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
+		struct cmdq_thread *thread = &cmdq->thread[bit];
+
+		spin_lock_irqsave(&thread->chan->lock, flags);
+		cmdq_thread_irq_handler(cmdq, thread);
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+	}
+	return IRQ_HANDLED;
+}
+
+static void cmdq_thread_handle_timeout(unsigned long data)
+{
+	struct cmdq_thread *thread = (struct cmdq_thread *)data;
+	struct cmdq *cmdq = container_of(thread->chan->mbox, struct cmdq, mbox);
+	struct cmdq_task *task, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&thread->chan->lock, flags);
+	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+
+	/*
+	 * Although IRQ is disabled, GCE continues to execute.
+	 * It may have pending IRQ before GCE thread is suspended,
+	 * so check this condition again.
+	 */
+	cmdq_thread_irq_handler(cmdq, thread);
+
+	if (list_empty(&thread->task_busy_list)) {
+		cmdq_thread_resume(thread);
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+		return;
+	}
+
+	dev_err(cmdq->mbox.dev, "timeout\n");
+	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
+				 list_entry) {
+		cmdq_task_exec_done(task, true);
+		kfree(task);
+	}
+
+	cmdq_thread_resume(thread);
+	cmdq_thread_disable(cmdq, thread);
+	clk_disable(cmdq->clock);
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+}
+
+static int cmdq_remove(struct platform_device *pdev)
+{
+	struct cmdq *cmdq = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&cmdq->mbox);
+	clk_unprepare(cmdq->clock);
+	return 0;
+}
+
+static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	cmdq_task_exec(data, chan->con_priv);
+	return 0;
+}
+
+static int cmdq_mbox_startup(struct mbox_chan *chan)
+{
+	return 0;
+}
+
+static void cmdq_mbox_shutdown(struct mbox_chan *chan)
+{
+}
+
+static bool cmdq_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	return true;
+}
+
+static const struct mbox_chan_ops cmdq_mbox_chan_ops = {
+	.send_data = cmdq_mbox_send_data,
+	.startup = cmdq_mbox_startup,
+	.shutdown = cmdq_mbox_shutdown,
+	.last_tx_done = cmdq_mbox_last_tx_done,
+};
+
+static struct mbox_chan *cmdq_xlate(struct mbox_controller *mbox,
+		const struct of_phandle_args *sp)
+{
+	int ind = sp->args[0];
+	struct cmdq_thread *thread;
+
+	if (ind >= mbox->num_chans)
+		return ERR_PTR(-EINVAL);
+
+	thread = mbox->chans[ind].con_priv;
+	thread->atomic_exec = (sp->args[1] != 0);
+	thread->chan = &mbox->chans[ind];
+
+	return &mbox->chans[ind];
+}
+
+static int cmdq_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct cmdq *cmdq;
+	int err, i;
+
+	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
+	if (!cmdq)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cmdq->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cmdq->base)) {
+		dev_err(dev, "failed to ioremap gce\n");
+		return PTR_ERR(cmdq->base);
+	}
+
+	cmdq->irq = platform_get_irq(pdev, 0);
+	if (!cmdq->irq) {
+		dev_err(dev, "failed to get irq\n");
+		return -EINVAL;
+	}
+	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
+			       "mtk_cmdq", cmdq);
+	if (err < 0) {
+		dev_err(dev, "failed to register ISR (%d)\n", err);
+		return err;
+	}
+
+	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
+		dev, cmdq->base, cmdq->irq);
+
+	cmdq->clock = devm_clk_get(dev, "gce");
+	if (IS_ERR(cmdq->clock)) {
+		dev_err(dev, "failed to get gce clk\n");
+		return PTR_ERR(cmdq->clock);
+	}
+
+	cmdq->mbox.dev = dev;
+	cmdq->mbox.chans = devm_kcalloc(dev, CMDQ_THR_MAX_COUNT,
+					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
+	if (!cmdq->mbox.chans)
+		return -ENOMEM;
+
+	cmdq->mbox.num_chans = CMDQ_THR_MAX_COUNT;
+	cmdq->mbox.ops = &cmdq_mbox_chan_ops;
+	cmdq->mbox.of_xlate = cmdq_xlate;
+
+	/* make use of TXDONE_BY_ACK */
+	cmdq->mbox.txdone_irq = false;
+	cmdq->mbox.txdone_poll = false;
+
+	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
+		cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
+				CMDQ_THR_SIZE * i;
+		INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
+		init_timer(&cmdq->thread[i].timeout);
+		cmdq->thread[i].timeout.function = cmdq_thread_handle_timeout;
+		cmdq->thread[i].timeout.data = (unsigned long)&cmdq->thread[i];
+		cmdq->mbox.chans[i].con_priv = &cmdq->thread[i];
+	}
+
+	err = mbox_controller_register(&cmdq->mbox);
+	if (err < 0) {
+		dev_err(dev, "failed to register mailbox: %d\n", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, cmdq);
+	WARN_ON(clk_prepare(cmdq->clock) < 0);
+	return 0;
+}
+
+static const struct of_device_id cmdq_of_ids[] = {
+	{.compatible = "mediatek,mt8173-gce",},
+	{}
+};
+
+static struct platform_driver cmdq_drv = {
+	.probe = cmdq_probe,
+	.remove = cmdq_remove,
+	.driver = {
+		.name = "mtk_cmdq",
+		.of_match_table = cmdq_of_ids,
+	}
+};
+
+builtin_platform_driver(cmdq_drv);
diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 0a4ea80..94651ed 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -1,6 +1,17 @@
 #
 # MediaTek SoC drivers
 #
+config MTK_CMDQ
+	bool "MediaTek CMDQ Support"
+	depends on ARM64 && ( ARCH_MEDIATEK || COMPILE_TEST )
+	select MTK_CMDQ_MBOX
+	select MTK_INFRACFG
+	help
+	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
+	  driver. The CMDQ is used to help read/write registers with critical
+	  time limitation, such as updating display configuration during the
+	  vblank.
+
 config MTK_INFRACFG
 	bool "MediaTek INFRACFG Support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 12998b0..64ce5ee 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
new file mode 100644
index 0000000..f4002bf
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -0,0 +1,310 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/mailbox/mtk-cmdq-mailbox.h>
+#include <linux/of_address.h>
+
+#define CMDQ_SUBSYS_SHIFT	16
+#define CMDQ_ARG_A_WRITE_MASK	0xffff
+#define CMDQ_WRITE_ENABLE_MASK	BIT(0)
+#define CMDQ_EOC_IRQ_EN		BIT(0)
+#define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
+				<< 32 | CMDQ_EOC_IRQ_EN)
+
+struct cmdq_subsys {
+	u32	base;
+	int	id;
+};
+
+static const struct cmdq_subsys gce_subsys[] = {
+	{0x1400, 1},
+	{0x1401, 2},
+	{0x1402, 3},
+};
+
+static int cmdq_subsys_base_to_id(u32 base)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gce_subsys); i++)
+		if (gce_subsys[i].base == base)
+			return gce_subsys[i].id;
+	return -EFAULT;
+}
+
+static int cmdq_pkt_realloc_cmd_buffer(struct cmdq_pkt *pkt, size_t size)
+{
+	void *new_buf;
+
+	new_buf = krealloc(pkt->va_base, size, GFP_KERNEL | __GFP_ZERO);
+	if (!new_buf)
+		return -ENOMEM;
+	pkt->va_base = new_buf;
+	pkt->buf_size = size;
+	return 0;
+}
+
+struct cmdq_base *cmdq_register_device(struct device *dev)
+{
+	struct cmdq_base *cmdq_base;
+	struct resource res;
+	int subsys;
+	u32 base;
+
+	if (of_address_to_resource(dev->of_node, 0, &res))
+		return NULL;
+	base = (u32)res.start;
+
+	subsys = cmdq_subsys_base_to_id(base >> 16);
+	if (subsys < 0)
+		return NULL;
+
+	cmdq_base = devm_kmalloc(dev, sizeof(*cmdq_base), GFP_KERNEL);
+	if (!cmdq_base)
+		return NULL;
+	cmdq_base->subsys = subsys;
+	cmdq_base->base = base;
+
+	return cmdq_base;
+}
+EXPORT_SYMBOL(cmdq_register_device);
+
+struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
+{
+	struct cmdq_client *client;
+
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	client->client.dev = dev;
+	client->client.tx_block = false;
+	client->chan = mbox_request_channel(&client->client, index);
+	return client;
+}
+EXPORT_SYMBOL(cmdq_mbox_create);
+
+void cmdq_mbox_destroy(struct cmdq_client *client)
+{
+	mbox_free_channel(client->chan);
+	kfree(client);
+}
+EXPORT_SYMBOL(cmdq_mbox_destroy);
+
+int cmdq_pkt_create(struct cmdq_pkt **pkt_ptr)
+{
+	struct cmdq_pkt *pkt;
+	int err;
+
+	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+	err = cmdq_pkt_realloc_cmd_buffer(pkt, PAGE_SIZE);
+	if (err < 0) {
+		kfree(pkt);
+		return err;
+	}
+	*pkt_ptr = pkt;
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_create);
+
+void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
+{
+	kfree(pkt->va_base);
+	kfree(pkt);
+}
+EXPORT_SYMBOL(cmdq_pkt_destroy);
+
+static bool cmdq_pkt_is_finalized(struct cmdq_pkt *pkt)
+{
+	u64 *expect_eoc;
+
+	if (pkt->cmd_buf_size < CMDQ_INST_SIZE << 1)
+		return false;
+
+	expect_eoc = pkt->va_base + pkt->cmd_buf_size - (CMDQ_INST_SIZE << 1);
+	if (*expect_eoc == CMDQ_EOC_CMD)
+		return true;
+
+	return false;
+}
+
+static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
+				   u32 arg_a, u32 arg_b)
+{
+	u64 *cmd_ptr;
+	int err;
+
+	if (WARN_ON(cmdq_pkt_is_finalized(pkt)))
+		return -EBUSY;
+	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
+		err = cmdq_pkt_realloc_cmd_buffer(pkt, pkt->buf_size << 1);
+		if (err < 0)
+			return err;
+	}
+	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
+	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
+	pkt->cmd_buf_size += CMDQ_INST_SIZE;
+	return 0;
+}
+
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, struct cmdq_base *base,
+		   u32 offset)
+{
+	u32 arg_a = ((base->base + offset) & CMDQ_ARG_A_WRITE_MASK) |
+		    (base->subsys << CMDQ_SUBSYS_SHIFT);
+	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
+}
+EXPORT_SYMBOL(cmdq_pkt_write);
+
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
+			struct cmdq_base *base, u32 offset, u32 mask)
+{
+	u32 offset_mask = offset;
+	int err;
+
+	if (mask != 0xffffffff) {
+		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
+		if (err < 0)
+			return err;
+		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
+	}
+	return cmdq_pkt_write(pkt, value, base, offset_mask);
+}
+EXPORT_SYMBOL(cmdq_pkt_write_mask);
+
+static const u32 cmdq_event_value[CMDQ_MAX_EVENT] = {
+	/* Display start of frame(SOF) events */
+	[CMDQ_EVENT_DISP_OVL0_SOF] = 11,
+	[CMDQ_EVENT_DISP_OVL1_SOF] = 12,
+	[CMDQ_EVENT_DISP_RDMA0_SOF] = 13,
+	[CMDQ_EVENT_DISP_RDMA1_SOF] = 14,
+	[CMDQ_EVENT_DISP_RDMA2_SOF] = 15,
+	[CMDQ_EVENT_DISP_WDMA0_SOF] = 16,
+	[CMDQ_EVENT_DISP_WDMA1_SOF] = 17,
+	/* Display end of frame(EOF) events */
+	[CMDQ_EVENT_DISP_OVL0_EOF] = 39,
+	[CMDQ_EVENT_DISP_OVL1_EOF] = 40,
+	[CMDQ_EVENT_DISP_RDMA0_EOF] = 41,
+	[CMDQ_EVENT_DISP_RDMA1_EOF] = 42,
+	[CMDQ_EVENT_DISP_RDMA2_EOF] = 43,
+	[CMDQ_EVENT_DISP_WDMA0_EOF] = 44,
+	[CMDQ_EVENT_DISP_WDMA1_EOF] = 45,
+	/* Mutex end of frame(EOF) events */
+	[CMDQ_EVENT_MUTEX0_STREAM_EOF] = 53,
+	[CMDQ_EVENT_MUTEX1_STREAM_EOF] = 54,
+	[CMDQ_EVENT_MUTEX2_STREAM_EOF] = 55,
+	[CMDQ_EVENT_MUTEX3_STREAM_EOF] = 56,
+	[CMDQ_EVENT_MUTEX4_STREAM_EOF] = 57,
+	/* Display underrun events */
+	[CMDQ_EVENT_DISP_RDMA0_UNDERRUN] = 63,
+	[CMDQ_EVENT_DISP_RDMA1_UNDERRUN] = 64,
+	[CMDQ_EVENT_DISP_RDMA2_UNDERRUN] = 65,
+};
+
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, enum cmdq_event event)
+{
+	u32 arg_b;
+
+	if (event >= CMDQ_MAX_EVENT || event < 0)
+		return -EINVAL;
+
+	/*
+	 * WFE arg_b
+	 * bit 0-11: wait value
+	 * bit 15: 1 - wait, 0 - no wait
+	 * bit 16-27: update value
+	 * bit 31: 1 - update, 0 - no update
+	 */
+	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
+	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE,
+			cmdq_event_value[event], arg_b);
+}
+EXPORT_SYMBOL(cmdq_pkt_wfe);
+
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, enum cmdq_event event)
+{
+	if (event >= CMDQ_MAX_EVENT || event < 0)
+		return -EINVAL;
+
+	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE,
+			cmdq_event_value[event], CMDQ_WFE_UPDATE);
+}
+EXPORT_SYMBOL(cmdq_pkt_clear_event);
+
+static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
+{
+	int err;
+
+	if (cmdq_pkt_is_finalized(pkt))
+		return 0;
+
+	/* insert EOC and generate IRQ for each command iteration */
+	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
+	if (err < 0)
+		return err;
+
+	/* JUMP to end */
+	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
+			 cmdq_async_flush_cb cb, void *data)
+{
+	int err;
+
+	err = cmdq_pkt_finalize(pkt);
+	if (err < 0)
+		return err;
+
+	pkt->cb.cb = cb;
+	pkt->cb.data = data;
+
+	mbox_send_message(client->chan, pkt);
+	/* We can send next packet immediately, so just call txdone. */
+	mbox_client_txdone(client->chan, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_flush_async);
+
+struct cmdq_flush_completion {
+	struct completion cmplt;
+	bool err;
+};
+
+static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
+{
+	struct cmdq_flush_completion *cmplt = data.data;
+
+	cmplt->err = data.err;
+	complete(&cmplt->cmplt);
+}
+
+int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt)
+{
+	struct cmdq_flush_completion cmplt;
+	int err;
+
+	init_completion(&cmplt.cmplt);
+	err = cmdq_pkt_flush_async(client, pkt, cmdq_pkt_flush_cb, &cmplt);
+	if (err < 0)
+		return err;
+	wait_for_completion(&cmplt.cmplt);
+	return cmplt.err ? -EFAULT : 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_flush);
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
new file mode 100644
index 0000000..131b8b3
--- /dev/null
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MTK_CMDQ_MAILBOX_H__
+#define __MTK_CMDQ_MAILBOX_H__
+
+#include <linux/slab.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#define CMDQ_INST_SIZE			8 /* instruction is 64-bit */
+#define CMDQ_OP_CODE_SHIFT		24
+#define CMDQ_JUMP_PASS			CMDQ_INST_SIZE
+
+#define CMDQ_WFE_UPDATE			BIT(31)
+#define CMDQ_WFE_WAIT			BIT(15)
+#define CMDQ_WFE_WAIT_VALUE		0x1
+
+/*
+ * CMDQ_CODE_MASK:
+ *   set write mask
+ *   format: op mask
+ * CMDQ_CODE_WRITE:
+ *   write value into target register
+ *   format: op subsys address value
+ * CMDQ_CODE_JUMP:
+ *   jump by offset
+ *   format: op offset
+ * CMDQ_CODE_WFE:
+ *   wait for event and clear
+ *   it is just clear if no wait
+ *   format: [wait]  op event update:1 to_wait:1 wait:1
+ *           [clear] op event update:1 to_wait:0 wait:0
+ * CMDQ_CODE_EOC:
+ *   end of command
+ *   format: op irq_flag
+ */
+enum cmdq_code {
+	CMDQ_CODE_MASK = 0x02,
+	CMDQ_CODE_WRITE = 0x04,
+	CMDQ_CODE_JUMP = 0x10,
+	CMDQ_CODE_WFE = 0x20,
+	CMDQ_CODE_EOC = 0x40,
+};
+
+struct cmdq_task_cb {
+	cmdq_async_flush_cb	cb;
+	void			*data;
+};
+
+struct cmdq_pkt {
+	void			*va_base;
+	size_t			cmd_buf_size; /* command occupied size */
+	size_t			buf_size; /* real buffer size */
+	struct cmdq_task_cb	cb;
+};
+
+#endif /* __MTK_CMDQ_MAILBOX_H__ */
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
new file mode 100644
index 0000000..7320837
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -0,0 +1,182 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MTK_CMDQ_H__
+#define __MTK_CMDQ_H__
+
+#include <linux/mailbox_client.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+/* display events in command queue(CMDQ) */
+enum cmdq_event {
+	/* Display start of frame(SOF) events */
+	CMDQ_EVENT_DISP_OVL0_SOF,
+	CMDQ_EVENT_DISP_OVL1_SOF,
+	CMDQ_EVENT_DISP_RDMA0_SOF,
+	CMDQ_EVENT_DISP_RDMA1_SOF,
+	CMDQ_EVENT_DISP_RDMA2_SOF,
+	CMDQ_EVENT_DISP_WDMA0_SOF,
+	CMDQ_EVENT_DISP_WDMA1_SOF,
+	/* Display end of frame(EOF) events */
+	CMDQ_EVENT_DISP_OVL0_EOF,
+	CMDQ_EVENT_DISP_OVL1_EOF,
+	CMDQ_EVENT_DISP_RDMA0_EOF,
+	CMDQ_EVENT_DISP_RDMA1_EOF,
+	CMDQ_EVENT_DISP_RDMA2_EOF,
+	CMDQ_EVENT_DISP_WDMA0_EOF,
+	CMDQ_EVENT_DISP_WDMA1_EOF,
+	/* Mutex end of frame(EOF) events */
+	CMDQ_EVENT_MUTEX0_STREAM_EOF,
+	CMDQ_EVENT_MUTEX1_STREAM_EOF,
+	CMDQ_EVENT_MUTEX2_STREAM_EOF,
+	CMDQ_EVENT_MUTEX3_STREAM_EOF,
+	CMDQ_EVENT_MUTEX4_STREAM_EOF,
+	/* Display underrun events */
+	CMDQ_EVENT_DISP_RDMA0_UNDERRUN,
+	CMDQ_EVENT_DISP_RDMA1_UNDERRUN,
+	CMDQ_EVENT_DISP_RDMA2_UNDERRUN,
+	/* Keep this at the end */
+	CMDQ_MAX_EVENT,
+};
+
+struct cmdq_cb_data {
+	bool	err;
+	void	*data;
+};
+
+typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
+
+struct cmdq_pkt;
+
+struct cmdq_base {
+	int	subsys;
+	u32	base;
+};
+
+struct cmdq_client {
+	struct mbox_client client;
+	struct mbox_chan *chan;
+};
+
+/**
+ * cmdq_register_device() - register device which needs CMDQ
+ * @dev:	device for CMDQ to access its registers
+ *
+ * Return: cmdq_base pointer or NULL for failed
+ */
+struct cmdq_base *cmdq_register_device(struct device *dev);
+
+/**
+ * cmdq_mbox_create() - create CMDQ mailbox client and channel
+ * @dev:	device of CMDQ mailbox client
+ * @index:	index of CMDQ mailbox channel
+ *
+ * Return: CMDQ mailbox client pointer
+ */
+struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
+
+/**
+ * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
+ * @client:	the CMDQ mailbox client
+ */
+void cmdq_mbox_destroy(struct cmdq_client *client);
+
+/**
+ * cmdq_pkt_create() - create a CMDQ packet
+ * @pkt_ptr:	CMDQ packet pointer to retrieve cmdq_pkt
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_create(struct cmdq_pkt **pkt_ptr);
+
+/**
+ * cmdq_pkt_destroy() - destroy the CMDQ packet
+ * @pkt:	the CMDQ packet
+ */
+void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_pkt_write() - append write command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @value:	the specified target register value
+ * @base:	the CMDQ base
+ * @offset:	register offset from module base
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value,
+		   struct cmdq_base *base, u32 offset);
+
+/**
+ * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @value:	the specified target register value
+ * @base:	the CMDQ base
+ * @offset:	register offset from module base
+ * @mask:	the specified target register mask
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
+			struct cmdq_base *base, u32 offset, u32 mask);
+
+/**
+ * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @event:	the desired event type to "wait and CLEAR"
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, enum cmdq_event event);
+
+/**
+ * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @event:	the desired event to be cleared
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, enum cmdq_event event);
+
+/**
+ * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
+ * @client:	the CMDQ mailbox client
+ * @pkt:	the CMDQ packet
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ * Trigger CMDQ to execute the CMDQ packet. Note that this is a
+ * synchronous flush function. When the function returned, the recorded
+ * commands have been done.
+ */
+int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
+ *                          packet and call back at the end of done packet
+ * @client:	the CMDQ mailbox client
+ * @pkt:	the CMDQ packet
+ * @cb:		called at the end of done packet
+ * @data:	this data will pass back to cb
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
+ * at the end of done packet. Note that this is an ASYNC function. When the
+ * function returned, it may or may not be finished.
+ */
+int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
+			 cmdq_async_flush_cb cb, void *data);
+
+#endif	/* __MTK_CMDQ_H__ */
-- 
1.9.1
