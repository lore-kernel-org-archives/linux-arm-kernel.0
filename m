From: leo.yan@linaro.org (Leo Yan)
Date: Mon,  3 Aug 2015 09:13:09 +0800
Subject: [RFC PATCH 2/3] mailbox: Hisilicon: add mailbox driver
In-Reply-To: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1438564390-28111-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Hisilicon mailbox's common driver, it registers mailbox channels
into framework; it also invokes low level callback functions for
register's related operations. Enhance rx channel's message queue,
which is based on the code in drivers/mailbox/omap-mailbox.c.

Enable Hi6220 mailbox driver as the first platform to use this
framework. Hi6220's mailbox communicates with MCU; for sending data,
it can support two methods for low level implementation: one is to
use interrupt as acknowledge, another is automatic mode which without
any acknowledge. These two methods have been supported in the driver;
for receiving data, it will depend on the interrupt to notify the
channel has incoming message.

Now mailbox driver is used to send message to MCU to control dynamic
voltage and frequency scaling for CPU, GPU and DDR.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/mailbox/Kconfig                    |   2 +
 drivers/mailbox/Makefile                   |   2 +
 drivers/mailbox/hisilicon/Kconfig          |  13 ++
 drivers/mailbox/hisilicon/Makefile         |   2 +
 drivers/mailbox/hisilicon/common.c         | 282 ++++++++++++++++++++++++++
 drivers/mailbox/hisilicon/common.h         | 114 +++++++++++
 drivers/mailbox/hisilicon/hi6220-mailbox.c | 305 +++++++++++++++++++++++++++++
 7 files changed, 720 insertions(+)
 create mode 100644 drivers/mailbox/hisilicon/Kconfig
 create mode 100644 drivers/mailbox/hisilicon/Makefile
 create mode 100644 drivers/mailbox/hisilicon/common.c
 create mode 100644 drivers/mailbox/hisilicon/common.h
 create mode 100644 drivers/mailbox/hisilicon/hi6220-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index e269f08..a426901 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -70,4 +70,6 @@ config BCM2835_MBOX
 	  the services of the Videocore. Say Y here if you want to use the
 	  BCM2835 Mailbox.
 
+source "drivers/mailbox/hisilicon/Kconfig"
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 8e6d822..1e82dfb 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_PCC)		+= pcc.o
 obj-$(CONFIG_ALTERA_MBOX)	+= mailbox-altera.o
 
 obj-$(CONFIG_BCM2835_MBOX)	+= bcm2835-mailbox.o
