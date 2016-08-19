From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:26 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The Boot and Power Management Processor (BPMP) is a co-processor found
on Tegra SoCs. It is designed to handle the early stages of the boot
process and offload power management tasks (such as clocks, resets,
powergates, ...) as well as system control services.

Compared to the ARM SCPI, the services provided by BPMP are message-
based rather than method-based. The BPMP firmware driver provides the
services to transmit data to and receive data from the BPMP. Users can
also register an MRQ, for which a service routine will be run when a
corresponding event is received from the firmware.

A set of messages, called the BPMP ABI, are specified for a number of
different services provided by the BPMP (such as clocks or resets).

Based on work by Sivaram Nair <sivaramn@nvidia.com> and Joseph Lo
<josephl@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- use a message structure for transfers to avoid long function
  prototypes
- restructure driver for easier maintainability
- rename bpmp_abi.h to bpmp-abi.h for consistency

 drivers/firmware/tegra/Kconfig  |   12 +
 drivers/firmware/tegra/Makefile |    1 +
 drivers/firmware/tegra/bpmp.c   |  880 +++++++++++++++++++++
 include/soc/tegra/bpmp-abi.h    | 1601 +++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h        |  122 +++
 5 files changed, 2616 insertions(+)
 create mode 100644 drivers/firmware/tegra/bpmp.c
 create mode 100644 include/soc/tegra/bpmp-abi.h
 create mode 100644 include/soc/tegra/bpmp.h

diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
index 1fa3e4e136a5..ff2730d5c468 100644
--- a/drivers/firmware/tegra/Kconfig
+++ b/drivers/firmware/tegra/Kconfig
@@ -10,4 +10,16 @@ config TEGRA_IVC
 	  keeps the content is synchronization between host CPU and remote
 	  processors.
 
+config TEGRA_BPMP
+	bool "Tegra BPMP driver"
+	depends on ARCH_TEGRA && TEGRA_HSP_MBOX && TEGRA_IVC
+	help
+	  BPMP (Boot and Power Management Processor) is designed to off-loading
+	  the PM functions which include clock/DVFS/thermal/power from the CPU.
+	  It needs HSP as the HW synchronization and notification module and
+	  IVC module as the message communication protocol.
+
+	  This driver manages the IPC interface between host CPU and the
+	  firmware running on BPMP.
+
 endmenu
diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
index 92e2153e8173..e34a2f79e1ad 100644
--- a/drivers/firmware/tegra/Makefile
+++ b/drivers/firmware/tegra/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_TEGRA_BPMP)	+= bpmp.o
 obj-$(CONFIG_TEGRA_IVC)		+= ivc.o
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
new file mode 100644
index 000000000000..a09043b1be05
--- /dev/null
+++ b/drivers/firmware/tegra/bpmp.c
@@ -0,0 +1,880 @@
+/*
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#define DEBUG
+
+#include <linux/clk/tegra.h>
+#include <linux/mailbox_client.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/semaphore.h>
+
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
+#include <soc/tegra/ivc.h>
+
+#define MSG_ACK		BIT(0)
+#define MSG_RING	BIT(1)
+
+static inline struct tegra_bpmp *
+mbox_client_to_bpmp(struct mbox_client *client)
+{
+	return container_of(client, struct tegra_bpmp, mbox.client);
+}
+
+struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct tegra_bpmp *bpmp;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "nvidia,bpmp", 0);
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto put;
+	}
+
+	bpmp = platform_get_drvdata(pdev);
+	if (!bpmp) {
+		bpmp = ERR_PTR(-EPROBE_DEFER);
+		put_device(&pdev->dev);
+		goto put;
+	}
+
+put:
+	of_node_put(np);
+	return bpmp;
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_get);
+
+void tegra_bpmp_put(struct tegra_bpmp *bpmp)
+{
+	if (bpmp)
+		put_device(bpmp->dev);
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_put);
+
+static int tegra_bpmp_channel_get_index(struct tegra_bpmp_channel *channel)
+{
+	return channel - channel->bpmp->channels;
+}
+
+static int
+tegra_bpmp_channel_get_thread_index(struct tegra_bpmp_channel *channel)
+{
+	struct tegra_bpmp *bpmp = channel->bpmp;
+	unsigned int offset, count;
+	int index;
+
+	offset = bpmp->soc->channels.thread.offset;
+	count = bpmp->soc->channels.thread.count;
+
+	index = tegra_bpmp_channel_get_index(channel);
+	if (index < 0)
+		return index;
+
+	if (index < offset || index >= offset + count)
+		return -EINVAL;
+
+	return index - offset;
+}
+
+static struct tegra_bpmp_channel *
+tegra_bpmp_channel_get_thread(struct tegra_bpmp *bpmp, unsigned int index)
+{
+	unsigned int offset = bpmp->soc->channels.thread.offset;
+	unsigned int count = bpmp->soc->channels.thread.count;
+
+	if (index >= count)
+		return NULL;
+
+	return &bpmp->channels[offset + index];
+}
+
+static struct tegra_bpmp_channel *
+tegra_bpmp_channel_get_tx(struct tegra_bpmp *bpmp)
+{
+	unsigned int offset = bpmp->soc->channels.cpu_tx.offset;
+
+	return &bpmp->channels[offset + smp_processor_id()];
+}
+
+static struct tegra_bpmp_channel *
+tegra_bpmp_channel_get_rx(struct tegra_bpmp *bpmp)
+{
+	unsigned int offset = bpmp->soc->channels.cpu_rx.offset;
+
+	return &bpmp->channels[offset];
+}
+
+static bool tegra_bpmp_message_valid(const struct tegra_bpmp_message *msg)
+{
+	return (msg->tx.size <= TEGRA_BPMP_MSG_DATA_SIZE) &&
+	       (msg->rx.size <= TEGRA_BPMP_MSG_DATA_SIZE) &&
+	       (msg->tx.size == 0 || msg->tx.data) &&
+	       (msg->rx.size == 0 || msg->rx.data);
+}
+
+static bool tegra_bpmp_master_acked(struct tegra_bpmp_channel *channel)
+{
+	void *frame;
+
+	frame = tegra_ivc_read_get_next_frame(channel->ivc);
+	if (IS_ERR_OR_NULL(frame)) {
+		channel->ib = NULL;
+		return false;
+	}
+
+	channel->ib = frame;
+
+	return true;
+}
+
+static int tegra_bpmp_wait_ack(struct tegra_bpmp_channel *channel)
+{
+	unsigned long timeout = channel->bpmp->soc->channels.cpu_tx.timeout;
+	ktime_t start, now;
+
+	start = ns_to_ktime(local_clock());
+
+	do {
+		if (tegra_bpmp_master_acked(channel))
+			return 0;
+
+		now = ns_to_ktime(local_clock());
+	} while (ktime_us_delta(now, start) < timeout);
+
+	return -ETIMEDOUT;
+}
+
+static bool tegra_bpmp_master_free(struct tegra_bpmp_channel *channel)
+{
+	void *frame;
+
+	frame = tegra_ivc_write_get_next_frame(channel->ivc);
+	if (IS_ERR_OR_NULL(frame)) {
+		channel->ob = NULL;
+		return false;
+	}
+
+	channel->ob = frame;
+
+	return true;
+}
+
+static int tegra_bpmp_wait_master_free(struct tegra_bpmp_channel *channel)
+{
+	unsigned long timeout = channel->bpmp->soc->channels.cpu_tx.timeout;
+	ktime_t start, now;
+
+	start = ns_to_ktime(local_clock());
+
+	do {
+		if (tegra_bpmp_master_free(channel))
+			return 0;
+
+		now = ns_to_ktime(local_clock());
+	} while (ktime_us_delta(now, start) < timeout);
+
+	return -ETIMEDOUT;
+}
+
+static ssize_t __tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
+					 void *data, size_t size)
+{
+	if (data && size > 0)
+		memcpy_fromio(data, channel->ib->data, size);
+
+	return tegra_ivc_read_advance(channel->ivc);
+}
+
+static ssize_t tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
+				       void *data, size_t size)
+{
+	struct tegra_bpmp *bpmp = channel->bpmp;
+	unsigned long flags;
+	ssize_t err;
+	int index;
+
+	index = tegra_bpmp_channel_get_thread_index(channel);
+	if (index < 0)
+		return index;
+
+	spin_lock_irqsave(&bpmp->lock, flags);
+	err = __tegra_bpmp_channel_read(channel, data, size);
+	clear_bit(index, bpmp->threaded.allocated);
+	spin_unlock_irqrestore(&bpmp->lock, flags);
+
+	up(&bpmp->threaded.lock);
+
+	return err;
+}
+
+static ssize_t __tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
+					  unsigned int mrq, unsigned long flags,
+					  const void *data, size_t size)
+{
+	channel->ob->code = mrq;
+	channel->ob->flags = flags;
+
+	if (data && size > 0)
+		memcpy_toio(channel->ob->data, data, size);
+
+	return tegra_ivc_write_advance(channel->ivc);
+}
+
+static struct tegra_bpmp_channel *
+tegra_bpmp_write_threaded(struct tegra_bpmp *bpmp, unsigned int mrq,
+			  const void *data, size_t size)
+{
+	unsigned long timeout = bpmp->soc->channels.thread.timeout;
+	unsigned int count = bpmp->soc->channels.thread.count;
+	struct tegra_bpmp_channel *channel;
+	unsigned long flags;
+	unsigned int index;
+	int err;
+
+	err = down_timeout(&bpmp->threaded.lock, usecs_to_jiffies(timeout));
+	if (err < 0)
+		return ERR_PTR(err);
+
+	spin_lock_irqsave(&bpmp->lock, flags);
+
+	index = find_first_zero_bit(bpmp->threaded.allocated, count);
+	if (index == count) {
+		channel = ERR_PTR(-EBUSY);
+		goto unlock;
+	}
+
+	channel = tegra_bpmp_channel_get_thread(bpmp, index);
+	if (!channel) {
+		channel = ERR_PTR(-EINVAL);
+		goto unlock;
+	}
+
+	if (!tegra_bpmp_master_free(channel)) {
+		channel = ERR_PTR(-EBUSY);
+		goto unlock;
+	}
+
+	set_bit(index, bpmp->threaded.allocated);
+
+	err = __tegra_bpmp_channel_write(channel, mrq, MSG_ACK | MSG_RING,
+					 data, size);
+	if (err < 0) {
+		clear_bit(index, bpmp->threaded.allocated);
+		goto unlock;
+	}
+
+	set_bit(index, bpmp->threaded.busy);
+
+unlock:
+	spin_unlock_irqrestore(&bpmp->lock, flags);
+	return channel;
+}
+
+static ssize_t tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
+					unsigned int mrq, unsigned long flags,
+					const void *data, size_t size)
+{
+	int err;
+
+	err = tegra_bpmp_wait_master_free(channel);
+	if (err < 0)
+		return err;
+
+	return __tegra_bpmp_channel_write(channel, mrq, flags, data, size);
+}
+
+int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
+			       struct tegra_bpmp_message *msg)
+{
+	struct tegra_bpmp_channel *channel;
+	int err;
+
+	if (WARN_ON(!irqs_disabled()))
+		return -EPERM;
+
+	if (!tegra_bpmp_message_valid(msg))
+		return -EINVAL;
+
+	channel = tegra_bpmp_channel_get_tx(bpmp);
+
+	err = tegra_bpmp_channel_write(channel, msg->mrq, MSG_ACK,
+				       msg->tx.data, msg->tx.size);
+	if (err < 0)
+		return err;
+
+	err = mbox_send_message(bpmp->mbox.channel, NULL);
+	if (err < 0)
+		return err;
+
+	mbox_client_txdone(bpmp->mbox.channel, 0);
+
+	err = tegra_bpmp_wait_ack(channel);
+	if (err)
+		return err;
+
+	return __tegra_bpmp_channel_read(channel, msg->rx.data, msg->rx.size);
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_transfer_atomic);
+
+int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
+			struct tegra_bpmp_message *msg)
+{
+	struct tegra_bpmp_channel *channel;
+	unsigned long timeout;
+	int err;
+
+	if (WARN_ON(irqs_disabled()))
+		return -EPERM;
+
+	if (!tegra_bpmp_message_valid(msg))
+		return -EINVAL;
+
+	channel = tegra_bpmp_write_threaded(bpmp, msg->mrq, msg->tx.data,
+					    msg->tx.size);
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
+	err = mbox_send_message(bpmp->mbox.channel, NULL);
+	if (err < 0)
+		return err;
+
+	mbox_client_txdone(bpmp->mbox.channel, 0);
+
+	timeout = usecs_to_jiffies(bpmp->soc->channels.thread.timeout);
+
+	err = wait_for_completion_timeout(&channel->completion, timeout);
+	if (err <= 0) {
+		if (err == 0)
+			err = -ETIMEDOUT;
+
+		return err;
+	}
+
+	return tegra_bpmp_channel_read(channel, msg->rx.data, msg->rx.size);
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_transfer);
+
+static struct tegra_bpmp_mrq *tegra_bpmp_find_mrq(struct tegra_bpmp *bpmp,
+						  unsigned int mrq)
+{
+	struct tegra_bpmp_mrq *entry;
+
+	list_for_each_entry(entry, &bpmp->mrqs, list)
+		if (entry->mrq == mrq)
+			return entry;
+
+	return NULL;
+}
+
+static void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel,
+				  int code, const void *data, size_t size)
+{
+	unsigned long flags = channel->ib->flags;
+	struct tegra_bpmp *bpmp = channel->bpmp;
+	struct tegra_bpmp_mb_data *frame;
+	int err;
+
+	if (WARN_ON(size > TEGRA_BPMP_MSG_DATA_SIZE))
+		return;
+
+	err = tegra_ivc_read_advance(channel->ivc);
+	if (WARN_ON(err < 0))
+		return;
+
+	if ((flags & MSG_ACK) == 0)
+		return;
+
+	frame = tegra_ivc_write_get_next_frame(channel->ivc);
+	if (WARN_ON(IS_ERR_OR_NULL(frame)))
+		return;
+
+	frame->code = code;
+
+	if (data && size > 0)
+		memcpy_toio(frame->data, data, size);
+
+	err = tegra_ivc_write_advance(channel->ivc);
+	if (WARN_ON(err < 0))
+		return;
+
+	if (flags & MSG_RING) {
+		err = mbox_send_message(bpmp->mbox.channel, NULL);
+		if (WARN_ON(err < 0))
+			return;
+
+		mbox_client_txdone(bpmp->mbox.channel, 0);
+	}
+}
+
+static void tegra_bpmp_handle_mrq(struct tegra_bpmp *bpmp,
+				  unsigned int mrq,
+				  struct tegra_bpmp_channel *channel)
+{
+	struct tegra_bpmp_mrq *entry;
+	u32 zero = 0;
+
+	spin_lock(&bpmp->lock);
+
+	entry = tegra_bpmp_find_mrq(bpmp, mrq);
+	if (!entry) {
+		spin_unlock(&bpmp->lock);
+		tegra_bpmp_mrq_return(channel, -EINVAL, &zero, sizeof(zero));
+		return;
+	}
+
+	entry->handler(mrq, channel, entry->data);
+
+	spin_unlock(&bpmp->lock);
+}
+
+int tegra_bpmp_request_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
+			   tegra_bpmp_mrq_handler_t handler, void *data)
+{
+	struct tegra_bpmp_mrq *entry;
+	unsigned long flags;
+
+	if (!handler)
+		return -EINVAL;
+
+	entry = devm_kzalloc(bpmp->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&bpmp->lock, flags);
+
+	entry->mrq = mrq;
+	entry->handler = handler;
+	entry->data = data;
+	list_add(&entry->list, &bpmp->mrqs);
+
+	spin_unlock_irqrestore(&bpmp->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_request_mrq);
+
+void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq, void *data)
+{
+	struct tegra_bpmp_mrq *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bpmp->lock, flags);
+
+	entry = tegra_bpmp_find_mrq(bpmp, mrq);
+	if (!entry)
+		goto unlock;
+
+	list_del(&entry->list);
+	devm_kfree(bpmp->dev, entry);
+
+unlock:
+	spin_unlock_irqrestore(&bpmp->lock, flags);
+}
+EXPORT_SYMBOL_GPL(tegra_bpmp_free_mrq);
+
+static void tegra_bpmp_mrq_handle_ping(unsigned int mrq,
+				       struct tegra_bpmp_channel *channel,
+				       void *data)
+{
+	struct mrq_ping_request *request;
+	struct mrq_ping_response response;
+
+	request = (struct mrq_ping_request *)channel->ib->data;
+
+	memset(&response, 0, sizeof(response));
+	response.reply = request->challenge << (smp_processor_id() + 1);
+
+	tegra_bpmp_mrq_return(channel, 0, &response, sizeof(response));
+}
+
+static int tegra_bpmp_ping(struct tegra_bpmp *bpmp)
+{
+	struct mrq_ping_response response;
+	struct mrq_ping_request request;
+	struct tegra_bpmp_message msg;
+	ktime_t start, delta;
+	unsigned long flags;
+	int err;
+
+	memset(&request, 0, sizeof(request));
+	request.challenge = 1;
+
+	memset(&response, 0, sizeof(response));
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_PING;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+	msg.rx.data = &response;
+	msg.rx.size = sizeof(response);
+
+	start = ktime_get();
+
+	local_irq_save(flags);
+	err = tegra_bpmp_transfer_atomic(bpmp, &msg);
+	local_irq_restore(flags);
+
+	delta = ktime_sub(ktime_get(), start);
+
+	if (!err)
+		dev_info(bpmp->dev,
+			 "ping ok: challenge: %u, response: %u, time: %lld\n",
+			 request.challenge, response.reply,
+			 ktime_to_us(delta));
+
+	return err;
+}
+
+static int tegra_bpmp_get_firmware_tag(struct tegra_bpmp *bpmp, char *tag,
+				       size_t size)
+{
+	struct mrq_query_tag_request request;
+	struct tegra_bpmp_message msg;
+	unsigned long flags;
+	dma_addr_t phys;
+	void *virt;
+	int err;
+
+	virt = dma_alloc_coherent(bpmp->dev, TEGRA_BPMP_MSG_DATA_SIZE, &phys,
+				  GFP_KERNEL | GFP_DMA32);
+	if (!virt)
+		return -ENOMEM;
+
+	memset(&request, 0, sizeof(request));
+	request.addr = phys;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_QUERY_TAG;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+
+	local_irq_save(flags);
+	err = tegra_bpmp_transfer_atomic(bpmp, &msg);
+	local_irq_restore(flags);
+
+	if (err == 0)
+		strlcpy(tag, virt, size);
+
+	dma_free_coherent(bpmp->dev, TEGRA_BPMP_MSG_DATA_SIZE, virt, phys);
+
+	return err;
+}
+
+static void tegra_bpmp_channel_signal(struct tegra_bpmp_channel *channel)
+{
+	unsigned long flags = channel->ob->flags;
+
+	if ((flags & MSG_RING) == 0)
+		return;
+
+	complete(&channel->completion);
+}
+
+static void tegra_bpmp_handle_rx(struct mbox_client *client, void *data)
+{
+	struct tegra_bpmp *bpmp = mbox_client_to_bpmp(client);
+	struct tegra_bpmp_channel *channel;
+	unsigned int i, count;
+	unsigned long *busy;
+
+	channel = tegra_bpmp_channel_get_rx(bpmp);
+	count = bpmp->soc->channels.thread.count;
+	busy = bpmp->threaded.busy;
+
+	if (tegra_bpmp_master_acked(channel))
+		tegra_bpmp_handle_mrq(bpmp, channel->ib->code, channel);
+
+	spin_lock(&bpmp->lock);
+
+	for_each_set_bit(i, busy, count) {
+		struct tegra_bpmp_channel *channel;
+
+		channel = tegra_bpmp_channel_get_thread(bpmp, i);
+		if (!channel)
+			continue;
+
+		if (tegra_bpmp_master_acked(channel)) {
+			tegra_bpmp_channel_signal(channel);
+			clear_bit(i, busy);
+		}
+	}
+
+	spin_unlock(&bpmp->lock);
+}
+
+static void tegra_bpmp_ivc_notify(struct tegra_ivc *ivc, void *data)
+{
+	struct tegra_bpmp *bpmp = data;
+	int err;
+
+	err = mbox_send_message(bpmp->mbox.channel, NULL);
+	if (err < 0)
+		return;
+
+	mbox_client_txdone(bpmp->mbox.channel, 0);
+}
+
+static int tegra_bpmp_channel_init(struct tegra_bpmp_channel *channel,
+				   struct tegra_bpmp *bpmp,
+				   unsigned int index)
+{
+	size_t message, queue;
+	void __iomem *rx_base;
+	void __iomem *tx_base;
+	int err;
+
+	channel->ivc = devm_kzalloc(bpmp->dev, sizeof(*channel->ivc),
+				    GFP_KERNEL);
+	if (!channel->ivc)
+		return -ENOMEM;
+
+	message = tegra_ivc_align(TEGRA_BPMP_MSG_SIZE);
+	queue = tegra_ivc_total_queue_size(message);
+
+	rx_base = bpmp->rx_base + queue * index;
+	tx_base = bpmp->tx_base + queue * index;
+
+	err = tegra_ivc_init(channel->ivc, bpmp->dev, rx_base, DMA_ERROR_CODE,
+			     tx_base, DMA_ERROR_CODE, 1, message,
+			     tegra_bpmp_ivc_notify, bpmp);
+	if (err < 0) {
+		dev_err(bpmp->dev, "failed to setup IVC for channel %u: %d\n",
+			index, err);
+		return err;
+	}
+
+	/* reset the channel state */
+	tegra_ivc_reset(channel->ivc);
+
+	/* sync the channel state with BPMP */
+	while (tegra_ivc_notified(channel->ivc))
+		;
+
+	init_completion(&channel->completion);
+	channel->bpmp = bpmp;
+
+	return 0;
+}
+
+static int tegra_bpmp_init_powergates(struct tegra_bpmp *bpmp)
+{
+	struct mrq_pg_read_state_response response;
+	struct mrq_pg_read_state_request request;
+	struct tegra_bpmp_message msg;
+	unsigned int i;
+	int err;
+
+	dev_dbg(bpmp->dev, "powergates:\n");
+
+	for (i = 0; i < 32; i++) {
+		memset(&request, 0, sizeof(request));
+		request.partition_id = i;
+
+		memset(&response, 0, sizeof(response));
+
+		memset(&msg, 0, sizeof(msg));
+		msg.mrq = MRQ_PG_READ_STATE;
+		msg.tx.data = &request;
+		msg.tx.size = sizeof(request);
+		msg.rx.data = &response;
+		msg.rx.size = sizeof(response);
+
+		err = tegra_bpmp_transfer(bpmp, &msg);
+		if (err < 0) {
+			dev_err(bpmp->dev, "failed to transfer message: %d\n", err);
+			continue;
+		}
+
+		dev_dbg(bpmp->dev, "  %u: %x (%x)\n", i, response.logic_state,
+			response.sram_state);
+	}
+
+	return 0;
+}
+
+static int tegra_bpmp_probe(struct platform_device *pdev)
+{
+	struct tegra_bpmp_channel *channel;
+	struct tegra_bpmp *bpmp;
+	struct device_node *np;
+	struct resource res;
+	unsigned int i;
+	char tag[32];
+	size_t size;
+	int err;
+
+	bpmp = devm_kzalloc(&pdev->dev, sizeof(*bpmp), GFP_KERNEL);
+	if (!bpmp)
+		return -ENOMEM;
+
+	bpmp->soc = of_device_get_match_data(&pdev->dev);
+	bpmp->dev = &pdev->dev;
+
+	np = of_parse_phandle(pdev->dev.of_node, "shmem", 0);
+	if (!np)
+		return -ENOENT;
+
+	of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+
+	bpmp->tx_base = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(bpmp->tx_base))
+		return PTR_ERR(bpmp->tx_base);
+
+	np = of_parse_phandle(pdev->dev.of_node, "shmem", 1);
+	if (!np)
+		return -ENOENT;
+
+	of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+
+	bpmp->rx_base = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(bpmp->rx_base))
+		return PTR_ERR(bpmp->rx_base);
+
+	bpmp->num_channels = bpmp->soc->channels.cpu_tx.count +
+			     bpmp->soc->channels.thread.count +
+			     bpmp->soc->channels.cpu_rx.count;
+
+	bpmp->channels = devm_kcalloc(&pdev->dev, bpmp->num_channels,
+				      sizeof(*channel), GFP_KERNEL);
+	if (!bpmp->channels)
+		return -ENOMEM;
+
+	/* mbox registration */
+	bpmp->mbox.client.dev = &pdev->dev;
+	bpmp->mbox.client.rx_callback = tegra_bpmp_handle_rx;
+	bpmp->mbox.client.tx_block = false;
+	bpmp->mbox.client.knows_txdone = false;
+
+	bpmp->mbox.channel = mbox_request_channel(&bpmp->mbox.client, 0);
+	if (IS_ERR(bpmp->mbox.channel)) {
+		err = PTR_ERR(bpmp->mbox.channel);
+		dev_err(&pdev->dev, "failed to get HSP mailbox: %d\n", err);
+		return err;
+	}
+
+	/* message channel initialization */
+	for (i = 0; i < bpmp->num_channels; i++) {
+		struct tegra_bpmp_channel *channel = &bpmp->channels[i];
+
+		err = tegra_bpmp_channel_init(channel, bpmp, i);
+		if (err)
+			return err;
+	}
+
+	bpmp->threaded.count = bpmp->soc->channels.thread.count;
+	size = BITS_TO_LONGS(bpmp->threaded.count) * sizeof(long);
+
+	bpmp->threaded.allocated = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!bpmp->threaded.allocated)
+		return -ENOMEM;
+
+	bpmp->threaded.busy = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!bpmp->threaded.busy)
+		return -ENOMEM;
+
+	sema_init(&bpmp->threaded.lock, bpmp->threaded.count);
+
+	INIT_LIST_HEAD(&bpmp->mrqs);
+	spin_lock_init(&bpmp->lock);
+
+	err = tegra_bpmp_request_mrq(bpmp, MRQ_PING,
+				     tegra_bpmp_mrq_handle_ping, bpmp);
+	if (err < 0)
+		return err;
+
+	err = tegra_bpmp_ping(bpmp);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to ping BPMP: %d\n", err);
+		goto free_mrq;
+	}
+
+	err = tegra_bpmp_get_firmware_tag(bpmp, tag, sizeof(tag) - 1);
+	if (err) {
+		dev_err(&pdev->dev, "failed to get firmware tag: %d\n", err);
+		goto free_mrq;
+	}
+
+	dev_info(&pdev->dev, "firmware: %s\n", tag);
+
+	err = tegra_bpmp_init_clocks(bpmp);
+	if (err < 0)
+		return err;
+
+	err = tegra_bpmp_init_resets(bpmp);
+	if (err < 0)
+		return err;
+
+	err = tegra_bpmp_init_powergates(bpmp);
+	if (err < 0)
+		return err;
+
+	platform_set_drvdata(pdev, bpmp);
+
+	return 0;
+
+free_mrq:
+	tegra_bpmp_free_mrq(bpmp, MRQ_PING, bpmp);
+
+	return err;
+}
+
+static const struct tegra_bpmp_soc tegra186_soc = {
+	.channels = {
+		.cpu_tx = {
+			.offset = 0,
+			.count = 6,
+			.timeout = 60 * USEC_PER_SEC,
+		},
+		.thread = {
+			.offset = 6,
+			.count = 7,
+			.timeout = 600 * USEC_PER_SEC,
+		},
+		.cpu_rx = {
+			.offset = 13,
+			.count = 1,
+			.timeout = 0,
+		},
+	},
+	.num_resets = 193,
+};
+
+static const struct of_device_id tegra_bpmp_match[] = {
+	{ .compatible = "nvidia,tegra186-bpmp", .data = &tegra186_soc },
+	{ }
+};
+
+static struct platform_driver tegra_bpmp_driver = {
+	.driver = {
+		.name = "tegra-bpmp",
+		.of_match_table = tegra_bpmp_match,
+	},
+	.probe = tegra_bpmp_probe,
+};
+
+static int __init tegra_bpmp_init(void)
+{
+	return platform_driver_register(&tegra_bpmp_driver);
+}
+core_initcall(tegra_bpmp_init);
diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
new file mode 100644
index 000000000000..0aaef5960e29
--- /dev/null
+++ b/include/soc/tegra/bpmp-abi.h
@@ -0,0 +1,1601 @@
+/*
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ABI_BPMP_ABI_H_
+#define _ABI_BPMP_ABI_H_
+
+#ifdef LK
+#include <stdint.h>
+#endif
+
+#ifndef __ABI_PACKED
+#define __ABI_PACKED __attribute__((packed))
+#endif
+
+#ifdef NO_GCC_EXTENSIONS
+#define EMPTY char empty;
+#define EMPTY_ARRAY 1
+#else
+#define EMPTY
+#define EMPTY_ARRAY 0
+#endif
+
+#ifndef __UNION_ANON
+#define __UNION_ANON
+#endif
+/**
+ * @file
+ */
+
+
+/**
+ * @defgroup MRQ MRQ Messages
+ * @brief Messages sent to/from BPMP via IPC
+ * @{
+ *   @defgroup MRQ_Format Message Format
+ *   @defgroup MRQ_Codes Message Request (MRQ) Codes
+ *   @defgroup MRQ_Payloads Message Payloads
+ *   @defgroup Error_Codes Error Codes
+ * @}
+ */
+
+/**
+ * @addtogroup MRQ_Format Message Format
+ * @{
+ * The CPU requests the BPMP to perform a particular service by
+ * sending it an IVC frame containing a single MRQ message. An MRQ
+ * message consists of a @ref mrq_request followed by a payload whose
+ * format depends on mrq_request::mrq.
+ *
+ * The BPMP processes the data and replies with an IVC frame (on the
+ * same IVC channel) containing and MRQ response. An MRQ response
+ * consists of a @ref mrq_response followed by a payload whose format
+ * depends on the associated mrq_request::mrq.
+ *
+ * A well-defined subset of the MRQ messages that the CPU sends to the
+ * BPMP can lead to BPMP eventually sending an MRQ message to the
+ * CPU. For example, when the CPU uses an #MRQ_THERMAL message to set
+ * a thermal trip point, the BPMP may eventually send a single
+ * #MRQ_THERMAL message of its own to the CPU indicating that the trip
+ * point has been crossed.
+ * @}
+ */
+
+/**
+ * @ingroup MRQ_Format
+ * @brief header for an MRQ message
+ *
+ * Provides the MRQ number for the MRQ message: #mrq. The remainder of
+ * the MRQ message is a payload (immediately following the
+ * mrq_request) whose format depends on mrq.
+ *
+ * @todo document the flags
+ */
+struct mrq_request {
+	/** @brief MRQ number of the request */
+	uint32_t mrq;
+	/** @brief flags for the request */
+	uint32_t flags;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Format
+ * @brief header for an MRQ response
+ *
+ *  Provides an error code for the associated MRQ message. The
+ *  remainder of the MRQ response is a payload (immediately following
+ *  the mrq_response) whose format depends on the associated
+ *  mrq_request::mrq
+ *
+ * @todo document the flags
+ */
+struct mrq_response {
+	/** @brief error code for the MRQ request itself */
+	int32_t err;
+	/** @brief flags for the response */
+	uint32_t flags;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Format
+ * Minimum needed size for an IPC message buffer
+ */
+#define MSG_MIN_SZ	128
+/**
+ * @ingroup MRQ_Format
+ *  Minimum size guaranteed for data in an IPC message buffer
+ */
+#define MSG_DATA_MIN_SZ	120
+
+/**
+ * @ingroup MRQ_Codes
+ * @name Legal MRQ codes
+ * These are the legal values for mrq_request::mrq
+ * @{
+ */
+
+#define MRQ_PING		0
+#define MRQ_QUERY_TAG		1
+#define MRQ_MODULE_LOAD		4
+#define MRQ_MODULE_UNLOAD	5
+#define MRQ_TRACE_MODIFY	7
+#define MRQ_WRITE_TRACE		8
+#define MRQ_THREADED_PING	9
+#define MRQ_MODULE_MAIL		11
+#define MRQ_DEBUGFS		19
+#define MRQ_RESET		20
+#define MRQ_I2C			21
+#define MRQ_CLK			22
+#define MRQ_QUERY_ABI		23
+#define MRQ_PG_READ_STATE	25
+#define MRQ_PG_UPDATE_STATE	26
+#define MRQ_THERMAL		27
+#define MRQ_CPU_VHINT		28
+#define MRQ_ABI_RATCHET		29
+#define MRQ_EMC_DVFS_LATENCY	31
+#define MRQ_TRACE_ITER		64
+
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @brief Maximum MRQ code to be sent by CPU software to
+ * BPMP. Subject to change in future
+ */
+#define MAX_CPU_MRQ_ID		64
+
+/**
+ * @addtogroup MRQ_Payloads Message Payloads
+ * @{
+ *   @defgroup Ping
+ *   @defgroup Query_Tag Query Tag
+ *   @defgroup Module Loadable Modules
+ *   @defgroup Trace
+ *   @defgroup Debugfs
+ *   @defgroup Reset
+ *   @defgroup I2C
+ *   @defgroup Clocks
+ *   @defgroup ABI_info ABI Info
+ *   @defgroup MC_Flush MC Flush
+ *   @defgroup Powergating
+ *   @defgroup Thermal
+ *   @defgroup Vhint CPU Voltage hint
+ *   @defgroup MRQ_Deprecated Deprecated MRQ messages
+ *   @defgroup EMC
+ * @}
+ */
+
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_PING
+ * @brief A simple ping
+ *
+ * * Platforms: All
+ * * Initiators: Any
+ * * Targets: Any
+ * * Request Payload: @ref mrq_ping_request
+ * * Response Payload: @ref mrq_ping_response
+ *
+ * @ingroup MRQ_Codes
+ * @def MRQ_THREADED_PING
+ * @brief A deeper ping
+ *
+ * * Platforms: All
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_ping_request
+ * * Response Payload: @ref mrq_ping_response
+ *
+ * Behavior is equivalent to a simple #MRQ_PING except that BPMP
+ * responds from a thread context (providing a slightly more robust
+ * sign of life).
+ *
+ */
+
+/**
+ * @ingroup Ping
+ * @brief request with #MRQ_PING
+ *
+ * Used by the sender of an #MRQ_PING message to request a pong from
+ * recipient. The response from the recipient is computed based on
+ * #challenge.
+ */
+struct mrq_ping_request {
+/** @brief arbitrarily chosen value */
+	uint32_t challenge;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Ping
+ * @brief response to #MRQ_PING
+ *
+ * Sent in response to an #MRQ_PING message. #reply should be the
+ * mrq_ping_request challenge left shifted by 1 with the carry-bit
+ * dropped.
+ *
+ */
+struct mrq_ping_response {
+	/** @brief response to the MRQ_PING challege */
+	uint32_t reply;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_QUERY_TAG
+ * @brief Query BPMP firmware's tag (i.e. version information)
+ *
+ * * Platforms: All
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_query_tag_request
+ * * Response Payload: N/A
+ *
+ */
+
+/**
+ * @ingroup Query_Tag
+ * @brief request with #MRQ_QUERY_TAG
+ *
+ * Used by #MRQ_QUERY_TAG call to ask BPMP to fill in the memory
+ * pointed by #addr with BPMP firmware header.
+ *
+ * The sender is reponsible for ensuring that #addr is mapped in to
+ * the recipient's address map.
+ */
+struct mrq_query_tag_request {
+  /** @brief base address to store the firmware header */
+	uint32_t addr;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_MODULE_LOAD
+ * @brief dynamically load a BPMP code module
+ *
+ * * Platforms: All
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_module_load_request
+ * * Response Payload: @ref mrq_module_load_response
+ *
+ * @note This MRQ is disabled on production systems
+ *
+ */
+
+/**
+ * @ingroup Module
+ * @brief request with #MRQ_MODULE_LOAD
+ *
+ * Used by #MRQ_MODULE_LOAD calls to ask the recipient to dynamically
+ * load the code located at #phys_addr and having size #size
+ * bytes. #phys_addr is treated as a void pointer.
+ *
+ * The recipient copies the code from #phys_addr to locally allocated
+ * memory prior to responding to this message.
+ *
+ * @todo document the module header format
+ *
+ * The sender is responsible for ensuring that the code is mapped in
+ * the recipient's address map.
+ *
+ */
+struct mrq_module_load_request {
+	/** @brief base address of the code to load. Treated as (void *) */
+	uint32_t phys_addr; /* (void *) */
+	/** @brief size in bytes of code to load */
+	uint32_t size;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Module
+ * @brief response to #MRQ_MODULE_LOAD
+ *
+ * @todo document mrq_response::err
+ */
+struct mrq_module_load_response {
+	/** @brief handle to the loaded module */
+	uint32_t base;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_MODULE_UNLOAD
+ * @brief unload a previously loaded code module
+ *
+ * * Platforms: All
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_module_unload_request
+ * * Response Payload: N/A
+ *
+ * @note This MRQ is disabled on production systems
+ */
+
+/**
+ * @ingroup Module
+ * @brief request with #MRQ_MODULE_UNLOAD
+ *
+ * Used by #MRQ_MODULE_UNLOAD calls to request that a previously loaded
+ * module be unloaded.
+ */
+struct mrq_module_unload_request {
+	/** @brief handle of the module to unload */
+	uint32_t base;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_TRACE_MODIFY
+ * @brief modify the set of enabled trace events
+ *
+ * * Platforms: All
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_trace_modify_request
+ * * Response Payload: @ref mrq_trace_modify_response
+ *
+ * @note This MRQ is disabled on production systems
+ */
+
+/**
+ * @ingroup Trace
+ * @brief request with #MRQ_TRACE_MODIFY
+ *
+ * Used by %MRQ_TRACE_MODIFY calls to enable or disable specify trace
+ * events.  #set takes precedence for any bit set in both #set and
+ * #clr.
+ */
+struct mrq_trace_modify_request {
+	/** @brief bit mask of trace events to disable */
+	uint32_t clr;
+	/** @brief bit mask of trace events to enable */
+	uint32_t set;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Trace
+ * @brief response to #MRQ_TRACE_MODIFY
+ *
+ * Sent in repsonse to an #MRQ_TRACE_MODIFY message. #mask reflects the
+ * state of which events are enabled after the recipient acted on the
+ * message.
+ *
+ */
+struct mrq_trace_modify_response {
+	/** @brief bit mask of trace event enable states */
+	uint32_t mask;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_WRITE_TRACE
+ * @brief Write trace data to a buffer
+ *
+ * * Platforms: All
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_write_trace_request
+ * * Response Payload: @ref mrq_write_trace_response
+ *
+ * mrq_response::err depends on the @ref mrq_write_trace_request field
+ * values. err is -#BPMP_EINVAL if size is zero or area is NULL or
+ * area is in an illegal range. A positive value for err indicates the
+ * number of bytes written to area.
+ *
+ * @note This MRQ is disabled on production systems
+ */
+
+/**
+ * @ingroup Trace
+ * @brief request with #MRQ_WRITE_TRACE
+ *
+ * Used by MRQ_WRITE_TRACE calls to ask the recipient to copy trace
+ * data from the recipient's local buffer to the output buffer. #area
+ * is treated as a byte-aligned pointer in the recipient's address
+ * space.
+ *
+ * The sender is responsible for ensuring that the output
+ * buffer is mapped in the recipient's address map. The recipient is
+ * responsible for protecting its own code and data from accidental
+ * overwrites.
+ */
+struct mrq_write_trace_request {
+	/** @brief base address of output buffer */
+	uint32_t area;
+	/** @brief size in bytes of the output buffer */
+	uint32_t size;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Trace
+ * @brief response to #MRQ_WRITE_TRACE
+ *
+ * Once this response is sent, the respondent will not access the
+ * output buffer further.
+ */
+struct mrq_write_trace_response {
+	/**
+	 * @brief flag whether more data remains in local buffer
+	 *
+	 * Value is 1 if the entire local trace buffer has been
+	 * drained to the outputbuffer. Value is 0 otherwise.
+	 */
+	uint32_t eof;
+} __ABI_PACKED;
+
+/** @private */
+struct mrq_threaded_ping_request {
+	uint32_t challenge;
+} __ABI_PACKED;
+
+/** @private */
+struct mrq_threaded_ping_response {
+	uint32_t reply;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_MODULE_MAIL
+ * @brief send a message to a loadable module
+ *
+ * * Platforms: All
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_module_mail_request
+ * * Response Payload: @ref mrq_module_mail_response
+ *
+ * @note This MRQ is disabled on production systems
+ */
+
+/**
+ * @ingroup Module
+ * @brief request with #MRQ_MODULE_MAIL
+ */
+struct mrq_module_mail_request {
+	/** @brief handle to the previously loaded module */
+	uint32_t base;
+	/** @brief module-specific mail payload
+	 *
+	 * The length of data[ ] is unknown to the BPMP core firmware
+	 * but it is limited to the size of an IPC message.
+	 */
+	uint8_t data[EMPTY_ARRAY];
+} __ABI_PACKED;
+
+/**
+ * @ingroup Module
+ * @brief response to #MRQ_MODULE_MAIL
+ */
+struct mrq_module_mail_response {
+	/** @brief module-specific mail payload
+	 *
+	 * The length of data[ ] is unknown to the BPMP core firmware
+	 * but it is limited to the size of an IPC message.
+	 */
+	uint8_t data[EMPTY_ARRAY];
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_DEBUGFS
+ * @brief Interact with BPMP's debugfs file nodes
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_debugfs_request
+ * * Response Payload: @ref mrq_debugfs_response
+ */
+
+/**
+ * @addtogroup Debugfs
+ * @{
+ *
+ * The BPMP firmware implements a pseudo-filesystem called
+ * debugfs. Any driver within the firmware may register with debugfs
+ * to expose an arbitrary set of "files" in the filesystem. When
+ * software on the CPU writes to a debugfs file, debugfs passes the
+ * written data to a callback provided by the driver. When software on
+ * the CPU reads a debugfs file, debugfs queries the driver for the
+ * data to return to the CPU. The intention of the debugfs filesystem
+ * is to provide information useful for debugging the system at
+ * runtime.
+ *
+ * @note The files exposed via debugfs are not part of the
+ * BPMP firmware's ABI. debugfs files may be added or removed in any
+ * given version of the firmware. Typically the semantics of a debugfs
+ * file are consistent from version to version but even that is not
+ * guaranteed.
+ *
+ * @}
+ */
+/** @ingroup Debugfs */
+enum mrq_debugfs_commands {
+	CMD_DEBUGFS_READ = 1,
+	CMD_DEBUGFS_WRITE = 2,
+	CMD_DEBUGFS_DUMPDIR = 3,
+	CMD_DEBUGFS_MAX
+};
+
+/**
+ * @ingroup Debugfs
+ * @brief parameters for CMD_DEBUGFS_READ/WRITE command
+ */
+struct cmd_debugfs_fileop_request {
+	/** @brief physical address pointing at filename */
+	uint32_t fnameaddr;
+	/** @brief length in bytes of filename buffer */
+	uint32_t fnamelen;
+	/** @brief physical address pointing to data buffer */
+	uint32_t dataaddr;
+	/** @brief length in bytes of data buffer */
+	uint32_t datalen;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Debugfs
+ * @brief parameters for CMD_DEBUGFS_READ/WRITE command
+ */
+struct cmd_debugfs_dumpdir_request {
+	/** @brief physical address pointing to data buffer */
+	uint32_t dataaddr;
+	/** @brief length in bytes of data buffer */
+	uint32_t datalen;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Debugfs
+ * @brief response data for CMD_DEBUGFS_READ/WRITE command
+ */
+struct cmd_debugfs_fileop_response {
+	/** @brief always 0 */
+	uint32_t reserved;
+	/** @brief number of bytes read from or written to data buffer */
+	uint32_t nbytes;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Debugfs
+ * @brief response data for CMD_DEBUGFS_DUMPDIR command
+ */
+struct cmd_debugfs_dumpdir_response {
+	/** @brief always 0 */
+	uint32_t reserved;
+	/** @brief number of bytes read from or written to data buffer */
+	uint32_t nbytes;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Debugfs
+ * @brief request with #MRQ_DEBUGFS.
+ *
+ * The sender of an MRQ_DEBUGFS message uses #cmd to specify a debugfs
+ * command to execute. Legal commands are the values of @ref
+ * mrq_debugfs_commands. Each command requires a specific additional
+ * payload of data.
+ *
+ * |command            |payload|
+ * |-------------------|-------|
+ * |CMD_DEBUGFS_READ   |fop    |
+ * |CMD_DEBUGFS_WRITE  |fop    |
+ * |CMD_DEBUGFS_DUMPDIR|dumpdir|
+ */
+struct mrq_debugfs_request {
+	uint32_t cmd;
+	union {
+		struct cmd_debugfs_fileop_request fop;
+		struct cmd_debugfs_dumpdir_request dumpdir;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Debugfs
+ */
+struct mrq_debugfs_response {
+	/** @brief always 0 */
+	int32_t reserved;
+	union {
+		/** @brief response data for CMD_DEBUGFS_READ OR
+		 * CMD_DEBUGFS_WRITE command
+		 */
+		struct cmd_debugfs_fileop_response fop;
+		/** @brief response data for CMD_DEBUGFS_DUMPDIR command */
+		struct cmd_debugfs_dumpdir_response dumpdir;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @addtogroup Debugfs
+ * @{
+ */
+#define DEBUGFS_S_ISDIR	(1 << 9)
+#define DEBUGFS_S_IRUSR	(1 << 8)
+#define DEBUGFS_S_IWUSR	(1 << 7)
+/** @} */
+
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_RESET
+ * @brief reset an IP block
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_reset_request
+ * * Response Payload: N/A
+ */
+
+/**
+ * @ingroup Reset
+ */
+enum mrq_reset_commands {
+	CMD_RESET_ASSERT = 1,
+	CMD_RESET_DEASSERT = 2,
+	CMD_RESET_MODULE = 3,
+	CMD_RESET_MAX, /* not part of ABI and subject to change */
+};
+
+/**
+ * @ingroup Reset
+ * @brief request with MRQ_RESET
+ *
+ * Used by the sender of an #MRQ_RESET message to request BPMP to
+ * assert or or deassert a given reset line.
+ */
+struct mrq_reset_request {
+	/** @brief reset action to perform (@enum mrq_reset_commands) */
+	uint32_t cmd;
+	/** @brief id of the reset to affected */
+	uint32_t reset_id;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_I2C
+ * @brief issue an i2c transaction
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_i2c_request
+ * * Response Payload: @ref mrq_i2c_response
+ */
+
+/**
+ * @addtogroup I2C
+ * @{
+ */
+#define TEGRA_I2C_IPC_MAX_IN_BUF_SIZE	(MSG_DATA_MIN_SZ - 12)
+#define TEGRA_I2C_IPC_MAX_OUT_BUF_SIZE	(MSG_DATA_MIN_SZ - 4)
+/** @} */
+
+/**
+ * @ingroup I2C
+ * @name Serial I2C flags
+ * Use these flags with serial_i2c_request::flags
+ * @{
+ */
+#define SERIALI2C_TEN           0x0010
+#define SERIALI2C_RD            0x0001
+#define SERIALI2C_STOP          0x8000
+#define SERIALI2C_NOSTART       0x4000
+#define SERIALI2C_REV_DIR_ADDR  0x2000
+#define SERIALI2C_IGNORE_NAK    0x1000
+#define SERIALI2C_NO_RD_ACK     0x0800
+#define SERIALI2C_RECV_LEN      0x0400
+/** @} */
+/** @ingroup I2C */
+enum {
+	CMD_I2C_XFER = 1
+};
+
+/**
+ * @ingroup I2C
+ * @brief serializable i2c request
+ *
+ * Instances of this structure are packed (little-endian) into
+ * cmd_i2c_xfer_request::data_buf. Each instance represents a single
+ * transaction (or a portion of a transaction with repeated starts) on
+ * an i2c bus.
+ *
+ * Because these structures are packed, some instances are likely to
+ * be misaligned. Additionally because #data is variable length, it is
+ * not possible to iterate through a serialized list of these
+ * structures without inspecting #len in each instance.  It may be
+ * easier to serialize or deserialize cmd_i2c_xfer_request::data_buf
+ * manually rather than using this structure definition.
+*/
+struct serial_i2c_request {
+	/** @brief I2C slave address */
+	uint16_t addr;
+	/** @brief bitmask of SERIALI2C_ flags */
+	uint16_t flags;
+	/** @brief length of I2C transaction in bytes */
+	uint16_t len;
+	/** @brief for write transactions only, #len bytes of data */
+	uint8_t data[];
+} __ABI_PACKED;
+
+/**
+ * @ingroup I2C
+ * @brief trigger one or more i2c transactions
+ */
+struct cmd_i2c_xfer_request {
+	/** @brief valid bus number from mach-t186/i2c-t186.h*/
+	uint32_t bus_id;
+
+	/** @brief count of valid bytes in #data_buf*/
+	uint32_t data_size;
+
+	/** @brief serialized packed instances of @ref serial_i2c_request*/
+	uint8_t data_buf[TEGRA_I2C_IPC_MAX_IN_BUF_SIZE];
+} __ABI_PACKED;
+
+/**
+ * @ingroup I2C
+ * @brief container for data read from the i2c bus
+ *
+ * Processing an cmd_i2c_xfer_request::data_buf causes BPMP to execute
+ * zero or more I2C reads. The data read from the bus is serialized
+ * into #data_buf.
+ */
+struct cmd_i2c_xfer_response {
+	/** @brief count of valid bytes in #data_buf*/
+	uint32_t data_size;
+	/** @brief i2c read data */
+	uint8_t data_buf[TEGRA_I2C_IPC_MAX_OUT_BUF_SIZE];
+} __ABI_PACKED;
+
+/**
+ * @ingroup I2C
+ * @brief request with #MRQ_I2C
+ */
+struct mrq_i2c_request {
+	/** @brief always CMD_I2C_XFER (i.e. 1) */
+	uint32_t cmd;
+	/** @brief parameters of the transfer request */
+	struct cmd_i2c_xfer_request xfer;
+} __ABI_PACKED;
+
+/**
+ * @ingroup I2C
+ * @brief response to #MRQ_I2C
+ */
+struct mrq_i2c_response {
+	struct cmd_i2c_xfer_response xfer;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_CLK
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_clk_request
+ * * Response Payload: @ref mrq_clk_response
+ * @addtogroup Clocks
+ * @{
+ */
+
+/**
+ * @name MRQ_CLK sub-commands
+ * @{
+ */
+enum {
+	CMD_CLK_GET_RATE = 1,
+	CMD_CLK_SET_RATE = 2,
+	CMD_CLK_ROUND_RATE = 3,
+	CMD_CLK_GET_PARENT = 4,
+	CMD_CLK_SET_PARENT = 5,
+	CMD_CLK_IS_ENABLED = 6,
+	CMD_CLK_ENABLE = 7,
+	CMD_CLK_DISABLE = 8,
+	CMD_CLK_GET_ALL_INFO = 14,
+	CMD_CLK_GET_MAX_CLK_ID = 15,
+	CMD_CLK_MAX,
+};
+/** @} */
+
+#define MRQ_CLK_NAME_MAXLEN	40
+#define MRQ_CLK_MAX_PARENTS	16
+
+/** @private */
+struct cmd_clk_get_rate_request {
+	EMPTY
+} __ABI_PACKED;
+
+struct cmd_clk_get_rate_response {
+	int64_t rate;
+} __ABI_PACKED;
+
+struct cmd_clk_set_rate_request {
+	int32_t unused;
+	int64_t rate;
+} __ABI_PACKED;
+
+struct cmd_clk_set_rate_response {
+	int64_t rate;
+} __ABI_PACKED;
+
+struct cmd_clk_round_rate_request {
+	int32_t unused;
+	int64_t rate;
+} __ABI_PACKED;
+
+struct cmd_clk_round_rate_response {
+	int64_t rate;
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_get_parent_request {
+	EMPTY
+} __ABI_PACKED;
+
+struct cmd_clk_get_parent_response {
+	uint32_t parent_id;
+} __ABI_PACKED;
+
+struct cmd_clk_set_parent_request {
+	uint32_t parent_id;
+} __ABI_PACKED;
+
+struct cmd_clk_set_parent_response {
+	uint32_t parent_id;
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_is_enabled_request {
+	EMPTY
+} __ABI_PACKED;
+
+struct cmd_clk_is_enabled_response {
+	int32_t state;
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_enable_request {
+	EMPTY
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_enable_response {
+	EMPTY
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_disable_request {
+	EMPTY
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_disable_response {
+	EMPTY
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_get_all_info_request {
+	EMPTY
+} __ABI_PACKED;
+
+struct cmd_clk_get_all_info_response {
+	uint32_t flags;
+	uint32_t parent;
+	uint32_t parents[MRQ_CLK_MAX_PARENTS];
+	uint8_t num_parents;
+	uint8_t name[MRQ_CLK_NAME_MAXLEN];
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_clk_get_max_clk_id_request {
+	EMPTY
+} __ABI_PACKED;
+
+struct cmd_clk_get_max_clk_id_response {
+	uint32_t max_id;
+} __ABI_PACKED;
+/** @} */
+
+/**
+ * @ingroup Clocks
+ * @brief request with #MRQ_CLK
+ *
+ * Used by the sender of an #MRQ_CLK message to control clocks. The
+ * clk_request is split into several sub-commands. Some sub-commands
+ * require no additional data. Others have a sub-command specific
+ * payload
+ *
+ * |sub-command                 |payload                |
+ * |----------------------------|-----------------------|
+ * |CMD_CLK_GET_RATE            |-                      |
+ * |CMD_CLK_SET_RATE            |clk_set_rate           |
+ * |CMD_CLK_ROUND_RATE          |clk_round_rate         |
+ * |CMD_CLK_GET_PARENT          |-                      |
+ * |CMD_CLK_SET_PARENT          |clk_set_parent         |
+ * |CMD_CLK_IS_ENABLED          |-                      |
+ * |CMD_CLK_ENABLE              |-                      |
+ * |CMD_CLK_DISABLE             |-                      |
+ * |CMD_CLK_GET_ALL_INFO        |-                      |
+ * |CMD_CLK_GET_MAX_CLK_ID      |-                      |
+ *
+ */
+
+struct mrq_clk_request {
+	/** @brief sub-command and clock id concatenated to 32-bit word.
+	 * - bits[31..24] is the sub-cmd.
+	 * - bits[23..0] is the clock id
+	 */
+	uint32_t cmd_and_id;
+
+	union {
+		/** @private */
+		struct cmd_clk_get_rate_request clk_get_rate;
+		struct cmd_clk_set_rate_request clk_set_rate;
+		struct cmd_clk_round_rate_request clk_round_rate;
+		/** @private */
+		struct cmd_clk_get_parent_request clk_get_parent;
+		struct cmd_clk_set_parent_request clk_set_parent;
+		/** @private */
+		struct cmd_clk_enable_request clk_enable;
+		/** @private */
+		struct cmd_clk_disable_request clk_disable;
+		/** @private */
+		struct cmd_clk_is_enabled_request clk_is_enabled;
+		/** @private */
+		struct cmd_clk_get_all_info_request clk_get_all_info;
+		/** @private */
+		struct cmd_clk_get_max_clk_id_request clk_get_max_clk_id;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Clocks
+ * @brief response to MRQ_CLK
+ *
+ * Each sub-command supported by @ref mrq_clk_request may return
+ * sub-command-specific data. Some do and some do not as indicated in
+ * the following table
+ *
+ * |sub-command                 |payload                 |
+ * |----------------------------|------------------------|
+ * |CMD_CLK_GET_RATE            |clk_get_rate            |
+ * |CMD_CLK_SET_RATE            |clk_set_rate            |
+ * |CMD_CLK_ROUND_RATE          |clk_round_rate          |
+ * |CMD_CLK_GET_PARENT          |clk_get_parent          |
+ * |CMD_CLK_SET_PARENT          |clk_set_parent          |
+ * |CMD_CLK_IS_ENABLED          |clk_is_enabled          |
+ * |CMD_CLK_ENABLE              |-                       |
+ * |CMD_CLK_DISABLE             |-                       |
+ * |CMD_CLK_GET_ALL_INFO        |clk_get_all_info        |
+ * |CMD_CLK_GET_MAX_CLK_ID      |clk_get_max_id          |
+ *
+ */
+
+struct mrq_clk_response {
+	union {
+		struct cmd_clk_get_rate_response clk_get_rate;
+		struct cmd_clk_set_rate_response clk_set_rate;
+		struct cmd_clk_round_rate_response clk_round_rate;
+		struct cmd_clk_get_parent_response clk_get_parent;
+		struct cmd_clk_set_parent_response clk_set_parent;
+		/** @private */
+		struct cmd_clk_enable_response clk_enable;
+		/** @private */
+		struct cmd_clk_disable_response clk_disable;
+		struct cmd_clk_is_enabled_response clk_is_enabled;
+		struct cmd_clk_get_all_info_response clk_get_all_info;
+		struct cmd_clk_get_max_clk_id_response clk_get_max_clk_id;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_QUERY_ABI
+ * @brief check if an MRQ is implemented
+ *
+ * * Platforms: All
+ * * Initiators: Any
+ * * Targets: Any
+ * * Request Payload: @ref mrq_query_abi_request
+ * * Response Payload: @ref mrq_query_abi_response
+ */
+
+/**
+ * @ingroup ABI_info
+ * @brief request with MRQ_QUERY_ABI
+ *
+ * Used by #MRQ_QUERY_ABI call to check if MRQ code #mrq is supported
+ * by the recipient.
+ */
+struct mrq_query_abi_request {
+	/** @brief MRQ code to query */
+	uint32_t mrq;
+} __ABI_PACKED;
+
+/**
+ * @ingroup ABI_info
+ * @brief response to MRQ_QUERY_ABI
+ */
+struct mrq_query_abi_response {
+	/** @brief 0 if queried MRQ is supported. Else, -#BPMP_ENODEV */
+	int32_t status;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_PG_READ_STATE
+ * @brief read the power-gating state of a partition
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_pg_read_state_request
+ * * Response Payload: @ref mrq_pg_read_state_response
+ * @addtogroup Powergating
+ * @{
+ */
+
+/**
+ * @brief request with #MRQ_PG_READ_STATE
+ *
+ * Used by MRQ_PG_READ_STATE call to read the current state of a
+ * partition.
+ */
+struct mrq_pg_read_state_request {
+	/** @brief ID of partition */
+	uint32_t partition_id;
+} __ABI_PACKED;
+
+/**
+ * @brief response to MRQ_PG_READ_STATE
+ * @todo define possible errors.
+ */
+struct mrq_pg_read_state_response {
+	/** @brief read as don't care */
+	uint32_t sram_state;
+	/** @brief state of power partition
+	 * * 0 : off
+	 * * 1 : on
+	 */
+	uint32_t logic_state;
+} __ABI_PACKED;
+
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_PG_UPDATE_STATE
+ * @brief modify the power-gating state of a partition
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_pg_update_state_request
+ * * Response Payload: N/A
+ * @addtogroup Powergating
+ * @{
+ */
+
+/**
+ * @brief request with mrq_pg_update_state_request
+ *
+ * Used by #MRQ_PG_UPDATE_STATE call to request BPMP to change the
+ * state of a power partition #partition_id.
+ */
+struct mrq_pg_update_state_request {
+	/** @brief ID of partition */
+	uint32_t partition_id;
+	/** @brief secondary control of power partition
+	 *  @details Ignored by many versions of the BPMP
+	 *  firmware. For maximum compatibility, set the value
+	 *  according to @logic_state
+	 * *  0x1: power ON partition (@ref logic_state == 0x3)
+	 * *  0x3: power OFF partition (@ref logic_state == 0x1)
+	 */
+	uint32_t sram_state;
+	/** @brief controls state of power partition, legal values are
+	 * *  0x1 : power OFF partition
+	 * *  0x3 : power ON partition
+	 */
+	uint32_t logic_state;
+	/** @brief change state of clocks of the power partition, legal values
+	 * *  0x0 : do not change clock state
+	 * *  0x1 : disable partition clocks (only applicable when
+	 *          @ref logic_state == 0x1)
+	 * *  0x3 : enable partition clocks (only applicable when
+	 *          @ref logic_state == 0x3)
+	 */
+	uint32_t clock_state;
+} __ABI_PACKED;
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_THERMAL
+ * @brief interact with BPMP thermal framework
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: Any
+ * * Request Payload: TODO
+ * * Response Payload: TODO
+ *
+ * @addtogroup Thermal
+ *
+ * The BPMP firmware includes a thermal framework. Drivers within the
+ * bpmp firmware register with the framework to provide thermal
+ * zones. Each thermal zone corresponds to an entity whose temperature
+ * can be measured. The framework also has a notion of trip points. A
+ * trip point consists of a thermal zone id, a temperature, and a
+ * callback routine. The framework invokes the callback when the zone
+ * hits the indicated temperature. The BPMP firmware uses this thermal
+ * framework interally to implement various temperature-dependent
+ * functions.
+ *
+ * Software on the CPU can use #MRQ_THERMAL (with payload @ref
+ * mrq_thermal_host_to_bpmp_request) to interact with the BPMP thermal
+ * framework. The CPU must It can query the number of supported zones,
+ * query zone temperatures, and set trip points.
+ *
+ * When a trip point set by the CPU gets crossed, BPMP firmware issues
+ * an IPC to the CPU having mrq_request::mrq = #MRQ_THERMAL and a
+ * payload of @ref mrq_thermal_bpmp_to_host_request.
+ * @{
+ */
+enum mrq_thermal_host_to_bpmp_cmd {
+	/**
+	 * @brief Check whether the BPMP driver supports the specified
+	 * request type.
+	 *
+	 * Host needs to supply request parameters.
+	 *
+	 * mrq_response::err is 0 if the specified request is
+	 * supported and -#BPMP_ENODEV otherwise.
+	 */
+	CMD_THERMAL_QUERY_ABI = 0,
+
+	/**
+	 * @brief Get the current temperature of the specified zone.
+	 *
+	 * Host needs to supply request parameters.
+	 *
+	 * mrq_response::err is
+	 * *  0: Temperature query succeeded.
+	 * *  -#BPMP_EINVAL: Invalid request parameters.
+	 * *  -#BPMP_ENOENT: No driver registered for thermal zone..
+	 * *  -#BPMP_EFAULT: Problem reading temperature measurement.
+	 */
+	CMD_THERMAL_GET_TEMP = 1,
+
+	/**
+	 * @brief Enable or disable and set the lower and upper
+	 *   thermal limits for a thermal trip point. Each zone has
+	 *   one trip point.
+	 *
+	 * Host needs to supply request parameters. Once the
+	 * temperature hits a trip point, the BPMP will send a message
+	 * to the CPU having MRQ=MRQ_THERMAL and
+	 * type=CMD_THERMAL_HOST_TRIP_REACHED
+	 *
+	 * mrq_response::err is
+	 * *  0: Trip successfully set.
+	 * *  -#BPMP_EINVAL: Invalid request parameters.
+	 * *  -#BPMP_ENOENT: No driver registered for thermal zone.
+	 * *  -#BPMP_EFAULT: Problem setting trip point.
+	 */
+	CMD_THERMAL_SET_TRIP = 2,
+
+	/**
+	 * @brief Get the number of supported thermal zones.
+	 *
+	 * No request parameters required.
+	 *
+	 * mrq_response::err is always 0, indicating success.
+	 */
+	CMD_THERMAL_GET_NUM_ZONES = 3,
+
+	/** @brief: number of supported host-to-bpmp commands. May
+	 * increase in future
+	 */
+	CMD_THERMAL_HOST_TO_BPMP_NUM
+};
+
+enum mrq_thermal_bpmp_to_host_cmd {
+	/**
+	 * @brief Indication that the temperature for a zone has
+	 *   exceeded the range indicated in the thermal trip point
+	 *   for the zone.
+	 *
+	 * BPMP needs to supply request parameters. Host only needs to
+	 * acknowledge.
+	 */
+	CMD_THERMAL_HOST_TRIP_REACHED = 100,
+
+	/** @brief: number of supported bpmp-to-host commands. May
+	 * increase in future
+	 */
+	CMD_THERMAL_BPMP_TO_HOST_NUM
+};
+
+/*
+ * Host->BPMP request data for request type CMD_THERMAL_QUERY_ABI
+ *
+ * zone: Request type for which to check existence.
+ */
+struct cmd_thermal_query_abi_request {
+	uint32_t type;
+} __ABI_PACKED;
+
+/*
+ * Host->BPMP request data for request type CMD_THERMAL_GET_TEMP
+ *
+ * zone: Number of thermal zone.
+ */
+struct cmd_thermal_get_temp_request {
+	uint32_t zone;
+} __ABI_PACKED;
+
+/*
+ * BPMP->Host reply data for request CMD_THERMAL_GET_TEMP
+ *
+ * error: 0 if request succeeded.
+ *	-BPMP_EINVAL if request parameters were invalid.
+ *      -BPMP_ENOENT if no driver was registered for the specified thermal zone.
+ *      -BPMP_EFAULT for other thermal zone driver errors.
+ * temp: Current temperature in millicelsius.
+ */
+struct cmd_thermal_get_temp_response {
+	int32_t temp;
+} __ABI_PACKED;
+
+/*
+ * Host->BPMP request data for request type CMD_THERMAL_SET_TRIP
+ *
+ * zone: Number of thermal zone.
+ * low: Temperature of lower trip point in millicelsius
+ * high: Temperature of upper trip point in millicelsius
+ * enabled: 1 to enable trip point, 0 to disable trip point
+ */
+struct cmd_thermal_set_trip_request {
+	uint32_t zone;
+	int32_t low;
+	int32_t high;
+	uint32_t enabled;
+} __ABI_PACKED;
+
+/*
+ * BPMP->Host request data for request type CMD_THERMAL_HOST_TRIP_REACHED
+ *
+ * zone: Number of thermal zone where trip point was reached.
+ */
+struct cmd_thermal_host_trip_reached_request {
+	uint32_t zone;
+} __ABI_PACKED;
+
+/*
+ * BPMP->Host reply data for request type CMD_THERMAL_GET_NUM_ZONES
+ *
+ * num: Number of supported thermal zones. The thermal zones are indexed
+ *      starting from zero.
+ */
+struct cmd_thermal_get_num_zones_response {
+	uint32_t num;
+} __ABI_PACKED;
+
+/*
+ * Host->BPMP request data.
+ *
+ * Reply type is union mrq_thermal_bpmp_to_host_response.
+ *
+ * type: Type of request. Values listed in enum mrq_thermal_type.
+ * data: Request type specific parameters.
+ */
+struct mrq_thermal_host_to_bpmp_request {
+	uint32_t type;
+	union {
+		struct cmd_thermal_query_abi_request query_abi;
+		struct cmd_thermal_get_temp_request get_temp;
+		struct cmd_thermal_set_trip_request set_trip;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/*
+ * BPMP->Host request data.
+ *
+ * type: Type of request. Values listed in enum mrq_thermal_type.
+ * data: Request type specific parameters.
+ */
+struct mrq_thermal_bpmp_to_host_request {
+	uint32_t type;
+	union {
+		struct cmd_thermal_host_trip_reached_request host_trip_reached;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/*
+ * Data in reply to a Host->BPMP request.
+ */
+union mrq_thermal_bpmp_to_host_response {
+	struct cmd_thermal_get_temp_response get_temp;
+	struct cmd_thermal_get_num_zones_response get_num_zones;
+} __ABI_PACKED;
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_CPU_VHINT
+ * @brief Query CPU voltage hint data
+ *
+ * * Platforms: T186
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_cpu_vhint_request
+ * * Response Payload: N/A
+ *
+ * @addtogroup Vhint CPU Voltage hint
+ * @{
+ */
+
+/**
+ * @brief request with #MRQ_CPU_VHINT
+ *
+ * Used by #MRQ_CPU_VHINT call by CCPLEX to retrieve voltage hint data
+ * from BPMP to memory space pointed by #addr. CCPLEX is responsible
+ * to allocate sizeof(cpu_vhint_data) sized block of memory and
+ * appropriately map it for BPMP before sending the request.
+ */
+struct mrq_cpu_vhint_request {
+	/** @brief IOVA address for the #cpu_vhint_data */
+	uint32_t addr; /* struct cpu_vhint_data * */
+	/** @brief ID of the cluster whose data is requested */
+	uint32_t cluster_id; /* enum cluster_id */
+} __ABI_PACKED;
+
+/**
+ * @brief description of the CPU v/f relation
+ *
+ * Used by #MRQ_CPU_VHINT call to carry data pointed by #addr of
+ * struct mrq_cpu_vhint_request
+ */
+struct cpu_vhint_data {
+	uint32_t ref_clk_hz; /**< reference frequency in Hz */
+	uint16_t pdiv; /**< post divider value */
+	uint16_t mdiv; /**< input divider value */
+	uint16_t ndiv_max; /**< fMAX expressed with max NDIV value */
+	/** table of ndiv values as a function of vINDEX (voltage index) */
+	uint16_t ndiv[80];
+	/** minimum allowed NDIV value */
+	uint16_t ndiv_min;
+	/** minimum allowed voltage hint value (as in vINDEX) */
+	uint16_t vfloor;
+	/** maximum allowed voltage hint value (as in vINDEX) */
+	uint16_t vceil;
+	/** post-multiplier for vindex value */
+	uint16_t vindex_mult;
+	/** post-divider for vindex value */
+	uint16_t vindex_div;
+	/** reserved for future use */
+	uint16_t reserved[328];
+} __ABI_PACKED;
+
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_ABI_RATCHET
+ * @brief ABI ratchet value query
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_abi_ratchet_request
+ * * Response Payload: @ref mrq_abi_ratchet_response
+ * @addtogroup ABI_info
+ * @{
+ */
+
+/**
+ * @brief an ABI compatibility mechanism
+ *
+ * BPMP_ABI_RATCHET_VALUE may increase for various reasons in a future
+ * revision of this header file.
+ * 1. That future revision deprecates some MRQ
+ * 2. That future revision introduces a breaking change to an existing
+ *    MRQ or
+ * 3. A bug is discovered in an existing implementation of the BPMP-FW
+ *    (or possibly one of its clients) which warrants deprecating that
+ *    implementation.
+ */
+#define BPMP_ABI_RATCHET_VALUE 3
+
+/**
+ * @brief request with #MRQ_ABI_RATCHET.
+ *
+ * #ratchet should be #BPMP_ABI_RATCHET_VALUE from the ABI header
+ * against which the requester was compiled.
+ *
+ * If ratchet is less than BPMP's #BPMP_ABI_RATCHET_VALUE, BPMP may
+ * reply with mrq_response::err = -#BPMP_ERANGE to indicate that
+ * BPMP-FW cannot interoperate correctly with the requester. Requester
+ * should cease further communication with BPMP.
+ *
+ * Otherwise, err shall be 0.
+ */
+struct mrq_abi_ratchet_request {
+	/** @brief requester's ratchet value */
+	uint16_t ratchet;
+};
+
+/**
+ * @brief response to #MRQ_ABI_RATCHET
+ *
+ * #ratchet shall be #BPMP_ABI_RATCHET_VALUE from the ABI header
+ * against which BPMP firwmare was compiled.
+ *
+ * If #ratchet is less than the requester's #BPMP_ABI_RATCHET_VALUE,
+ * the requster must either interoperate with BPMP according to an ABI
+ * header version with BPMP_ABI_RATCHET_VALUE = ratchet or cease
+ * communication with BPMP.
+ *
+ * If mrq_response::err is 0 and ratchet is greater than or equal to the
+ * requester's BPMP_ABI_RATCHET_VALUE, the requester should continue
+ * normal operation.
+ */
+struct mrq_abi_ratchet_response {
+	/** @brief BPMP's ratchet value */
+	uint16_t ratchet;
+};
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_EMC_DVFS_LATENCY
+ * @brief query frequency dependent EMC DVFS latency
+ *
+ * * Platforms: T186
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: N/A
+ * * Response Payload: @ref mrq_emc_dvfs_latency_response
+ * @addtogroup EMC
+ * @{
+ */
+
+/**
+ * @brief used by @ref mrq_emc_dvfs_latency_response
+ */
+struct emc_dvfs_latency {
+	/** @brief EMC frequency in kHz */
+	uint32_t freq;
+	/** @brief EMC DVFS latency in nanoseconds */
+	uint32_t latency;
+} __ABI_PACKED;
+
+#define EMC_DVFS_LATENCY_MAX_SIZE	14
+/**
+ * @brief response to #MRQ_EMC_DVFS_LATENCY
+ */
+struct mrq_emc_dvfs_latency_response {
+	/** @brief the number valid entries in #pairs */
+	uint32_t num_pairs;
+	/** @brief EMC <frequency, latency> information */
+	struct emc_dvfs_latency pairs[EMC_DVFS_LATENCY_MAX_SIZE];
+} __ABI_PACKED;
+
+/** @} */
+
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_TRACE_ITER
+ * @brief manage the trace iterator
+ *
+ * * Platforms: All
+ * * Initiators: CCPLEX
+ * * Targets: BPMP
+ * * Request Payload: N/A
+ * * Response Payload: @ref mrq_trace_iter_request
+ * @addtogroup Trace
+ * @{
+ */
+enum {
+	/** @brief (re)start the tracing now. Ignore older events */
+	TRACE_ITER_INIT = 0,
+	/** @brief clobber all events in the trace buffer */
+	TRACE_ITER_CLEAN = 1
+};
+
+/**
+ * @brief request with #MRQ_TRACE_ITER
+ */
+struct mrq_trace_iter_request {
+	/** @brief TRACE_ITER_INIT or TRACE_ITER_CLEAN */
+	uint32_t cmd;
+} __ABI_PACKED;
+
+/** @} */
+
+/*
+ *  4. Enumerations
+ */
+
+/*
+ *   4.1 CPU enumerations
+ *
+ * See <mach-t186/system-t186.h>
+ *
+ *   4.2 CPU Cluster enumerations
+ *
+ * See <mach-t186/system-t186.h>
+ *
+ *   4.3 System low power state enumerations
+ *
+ * See <mach-t186/system-t186.h>
+ */
+
+/*
+ *   4.4 Clock enumerations
+ *
+ * For clock enumerations, see <mach-t186/clk-t186.h>
+ */
+
+/*
+ *   4.5 Reset enumerations
+ *
+ * For reset enumerations, see <mach-t186/reset-t186.h>
+ */
+
+/*
+ *   4.6 Thermal sensor enumerations
+ *
+ * For thermal sensor enumerations, see <mach-t186/thermal-t186.h>
+ */
+
+/**
+ * @defgroup Error_Codes
+ * Negative values for mrq_response::err generally indicate some
+ * error. The ABI defines the following error codes. Negating these
+ * defines is an exercise left to the user.
+ * @{
+ */
+/** @brief No such file or directory */
+#define BPMP_ENOENT	2
+/** @brief No MRQ handler */
+#define BPMP_ENOHANDLER	3
+/** @brief I/O error */
+#define BPMP_EIO	5
+/** @brief Bad sub-MRQ command */
+#define BPMP_EBADCMD	6
+/** @brief Not enough memory */
+#define BPMP_ENOMEM	12
+/** @brief Permission denied */
+#define BPMP_EACCES	13
+/** @brief Bad address */
+#define BPMP_EFAULT	14
+/** @brief No such device */
+#define BPMP_ENODEV	19
+/** @brief Argument is a directory */
+#define BPMP_EISDIR	21
+/** @brief Invalid argument */
+#define BPMP_EINVAL	22
+/** @brief Timeout during operation */
+#define BPMP_ETIMEDOUT  23
+/** @brief Out of range */
+#define BPMP_ERANGE	34
+/** @} */
+/** @} */
+#endif
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
new file mode 100644
index 000000000000..e17d091e8a9a
--- /dev/null
+++ b/include/soc/tegra/bpmp.h
@@ -0,0 +1,122 @@
+/*
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef __SOC_TEGRA_BPMP_H
+#define __SOC_TEGRA_BPMP_H
+
+#include <linux/mailbox_client.h>
+#include <linux/reset-controller.h>
+#include <linux/semaphore.h>
+#include <linux/types.h>
+
+#define TEGRA_BPMP_MSG_SIZE 128
+#define TEGRA_BPMP_MSG_DATA_SIZE 120
+
+struct tegra_bpmp_soc {
+	struct {
+		struct {
+			unsigned int offset;
+			unsigned int count;
+			unsigned int timeout;
+		} cpu_tx, thread, cpu_rx;
+	} channels;
+	unsigned int num_resets;
+};
+
+struct tegra_bpmp_mb_data {
+	u32 code;
+	u32 flags;
+	u8 data[TEGRA_BPMP_MSG_DATA_SIZE];
+} __packed;
+
+struct tegra_bpmp_channel {
+	struct tegra_bpmp *bpmp;
+	struct tegra_bpmp_mb_data *ib;
+	struct tegra_bpmp_mb_data *ob;
+	struct completion completion;
+	struct tegra_ivc *ivc;
+};
+
+typedef void (*tegra_bpmp_mrq_handler_t)(unsigned int mrq,
+					 struct tegra_bpmp_channel *channel,
+					 void *data);
+
+struct tegra_bpmp_mrq {
+	struct list_head list;
+	unsigned int mrq;
+	tegra_bpmp_mrq_handler_t handler;
+	void *data;
+};
+
+struct tegra_bpmp {
+	const struct tegra_bpmp_soc *soc;
+	struct device *dev;
+
+	void __iomem *tx_base;
+	void __iomem *rx_base;
+
+	struct {
+		struct mbox_client client;
+		struct mbox_chan *channel;
+	} mbox;
+
+	struct tegra_bpmp_channel *channels;
+	unsigned int num_channels;
+
+	struct {
+		unsigned long *allocated;
+		unsigned long *busy;
+		unsigned int count;
+		struct semaphore lock;
+	} threaded;
+
+	struct list_head mrqs;
+	spinlock_t lock;
+
+	unsigned int num_clocks;
+	struct clk_hw **clocks;
+
+	struct reset_controller_dev rstc;
+};
+
+struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
+void tegra_bpmp_put(struct tegra_bpmp *bpmp);
+
+struct tegra_bpmp_message {
+	unsigned int mrq;
+
+	struct {
+		const void *data;
+		size_t size;
+	} tx;
+
+	struct {
+		void *data;
+		size_t size;
+	} rx;
+};
+
+int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
+			       struct tegra_bpmp_message *msg);
+int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
+			struct tegra_bpmp_message *msg);
+
+int tegra_bpmp_request_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
+			   tegra_bpmp_mrq_handler_t handler, void *data);
+void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
+			 void *data);
+
+int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp);
+int tegra_bpmp_init_resets(struct tegra_bpmp *bpmp);
+
+#endif /* __SOC_TEGRA_BPMP_H */
-- 
2.9.0
