From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Fri, 13 Sep 2013 23:32:07 +1200
Subject: [RFC PATCH 1/3] Enable BCM2835 mailbox support
Message-ID: <5232F7B7.4070206@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cherry-picked selection of commits by Lubomir Rintel [1], Suman Anna and
Jassi Brar [2] on which to base the implementation.

Signed-off-by: Suman Ana <s-anna@ti.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

[1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
[2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html

---
diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
new file mode 100644
index 0000000..75dbb89
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
@@ -0,0 +1,15 @@
+Broadcom BCM2835 VideoCore mailbox IPC
+
+Required properties:
+
+- compatible : should be "brcm,bcm2835-mbox"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : the interrupt number
+
+Example:
+
+mailbox {
+	compatible = "brcm,bcm2835-mbox";
+	reg = <0x7e00b800 0x400>;
+	interrupts = <0 1>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 1e12aef..4fc8a68 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -29,6 +29,12 @@
 			#interrupt-cells = <2>;
 		};
 +		mailbox {
+			compatible = "brcm,bcm2835-mbox";
+			reg = <0x7e00b880 0x40>;
+			interrupts = <0 1>;
+		};
+
 		watchdog {
 			compatible = "brcm,bcm2835-pm-wdt";
 			reg = <0x7e100000 0x28>;
diff --git a/arch/arm/mach-bcm2835/Makefile b/arch/arm/mach-bcm2835/Makefile
index 4c3892f..934ab42 100644
--- a/arch/arm/mach-bcm2835/Makefile
+++ b/arch/arm/mach-bcm2835/Makefile
@@ -1 +1 @@
-obj-y += bcm2835.o
+obj-y += bcm2835.o mailbox.o
diff --git a/arch/arm/mach-bcm2835/mailbox.c b/arch/arm/mach-bcm2835/mailbox.c
new file mode 100644
index 0000000..cbc6898
--- /dev/null
+++ b/arch/arm/mach-bcm2835/mailbox.c
@@ -0,0 +1,278 @@
+/*
+ *  Copyright (C) 2010 Broadcom
+ *  Copyright (C) 2013 Lubomir Rintel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This device provides a mechanism for writing to the mailboxes,
+ * that are shared between the ARM and the VideoCore processor
+ *
+ * Parts of the driver are based on arch/arm/mach-bcm2708/vcio.c file
+ * written by Gray Girling that was obtained from branch "rpi-3.6.y"
+ * of git://github.com/raspberrypi/linux.git as well as documentation
+ * available on the following web site:
+ * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
+ */
+
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/kernel.h>
+
+#define BCM2835_MBOX_TIMEOUT HZ
+
+/* Mailboxes */
+#define ARM_0_MAIL0	0x00
+#define ARM_0_MAIL1	0x20
+
+/* Mailbox registers. We basically only support mailbox 0 & 1. We deliver to
+ * the VC in mailbox 1, it delivers to us in mailbox 0. See BCM2835 ARM
+ * Peripherals section 1.3 for an explanation about the placement of memory
+ * barriers. */
+#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
+#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
+#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
+#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)
+
+/* Read/write Channels. Currently we just need the property one. */
+#define MBOX_CHAN_PROPERTY	8
+#define MBOX_CHAN_COUNT		9
+
+/* Status register: FIFO state. */
+#define ARM_MS_FULL		0x80000000
+#define ARM_MS_EMPTY		0x40000000
+
+/* Configuration register: Enable interrupts. */
+#define ARM_MC_IHAVEDATAIRQEN	0x00000001
+
+#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
+#define MBOX_CHAN(msg)			((msg) & 0xf)
+#define MBOX_DATA28(msg)		((msg) & ~0xf)
+
+static struct device *bcm2835_mbox_dev;	/* we assume there's only one! */
+
+struct bcm2835_mbox {
+	struct device *dev;
+	void __iomem *regs;
+	struct {
+		u32 msg;
+		struct completion comp;
+		struct mutex lock;
+	} chan[MBOX_CHAN_COUNT];
+};
+
+static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
+{
+	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *)dev_id;
+	struct device *dev = mbox->dev;
+	int ret = IRQ_NONE;
+
+	/* wait for the mailbox FIFO to have some data in it */
+
+	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
+		u32 msg = readl(mbox->regs + MAIL0_RD);
+		unsigned int chan = MBOX_CHAN(msg);
+		rmb(); /* Finished last mailbox read. */
+
+		if (chan > MBOX_CHAN_COUNT) {
+			dev_err(dev, "invalid channel (%d)\n", chan);
+			continue;
+		}
+
+		if (mbox->chan[chan].msg) {
+			dev_err(dev, "overflow on channel (%d)\n", chan);
+			continue;
+		}
+
+		mbox->chan[chan].msg = msg;
+		complete(&mbox->chan[chan].comp);
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+/**
+ * bcm2835_mbox_io() - send a message to BCM2835 mailbox and read a reply
+ * @chan:	Channel number
+ * @in28:	Message to send
+ * @out28:	Where to put the response
+ *
+ * Sends a message to the BCM2835 mailbox.
+ *
+ * If the last argument is non-NULL, a response from VideoCore is awaited
+ * for and written to memory pointed to by it.
+ *
+ * The I/O to property mailbox is more conveniently dealt with by using
+ * bcm2835_mbox_property() function.
+ *
+ * Return: 0 in case of success, otherwise an error code
+ */
+
+int bcm2835_mbox_io(unsigned chan, u32 in28, u32 *out28)
+{
+	struct bcm2835_mbox *mbox;
+	int timeout;
+	int ret = 0;
+
+	if (!bcm2835_mbox_dev)
+		return -ENODEV;
+
+	mbox = dev_get_drvdata(bcm2835_mbox_dev);
+
+	device_lock(bcm2835_mbox_dev);
+	/* wait for the mailbox FIFO to have some space in it */
+	while (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL)
+		cpu_relax();
+	rmb(); /* Finished last mailbox read. */
+
+	mutex_lock(&mbox->chan[chan].lock);
+	INIT_COMPLETION(mbox->chan[chan].comp);
+	wmb(); /* About to write to the mail box. */
+	writel(MBOX_MSG(chan, in28), mbox->regs + MAIL1_WRT);
+	device_unlock(bcm2835_mbox_dev);
+
+	timeout = wait_for_completion_timeout(&mbox->chan[chan].comp,
+						BCM2835_MBOX_TIMEOUT);
+	if (timeout  == 0) {
+		dev_warn(bcm2835_mbox_dev, "Channel %d timeout\n", chan);
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (out28 != NULL)
+		*out28 = MBOX_DATA28(mbox->chan[chan].msg);
+
+out:
+	mbox->chan[chan].msg = 0;
+	mutex_unlock(&mbox->chan[chan].lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bcm2835_mbox_io);
+
+/**
+ * bcm2835_mbox_property() - Call a BCM2835 Property mailbox service
+ * @mem_bus:	DMA address of message
+ *
+ * Sends a message to the BCM2835 property mailbox and wait for VideoCore to
+ * respond. The message memory should be obtained with dma_alloc_coherent()
+ * and be filled with a properly formatted mailbox message.
+ *
+ * Return: 0 in case of success, otherwise an error code
+ */
+
+int bcm2835_mbox_property(dma_addr_t mem_bus)
+{
+	int ret;
+	int val;
+
+	ret = bcm2835_mbox_io(MBOX_CHAN_PROPERTY, (u32)mem_bus, (u32 *)&val);
+	if (mem_bus != val) {
+		dev_warn(bcm2835_mbox_dev, "Bad response from property mailbox\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bcm2835_mbox_property);
+
+static int bcm2835_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct bcm2835_mbox *mbox;
+	int irq;
+	int ret;
+	int i;
+	struct resource *iomem;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (mbox == NULL) {
+		dev_err(dev, "Failed to allocate mailbox memory\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize the channels */
+	for (i = 0; i < MBOX_CHAN_COUNT; i++) {
+		mbox->chan[i].msg = 0;
+		init_completion(&mbox->chan[i].comp);
+		mutex_init(&mbox->chan[i].lock);
+	}
+
+	platform_set_drvdata(pdev, mbox);
+	mbox->dev = dev;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		dev_err(dev, "Can't get IRQ number for mailbox\n");
+		return -ENODEV;
+	}
+	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, IRQF_SHARED,
+						dev_name(dev), mbox);
+	if (ret) {
+		dev_err(dev, "Failed to register a mailbox IRQ handler\n");
+		return -ENODEV;
+	}
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbox->regs = devm_request_and_ioremap(&pdev->dev, iomem);
+	if (!mbox->regs) {
+		dev_err(dev, "Failed to remap mailbox regs\n");
+		return -ENODEV;
+	}
+
+	/* Enable the interrupt on data reception */
+	writel(ARM_MC_IHAVEDATAIRQEN, mbox->regs + MAIL0_CNF);
+
+	dev_info(dev, "Broadcom BCM2835 mailbox IPC");
+	bcm2835_mbox_dev = dev;
+
+	return 0;
+}
+
+static int bcm2835_mbox_remove(struct platform_device *pdev)
+{
+	bcm2835_mbox_dev = NULL;
+	return 0;
+}
+
+static const struct of_device_id bcm2835_mbox_of_match[] = {
+	{ .compatible = "brcm,bcm2835-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_mbox_of_match);
+
+static struct platform_driver bcm2835_mbox_driver = {
+	.driver = {
+		.name = "bcm2835-mbox",
+		.owner = THIS_MODULE,
+		.of_match_table = bcm2835_mbox_of_match,
+	},
+	.probe		= bcm2835_mbox_probe,
+	.remove		= bcm2835_mbox_remove,
+};
+module_platform_driver(bcm2835_mbox_driver);
+
+/*
+static int __init bcm2835_mbox_init(void)
+{
+	return platform_driver_register(&bcm2835_mbox_driver);
+}
+
+arch_initcall(bcm2835_mbox_init);
+*/
+
+MODULE_AUTHOR("Lubomir Rintel");
+MODULE_DESCRIPTION("BCM2835 mailbox IPC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index e0facb3..2fa343a 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -1,3 +1,7 @@
+# Generic MAILBOX API
+
+obj-$(CONFIG_MAILBOX)		+= mailbox.o
+
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
  obj-$(CONFIG_OMAP_MBOX)		+= omap-mailbox.o
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
new file mode 100644
index 0000000..c4ef608
--- /dev/null
+++ b/drivers/mailbox/mailbox.c
@@ -0,0 +1,474 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+
+#include "mailbox_internal.h"
+
+static LIST_HEAD(ipc_cons);
+static DEFINE_MUTEX(con_mutex);
+
+static request_token_t _add_to_rbuf(struct ipc_chan *chan, void *mssg)
+{
+	request_token_t idx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	/* See if there is any space left */
+	if (chan->msg_count == MBOX_TX_QUEUE_LEN) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return 0;
+	}
+
+	idx = chan->msg_free;
+	chan->msg_data[idx] = mssg;
+	chan->msg_count++;
+
+	if (idx == MBOX_TX_QUEUE_LEN - 1)
+		chan->msg_free = 0;
+	else
+		chan->msg_free++;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	/* To aid debugging, we return 'idx+1' instead of 1 */
+	return idx + 1;
+}
+
+static void _msg_submit(struct ipc_chan *chan)
+{
+	struct ipc_link *link = chan->link;
+	unsigned count, idx;
+	unsigned long flags;
+	void *data;
+	int err;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	if (!chan->msg_count || chan->active_req) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return;
+	}
+
+	count = chan->msg_count;
+	idx = chan->msg_free;
+	if (idx >= count)
+		idx -= count;
+	else
+		idx += MBOX_TX_QUEUE_LEN - count;
+
+	data = chan->msg_data[idx];
+
+	/* Try to submit a message to the IPC controller */
+	err = chan->link_ops->send_data(link, data);
+	if (!err) {
+		chan->active_req = data;
+		chan->msg_count--;
+	}
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+static void tx_tick(struct ipc_chan *chan, enum xfer_result r)
+{
+	unsigned long flags;
+	void *mssg;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	mssg = chan->active_req;
+	chan->active_req = NULL;
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	/* Submit next message */
+	_msg_submit(chan);
+
+	/* Notify the client */
+	if (chan->tx_block)
+		complete(&chan->tx_complete);
+	else if (mssg && chan->txcb)
+		chan->txcb(chan->cl_id, mssg, r);
+}
+
+static void poll_txdone(unsigned long data)
+{
+	struct ipc_con *con = (struct ipc_con *)data;
+	bool txdone, resched = false;
+	struct ipc_chan *chan;
+
+	list_for_each_entry(chan, &con->channels, node) {
+		if (chan->active_req && chan->assigned) {
+			resched = true;
+			txdone = chan->link_ops->is_ready(chan->link);
+			if (txdone)
+				tx_tick(chan, XFER_OK);
+		}
+	}
+
+	if (resched)
+		mod_timer(&con->poll,
+			jiffies + msecs_to_jiffies(con->period));
+}
+
+/*
+ * After 'startup' and before 'shutdown', the IPC controller driver
+ * notifies the API of data received over the link.
+ * The controller driver should make sure the 'RTR' is de-asserted since
+ * reception of the packet and until after this call returns.
+ * This call could be made from atomic context.
+ */
+void ipc_link_received_data(struct ipc_link *link, void *mssg)
+{
+	struct ipc_chan *chan = (struct ipc_chan *)link->api_priv;
+
+	/* No buffering the received data */
+	if (chan->rxcb)
+		chan->rxcb(chan->cl_id, mssg);
+}
+EXPORT_SYMBOL(ipc_link_received_data);
+
+/*
+ * The IPC controller driver notifies the API that the remote has
+ * asserted RTR and it could now send another message on the link.
+ */
+void ipc_link_txdone(struct ipc_link *link, enum xfer_result r)
+{
+	struct ipc_chan *chan = (struct ipc_chan *)link->api_priv;
+
+	if (unlikely(!(chan->txdone_method & TXDONE_BY_IRQ))) {
+		pr_err("Controller can't run the TX ticker\n");
+		return;
+	}
+
+	tx_tick(chan, r);
+}
+EXPORT_SYMBOL(ipc_link_txdone);
+
+/*
+ * The client/protocol had received some 'ACK' packet and it notifies
+ * the API that the last packet was sent successfully. This only works
+ * if the controller doesn't get IRQ for TX done.
+ */
+void ipc_client_txdone(void *channel, enum xfer_result r)
+{
+	struct ipc_chan *chan = (struct ipc_chan *)channel;
+	bool txdone = true;
+
+	if (unlikely(!(chan->txdone_method & TXDONE_BY_ACK))) {
+		pr_err("Client can't run the TX ticker\n");
+		return;
+	}
+
+	if (chan->txdone_method & TXDONE_BY_POLL)
+		txdone = chan->link_ops->is_ready(chan->link);
+
+	if (txdone)
+		tx_tick(chan, r);
+}
+EXPORT_SYMBOL(ipc_client_txdone);
+
+/*
+ * Called by a client to "put data on the h/w channel" so that if
+ * everything else is fine we don't need to do anything more locally
+ * for the remote to receive the data intact.
+ * In reality, the remote may receive it intact, corrupted or not at all.
+ * This could be called from atomic context as it simply
+ * queues the data and returns a token (request_token_t)
+ * against the request.
+ * The client is later notified of successful transmission of
+ * data over the channel via the 'txcb'. The client could in
+ * turn queue more messages from txcb.
+ */
+request_token_t ipc_send_message(void *channel, void *mssg)
+{
+	struct ipc_chan *chan = (struct ipc_chan *)channel;
+	request_token_t t;
+
+	if (!chan || !chan->assigned)
+		return 0;
+
+	t = _add_to_rbuf(chan, mssg);
+	if (!t)
+		pr_err("Try increasing MBOX_TX_QUEUE_LEN\n");
+
+	_msg_submit(chan);
+
+	if (chan->txdone_method	== TXDONE_BY_POLL)
+		poll_txdone((unsigned long)chan->con);
+
+	if (chan->tx_block && chan->active_req) {
+		int ret;
+		init_completion(&chan->tx_complete);
+		ret = wait_for_completion_timeout(&chan->tx_complete,
+			chan->tx_tout);
+		if (ret == 0) {
+			t = 0;
+			tx_tick(chan, XFER_ERR);
+		}
+	}
+
+	return t;
+}
+EXPORT_SYMBOL(ipc_send_message);
+
+/*
+ * A client driver asks for exclusive use of a channel/mailbox.
+ * If assigned, the channel has to be 'freed' before it could
+ * be assigned to some other client.
+ * After assignment, any packet received on this channel will be
+ * handed over to the client via the 'rxcb' callback.
+ * The 'txcb' callback is used to notify client upon sending the
+ * packet over the channel, which may or may not have been yet
+ * read by the remote processor.
+ */
+void *ipc_request_channel(struct ipc_client *cl)
+{
+	struct ipc_chan *chan;
+	struct ipc_con *con;
+	unsigned long flags;
+	char *con_name;
+	int len, ret;
+
+	con_name = cl->chan_name;
+	len = strcspn(cl->chan_name, ":");
+
+	ret = 0;
+	mutex_lock(&con_mutex);
+	list_for_each_entry(con, &ipc_cons, node)
+		if (!strncmp(con->name, con_name, len)) {
+			ret = 1;
+			break;
+		}
+	mutex_unlock(&con_mutex);
+
+	if (!ret) {
+		pr_err("Controller(%s) not found!\n", cl->chan_name);
+		return NULL;
+	}
+
+	ret = 0;
+	list_for_each_entry(chan, &con->channels, node) {
+		if (!strcmp(con_name + len + 1, chan->name)
+				&& !chan->assigned) {
+			spin_lock_irqsave(&chan->lock, flags);
+			chan->msg_free = 0;
+			chan->msg_count = 0;
+			chan->active_req = NULL;
+			chan->rxcb = cl->rxcb;
+			chan->txcb = cl->txcb;
+			chan->cl_id = cl->cl_id;
+			chan->assigned = true;
+			chan->tx_block = cl->tx_block;
+			if (!cl->tx_tout)
+				chan->tx_tout = ~0;
+			else
+				chan->tx_tout = msecs_to_jiffies(cl->tx_tout);
+			if (chan->txdone_method	== TXDONE_BY_POLL
+					&& cl->knows_txdone)
+				chan->txdone_method |= TXDONE_BY_ACK;
+			spin_unlock_irqrestore(&chan->lock, flags);
+			ret = 1;
+			break;
+		}
+	}
+
+	if (!ret) {
+		pr_err("Unable to assign mailbox(%s)\n", cl->chan_name);
+		return NULL;
+	}
+
+	ret = chan->link_ops->startup(chan->link, cl->link_data);
+	if (ret) {
+		pr_err("Unable to startup the link\n");
+		ipc_free_channel((void *)chan);
+		return NULL;
+	}
+
+	return (void *)chan;
+}
+EXPORT_SYMBOL(ipc_request_channel);
+
+/* Drop any messages queued and release the channel */
+void ipc_free_channel(void *ch)
+{
+	struct ipc_chan *chan = (struct ipc_chan *)ch;
+	unsigned long flags;
+
+	if (!chan || !chan->assigned)
+		return;
+
+	chan->link_ops->shutdown(chan->link);
+
+	/* The queued TX requests are simply aborted, no callbacks are made */
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->assigned = false;
+	chan->active_req = NULL;
+	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
+		chan->txdone_method = TXDONE_BY_POLL;
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	blocking_notifier_call_chain(&chan->avail, 0, NULL);
+}
+EXPORT_SYMBOL(ipc_free_channel);
+
+static struct ipc_chan *name_to_chan(const char *name)
+{
+	struct ipc_chan *chan = NULL;
+	struct ipc_con *con;
+	int len, found = 0;
+
+	len = strcspn(name, ":");
+
+	mutex_lock(&con_mutex);
+
+	list_for_each_entry(con, &ipc_cons, node) {
+		if (!strncmp(con->name, name, len)) {
+			list_for_each_entry(chan, &con->channels, node) {
+				if (!strcmp(name + len + 1, chan->name)) {
+					found = 1;
+					goto done;
+				}
+			}
+		}
+	}
+done:
+	mutex_unlock(&con_mutex);
+
+	if (!found)
+		return NULL;
+
+	return chan;
+}
+
+int ipc_notify_chan_register(const char *name, struct notifier_block *nb)
+{
+	struct ipc_chan *chan = name_to_chan(name);
+
+	if (chan && nb)
+		return blocking_notifier_chain_register(&chan->avail, nb);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(ipc_notify_chan_register);
+
+void ipc_notify_chan_unregister(const char *name, struct notifier_block *nb)
+{
+	struct ipc_chan *chan = name_to_chan(name);
+
+	if (chan && nb)
+		blocking_notifier_chain_unregister(&chan->avail, nb);
+}
+EXPORT_SYMBOL(ipc_notify_chan_unregister);
+
+/*
+ * Call for IPC controller drivers to register a controller, adding
+ * its channels/mailboxes to the global pool.
+ */
+int ipc_links_register(struct ipc_controller *ipc)
+{
+	int i, num_links, txdone;
+	struct ipc_chan *chan;
+	struct ipc_con *con;
+
+	/* Sanity check */
+	if (!ipc || !ipc->ops)
+		return -EINVAL;
+
+	for (i = 0; ipc->links[i]; i++)
+		;
+	if (!i)
+		return -EINVAL;
+	num_links = i;
+
+	mutex_lock(&con_mutex);
+	/* Check if already populated */
+	list_for_each_entry(con, &ipc_cons, node)
+		if (!strcmp(ipc->controller_name, con->name)) {
+			mutex_unlock(&con_mutex);
+			return -EINVAL;
+		}
+	mutex_unlock(&con_mutex);
+
+	con = kzalloc(sizeof(*con) + sizeof(*chan) * num_links, GFP_KERNEL);
+	if (!con)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&con->channels);
+	snprintf(con->name, 16, "%s", ipc->controller_name);
+
+	if (ipc->txdone_irq)
+		txdone = TXDONE_BY_IRQ;
+	else if (ipc->txdone_poll)
+		txdone = TXDONE_BY_POLL;
+	else /* It has to be ACK then */
+		txdone = TXDONE_BY_ACK;
+
+	if (txdone == TXDONE_BY_POLL) {
+		con->period = ipc->txpoll_period;
+		con->poll.function = &poll_txdone;
+		con->poll.data = (unsigned long)con;
+		init_timer(&con->poll);
+	}
+
+	chan = (void *)con + sizeof(*con);
+	for (i = 0; i < num_links; i++) {
+		chan[i].con = con;
+		chan[i].assigned = false;
+		chan[i].link_ops = ipc->ops;
+		chan[i].link = ipc->links[i];
+		chan[i].txdone_method = txdone;
+		chan[i].link->api_priv = &chan[i];
+		spin_lock_init(&chan[i].lock);
+		BLOCKING_INIT_NOTIFIER_HEAD(&chan[i].avail);
+		list_add_tail(&chan[i].node, &con->channels);
+		snprintf(chan[i].name, 16, "%s", ipc->links[i]->link_name);
+	}
+
+	mutex_lock(&con_mutex);
+	list_add_tail(&con->node, &ipc_cons);
+	mutex_unlock(&con_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(ipc_links_register);
+
+void ipc_links_unregister(struct ipc_controller *ipc)
+{
+	struct ipc_con *t, *con = NULL;
+	struct ipc_chan *chan;
+
+	mutex_lock(&con_mutex);
+
+	list_for_each_entry(t, &ipc_cons, node)
+		if (!strcmp(ipc->controller_name, t->name)) {
+			con = t;
+			break;
+		}
+
+	if (con)
+		list_del(&con->node);
+
+	mutex_unlock(&con_mutex);
+
+	if (!con)
+		return;
+
+	list_for_each_entry(chan, &con->channels, node)
+		ipc_free_channel((void *)chan);
+
+	del_timer_sync(&con->poll);
+
+	kfree(con);
+}
+EXPORT_SYMBOL(ipc_links_unregister);
diff --git a/drivers/mailbox/mailbox_internal.h b/drivers/mailbox/mailbox_internal.h
new file mode 100644
index 0000000..a39dcb7
--- /dev/null
+++ b/drivers/mailbox/mailbox_internal.h
@@ -0,0 +1,77 @@
+/*
+ * mailbox: interprocessor communication module
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MAILBOX_INTERNAL_H
+#define MAILBOX_INTERNAL_H
+
+#include <linux/device.h>
+#include <linux/mailbox_controller.h>
+
+/*
+ * The length of circular buffer for queuing messages from a client.
+ * 'msg_count' tracks the number of buffered messages while 'msg_free'
+ * is the index where the next message would be buffered.
+ * We shouldn't need it too big because every transferr is interrupt
+ * triggered and if we have lots of data to transfer, the interrupt
+ * latencies are going to be the bottleneck, not the buffer length.
+ * Besides, ipc_send_message could be called from atomic context and
+ * the client could also queue another message from the notifier 'txcb'
+ * of the last transfer done.
+ * REVIST: If too many platforms see the "Try increasing MBOX_TX_QUEUE_LEN"
+ * print, it needs to be taken from config option or somesuch.
+ */
+#define MBOX_TX_QUEUE_LEN	20
+
+#define TXDONE_BY_IRQ	(1 << 0) /* controller has remote RTR irq */
+#define TXDONE_BY_POLL	(1 << 1) /* controller can read status of last TX */
+#define TXDONE_BY_ACK	(1 << 2) /* S/W ACK recevied by Client ticks the TX */
+
+struct ipc_chan {
+	char name[16]; /* link_name */
+	struct ipc_con *con; /* Parent Controller */
+	unsigned txdone_method;
+
+	/* Cached values from controller */
+	struct ipc_link *link;
+	struct ipc_link_ops *link_ops;
+
+	/* Cached values from client */
+	void *cl_id;
+	void (*rxcb)(void *cl_id, void *mssg);
+	void (*txcb)(void *cl_id, void *mssg, enum xfer_result r);
+	bool tx_block;
+	unsigned long tx_tout;
+	struct completion tx_complete;
+
+	void *active_req;
+	unsigned msg_count, msg_free;
+	void *msg_data[MBOX_TX_QUEUE_LEN];
+	bool assigned;
+	/* Serialize access to the channel */
+	spinlock_t lock;
+	/* Hook to add to the controller's list of channels */
+	struct list_head node;
+	/* Notifier to all clients waiting on aquiring this channel */
+	struct blocking_notifier_head avail;
+};
+
+/* Internal representation of a controller */
+struct ipc_con {
+	char name[16]; /* controller_name */
+	struct list_head channels;
+	/*
+	 * If the controller supports only TXDONE_BY_POLL,
+	 * this timer polls all the links for txdone.
+	 */
+	struct timer_list poll;
+	unsigned period;
+	/* Hook to add to the global controller list */
+	struct list_head node;
+};
+
+#endif /* MAILBOX_INTERNAL_H */
diff --git a/include/linux/mailbox.h b/include/linux/mailbox.h
index 5161f63..232e2c4 100644
--- a/include/linux/mailbox.h
+++ b/include/linux/mailbox.h
@@ -1,17 +1,17 @@
 /*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 -int pl320_ipc_transmit(u32 *data);
-int pl320_ipc_register_notifier(struct notifier_block *nb);
-int pl320_ipc_unregister_notifier(struct notifier_block *nb);
+#ifndef __MAILBOX_H
+#define __MAILBOX_H
+
+enum xfer_result {
+	XFER_OK = 0,
+	XFER_ERR,
+};
+
+typedef unsigned request_token_t;
+
+#endif /* __MAILBOX_H */
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
new file mode 100644
index 0000000..c43f2c7
--- /dev/null
+++ b/include/linux/mailbox_client.h
@@ -0,0 +1,87 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MAILBOX_CLIENT_H
+#define __MAILBOX_CLIENT_H
+
+#include <linux/mailbox.h>
+
+/**
+ * struct ipc_client - User of a mailbox
+ * @chan_name: the "controller:channel" this client wants
+ * @cl_id: The identity to associate any tx/rx data with
+ * @rxcb: atomic callback to provide client the data received
+ * @txcb: atomic callback to tell client of data transmission
+ * @tx_block: if the ipc_send_message should block until data is transmitted
+ * @tx_tout: Max block period in ms before TX is assumed failure
+ * @knows_txdone: if the client could run the TX state machine. Usually if
+ *    the client receives some ACK packet for transmission. Unused if the
+ *    controller already has TX_Done/RTR IRQ.
+ * @link_data: Optional controller specific parameters during channel request
+ */
+struct ipc_client {
+	char *chan_name;
+	void *cl_id;
+	void (*rxcb)(void *cl_id, void *mssg);
+	void (*txcb)(void *cl_id, void *mssg, enum xfer_result r);
+	bool tx_block;
+	unsigned long tx_tout;
+	bool knows_txdone;
+	void *link_data;
+};
+
+/**
+ * The Client specifies its requirements and capabilities while asking for
+ * a channel/mailbox by name. It can't be called from atomic context.
+ * The channel is exclusively allocated and can't be used by another
+ * client before the owner calls ipc_free_channel.
+ */
+void *ipc_request_channel(struct ipc_client *cl);
+
+/**
+ * For client to submit data to the controller destined for a remote
+ * processor. If the client had set 'tx_block', the call will return
+ * either when the remote receives the data or when 'tx_tout' millisecs
+ * run out.
+ *  In non-blocking mode, the requests are buffered by the API and a
+ * non-zero token is returned for each queued request. If the queue
+ * was full the returned token will be 0. Upon failure or successful
+ * TX, the API calls 'txcb' from atomic context, from which the client
+ * could submit yet another request.
+ *  In blocking mode, 'txcb' is not called, effectively making the
+ * queue length 1. The returned value is 0 if TX timed out, some
+ * non-zero value upon success.
+ */
+request_token_t ipc_send_message(void *channel, void *mssg);
+
+/**
+ * The way for a client to run the TX state machine. This works
+ * only if the client sets 'knows_txdone' and the IPC controller
+ * doesn't get an IRQ for TX_Done/Remote_RTR.
+ */
+void ipc_client_txdone(void *channel, enum xfer_result r);
+
+/**
+ * The client relinquishes control of a mailbox by this call,
+ * make it available to other clients.
+ * The ipc_request/free_channel are light weight calls, so the
+ * client should avoid holding it when it doesn't need to
+ * transfer data.
+ */
+void ipc_free_channel(void *channel);
+
+/**
+ * The client make ask the API to be notified when a particular channel
+ * becomes available to be acquired again.
+ */
+int ipc_notify_chan_register(const char *name, struct notifier_block *nb);
+
+/**
+ * The client is no more interested in acquiring the channel.
+ */
+void ipc_notify_chan_unregister(const char *name, struct notifier_block *nb);
+
+#endif /* __MAILBOX_CLIENT_H */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
new file mode 100644
index 0000000..d4ef764
--- /dev/null
+++ b/include/linux/mailbox_controller.h
@@ -0,0 +1,102 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MAILBOX_CONTROLLER_H
+#define __MAILBOX_CONTROLLER_H
+
+#include <linux/mailbox.h>
+
+/**
+ * struct ipc_link - s/w representation of a communication link
+ * @link_name: Literal name assigned to the link. Physically
+ *    identical channels may have the same name.
+ * @api_priv: hook for the API to map its private data on the link
+ *    Controller driver must not touch it.
+ */
+struct ipc_link {
+	char link_name[16];
+	void *api_priv;
+};
+
+/**
+ * struct ipc_link - s/w representation of a communication link
+ * @send_data: The API asks the IPC controller driver, in atomic
+ *    context try to transmit a message on the bus. Returns 0 if
+ *    data is accepted for transmission, -EBUSY while rejecting
+ *    if the remote hasn't yet read the last data sent. Actual
+ *    transmission of data is reported by the controller via
+ *    ipc_link_txdone (if it has some TX ACK irq). It must not
+ *    block.
+ * @startup: Called when a client requests the link. The controller
+ *    could ask clients for additional parameters of communication
+ *    to be provided via client's link_data. This call may block.
+ *    After this call the Controller must forward any data received
+ *    on the link by calling ipc_link_received_data (which won't block)
+ * @shutdown: Called when a client relinquishes control of a link.
+ *    This call may block too. The controller must not forwared
+ *    any received data anymore.
+ * @is_ready: If the controller sets 'txdone_poll', the API calls
+ *    this to poll status of last TX. The controller must give priority
+ *    to IRQ method over polling and never set both txdone_poll and
+ *    txdone_irq. Only in polling mode 'send_data' is expected to
+ *    return -EBUSY. Used only if txdone_poll:=true && txdone_irq:=false
+ */
+struct ipc_link_ops {
+	int (*send_data)(struct ipc_link *link, void *data);
+	int (*startup)(struct ipc_link *link, void *params);
+	void (*shutdown)(struct ipc_link *link);
+	bool (*is_ready)(struct ipc_link *link);
+};
+
+/**
+ * struct ipc_controller - Controller of a class of communication links
+ * @controller_name: Literal name of the controller.
+ * @ops: Operators that work on each communication link
+ * @links: Null terminated array of links.
+ * @txdone_irq: Indicates if the controller can report to API when the
+ *    last transmitted data was read by the remote. Eg, if it has some
+ *    TX ACK irq.
+ * @txdone_poll: If the controller can read but not report the TX done.
+ *    Eg, is some register shows the TX status but no interrupt rises.
+ *    Ignored if 'txdone_irq' is set.
+ * @txpoll_period: If 'txdone_poll' is in effect, the API polls for
+ *    last TX's status after these many millisecs
+ */
+struct ipc_controller {
+	char controller_name[16];
+	struct ipc_link_ops *ops;
+	struct ipc_link **links;
+	bool txdone_irq;
+	bool txdone_poll;
+	unsigned txpoll_period;
+};
+
+/**
+ * The controller driver registers its communication links to the
+ * global pool managed by the API.
+ */
+int ipc_links_register(struct ipc_controller *ipc_con);
+
+/**
+ * After startup and before shutdown any data received on the link
+ * is pused to the API via atomic ipc_link_received_data() API.
+ * The controller should ACK the RX only after this call returns.
+ */
+void ipc_link_received_data(struct ipc_link *link, void *data);
+
+/**
+ * The controller the has IRQ for TX ACK calls this atomic API
+ * to tick the TX state machine. It works only if txdone_irq
+ * is set by the controller.
+ */
+void ipc_link_txdone(struct ipc_link *link, enum xfer_result r);
+
+/**
+ * Purge the links from the global pool maintained by the API.
+ */
+void ipc_links_unregister(struct ipc_controller *ipc_con);
+
+#endif /* __MAILBOX_CONTROLLER_H */