+
+obj-$(CONFIG_HISI_MBOX)		+= hisilicon/
diff --git a/drivers/mailbox/hisilicon/Kconfig b/drivers/mailbox/hisilicon/Kconfig
new file mode 100644
index 0000000..87548a9
--- /dev/null
+++ b/drivers/mailbox/hisilicon/Kconfig
@@ -0,0 +1,13 @@
+config HISI_MBOX
+	bool "Hisilicon's Mailbox"
+	depends on ARCH_HISI || OF
+	help
+	  Support for mailbox drivers on Hisilicon series of SoCs.
+
+config HI6220_MBOX
+	tristate "Hi6220 Mailbox Controller"
+	depends on HISI_MBOX
+	help
+	  An implementation of the hi6220 mailbox. It is used to send message
+	  between application processors and MCU. Say Y here if you want to build
+	  the Hi6220 mailbox controller driver.
diff --git a/drivers/mailbox/hisilicon/Makefile b/drivers/mailbox/hisilicon/Makefile
new file mode 100644
index 0000000..59135b0
--- /dev/null
+++ b/drivers/mailbox/hisilicon/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_HISI_MBOX) += common.o
+obj-$(CONFIG_HI6220_MBOX) += hi6220-mailbox.o
diff --git a/drivers/mailbox/hisilicon/common.c b/drivers/mailbox/hisilicon/common.c
new file mode 100644
index 0000000..c3c8e49
--- /dev/null
+++ b/drivers/mailbox/hisilicon/common.c
@@ -0,0 +1,282 @@
+/*
+ * Hisilicon mailbox common driver
+ *
+ * This is skeleton driver for Hisilicon's mailbox, it registers mailbox
+ * channels into framework; it also need invoke low level's callback
+ * functions for low level operations. RX channel's message queue is
+ * based on the code written in drivers/mailbox/omap-mailbox.c.
+
+ * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 Linaro Limited.
+ *
+ * Author: Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#include "common.h"
+
+#define MBOX_MSG_LEN		(32)
+#define MBOX_MSG_NUM		(16)
+#define MBOX_MSG_FIFO_SIZE	(MBOX_MSG_LEN * MBOX_MSG_NUM)
+
+static bool hisi_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+
+	/* Only set idle state for polling mode */
+	BUG_ON(mbox_hw->tx_irq_mode);
+
+	return mbox_hw->ops->tx_is_done(mchan);
+}
+
+static int hisi_mbox_send_data(struct mbox_chan *chan, void *msg)
+{
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+
+	return mbox_hw->ops->tx(mchan, msg, MBOX_MSG_LEN);
+}
+
+static void hisi_mbox_rx_work(struct work_struct *work)
+{
+	struct hisi_mbox_queue *mq =
+			container_of(work, struct hisi_mbox_queue, work);
+	struct mbox_chan *chan = mq->chan;
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+
+	char msg[MBOX_MSG_LEN];
+	int len;
+
+	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
+		len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+		WARN_ON(len != sizeof(msg));
+
+		mbox_chan_received_data(chan, (void *)msg);
+		spin_lock_irq(&mq->lock);
+		if (mq->full) {
+			mq->full = false;
+			mbox_hw->ops->enable_irq(mchan);
+		}
+		spin_unlock_irq(&mq->lock);
+	}
+}
+
+static void hisi_mbox_tx_interrupt(struct mbox_chan *chan)
+{
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+
+	mbox_hw->ops->clear_irq(mchan);
+	mbox_hw->ops->ack(mchan);
+
+	mbox_chan_txdone(chan, 0);
+}
+
+static void hisi_mbox_rx_interrupt(struct mbox_chan *chan)
+{
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_queue *mq = mchan->mq;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+	char msg[MBOX_MSG_LEN];
+	int len;
+
+	if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
+		mbox_hw->ops->disable_irq(mchan);
+		mq->full = true;
+		goto nomem;
+	}
+
+	mbox_hw->ops->rx(mchan, msg, sizeof(msg));
+
+	len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
+	WARN_ON(len != sizeof(msg));
+
+	mbox_hw->ops->ack(mchan);
+nomem:
+	schedule_work(&mq->work);
+}
+
+static irqreturn_t hisi_mbox_interrupt(int irq, void *p)
+{
+	struct hisi_mbox *mbox = p;
+	struct hisi_mbox_hw *mbox_hw = mbox->hw;
+	struct hisi_mbox_chan *mchan;
+	struct mbox_chan *chan;
+	unsigned int state;
+	unsigned int intr_bit;
+
+	state = mbox_hw->ops->get_pending_irq(mbox_hw);
+	if (!state) {
+		dev_warn(mbox_hw->dev, "%s: spurious interrupt\n",
+			 __func__);
+		return IRQ_HANDLED;
+	}
+
+	while (state) {
+		intr_bit = __ffs(state);
+		state &= (state - 1);
+
+		chan = mbox->irq_map_chan[intr_bit];
+		if (!chan) {
+			dev_warn(mbox_hw->dev, "%s: unexpected irq vector %d\n",
+				 __func__, intr_bit);
+			continue;
+		}
+
+		mchan = chan->con_priv;
+		if (mchan->dir == MBOX_TX)
+			hisi_mbox_tx_interrupt(chan);
+		else
+			hisi_mbox_rx_interrupt(chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct hisi_mbox_queue *hisi_mbox_queue_alloc(
+		struct mbox_chan *chan,
+		void (*work)(struct work_struct *))
+{
+	struct hisi_mbox_queue *mq;
+
+	if (!work)
+		return NULL;
+
+	mq = kzalloc(sizeof(struct hisi_mbox_queue), GFP_KERNEL);
+	if (!mq)
+		return NULL;
+
+	spin_lock_init(&mq->lock);
+
+	if (kfifo_alloc(&mq->fifo, MBOX_MSG_FIFO_SIZE, GFP_KERNEL))
+		goto error;
+
+	mq->chan = chan;
+	INIT_WORK(&mq->work, work);
+	return mq;
+
+error:
+	kfree(mq);
+	return NULL;
+}
+
+static void hisi_mbox_queue_free(struct hisi_mbox_queue *mq)
+{
+	kfifo_free(&mq->fifo);
+	kfree(mq);
+}
+
+static int hisi_mbox_startup(struct mbox_chan *chan)
+{
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+	struct hisi_mbox *mbox = mchan->mbox_hw->parent;
+
+	struct hisi_mbox_queue *mq;
+	unsigned int irq = mchan->local_irq;
+
+	mq = hisi_mbox_queue_alloc(chan, hisi_mbox_rx_work);
+	if (!mq)
+		return -ENOMEM;
+	mchan->mq = mq;
+
+	mbox->irq_map_chan[irq] = (void *)chan;
+	return mbox_hw->ops->startup(mchan);
+}
+
+static void hisi_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct hisi_mbox_chan *mchan = chan->con_priv;
+	struct hisi_mbox_hw *mbox_hw = mchan->mbox_hw;
+	struct hisi_mbox *mbox = mbox_hw->parent;
+	unsigned int irq = mchan->local_irq;
+
+	mbox_hw->ops->shutdown(mchan);
+
+	mbox->irq_map_chan[irq] = NULL;
+	flush_work(&mchan->mq->work);
+	hisi_mbox_queue_free(mchan->mq);
+}
+
+static struct mbox_chan_ops hisi_mbox_chan_ops = {
+	.send_data    = hisi_mbox_send_data,
+	.startup      = hisi_mbox_startup,
+	.shutdown     = hisi_mbox_shutdown,
+	.last_tx_done = hisi_mbox_last_tx_done,
+};
+
+int hisi_mbox_register(struct hisi_mbox_hw *mbox_hw)
+{
+	struct device *dev = mbox_hw->dev;
+	struct hisi_mbox *mbox;
+	int i, err;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	mbox->hw = mbox_hw;
+	mbox->chan = devm_kzalloc(dev,
+		mbox_hw->chan_num * sizeof(struct mbox_chan), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	err = devm_request_irq(dev, mbox_hw->irq, hisi_mbox_interrupt, 0,
+			dev_name(dev), mbox);
+	if (err) {
+		dev_err(dev, "Failed to register a mailbox IRQ handler: %d\n",
+			err);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < mbox_hw->chan_num; i++) {
+		mbox->chan[i].con_priv = &mbox_hw->chan[i];
+		mbox->irq_map_chan[i] = NULL;
+	}
+
+	mbox->controller.dev = dev;
+	mbox->controller.chans = &mbox->chan[0];
+	mbox->controller.num_chans = mbox_hw->chan_num;
+	mbox->controller.ops = &hisi_mbox_chan_ops;
+
+	if (mbox_hw->tx_irq_mode)
+		mbox->controller.txdone_irq = true;
+	else {
+		mbox->controller.txdone_poll = true;
+		mbox->controller.txpoll_period = 5;
+	}
+
+	err = mbox_controller_register(&mbox->controller);
+	if (err) {
+		dev_err(dev, "Failed to register mailbox %d\n", err);
+		return err;
+	}
+
+	mbox_hw->parent = mbox;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_mbox_register);
+
+void hisi_mbox_unregister(struct hisi_mbox_hw *mbox_hw)
+{
+	struct hisi_mbox *mbox = mbox_hw->parent;
+
+	mbox_controller_unregister(&mbox->controller);
+}
+EXPORT_SYMBOL_GPL(hisi_mbox_unregister);
diff --git a/drivers/mailbox/hisilicon/common.h b/drivers/mailbox/hisilicon/common.h
new file mode 100644
index 0000000..c2199e2
--- /dev/null
+++ b/drivers/mailbox/hisilicon/common.h
@@ -0,0 +1,114 @@
+/*
+ * Hisilicon mailbox definition
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 Linaro Limited.
+ *
+ * Author: Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __HISI_MBOX_H
+#define __HISI_MBOX_H
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kfifo.h>
+#include <linux/mailbox_controller.h>
+#include <linux/spinlock.h>
+
+#define MBOX_MAX_CHANS		32
+#define MBOX_RX			0x0
+#define MBOX_TX			0x1
+
+struct hisi_mbox_queue {
+	spinlock_t lock;
+	struct kfifo fifo;
+	struct work_struct work;
+	struct mbox_chan *chan;
+	bool full;
+};
+
+struct hisi_mbox_chan {
+
+	/*
+	 * Description for channel's hardware info:
+	 * - direction;
+	 * - peer core id for communication;
+	 * - local irq vector or number;
+	 * - remoted irq vector or number for peer core;
+	 */
+	unsigned int dir;
+	unsigned int peer_core;
+	unsigned int remote_irq;
+	unsigned int local_irq;
+
+	/*
+	 * Slot address is cached value derived from index
+	 * within buffer for every channel
+	 */
+	void __iomem *slot;
+
+	/* For rx's fifo operations */
+	struct hisi_mbox_queue *mq;
+
+	struct hisi_mbox_hw *mbox_hw;
+};
+
+struct hisi_mbox_ops {
+	int (*startup)(struct hisi_mbox_chan *chan);
+	void (*shutdown)(struct hisi_mbox_chan *chan);
+
+	int (*rx)(struct hisi_mbox_chan *chan, void *msg, int len);
+	int (*tx)(struct hisi_mbox_chan *chan, void *msg, int len);
+	int (*tx_is_done)(struct hisi_mbox_chan *chan);
+	int (*ack)(struct hisi_mbox_chan *chan);
+
+	u32 (*get_pending_irq)(struct hisi_mbox_hw *mbox_hw);
+
+	void (*clear_irq)(struct hisi_mbox_chan *chan);
+	void (*enable_irq)(struct hisi_mbox_chan *chan);
+	void (*disable_irq)(struct hisi_mbox_chan *chan);
+};
+
+struct hisi_mbox_hw {
+	struct device *dev;
+
+	unsigned int irq;
+
+	/* flag of enabling tx's irq mode */
+	bool tx_irq_mode;
+
+	/* region for ipc event */
+	void __iomem *ipc;
+
+	/* region for share mem */
+	void __iomem *buf;
+
+	unsigned int chan_num;
+	struct hisi_mbox_chan *chan;
+	struct hisi_mbox_ops *ops;
+	struct hisi_mbox *parent;
+};
+
+struct hisi_mbox {
+	struct hisi_mbox_hw *hw;
+
+	void *irq_map_chan[MBOX_MAX_CHANS];
+	struct mbox_chan *chan;
+	struct mbox_controller controller;
+};
+
+extern int hisi_mbox_register(struct hisi_mbox_hw *mbox_hw);
+extern void hisi_mbox_unregister(struct hisi_mbox_hw *mbox_hw);
+
+#endif /* __HISI_MBOX_H */
diff --git a/drivers/mailbox/hisilicon/hi6220-mailbox.c b/drivers/mailbox/hisilicon/hi6220-mailbox.c
new file mode 100644
index 0000000..099e21d
--- /dev/null
+++ b/drivers/mailbox/hisilicon/hi6220-mailbox.c
@@ -0,0 +1,305 @@
+/*
+ * Hisilicon's Hi6220 mailbox low level driver
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 Linaro Limited.
+ *
+ * Author: Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "common.h"
+
+#define HI6220_MBOX_CHAN_NUM			2
+#define HI6220_MBOX_CHAN_SLOT_SIZE		(1 << 6)
+
+/* Status & Mode Register */
+#define HI6220_MBOX_MODE_REG			(0x0)
+
+#define HI6220_MBOX_STATUS_MASK			(0xF << 4)
+#define HI6220_MBOX_STATUS_IDLE			(0x1 << 4)
+#define HI6220_MBOX_STATUS_TX			(0x2 << 4)
+#define HI6220_MBOX_STATUS_RX			(0x4 << 4)
+#define HI6220_MBOX_STATUS_ACK			(0x8 << 4)
+#define HI6220_MBOX_ACK_CONFIG_MASK		(0x1 << 0)
+#define HI6220_MBOX_ACK_AUTOMATIC		(0x1 << 0)
+#define HI6220_MBOX_ACK_IRQ			(0x0 << 0)
+
+/* Data Registers */
+#define HI6220_MBOX_DATA_REG(i)			(0x4 + (i << 2))
+
+/* ACPU Interrupt Register */
+#define HI6220_MBOX_ACPU_INT_RAW_REG		(0x400)
+#define HI6220_MBOX_ACPU_INT_MSK_REG		(0x404)
+#define HI6220_MBOX_ACPU_INT_STAT_REG		(0x408)
+#define HI6220_MBOX_ACPU_INT_CLR_REG		(0x40c)
+#define HI6220_MBOX_ACPU_INT_ENA_REG		(0x500)
+#define HI6220_MBOX_ACPU_INT_DIS_REG		(0x504)
+
+/* MCU Interrupt Register */
+#define HI6220_MBOX_MCU_INT_RAW_REG		(0x420)
+
+/* Core Id */
+#define HI6220_CORE_ACPU			(0x0)
+#define HI6220_CORE_MCU				(0x2)
+
+static u32 hi6220_mbox_get_status(struct hisi_mbox_chan *chan)
+{
+	u32 status;
+
+	status = readl(chan->slot + HI6220_MBOX_MODE_REG);
+	return status & HI6220_MBOX_STATUS_MASK;
+}
+
+static void hi6220_mbox_set_status(struct hisi_mbox_chan *chan, u32 val)
+{
+	u32 status;
+
+	status = readl(chan->slot + HI6220_MBOX_MODE_REG);
+	status &= ~HI6220_MBOX_STATUS_MASK;
+	status |= val;
+	writel(status, chan->slot + HI6220_MBOX_MODE_REG);
+}
+
+static void hi6220_mbox_set_mode(struct hisi_mbox_chan *chan, u32 val)
+{
+	u32 mode;
+
+	mode = readl(chan->slot + HI6220_MBOX_MODE_REG);
+	mode &= ~HI6220_MBOX_ACK_CONFIG_MASK;
+	mode |= val;
+	writel(mode, chan->slot + HI6220_MBOX_MODE_REG);
+}
+
+static void hi6220_mbox_clear_irq(struct hisi_mbox_chan *chan)
+{
+	struct hisi_mbox_hw *mbox_hw = chan->mbox_hw;
+	int irq = chan->local_irq;
+
+	writel(1 << irq, mbox_hw->ipc + HI6220_MBOX_ACPU_INT_CLR_REG);
+}
+
+static void hi6220_mbox_enable_irq(struct hisi_mbox_chan *chan)
+{
+	struct hisi_mbox_hw *mbox_hw = chan->mbox_hw;
+	int irq = chan->local_irq;
+
+	writel(1 << irq, mbox_hw->ipc + HI6220_MBOX_ACPU_INT_ENA_REG);
+}
+
+static void hi6220_mbox_disable_irq(struct hisi_mbox_chan *chan)
+{
+	struct hisi_mbox_hw *mbox_hw = chan->mbox_hw;
+	int irq = chan->local_irq;
+
+	writel(1 << irq, mbox_hw->ipc + HI6220_MBOX_ACPU_INT_DIS_REG);
+}
+
+static u32 hi6220_mbox_get_pending_irq(struct hisi_mbox_hw *mbox_hw)
+{
+	return readl(mbox_hw->ipc + HI6220_MBOX_ACPU_INT_STAT_REG);
+}
+
+static int hi6220_mbox_startup(struct hisi_mbox_chan *chan)
+{
+	hi6220_mbox_enable_irq(chan);
+	return 0;
+}
+
+static void hi6220_mbox_shutdown(struct hisi_mbox_chan *chan)
+{
+	hi6220_mbox_disable_irq(chan);
+}
+
+static int hi6220_mbox_rx(struct hisi_mbox_chan *chan, void *msg, int len)
+{
+	int *buf = msg;
+	int i;
+
+	for (i = 0; i < (len >> 2); i++)
+		buf[i] = readl(chan->slot + HI6220_MBOX_DATA_REG(i));
+
+	/* clear IRQ source */
+	hi6220_mbox_clear_irq(chan);
+	hi6220_mbox_set_status(chan, HI6220_MBOX_STATUS_IDLE);
+	return len;
+}
+
+static int hi6220_mbox_tx(struct hisi_mbox_chan *chan, void *msg, int len)
+{
+	struct hisi_mbox_hw *mbox_hw = chan->mbox_hw;
+	int *buf = msg;
+	int irq = chan->remote_irq, i;
+
+	hi6220_mbox_set_status(chan, HI6220_MBOX_STATUS_TX);
+
+	if (mbox_hw->tx_irq_mode)
+		hi6220_mbox_set_mode(chan, HI6220_MBOX_ACK_IRQ);
+	else
+		hi6220_mbox_set_mode(chan, HI6220_MBOX_ACK_AUTOMATIC);
+
+	for (i = 0; i < (len >> 2); i++)
+		writel(buf[i], chan->slot + HI6220_MBOX_DATA_REG(i));
+
+	/* trigger remote request */
+	writel(1 << irq, mbox_hw->ipc + HI6220_MBOX_MCU_INT_RAW_REG);
+	return 0;
+}
+
+static int hi6220_mbox_tx_is_done(struct hisi_mbox_chan *chan)
+{
+	int status;
+
+	status = hi6220_mbox_get_status(chan);
+	return (status == HI6220_MBOX_STATUS_IDLE);
+}
+
+static int hi6220_mbox_ack(struct hisi_mbox_chan *chan)
+{
+	hi6220_mbox_set_status(chan, HI6220_MBOX_STATUS_IDLE);
+	return 0;
+}
+
+static struct hisi_mbox_ops hi6220_mbox_ops = {
+	.startup	 = hi6220_mbox_startup,
+	.shutdown	 = hi6220_mbox_shutdown,
+
+	.clear_irq	 = hi6220_mbox_clear_irq,
+	.enable_irq	 = hi6220_mbox_enable_irq,
+	.disable_irq	 = hi6220_mbox_disable_irq,
+	.get_pending_irq = hi6220_mbox_get_pending_irq,
+
+	.rx		 = hi6220_mbox_rx,
+	.tx		 = hi6220_mbox_tx,
+	.tx_is_done	 = hi6220_mbox_tx_is_done,
+	.ack		 = hi6220_mbox_ack,
+};
+
+static void hi6220_mbox_init_hw(struct hisi_mbox_hw *mbox_hw)
+{
+	struct hisi_mbox_chan init_data[HI6220_MBOX_CHAN_NUM] = {
+		{ MBOX_RX, HI6220_CORE_MCU, 1, 10 },
+		{ MBOX_TX, HI6220_CORE_MCU, 0, 11 },
+	};
+	struct hisi_mbox_chan *chan = mbox_hw->chan;
+	int i;
+
+	for (i = 0; i < HI6220_MBOX_CHAN_NUM; i++) {
+		memcpy(&chan[i], &init_data[i], sizeof(*chan));
+		chan[i].slot = mbox_hw->buf + HI6220_MBOX_CHAN_SLOT_SIZE;
+		chan[i].mbox_hw = mbox_hw;
+	}
+
+	/* mask and clear all interrupt vectors */
+	writel(0x0,  mbox_hw->ipc + HI6220_MBOX_ACPU_INT_MSK_REG);
+	writel(~0x0, mbox_hw->ipc + HI6220_MBOX_ACPU_INT_CLR_REG);
+
+	/* use interrupt for tx's ack */
+	mbox_hw->tx_irq_mode = true;
+
+	/* set low level ops */
+	mbox_hw->ops = &hi6220_mbox_ops;
+}
+
+static const struct of_device_id hi6220_mbox_of_match[] = {
+	{ .compatible = "hisilicon,hi6220-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hi6220_mbox_of_match);
+
+static int hi6220_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_mbox_hw *mbox_hw;
+	struct resource *res;
+	int err;
+
+	mbox_hw = devm_kzalloc(dev, sizeof(*mbox_hw), GFP_KERNEL);
+	if (!mbox_hw)
+		return -ENOMEM;
+
+	mbox_hw->dev = dev;
+	mbox_hw->chan_num = HI6220_MBOX_CHAN_NUM;
+	mbox_hw->chan = devm_kzalloc(dev,
+		mbox_hw->chan_num * sizeof(struct hisi_mbox_chan), GFP_KERNEL);
+	if (!mbox_hw->chan)
+		return -ENOMEM;
+
+	mbox_hw->irq = platform_get_irq(pdev, 0);
+	if (mbox_hw->irq < 0)
+		return mbox_hw->irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbox_hw->ipc = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mbox_hw->ipc)) {
+		dev_err(dev, "ioremap ipc failed\n");
+		return PTR_ERR(mbox_hw->ipc);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	mbox_hw->buf = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mbox_hw->buf)) {
+		dev_err(dev, "ioremap buffer failed\n");
+		return PTR_ERR(mbox_hw->buf);
+	}
+
+	hi6220_mbox_init_hw(mbox_hw);
+
+	err = hisi_mbox_register(mbox_hw);
+	if (err)
+		return err;
+
+	platform_set_drvdata(pdev, mbox_hw);
+	dev_info(dev, "Mailbox enabled\n");
+	return 0;
+}
+
+static int hi6220_mbox_remove(struct platform_device *pdev)
+{
+	struct hisi_mbox_hw *mbox_hw = platform_get_drvdata(pdev);
+
+	hisi_mbox_unregister(mbox_hw);
+	return 0;
+}
+
+static struct platform_driver hi6220_mbox_driver = {
+	.driver = {
+		.name = "hi6220-mbox",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(hi6220_mbox_of_match),
+	},
+	.probe	= hi6220_mbox_probe,
+	.remove	= hi6220_mbox_remove,
+};
+
+static int __init hi6220_mbox_init(void)
+{
+	return platform_driver_register(&hi6220_mbox_driver);
+}
+module_init(hi6220_mbox_init);
+
+static void __exit hi6220_mbox_exit(void)
+{
+	platform_driver_unregister(&hi6220_mbox_driver);
+}
+module_exit(hi6220_mbox_exit);
+
+MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
+MODULE_DESCRIPTION("Hi6220 mailbox driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
