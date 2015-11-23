From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 22 Nov 2015 21:28:25 -0500
Subject: [PATCH V7 3/3] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1448245707-27499-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for hidma engine. The driver consists
of two logical blocks. The DMA engine interface and the
low-level interface. The hardware only supports memcpy/memset
and this driver only support memcpy interface. HW and driver
doesn't support slave interface.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 .../devicetree/bindings/dma/qcom_hidma.txt         |  18 +
 drivers/dma/qcom/Kconfig                           |  10 +
 drivers/dma/qcom/Makefile                          |   2 +
 drivers/dma/qcom/hidma.c                           | 706 ++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 157 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 217 +++++
 drivers/dma/qcom/hidma_ll.c                        | 924 +++++++++++++++++++++
 7 files changed, 2034 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma.txt
 create mode 100644 drivers/dma/qcom/hidma.c
 create mode 100644 drivers/dma/qcom/hidma.h
 create mode 100644 drivers/dma/qcom/hidma_dbg.c
 create mode 100644 drivers/dma/qcom/hidma_ll.c

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma.txt b/Documentation/devicetree/bindings/dma/qcom_hidma.txt
new file mode 100644
index 0000000..d18c8fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma.txt
@@ -0,0 +1,18 @@
+Qualcomm Technologies HIDMA Channel driver
+
+Required properties:
+- compatible: must contain "qcom,hidma-1.0"
+- reg: Addresses for the transfer and event channel
+- interrupts: Should contain the event interrupt
+- desc-count: Number of asynchronous requests this channel can handle
+- event-channel: The HW event channel completions will be delivered.
+Example:
+
+	hidma_24: dma-controller at 0x5c050000 {
+		compatible = "qcom,hidma-1.0";
+		reg = <0 0x5c050000 0x0 0x1000>,
+		      <0 0x5c0b0000 0x0 0x1000>;
+		interrupts = <0 389 0>;
+		desc-count = <10>;
+		event-channel = <4>;
+	};
diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index ebe5b8c..5588e1c 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -17,3 +17,13 @@ config QCOM_HIDMA_MGMT
 	  start managing the channels. In a virtualized environment,
 	  the guest OS would run QCOM_HIDMA channel driver and the
 	  hypervisor would run the QCOM_HIDMA_MGMT management driver.
+
+config QCOM_HIDMA
+	tristate "Qualcomm Technologies HIDMA Channel support"
+	select DMA_ENGINE
+	help
+	  Enable support for the Qualcomm Technologies HIDMA controller.
+	  The HIDMA controller supports optimized buffer copies
+	  (user to kernel, kernel to kernel, etc.).  It only supports
+	  memcpy interface. The core is not intended for general
+	  purpose slave DMA.
diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
index 1a5a96d..f702df1 100644
--- a/drivers/dma/qcom/Makefile
+++ b/drivers/dma/qcom/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
 obj-$(CONFIG_QCOM_HIDMA_MGMT) += hidma_mgmt.o hidma_mgmt_sys.o
+obj-$(CONFIG_QCOM_HIDMA) +=  hdma.o
+hdma-objs        := hidma_ll.o hidma.o hidma_dbg.o
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
new file mode 100644
index 0000000..c0c7f44
--- /dev/null
+++ b/drivers/dma/qcom/hidma.c
@@ -0,0 +1,706 @@
+/*
+ * Qualcomm Technologies HIDMA DMA engine interface
+ *
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2007, 2008.
+ * Copyright (C) Semihalf 2009
+ * Copyright (C) Ilya Yanok, Emcraft Systems 2010
+ * Copyright (C) Alexander Popov, Promcontroller 2014
+ *
+ * Written by Piotr Ziecik <kosmo@semihalf.com>. Hardware description
+ * (defines, structures and comments) was taken from MPC5121 DMA driver
+ * written by Hongjun Chen <hong-jun.chen@freescale.com>.
+ *
+ * Approved as OSADL project by a majority of OSADL members and funded
+ * by OSADL membership fees in 2009;  for details see www.osadl.org.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+
+/* Linux Foundation elects GPLv2 license only. */
+
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/of_dma.h>
+#include <linux/property.h>
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/atomic.h>
+#include <linux/pm_runtime.h>
+
+#include "../dmaengine.h"
+#include "hidma.h"
+
+/*
+ * Default idle time is 2 seconds. This parameter can
+ * be overridden by changing the following
+ * /sys/bus/platform/devices/QCOM8061:<xy>/power/autosuspend_delay_ms
+ * during kernel boot.
+ */
+#define AUTOSUSPEND_TIMEOUT		2000
+#define ERR_INFO_SW			0xFF
+#define ERR_CODE_UNEXPECTED_TERMINATE	0x0
+
+static inline struct hidma_dev *to_hidma_dev(struct dma_device *dmadev)
+{
+	return container_of(dmadev, struct hidma_dev, ddev);
+}
+
+static inline
+struct hidma_dev *to_hidma_dev_from_lldev(struct hidma_lldev **_lldevp)
+{
+	return container_of(_lldevp, struct hidma_dev, lldev);
+}
+
+static inline struct hidma_chan *to_hidma_chan(struct dma_chan *dmach)
+{
+	return container_of(dmach, struct hidma_chan, chan);
+}
+
+static inline struct hidma_desc *
+to_hidma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct hidma_desc, desc);
+}
+
+static void hidma_free(struct hidma_dev *dmadev)
+{
+	INIT_LIST_HEAD(&dmadev->ddev.channels);
+}
+
+static unsigned int nr_desc_prm;
+module_param(nr_desc_prm, uint, 0644);
+MODULE_PARM_DESC(nr_desc_prm, "number of descriptors (default: 0)");
+
+#define MAX_HIDMA_CHANNELS	64
+static int event_channel_idx[MAX_HIDMA_CHANNELS] = {
+	[0 ... (MAX_HIDMA_CHANNELS - 1)] = -1
+};
+
+static unsigned int num_event_channel_idx;
+module_param_array_named(event_channel_idx, event_channel_idx, int,
+			&num_event_channel_idx, 0644);
+MODULE_PARM_DESC(event_channel_idx,
+		"event channel index array for the notifications");
+static atomic_t channel_ref_count;
+
+/* process completed descriptors */
+static void hidma_process_completed(struct hidma_dev *mdma)
+{
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t last_cookie;
+	struct hidma_chan *mchan;
+	struct hidma_desc *mdesc;
+	unsigned long irqflags;
+	struct list_head list;
+	struct dma_chan *dmach;
+
+	list_for_each_entry(dmach, &mdma->ddev.channels, device_node) {
+		mchan = to_hidma_chan(dmach);
+		INIT_LIST_HEAD(&list);
+
+		/* Get all completed descriptors */
+		spin_lock_irqsave(&mchan->lock, irqflags);
+		list_splice_tail_init(&mchan->completed, &list);
+		spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+		/* Execute callbacks and run dependencies */
+		list_for_each_entry(mdesc, &list, node) {
+			enum dma_status llstat;
+
+			desc = &mdesc->desc;
+
+			spin_lock_irqsave(&mchan->lock, irqflags);
+			dma_cookie_complete(desc);
+			spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+			llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
+			if (desc->callback && (llstat == DMA_COMPLETE))
+				desc->callback(desc->callback_param);
+
+			last_cookie = desc->cookie;
+			dma_run_dependencies(desc);
+		}
+
+		/* Free descriptors */
+		spin_lock_irqsave(&mchan->lock, irqflags);
+		list_splice_tail_init(&list, &mchan->free);
+		spin_unlock_irqrestore(&mchan->lock, irqflags);
+	}
+}
+
+/*
+ * Called once for each submitted descriptor.
+ * PM is locked once for each descriptor that is currently
+ * in execution.
+ */
+static void hidma_callback(void *data)
+{
+	struct hidma_desc *mdesc = data;
+	struct hidma_chan *mchan = to_hidma_chan(mdesc->desc.chan);
+	struct dma_device *ddev = mchan->chan.device;
+	struct hidma_dev *dmadev = to_hidma_dev(ddev);
+	unsigned long irqflags;
+	bool queued = false;
+
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	if (mdesc->node.next) {
+		/* Delete from the active list, add to completed list */
+		list_move_tail(&mdesc->node, &mchan->completed);
+		queued = true;
+	}
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	hidma_process_completed(dmadev);
+
+	if (queued) {
+		pm_runtime_mark_last_busy(dmadev->ddev.dev);
+		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	}
+}
+
+static int hidma_chan_init(struct hidma_dev *dmadev, u32 dma_sig)
+{
+	struct hidma_chan *mchan;
+	struct dma_device *ddev;
+
+	mchan = devm_kzalloc(dmadev->ddev.dev, sizeof(*mchan), GFP_KERNEL);
+	if (!mchan)
+		return -ENOMEM;
+
+	ddev = &dmadev->ddev;
+	mchan->dma_sig = dma_sig;
+	mchan->dmadev = dmadev;
+	mchan->chan.device = ddev;
+	dma_cookie_init(&mchan->chan);
+
+	INIT_LIST_HEAD(&mchan->free);
+	INIT_LIST_HEAD(&mchan->prepared);
+	INIT_LIST_HEAD(&mchan->active);
+	INIT_LIST_HEAD(&mchan->completed);
+
+	spin_lock_init(&mchan->lock);
+	list_add_tail(&mchan->chan.device_node, &ddev->channels);
+	dmadev->ddev.chancnt++;
+	return 0;
+}
+
+static void hidma_issue_pending(struct dma_chan *dmach)
+{
+	struct hidma_chan *mchan = to_hidma_chan(dmach);
+	struct hidma_dev *dmadev = mchan->dmadev;
+
+	/* PM will be released in hidma_callback function. */
+	pm_runtime_get_sync(dmadev->ddev.dev);
+	hidma_ll_start(dmadev->lldev);
+}
+
+static enum dma_status hidma_tx_status(struct dma_chan *dmach,
+			dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	struct hidma_chan *mchan = to_hidma_chan(dmach);
+	enum dma_status ret;
+
+	if (mchan->paused)
+		ret = DMA_PAUSED;
+	else
+		ret = dma_cookie_status(dmach, cookie, txstate);
+
+	return ret;
+}
+
+/*
+ * Submit descriptor to hardware.
+ * Lock the PM for each descriptor we are sending.
+ */
+static dma_cookie_t hidma_tx_submit(struct dma_async_tx_descriptor *txd)
+{
+	struct hidma_chan *mchan = to_hidma_chan(txd->chan);
+	struct hidma_dev *dmadev = mchan->dmadev;
+	struct hidma_desc *mdesc;
+	unsigned long irqflags;
+	dma_cookie_t cookie;
+
+	if (!hidma_ll_isenabled(dmadev->lldev))
+		return -ENODEV;
+
+	mdesc = container_of(txd, struct hidma_desc, desc);
+	spin_lock_irqsave(&mchan->lock, irqflags);
+
+	/* Move descriptor to active */
+	list_move_tail(&mdesc->node, &mchan->active);
+
+	/* Update cookie */
+	cookie = dma_cookie_assign(txd);
+
+	hidma_ll_queue_request(dmadev->lldev, mdesc->tre_ch);
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	return cookie;
+}
+
+static int hidma_alloc_chan_resources(struct dma_chan *dmach)
+{
+	struct hidma_chan *mchan = to_hidma_chan(dmach);
+	struct hidma_dev *dmadev = mchan->dmadev;
+	struct hidma_desc *mdesc, *tmp;
+	unsigned long irqflags;
+	LIST_HEAD(descs);
+	unsigned int i;
+	int rc = 0;
+
+	if (mchan->allocated)
+		return 0;
+
+	/* Alloc descriptors for this channel */
+	for (i = 0; i < dmadev->nr_descriptors; i++) {
+		mdesc = kzalloc(sizeof(struct hidma_desc), GFP_KERNEL);
+		if (!mdesc) {
+			rc = -ENOMEM;
+			break;
+		}
+		dma_async_tx_descriptor_init(&mdesc->desc, dmach);
+		mdesc->desc.flags = DMA_CTRL_ACK;
+		mdesc->desc.tx_submit = hidma_tx_submit;
+
+		rc = hidma_ll_request(dmadev->lldev, mchan->dma_sig,
+			"DMA engine", hidma_callback, mdesc, &mdesc->tre_ch);
+		if (rc) {
+			dev_err(dmach->device->dev,
+				"channel alloc failed at %u\n", i);
+			kfree(mdesc);
+			break;
+		}
+		list_add_tail(&mdesc->node, &descs);
+	}
+
+	if (rc) {
+		/* return the allocated descriptors */
+		list_for_each_entry_safe(mdesc, tmp, &descs, node) {
+			hidma_ll_free(dmadev->lldev, mdesc->tre_ch);
+			kfree(mdesc);
+		}
+		return rc;
+	}
+
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	list_splice_tail_init(&descs, &mchan->free);
+	mchan->allocated = true;
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+	return 1;
+}
+
+static void hidma_free_chan_resources(struct dma_chan *dmach)
+{
+	struct hidma_chan *mchan = to_hidma_chan(dmach);
+	struct hidma_dev *mdma = mchan->dmadev;
+	struct hidma_desc *mdesc, *tmp;
+	unsigned long irqflags;
+	LIST_HEAD(descs);
+
+	if (!list_empty(&mchan->prepared) || !list_empty(&mchan->active) ||
+		!list_empty(&mchan->completed)) {
+		/*
+		 * We have unfinished requests waiting.
+		 * Terminate the request from the hardware.
+		 */
+		hidma_cleanup_pending_tre(mdma->lldev, ERR_INFO_SW,
+					ERR_CODE_UNEXPECTED_TERMINATE);
+
+		/* Give enough time for completions to be called. */
+		msleep(100);
+	}
+
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	/* Channel must be idle */
+	WARN_ON(!list_empty(&mchan->prepared));
+	WARN_ON(!list_empty(&mchan->active));
+	WARN_ON(!list_empty(&mchan->completed));
+
+	/* Move data */
+	list_splice_tail_init(&mchan->free, &descs);
+
+	/* Free descriptors */
+	list_for_each_entry_safe(mdesc, tmp, &descs, node) {
+		hidma_ll_free(mdma->lldev, mdesc->tre_ch);
+		list_del(&mdesc->node);
+		kfree(mdesc);
+	}
+
+	mchan->allocated = 0;
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+}
+
+static struct dma_async_tx_descriptor *
+hidma_prep_dma_memcpy(struct dma_chan *dmach, dma_addr_t dma_dest,
+			dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct hidma_chan *mchan = to_hidma_chan(dmach);
+	struct hidma_desc *mdesc = NULL;
+	struct hidma_dev *mdma = mchan->dmadev;
+	unsigned long irqflags;
+
+	/* Get free descriptor */
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	if (!list_empty(&mchan->free)) {
+		mdesc = list_first_entry(&mchan->free, struct hidma_desc, node);
+		list_del(&mdesc->node);
+	}
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	if (!mdesc)
+		return NULL;
+
+	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
+				dma_src, dma_dest, len, flags);
+
+	/* Place descriptor in prepared list */
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	list_add_tail(&mdesc->node, &mchan->prepared);
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	return &mdesc->desc;
+}
+
+static int hidma_terminate_all(struct dma_chan *chan)
+{
+	struct hidma_dev *dmadev;
+	struct hidma_chan *mchan;
+	struct hidma_desc *tmp, *mdesc;
+	unsigned long irqflags;
+	LIST_HEAD(head);
+	LIST_HEAD(list);
+	int rc;
+
+	mchan = to_hidma_chan(chan);
+	dmadev = to_hidma_dev(mchan->chan.device);
+
+	pm_runtime_get_sync(dmadev->ddev.dev);
+	/* give completed requests a chance to finish */
+	hidma_process_completed(dmadev);
+
+	spin_lock_irqsave(&mchan->lock, irqflags);
+	list_splice_init(&mchan->active, &list);
+	list_splice_init(&mchan->prepared, &list);
+	list_splice_init(&mchan->completed, &list);
+	spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+	/* this suspends the existing transfer */
+	rc = hidma_ll_pause(dmadev->lldev);
+	if (rc) {
+		dev_err(dmadev->ddev.dev, "channel did not pause\n");
+		goto out;
+	}
+
+	/* return all user requests */
+	list_for_each_entry_safe(mdesc, tmp, &list, node) {
+		struct dma_async_tx_descriptor *txd = &mdesc->desc;
+		dma_async_tx_callback callback = mdesc->desc.callback;
+		void *param = mdesc->desc.callback_param;
+		enum dma_status status;
+
+		dma_descriptor_unmap(txd);
+
+		status = hidma_ll_status(dmadev->lldev, mdesc->tre_ch);
+		/*
+		 * The API requires that no submissions are done from a
+		 * callback, so we don't need to drop the lock here
+		 */
+		if (callback && (status == DMA_COMPLETE))
+			callback(param);
+
+		dma_run_dependencies(txd);
+
+		/* move myself to free_list */
+		list_move(&mdesc->node, &mchan->free);
+	}
+
+	/* reinitialize the hardware */
+	rc = hidma_ll_setup(dmadev->lldev);
+
+out:
+	pm_runtime_mark_last_busy(dmadev->ddev.dev);
+	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	return rc;
+}
+
+static int hidma_pause(struct dma_chan *chan)
+{
+	struct hidma_chan *mchan;
+	struct hidma_dev *dmadev;
+
+	mchan = to_hidma_chan(chan);
+	dmadev = to_hidma_dev(mchan->chan.device);
+	if (!mchan->paused) {
+		pm_runtime_get_sync(dmadev->ddev.dev);
+		if (hidma_ll_pause(dmadev->lldev))
+			dev_warn(dmadev->ddev.dev, "channel did not stop\n");
+		mchan->paused = true;
+		pm_runtime_mark_last_busy(dmadev->ddev.dev);
+		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	}
+	return 0;
+}
+
+static int hidma_resume(struct dma_chan *chan)
+{
+	struct hidma_chan *mchan;
+	struct hidma_dev *dmadev;
+	int rc = 0;
+
+	mchan = to_hidma_chan(chan);
+	dmadev = to_hidma_dev(mchan->chan.device);
+	if (mchan->paused) {
+		pm_runtime_get_sync(dmadev->ddev.dev);
+		rc = hidma_ll_resume(dmadev->lldev);
+		if (!rc)
+			mchan->paused = false;
+		else
+			dev_err(dmadev->ddev.dev,
+				"failed to resume the channel");
+		pm_runtime_mark_last_busy(dmadev->ddev.dev);
+		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	}
+	return rc;
+}
+
+static irqreturn_t hidma_chirq_handler(int chirq, void *arg)
+{
+	struct hidma_lldev **lldev_ptr = arg;
+
+	/*
+	 * All interrupts are request driven.
+	 * HW doesn't send an interrupt by itself.
+	 */
+	return hidma_ll_inthandler(chirq, *lldev_ptr);
+}
+
+static int hidma_probe(struct platform_device *pdev)
+{
+	struct hidma_dev *dmadev;
+	struct resource *trca_resource;
+	struct resource *evca_resource;
+	int chirq;
+	int current_channel_index = atomic_read(&channel_ref_count);
+	void __iomem *evca;
+	void __iomem *trca;
+	int rc;
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	trca_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	trca = devm_ioremap_resource(&pdev->dev, trca_resource);
+	if (IS_ERR(trca)) {
+		rc = -ENOMEM;
+		goto bailout;
+	}
+
+	evca_resource = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	evca = devm_ioremap_resource(&pdev->dev, evca_resource);
+	if (IS_ERR(evca)) {
+		rc = -ENOMEM;
+		goto bailout;
+	}
+
+	/*
+	 * This driver only handles the channel IRQs.
+	 * Common IRQ is handled by the management driver.
+	 */
+	chirq = platform_get_irq(pdev, 0);
+	if (chirq < 0) {
+		rc = -ENODEV;
+		goto bailout;
+	}
+
+	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev), GFP_KERNEL);
+	if (!dmadev) {
+		rc = -ENOMEM;
+		goto bailout;
+	}
+
+	INIT_LIST_HEAD(&dmadev->ddev.channels);
+	spin_lock_init(&dmadev->lock);
+	dmadev->ddev.dev = &pdev->dev;
+	pm_runtime_get_sync(dmadev->ddev.dev);
+
+	dma_cap_set(DMA_MEMCPY, dmadev->ddev.cap_mask);
+	if (WARN_ON(!pdev->dev.dma_mask)) {
+		rc = -ENXIO;
+		goto dmafree;
+	}
+
+	dmadev->dev_evca = evca;
+	dmadev->evca_resource = evca_resource;
+	dmadev->dev_trca = trca;
+	dmadev->trca_resource = trca_resource;
+	dmadev->ddev.device_prep_dma_memcpy = hidma_prep_dma_memcpy;
+	dmadev->ddev.device_alloc_chan_resources = hidma_alloc_chan_resources;
+	dmadev->ddev.device_free_chan_resources = hidma_free_chan_resources;
+	dmadev->ddev.device_tx_status = hidma_tx_status;
+	dmadev->ddev.device_issue_pending = hidma_issue_pending;
+	dmadev->ddev.device_pause = hidma_pause;
+	dmadev->ddev.device_resume = hidma_resume;
+	dmadev->ddev.device_terminate_all = hidma_terminate_all;
+	dmadev->ddev.copy_align = 8;
+
+	device_property_read_u32(&pdev->dev, "desc-count",
+				&dmadev->nr_descriptors);
+
+	if (!dmadev->nr_descriptors && nr_desc_prm)
+		dmadev->nr_descriptors = nr_desc_prm;
+
+	if (!dmadev->nr_descriptors) {
+		rc = -EINVAL;
+		goto dmafree;
+	}
+
+	if (current_channel_index > MAX_HIDMA_CHANNELS) {
+		rc = -EINVAL;
+		goto dmafree;
+	}
+
+	dmadev->evridx = -1;
+	device_property_read_u32(&pdev->dev, "event-channel", &dmadev->evridx);
+
+	/* kernel command line override for the guest machine */
+	if (event_channel_idx[current_channel_index] != -1)
+		dmadev->evridx = event_channel_idx[current_channel_index];
+
+	if (dmadev->evridx == -1) {
+		rc = -EINVAL;
+		goto dmafree;
+	}
+
+	/* Set DMA mask to 64 bits. */
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc) {
+		dev_warn(&pdev->dev, "unable to set coherent mask to 64");
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (rc)
+			goto dmafree;
+	}
+
+	dmadev->lldev = hidma_ll_init(dmadev->ddev.dev,
+				dmadev->nr_descriptors, dmadev->dev_trca,
+				dmadev->dev_evca, dmadev->evridx);
+	if (!dmadev->lldev) {
+		rc = -EPROBE_DEFER;
+		goto dmafree;
+	}
+
+	rc = devm_request_irq(&pdev->dev, chirq, hidma_chirq_handler, 0,
+			"qcom-hidma", &dmadev->lldev);
+	if (rc)
+		goto uninit;
+
+	INIT_LIST_HEAD(&dmadev->ddev.channels);
+	rc = hidma_chan_init(dmadev, 0);
+	if (rc)
+		goto uninit;
+
+	rc = dma_async_device_register(&dmadev->ddev);
+	if (rc)
+		goto uninit;
+
+	hidma_debug_init(dmadev);
+	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
+	platform_set_drvdata(pdev, dmadev);
+	pm_runtime_mark_last_busy(dmadev->ddev.dev);
+	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	atomic_inc(&channel_ref_count);
+	return 0;
+
+uninit:
+	hidma_debug_uninit(dmadev);
+	hidma_ll_uninit(dmadev->lldev);
+dmafree:
+	if (dmadev)
+		hidma_free(dmadev);
+bailout:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return rc;
+}
+
+static int hidma_remove(struct platform_device *pdev)
+{
+	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(dmadev->ddev.dev);
+	dma_async_device_unregister(&dmadev->ddev);
+	hidma_debug_uninit(dmadev);
+	hidma_ll_uninit(dmadev->lldev);
+	hidma_free(dmadev);
+
+	dev_info(&pdev->dev, "HI-DMA engine removed\n");
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id hidma_acpi_ids[] = {
+	{"QCOM8061"},
+	{},
+};
+#endif
+
+static const struct of_device_id hidma_match[] = {
+	{.compatible = "qcom,hidma-1.0",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hidma_match);
+
+static struct platform_driver hidma_driver = {
+	.probe = hidma_probe,
+	.remove = hidma_remove,
+	.driver = {
+		.name = "hidma",
+		.of_match_table = hidma_match,
+		.acpi_match_table = ACPI_PTR(hidma_acpi_ids),
+	},
+};
+
+module_platform_driver(hidma_driver);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
new file mode 100644
index 0000000..b2e6764
--- /dev/null
+++ b/drivers/dma/qcom/hidma.h
@@ -0,0 +1,157 @@
+/*
+ * Qualcomm Technologies HIDMA data structures
+ *
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef QCOM_HIDMA_H
+#define QCOM_HIDMA_H
+
+#include <linux/kfifo.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+
+#define TRE_SIZE			32 /* each TRE is 32 bytes  */
+#define TRE_CFG_IDX			0
+#define TRE_LEN_IDX			1
+#define TRE_SRC_LOW_IDX		2
+#define TRE_SRC_HI_IDX			3
+#define TRE_DEST_LOW_IDX		4
+#define TRE_DEST_HI_IDX		5
+
+struct hidma_tx_status {
+	u8 err_info;			/* error record in this transfer    */
+	u8 err_code;			/* completion code		    */
+};
+
+struct hidma_tre {
+	atomic_t allocated;		/* if this channel is allocated	    */
+	bool queued;			/* flag whether this is pending     */
+	u16 status;			/* status			    */
+	u32 chidx;			/* index of the tre	    */
+	u32 dma_sig;			/* signature of the tre	    */
+	const char *dev_name;		/* name of the device		    */
+	void (*callback)(void *data);	/* requester callback		    */
+	void *data;			/* Data associated with this channel*/
+	struct hidma_lldev *lldev;	/* lldma device pointer		    */
+	u32 tre_local[TRE_SIZE / sizeof(u32) + 1]; /* TRE local copy        */
+	u32 tre_index;			/* the offset where this was written*/
+	u32 int_flags;			/* interrupt flags*/
+};
+
+struct hidma_lldev {
+	bool initialized;		/* initialized flag               */
+	u8 trch_state;			/* trch_state of the device	  */
+	u8 evch_state;			/* evch_state of the device	  */
+	u8 evridx;			/* event channel to notify	  */
+	u32 nr_tres;			/* max number of configs          */
+	spinlock_t lock;		/* reentrancy                     */
+	struct hidma_tre *trepool;	/* trepool of user configs */
+	struct device *dev;		/* device			  */
+	void __iomem *trca;		/* Transfer Channel address       */
+	void __iomem *evca;		/* Event Channel address          */
+	struct hidma_tre
+		**pending_tre_list;	/* Pointers to pending TREs	  */
+	struct hidma_tx_status
+		*tx_status_list;	/* Pointers to pending TREs status*/
+	s32 pending_tre_count;		/* Number of TREs pending	  */
+
+	void *tre_ring;		/* TRE ring			  */
+	dma_addr_t tre_ring_handle;	/* TRE ring to be shared with HW  */
+	u32 tre_ring_size;		/* Byte size of the ring	  */
+	u32 tre_processed_off;		/* last processed TRE		   */
+
+	void *evre_ring;		/* EVRE ring			   */
+	dma_addr_t evre_ring_handle;	/* EVRE ring to be shared with HW  */
+	u32 evre_ring_size;		/* Byte size of the ring	  */
+	u32 evre_processed_off;	/* last processed EVRE		   */
+
+	u32 tre_write_offset;           /* TRE write location              */
+	struct tasklet_struct task;	/* task delivering notifications   */
+	DECLARE_KFIFO_PTR(handoff_fifo,
+		struct hidma_tre *);    /* pending TREs FIFO              */
+};
+
+struct hidma_desc {
+	struct dma_async_tx_descriptor	desc;
+	/* link list node for this channel*/
+	struct list_head		node;
+	u32				tre_ch;
+};
+
+struct hidma_chan {
+	bool				paused;
+	bool				allocated;
+	char				dbg_name[16];
+	u32				dma_sig;
+
+	/*
+	 * active descriptor on this channel
+	 * It is used by the DMA complete notification to
+	 * locate the descriptor that initiated the transfer.
+	 */
+	struct dentry			*debugfs;
+	struct dentry			*stats;
+	struct hidma_dev		*dmadev;
+
+	struct dma_chan			chan;
+	struct list_head		free;
+	struct list_head		prepared;
+	struct list_head		active;
+	struct list_head		completed;
+
+	/* Lock for this structure */
+	spinlock_t			lock;
+};
+
+struct hidma_dev {
+	int				evridx;
+	u32				nr_descriptors;
+
+	struct hidma_lldev		*lldev;
+	void				__iomem *dev_trca;
+	struct resource			*trca_resource;
+	void				__iomem *dev_evca;
+	struct resource			*evca_resource;
+
+	/* used to protect the pending channel list*/
+	spinlock_t			lock;
+	struct dma_device		ddev;
+
+	struct dentry			*debugfs;
+	struct dentry			*stats;
+};
+
+int hidma_ll_request(struct hidma_lldev *llhndl, u32 dev_id,
+			const char *dev_name,
+			void (*callback)(void *data), void *data, u32 *tre_ch);
+
+void hidma_ll_free(struct hidma_lldev *llhndl, u32 tre_ch);
+enum dma_status hidma_ll_status(struct hidma_lldev *llhndl, u32 tre_ch);
+bool hidma_ll_isenabled(struct hidma_lldev *llhndl);
+void hidma_ll_queue_request(struct hidma_lldev *llhndl, u32 tre_ch);
+void hidma_ll_start(struct hidma_lldev *llhndl);
+int hidma_ll_pause(struct hidma_lldev *llhndl);
+int hidma_ll_resume(struct hidma_lldev *llhndl);
+void hidma_ll_set_transfer_params(struct hidma_lldev *llhndl, u32 tre_ch,
+	dma_addr_t src, dma_addr_t dest, u32 len, u32 flags);
+int hidma_ll_setup(struct hidma_lldev *lldev);
+struct hidma_lldev *hidma_ll_init(struct device *dev, u32 max_channels,
+			void __iomem *trca, void __iomem *evca,
+			u8 evridx);
+int hidma_ll_uninit(struct hidma_lldev *llhndl);
+irqreturn_t hidma_ll_inthandler(int irq, void *arg);
+void hidma_cleanup_pending_tre(struct hidma_lldev *llhndl, u8 err_info,
+				u8 err_code);
+int hidma_debug_init(struct hidma_dev *dmadev);
+void hidma_debug_uninit(struct hidma_dev *dmadev);
+#endif
diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
new file mode 100644
index 0000000..a58af18
--- /dev/null
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -0,0 +1,217 @@
+/*
+ * Qualcomm Technologies HIDMA debug file
+ *
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/pm_runtime.h>
+
+#include "hidma.h"
+
+static void hidma_ll_chstats(struct seq_file *s, void *llhndl, u32 tre_ch)
+{
+	struct hidma_lldev *lldev = llhndl;
+	struct hidma_tre *tre;
+	u32 length;
+	dma_addr_t src_start;
+	dma_addr_t dest_start;
+	u32 *tre_local;
+
+	if (tre_ch >= lldev->nr_tres) {
+		dev_err(lldev->dev, "invalid TRE number in chstats:%d", tre_ch);
+		return;
+	}
+	tre = &lldev->trepool[tre_ch];
+	seq_printf(s, "------Channel %d -----\n", tre_ch);
+	seq_printf(s, "allocated=%d\n", atomic_read(&tre->allocated));
+	seq_printf(s, "queued = 0x%x\n", tre->queued);
+	seq_printf(s, "err_info = 0x%x\n",
+		lldev->tx_status_list[tre->chidx].err_info);
+	seq_printf(s, "err_code = 0x%x\n",
+		lldev->tx_status_list[tre->chidx].err_code);
+	seq_printf(s, "status = 0x%x\n", tre->status);
+	seq_printf(s, "chidx = 0x%x\n", tre->chidx);
+	seq_printf(s, "dma_sig = 0x%x\n", tre->dma_sig);
+	seq_printf(s, "dev_name=%s\n", tre->dev_name);
+	seq_printf(s, "callback=%p\n", tre->callback);
+	seq_printf(s, "data=%p\n", tre->data);
+	seq_printf(s, "tre_index = 0x%x\n", tre->tre_index);
+
+	tre_local = &tre->tre_local[0];
+	src_start = tre_local[TRE_SRC_LOW_IDX];
+	src_start = ((u64) (tre_local[TRE_SRC_HI_IDX]) << 32) + src_start;
+	dest_start = tre_local[TRE_DEST_LOW_IDX];
+	dest_start += ((u64) (tre_local[TRE_DEST_HI_IDX]) << 32);
+	length = tre_local[TRE_LEN_IDX];
+
+	seq_printf(s, "src=%pap\n", &src_start);
+	seq_printf(s, "dest=%pap\n", &dest_start);
+	seq_printf(s, "length = 0x%x\n", length);
+}
+
+static void hidma_ll_devstats(struct seq_file *s, void *llhndl)
+{
+	struct hidma_lldev *lldev = llhndl;
+
+	seq_puts(s, "------Device -----\n");
+	seq_printf(s, "lldev init = 0x%x\n", lldev->initialized);
+	seq_printf(s, "trch_state = 0x%x\n", lldev->trch_state);
+	seq_printf(s, "evch_state = 0x%x\n", lldev->evch_state);
+	seq_printf(s, "evridx = 0x%x\n", lldev->evridx);
+	seq_printf(s, "nr_tres = 0x%x\n", lldev->nr_tres);
+	seq_printf(s, "trca=%p\n", lldev->trca);
+	seq_printf(s, "tre_ring=%p\n", lldev->tre_ring);
+	seq_printf(s, "tre_ring_handle=%pap\n", &lldev->tre_ring_handle);
+	seq_printf(s, "tre_ring_size = 0x%x\n", lldev->tre_ring_size);
+	seq_printf(s, "tre_processed_off = 0x%x\n", lldev->tre_processed_off);
+	seq_printf(s, "pending_tre_count=%d\n", lldev->pending_tre_count);
+	seq_printf(s, "evca=%p\n", lldev->evca);
+	seq_printf(s, "evre_ring=%p\n", lldev->evre_ring);
+	seq_printf(s, "evre_ring_handle=%pap\n", &lldev->evre_ring_handle);
+	seq_printf(s, "evre_ring_size = 0x%x\n", lldev->evre_ring_size);
+	seq_printf(s, "evre_processed_off = 0x%x\n", lldev->evre_processed_off);
+	seq_printf(s, "tre_write_offset = 0x%x\n", lldev->tre_write_offset);
+}
+
+/*
+ * hidma_chan_stats: display HIDMA channel statistics
+ *
+ * Display the statistics for the current HIDMA virtual channel device.
+ */
+static int hidma_chan_stats(struct seq_file *s, void *unused)
+{
+	struct hidma_chan *mchan = s->private;
+	struct hidma_desc *mdesc;
+	struct hidma_dev *dmadev = mchan->dmadev;
+
+	pm_runtime_get_sync(dmadev->ddev.dev);
+	seq_printf(s, "paused=%u\n", mchan->paused);
+	seq_printf(s, "dma_sig=%u\n", mchan->dma_sig);
+	seq_puts(s, "prepared\n");
+	list_for_each_entry(mdesc, &mchan->prepared, node)
+		hidma_ll_chstats(s, mchan->dmadev->lldev, mdesc->tre_ch);
+
+	seq_puts(s, "active\n");
+	list_for_each_entry(mdesc, &mchan->active, node)
+		hidma_ll_chstats(s, mchan->dmadev->lldev, mdesc->tre_ch);
+
+	seq_puts(s, "completed\n");
+	list_for_each_entry(mdesc, &mchan->completed, node)
+		hidma_ll_chstats(s, mchan->dmadev->lldev, mdesc->tre_ch);
+
+	hidma_ll_devstats(s, mchan->dmadev->lldev);
+	pm_runtime_mark_last_busy(dmadev->ddev.dev);
+	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	return 0;
+}
+
+/*
+ * hidma_dma_info: display HIDMA device info
+ *
+ * Display the info for the current HIDMA device.
+ */
+static int hidma_dma_info(struct seq_file *s, void *unused)
+{
+	struct hidma_dev *dmadev = s->private;
+	resource_size_t sz;
+
+	seq_printf(s, "nr_descriptors=%d\n", dmadev->nr_descriptors);
+	seq_printf(s, "dev_trca=%p\n", &dmadev->dev_trca);
+	seq_printf(s, "dev_trca_phys=%pa\n", &dmadev->trca_resource->start);
+	sz = resource_size(dmadev->trca_resource);
+	seq_printf(s, "dev_trca_size=%pa\n", &sz);
+	seq_printf(s, "dev_evca=%p\n", &dmadev->dev_evca);
+	seq_printf(s, "dev_evca_phys=%pa\n", &dmadev->evca_resource->start);
+	sz = resource_size(dmadev->evca_resource);
+	seq_printf(s, "dev_evca_size=%pa\n", &sz);
+	return 0;
+}
+
+static int hidma_chan_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hidma_chan_stats, inode->i_private);
+}
+
+static int hidma_dma_info_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hidma_dma_info, inode->i_private);
+}
+
+static const struct file_operations hidma_chan_fops = {
+	.open = hidma_chan_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static const struct file_operations hidma_dma_fops = {
+	.open = hidma_dma_info_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+void hidma_debug_uninit(struct hidma_dev *dmadev)
+{
+	debugfs_remove_recursive(dmadev->debugfs);
+	debugfs_remove_recursive(dmadev->stats);
+}
+
+int hidma_debug_init(struct hidma_dev *dmadev)
+{
+	int rc = 0;
+	int chidx = 0;
+	struct list_head *position = NULL;
+
+	dmadev->debugfs = debugfs_create_dir(dev_name(dmadev->ddev.dev), NULL);
+	if (!dmadev->debugfs) {
+		rc = -ENODEV;
+		return rc;
+	}
+
+	/* walk through the virtual channel list */
+	list_for_each(position, &dmadev->ddev.channels) {
+		struct hidma_chan *chan;
+
+		chan = list_entry(position, struct hidma_chan,
+				chan.device_node);
+		sprintf(chan->dbg_name, "chan%d", chidx);
+		chan->debugfs = debugfs_create_dir(chan->dbg_name,
+					dmadev->debugfs);
+		if (!chan->debugfs) {
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		chan->stats = debugfs_create_file("stats", S_IRUGO,
+					chan->debugfs, chan, &hidma_chan_fops);
+		if (!chan->stats) {
+			rc = -ENOMEM;
+			goto cleanup;
+		}
+		chidx++;
+	}
+
+	dmadev->stats = debugfs_create_file("stats", S_IRUGO,
+				dmadev->debugfs, dmadev, &hidma_dma_fops);
+	if (!dmadev->stats) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	return 0;
+cleanup:
+	hidma_debug_uninit(dmadev);
+	return rc;
+}
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
new file mode 100644
index 0000000..59621f7
--- /dev/null
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -0,0 +1,924 @@
+/*
+ * Qualcomm Technologies HIDMA DMA engine low level code
+ *
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/dmaengine.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/atomic.h>
+#include <linux/iopoll.h>
+#include <linux/kfifo.h>
+
+#include "hidma.h"
+
+#define EVRE_SIZE			16	/* each EVRE is 16 bytes */
+
+#define TRCA_CTRLSTS_OFFSET		0x0
+#define TRCA_RING_LOW_OFFSET		0x8
+#define TRCA_RING_HIGH_OFFSET		0xC
+#define TRCA_RING_LEN_OFFSET		0x10
+#define TRCA_READ_PTR_OFFSET		0x18
+#define TRCA_WRITE_PTR_OFFSET		0x20
+#define TRCA_DOORBELL_OFFSET		0x400
+
+#define EVCA_CTRLSTS_OFFSET		0x0
+#define EVCA_INTCTRL_OFFSET		0x4
+#define EVCA_RING_LOW_OFFSET		0x8
+#define EVCA_RING_HIGH_OFFSET		0xC
+#define EVCA_RING_LEN_OFFSET		0x10
+#define EVCA_READ_PTR_OFFSET		0x18
+#define EVCA_WRITE_PTR_OFFSET		0x20
+#define EVCA_DOORBELL_OFFSET		0x400
+
+#define EVCA_IRQ_STAT_OFFSET		0x100
+#define EVCA_IRQ_CLR_OFFSET		0x108
+#define EVCA_IRQ_EN_OFFSET		0x110
+
+#define EVRE_CFG_IDX			0
+#define EVRE_LEN_IDX			1
+#define EVRE_DEST_LOW_IDX		2
+#define EVRE_DEST_HI_IDX		3
+
+#define EVRE_ERRINFO_BIT_POS		24
+#define EVRE_CODE_BIT_POS		28
+
+#define EVRE_ERRINFO_MASK		0xF
+#define EVRE_CODE_MASK			0xF
+
+#define CH_CONTROL_MASK		0xFF
+#define CH_STATE_MASK			0xFF
+#define CH_STATE_BIT_POS		0x8
+
+#define MAKE64(high, low) (((u64)(high) << 32) | (low))
+
+#define IRQ_EV_CH_EOB_IRQ_BIT_POS	0
+#define IRQ_EV_CH_WR_RESP_BIT_POS	1
+#define IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS 9
+#define IRQ_TR_CH_DATA_RD_ER_BIT_POS	10
+#define IRQ_TR_CH_DATA_WR_ER_BIT_POS	11
+#define IRQ_TR_CH_INVALID_TRE_BIT_POS	14
+
+#define	ENABLE_IRQS (BIT(IRQ_EV_CH_EOB_IRQ_BIT_POS) | \
+		BIT(IRQ_EV_CH_WR_RESP_BIT_POS) | \
+		BIT(IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS) |	 \
+		BIT(IRQ_TR_CH_DATA_RD_ER_BIT_POS) |		 \
+		BIT(IRQ_TR_CH_DATA_WR_ER_BIT_POS) |		 \
+		BIT(IRQ_TR_CH_INVALID_TRE_BIT_POS))
+
+enum ch_command {
+	CH_DISABLE = 0,
+	CH_ENABLE = 1,
+	CH_SUSPEND = 2,
+	CH_RESET = 9,
+};
+
+enum ch_state {
+	CH_DISABLED = 0,
+	CH_ENABLED = 1,
+	CH_RUNNING = 2,
+	CH_SUSPENDED = 3,
+	CH_STOPPED = 4,
+	CH_ERROR = 5,
+	CH_IN_RESET = 9,
+};
+
+enum tre_type {
+	TRE_MEMCPY = 3,
+	TRE_MEMSET = 4,
+};
+
+enum evre_type {
+	EVRE_DMA_COMPLETE = 0x23,
+	EVRE_IMM_DATA = 0x24,
+};
+
+enum err_code {
+	EVRE_STATUS_COMPLETE = 1,
+	EVRE_STATUS_ERROR = 4,
+};
+
+void hidma_ll_free(struct hidma_lldev *lldev, u32 tre_ch)
+{
+	struct hidma_tre *tre;
+
+	if (tre_ch >= lldev->nr_tres) {
+		dev_err(lldev->dev, "invalid TRE number in free:%d", tre_ch);
+		return;
+	}
+
+	tre = &lldev->trepool[tre_ch];
+	if (atomic_read(&tre->allocated) != true) {
+		dev_err(lldev->dev, "trying to free an unused TRE:%d", tre_ch);
+		return;
+	}
+
+	atomic_set(&tre->allocated, 0);
+}
+
+int hidma_ll_request(struct hidma_lldev *lldev, u32 dma_sig,
+		const char *dev_name,
+		void (*callback)(void *data), void *data, u32 *tre_ch)
+{
+	unsigned int i;
+	struct hidma_tre *tre;
+	u32 *tre_local;
+
+	if (!tre_ch || !lldev)
+		return -EINVAL;
+
+	/* need to have at least one empty spot in the queue */
+	for (i = 0; i < lldev->nr_tres - 1; i++) {
+		if (atomic_add_unless(&lldev->trepool[i].allocated, 1, 1))
+			break;
+	}
+
+	if (i == (lldev->nr_tres - 1))
+		return -ENOMEM;
+
+	tre = &lldev->trepool[i];
+	tre->dma_sig = dma_sig;
+	tre->dev_name = dev_name;
+	tre->callback = callback;
+	tre->data = data;
+	tre->chidx = i;
+	tre->status = 0;
+	tre->queued = 0;
+	lldev->tx_status_list[i].err_code = 0;
+	tre->lldev = lldev;
+	tre_local = &tre->tre_local[0];
+	tre_local[TRE_CFG_IDX] = TRE_MEMCPY;
+	tre_local[TRE_CFG_IDX] |= (lldev->evridx & 0xFF) << 8;
+	tre_local[TRE_CFG_IDX] |= BIT(16);	/* set IEOB */
+	*tre_ch = i;
+	if (callback)
+		callback(data);
+	return 0;
+}
+
+/*
+ * Multiple TREs may be queued and waiting in the
+ * pending queue.
+ */
+static void hidma_ll_tre_complete(unsigned long arg)
+{
+	struct hidma_lldev *lldev = (struct hidma_lldev *)arg;
+	struct hidma_tre *tre;
+
+	while (kfifo_out(&lldev->handoff_fifo, &tre, 1)) {
+		/* call the user if it has been read by the hardware */
+		if (tre->callback)
+			tre->callback(tre->data);
+	}
+}
+
+/*
+ * Called to handle the interrupt for the channel.
+ * Return a positive number if TRE or EVRE were consumed on this run.
+ * Return a positive number if there are pending TREs or EVREs.
+ * Return 0 if there is nothing to consume or no pending TREs/EVREs found.
+ */
+static int hidma_handle_tre_completion(struct hidma_lldev *lldev)
+{
+	struct hidma_tre *tre;
+	u32 evre_write_off;
+	u32 evre_ring_size = lldev->evre_ring_size;
+	u32 tre_ring_size = lldev->tre_ring_size;
+	u32 num_completed = 0, tre_iterator, evre_iterator;
+	unsigned long flags;
+
+	evre_write_off = readl_relaxed(lldev->evca + EVCA_WRITE_PTR_OFFSET);
+	tre_iterator = lldev->tre_processed_off;
+	evre_iterator = lldev->evre_processed_off;
+
+	if ((evre_write_off > evre_ring_size) ||
+		((evre_write_off % EVRE_SIZE) != 0)) {
+		dev_err(lldev->dev, "HW reports invalid EVRE write offset\n");
+		return 0;
+	}
+
+	/*
+	 * By the time control reaches here the number of EVREs and TREs
+	 * may not match. Only consume the ones that hardware told us.
+	 */
+	while ((evre_iterator != evre_write_off)) {
+		u32 *current_evre = lldev->evre_ring + evre_iterator;
+		u32 cfg;
+		u8 err_info;
+
+		spin_lock_irqsave(&lldev->lock, flags);
+		tre = lldev->pending_tre_list[tre_iterator / TRE_SIZE];
+		if (!tre) {
+			spin_unlock_irqrestore(&lldev->lock, flags);
+			dev_warn(lldev->dev,
+				"tre_index [%d] and tre out of sync\n",
+				tre_iterator / TRE_SIZE);
+			tre_iterator += TRE_SIZE;
+			if (tre_iterator >= tre_ring_size)
+				tre_iterator -= tre_ring_size;
+			evre_iterator += EVRE_SIZE;
+			if (evre_iterator >= evre_ring_size)
+				evre_iterator -= evre_ring_size;
+
+			continue;
+		}
+		lldev->pending_tre_list[tre->tre_index] = NULL;
+
+		/*
+		 * Keep track of pending TREs that SW is expecting to receive
+		 * from HW. We got one now. Decrement our counter.
+		 */
+		lldev->pending_tre_count--;
+		if (lldev->pending_tre_count < 0) {
+			dev_warn(lldev->dev,
+				"tre count mismatch on completion");
+			lldev->pending_tre_count = 0;
+		}
+
+		spin_unlock_irqrestore(&lldev->lock, flags);
+
+		cfg = current_evre[EVRE_CFG_IDX];
+		err_info = (cfg >> EVRE_ERRINFO_BIT_POS);
+		err_info &= EVRE_ERRINFO_MASK;
+		lldev->tx_status_list[tre->chidx].err_info = err_info;
+		lldev->tx_status_list[tre->chidx].err_code =
+			(cfg >> EVRE_CODE_BIT_POS) & EVRE_CODE_MASK;
+		tre->queued = 0;
+
+		kfifo_put(&lldev->handoff_fifo, tre);
+		tasklet_schedule(&lldev->task);
+
+		tre_iterator += TRE_SIZE;
+		if (tre_iterator >= tre_ring_size)
+			tre_iterator -= tre_ring_size;
+		evre_iterator += EVRE_SIZE;
+		if (evre_iterator >= evre_ring_size)
+			evre_iterator -= evre_ring_size;
+
+		/*
+		 * Read the new event descriptor written by the HW.
+		 * As we are processing the delivered events, other events
+		 * get queued to the SW for processing.
+		 */
+		evre_write_off =
+			readl_relaxed(lldev->evca + EVCA_WRITE_PTR_OFFSET);
+		num_completed++;
+	}
+
+	if (num_completed) {
+		u32 evre_read_off = (lldev->evre_processed_off +
+				EVRE_SIZE * num_completed);
+		u32 tre_read_off = (lldev->tre_processed_off +
+				TRE_SIZE * num_completed);
+
+		evre_read_off = evre_read_off % evre_ring_size;
+		tre_read_off = tre_read_off % tre_ring_size;
+
+		writel(evre_read_off, lldev->evca + EVCA_DOORBELL_OFFSET);
+
+		/* record the last processed tre offset */
+		lldev->tre_processed_off = tre_read_off;
+		lldev->evre_processed_off = evre_read_off;
+	}
+
+	return num_completed;
+}
+
+void hidma_cleanup_pending_tre(struct hidma_lldev *lldev, u8 err_info,
+				u8 err_code)
+{
+	u32 tre_iterator;
+	struct hidma_tre *tre;
+	u32 tre_ring_size = lldev->tre_ring_size;
+	int num_completed = 0;
+	u32 tre_read_off;
+	unsigned long flags;
+
+	tre_iterator = lldev->tre_processed_off;
+	while (lldev->pending_tre_count) {
+		int tre_index = tre_iterator / TRE_SIZE;
+
+		spin_lock_irqsave(&lldev->lock, flags);
+		tre = lldev->pending_tre_list[tre_index];
+		if (!tre) {
+			spin_unlock_irqrestore(&lldev->lock, flags);
+			tre_iterator += TRE_SIZE;
+			if (tre_iterator >= tre_ring_size)
+				tre_iterator -= tre_ring_size;
+			continue;
+		}
+		lldev->pending_tre_list[tre_index] = NULL;
+		lldev->pending_tre_count--;
+		if (lldev->pending_tre_count < 0) {
+			dev_warn(lldev->dev,
+				"tre count mismatch on completion");
+			lldev->pending_tre_count = 0;
+		}
+		spin_unlock_irqrestore(&lldev->lock, flags);
+
+		lldev->tx_status_list[tre->chidx].err_info = err_info;
+		lldev->tx_status_list[tre->chidx].err_code = err_code;
+		tre->queued = 0;
+
+		kfifo_put(&lldev->handoff_fifo, tre);
+		tasklet_schedule(&lldev->task);
+
+		tre_iterator += TRE_SIZE;
+		if (tre_iterator >= tre_ring_size)
+			tre_iterator -= tre_ring_size;
+
+		num_completed++;
+	}
+	tre_read_off = (lldev->tre_processed_off + TRE_SIZE * num_completed);
+
+	tre_read_off = tre_read_off % tre_ring_size;
+
+	/* record the last processed tre offset */
+	lldev->tre_processed_off = tre_read_off;
+}
+
+static int hidma_ll_reset(struct hidma_lldev *lldev)
+{
+	u32 val;
+	int ret;
+
+	val = readl(lldev->trca + TRCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_RESET << 16;
+	writel(val, lldev->trca + TRCA_CTRLSTS_OFFSET);
+
+	/*
+	 * Delay 10ms after reset to allow DMA logic to quiesce.
+	 * Do a polled read up to 1ms and 10ms maximum.
+	 */
+	ret = readl_poll_timeout(lldev->trca + TRCA_CTRLSTS_OFFSET, val,
+		(((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_DISABLED),
+		1000, 10000);
+	if (ret) {
+		dev_err(lldev->dev, "transfer channel did not reset\n");
+		return ret;
+	}
+
+	val = readl(lldev->evca + EVCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_RESET << 16;
+	writel(val, lldev->evca + EVCA_CTRLSTS_OFFSET);
+
+	/*
+	 * Delay 10ms after reset to allow DMA logic to quiesce.
+	 * Do a polled read up to 1ms and 10ms maximum.
+	 */
+	ret = readl_poll_timeout(lldev->evca + EVCA_CTRLSTS_OFFSET, val,
+		(((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_DISABLED),
+		1000, 10000);
+	if (ret)
+		return ret;
+
+	lldev->trch_state = CH_DISABLED;
+	lldev->evch_state = CH_DISABLED;
+	return 0;
+}
+
+static void hidma_ll_enable_irq(struct hidma_lldev *lldev, u32 irq_bits)
+{
+	writel(irq_bits, lldev->evca + EVCA_IRQ_EN_OFFSET);
+}
+
+/*
+ * The interrupt handler for HIDMA will try to consume as many pending
+ * EVRE from the event queue as possible. Each EVRE has an associated
+ * TRE that holds the user interface parameters. EVRE reports the
+ * result of the transaction. Hardware guarantees ordering between EVREs
+ * and TREs. We use last processed offset to figure out which TRE is
+ * associated with which EVRE. If two TREs are consumed by HW, the EVREs
+ * are in order in the event ring.
+ *
+ * This handler will do a one pass for consuming EVREs. Other EVREs may
+ * be delivered while we are working. It will try to consume incoming
+ * EVREs one more time and return.
+ *
+ * For unprocessed EVREs, hardware will trigger another interrupt until
+ * all the interrupt bits are cleared.
+ *
+ * Hardware guarantees that by the time interrupt is observed, all data
+ * transactions in flight are delivered to their respective places and
+ * are visible to the CPU.
+ *
+ * On demand paging for IOMMU is only supported for PCIe via PRI
+ * (Page Request Interface) not for HIDMA. All other hardware instances
+ * including HIDMA work on pinned DMA addresses.
+ *
+ * HIDMA is not aware of IOMMU presence since it follows the DMA API. All
+ * IOMMU latency will be built into the data movement time. By the time
+ * interrupt happens, IOMMU lookups + data movement has already taken place.
+ *
+ * While the first read in a typical PCI endpoint ISR flushes all outstanding
+ * requests traditionally to the destination, this concept does not apply
+ * here for this HW.
+ */
+static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev)
+{
+	u32 status;
+	u32 enable;
+	u32 cause;
+	int repeat = 2;
+	unsigned long timeout;
+
+	/*
+	 * Fine tuned for this HW...
+	 *
+	 * This ISR has been designed for this particular hardware. Relaxed
+	 * read and write accessors are used for performance reasons due to
+	 * interrupt delivery guarantees. Do not copy this code blindly and
+	 * expect that to work.
+	 */
+	status = readl_relaxed(lldev->evca + EVCA_IRQ_STAT_OFFSET);
+	enable = readl_relaxed(lldev->evca + EVCA_IRQ_EN_OFFSET);
+	cause = status & enable;
+
+	if ((cause & (BIT(IRQ_TR_CH_INVALID_TRE_BIT_POS))) ||
+		(cause & BIT(IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS)) ||
+		(cause & BIT(IRQ_EV_CH_WR_RESP_BIT_POS)) ||
+		(cause & BIT(IRQ_TR_CH_DATA_RD_ER_BIT_POS)) ||
+		(cause & BIT(IRQ_TR_CH_DATA_WR_ER_BIT_POS))) {
+		u8 err_code = EVRE_STATUS_ERROR;
+		u8 err_info = 0xFF;
+
+		/* Clear out pending interrupts */
+		writel(cause, lldev->evca + EVCA_IRQ_CLR_OFFSET);
+
+		dev_err(lldev->dev, "error 0x%x, resetting...\n", cause);
+
+		hidma_cleanup_pending_tre(lldev, err_info, err_code);
+
+		/* reset the channel for recovery */
+		if (hidma_ll_setup(lldev)) {
+			dev_err(lldev->dev,
+				"channel reinitialize failed after error\n");
+			return;
+		}
+		hidma_ll_enable_irq(lldev, ENABLE_IRQS);
+		return;
+	}
+
+	/*
+	 * Try to consume as many EVREs as possible.
+	 * skip this loop if the interrupt is spurious.
+	 */
+	while (cause && repeat) {
+		unsigned long start = jiffies;
+
+		/* This timeout should be sufficent for core to finish */
+		timeout = start + msecs_to_jiffies(500);
+
+		while (lldev->pending_tre_count) {
+			hidma_handle_tre_completion(lldev);
+			if (time_is_before_jiffies(timeout)) {
+				dev_warn(lldev->dev,
+					"ISR timeout %lx-%lx from %lx [%d]\n",
+					jiffies, timeout, start,
+					lldev->pending_tre_count);
+				break;
+			}
+		}
+
+		/* We consumed TREs or there are pending TREs or EVREs. */
+		writel_relaxed(cause, lldev->evca + EVCA_IRQ_CLR_OFFSET);
+
+		/*
+		 * Another interrupt might have arrived while we are
+		 * processing this one. Read the new cause.
+		 */
+		status = readl_relaxed(lldev->evca + EVCA_IRQ_STAT_OFFSET);
+		enable = readl_relaxed(lldev->evca + EVCA_IRQ_EN_OFFSET);
+		cause = status & enable;
+
+		repeat--;
+	}
+}
+
+static int hidma_ll_enable(struct hidma_lldev *lldev)
+{
+	u32 val;
+	int ret;
+
+	val = readl(lldev->evca + EVCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_ENABLE << 16;
+	writel(val, lldev->evca + EVCA_CTRLSTS_OFFSET);
+
+	ret = readl_poll_timeout(lldev->evca + EVCA_CTRLSTS_OFFSET, val,
+		((((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_ENABLED)
+		||
+		(((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_RUNNING)),
+		1000, 10000);
+	if (ret) {
+		dev_err(lldev->dev, "event channel did not get enabled\n");
+		return ret;
+	}
+
+	val = readl(lldev->trca + TRCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_ENABLE << 16;
+	writel(val, lldev->trca + TRCA_CTRLSTS_OFFSET);
+
+	ret = readl_poll_timeout(lldev->trca + TRCA_CTRLSTS_OFFSET, val,
+		((((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_ENABLED)
+		||
+		(((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_RUNNING)),
+		1000, 10000);
+	if (ret) {
+		dev_err(lldev->dev, "transfer channel did not get enabled\n");
+		return ret;
+	}
+
+	lldev->trch_state = CH_ENABLED;
+	lldev->evch_state = CH_ENABLED;
+
+	return 0;
+}
+
+int hidma_ll_resume(struct hidma_lldev *lldev)
+{
+	return hidma_ll_enable(lldev);
+}
+
+static void hidma_ll_hw_start(struct hidma_lldev *lldev)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&lldev->lock, irqflags);
+	writel(lldev->tre_write_offset, lldev->trca + TRCA_DOORBELL_OFFSET);
+	spin_unlock_irqrestore(&lldev->lock, irqflags);
+}
+
+bool hidma_ll_isenabled(struct hidma_lldev *lldev)
+{
+	u32 val;
+
+	val = readl(lldev->trca + TRCA_CTRLSTS_OFFSET);
+	lldev->trch_state = (val >> CH_STATE_BIT_POS) & CH_STATE_MASK;
+	val = readl(lldev->evca + EVCA_CTRLSTS_OFFSET);
+	lldev->evch_state = (val >> CH_STATE_BIT_POS) & CH_STATE_MASK;
+
+	/* both channels have to be enabled before calling this function */
+	if (((lldev->trch_state == CH_ENABLED) ||
+		(lldev->trch_state == CH_RUNNING)) &&
+		((lldev->evch_state == CH_ENABLED) ||
+		(lldev->evch_state == CH_RUNNING)))
+		return true;
+
+	return false;
+}
+
+void hidma_ll_queue_request(struct hidma_lldev *lldev, u32 tre_ch)
+{
+	struct hidma_tre *tre;
+	unsigned long flags;
+
+	tre = &lldev->trepool[tre_ch];
+
+	/* copy the TRE into its location in the TRE ring */
+	spin_lock_irqsave(&lldev->lock, flags);
+	tre->tre_index = lldev->tre_write_offset / TRE_SIZE;
+	lldev->pending_tre_list[tre->tre_index] = tre;
+	memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
+		TRE_SIZE);
+	lldev->tx_status_list[tre->chidx].err_code = 0;
+	lldev->tx_status_list[tre->chidx].err_info = 0;
+	tre->queued = 1;
+	lldev->pending_tre_count++;
+	lldev->tre_write_offset = (lldev->tre_write_offset + TRE_SIZE)
+				% lldev->tre_ring_size;
+	spin_unlock_irqrestore(&lldev->lock, flags);
+}
+
+void hidma_ll_start(struct hidma_lldev *lldev)
+{
+	hidma_ll_hw_start(lldev);
+}
+
+/*
+ * Note that even though we stop this channel
+ * if there is a pending transaction in flight
+ * it will complete and follow the callback.
+ * This request will prevent further requests
+ * to be made.
+ */
+int hidma_ll_pause(struct hidma_lldev *lldev)
+{
+	u32 val;
+	int ret;
+
+	val = readl(lldev->evca + EVCA_CTRLSTS_OFFSET);
+	lldev->evch_state = (val >> CH_STATE_BIT_POS) & CH_STATE_MASK;
+	val = readl(lldev->trca + TRCA_CTRLSTS_OFFSET);
+	lldev->trch_state = (val >> CH_STATE_BIT_POS) & CH_STATE_MASK;
+
+	/* already suspended by this OS */
+	if ((lldev->trch_state == CH_SUSPENDED) ||
+		(lldev->evch_state == CH_SUSPENDED))
+		return 0;
+
+	/* already stopped by the manager */
+	if ((lldev->trch_state == CH_STOPPED) ||
+		(lldev->evch_state == CH_STOPPED))
+		return 0;
+
+	val = readl(lldev->trca + TRCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_SUSPEND << 16;
+	writel(val, lldev->trca + TRCA_CTRLSTS_OFFSET);
+
+	/*
+	 * Start the wait right after the suspend is confirmed.
+	 * Do a polled read up to 1ms and 10ms maximum.
+	 */
+	ret = readl_poll_timeout(lldev->trca + TRCA_CTRLSTS_OFFSET, val,
+		(((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_SUSPENDED),
+		1000, 10000);
+	if (ret)
+		return ret;
+
+	val = readl(lldev->evca + EVCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_SUSPEND << 16;
+	writel(val, lldev->evca + EVCA_CTRLSTS_OFFSET);
+
+	/*
+	 * Start the wait right after the suspend is confirmed
+	 * Delay up to 10ms after reset to allow DMA logic to quiesce.
+	 */
+	ret = readl_poll_timeout(lldev->evca + EVCA_CTRLSTS_OFFSET, val,
+		(((val >> CH_STATE_BIT_POS) & CH_STATE_MASK) == CH_SUSPENDED),
+		1000, 10000);
+	if (ret)
+		return ret;
+
+	lldev->trch_state = CH_SUSPENDED;
+	lldev->evch_state = CH_SUSPENDED;
+	return 0;
+}
+
+void hidma_ll_set_transfer_params(struct hidma_lldev *lldev, u32 tre_ch,
+				dma_addr_t src, dma_addr_t dest, u32 len,
+				u32 flags)
+{
+	struct hidma_tre *tre;
+	u32 *tre_local;
+
+	if (tre_ch >= lldev->nr_tres) {
+		dev_err(lldev->dev,
+			"invalid TRE number in transfer params:%d", tre_ch);
+		return;
+	}
+
+	tre = &lldev->trepool[tre_ch];
+	if (atomic_read(&tre->allocated) != true) {
+		dev_err(lldev->dev,
+			"trying to set params on an unused TRE:%d", tre_ch);
+		return;
+	}
+
+	tre_local = &tre->tre_local[0];
+	tre_local[TRE_LEN_IDX] = len;
+	tre_local[TRE_SRC_LOW_IDX] = lower_32_bits(src);
+	tre_local[TRE_SRC_HI_IDX] = upper_32_bits(src);
+	tre_local[TRE_DEST_LOW_IDX] = lower_32_bits(dest);
+	tre_local[TRE_DEST_HI_IDX] = upper_32_bits(dest);
+	tre->int_flags = flags;
+}
+
+/*
+ * Called during initialization and after an error condition
+ * to restore hardware state.
+ */
+int hidma_ll_setup(struct hidma_lldev *lldev)
+{
+	int rc;
+	u64 addr;
+	u32 val;
+	u32 nr_tres = lldev->nr_tres;
+
+	lldev->pending_tre_count = 0;
+	lldev->tre_processed_off = 0;
+	lldev->evre_processed_off = 0;
+	lldev->tre_write_offset = 0;
+
+	/* disable interrupts */
+	hidma_ll_enable_irq(lldev, 0);
+
+	/* clear all pending interrupts */
+	val = readl(lldev->evca + EVCA_IRQ_STAT_OFFSET);
+	writel(val, lldev->evca + EVCA_IRQ_CLR_OFFSET);
+
+	rc = hidma_ll_reset(lldev);
+	if (rc)
+		return rc;
+
+	/*
+	 * Clear all pending interrupts again.
+	 * Otherwise, we observe reset complete interrupts.
+	 */
+	val = readl(lldev->evca + EVCA_IRQ_STAT_OFFSET);
+	writel(val, lldev->evca + EVCA_IRQ_CLR_OFFSET);
+
+	/* disable interrupts again after reset */
+	hidma_ll_enable_irq(lldev, 0);
+
+	addr = lldev->tre_ring_handle;
+	writel(lower_32_bits(addr), lldev->trca + TRCA_RING_LOW_OFFSET);
+	writel(upper_32_bits(addr), lldev->trca + TRCA_RING_HIGH_OFFSET);
+	writel(lldev->tre_ring_size, lldev->trca + TRCA_RING_LEN_OFFSET);
+
+	addr = lldev->evre_ring_handle;
+	writel(lower_32_bits(addr), lldev->evca + EVCA_RING_LOW_OFFSET);
+	writel(upper_32_bits(addr), lldev->evca + EVCA_RING_HIGH_OFFSET);
+	writel(EVRE_SIZE * nr_tres, lldev->evca + EVCA_RING_LEN_OFFSET);
+
+	/* support IRQ only for now */
+	val = readl(lldev->evca + EVCA_INTCTRL_OFFSET);
+	val &= ~0xF;
+	val |= 0x1;
+	writel(val, lldev->evca + EVCA_INTCTRL_OFFSET);
+
+	/* clear all pending interrupts and enable them */
+	writel(ENABLE_IRQS, lldev->evca + EVCA_IRQ_CLR_OFFSET);
+	hidma_ll_enable_irq(lldev, ENABLE_IRQS);
+
+	rc = hidma_ll_enable(lldev);
+	if (rc)
+		return rc;
+
+	return rc;
+}
+
+struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
+				void __iomem *trca, void __iomem *evca,
+				u8 evridx)
+{
+	u32 required_bytes;
+	struct hidma_lldev *lldev;
+	int rc;
+
+	if (!trca || !evca || !dev || !nr_tres)
+		return NULL;
+
+	/* need at least four TREs */
+	if (nr_tres < 4)
+		return NULL;
+
+	/* need an extra space */
+	nr_tres += 1;
+
+	lldev = devm_kzalloc(dev, sizeof(struct hidma_lldev), GFP_KERNEL);
+	if (!lldev)
+		return NULL;
+
+	lldev->evca = evca;
+	lldev->trca = trca;
+	lldev->dev = dev;
+	required_bytes = sizeof(struct hidma_tre) * nr_tres;
+	lldev->trepool = devm_kzalloc(lldev->dev, required_bytes, GFP_KERNEL);
+	if (!lldev->trepool)
+		return NULL;
+
+	required_bytes = sizeof(lldev->pending_tre_list[0]) * nr_tres;
+	lldev->pending_tre_list = devm_kzalloc(dev, required_bytes, GFP_KERNEL);
+	if (!lldev->pending_tre_list)
+		return NULL;
+
+	required_bytes = sizeof(lldev->tx_status_list[0]) * nr_tres;
+	lldev->tx_status_list = devm_kzalloc(dev, required_bytes, GFP_KERNEL);
+	if (!lldev->tx_status_list)
+		return NULL;
+
+	lldev->tre_ring = dmam_alloc_coherent(dev, (TRE_SIZE + 1) * nr_tres,
+				&lldev->tre_ring_handle, GFP_KERNEL);
+	if (!lldev->tre_ring)
+		return NULL;
+
+	memset(lldev->tre_ring, 0, (TRE_SIZE + 1) * nr_tres);
+	lldev->tre_ring_size = TRE_SIZE * nr_tres;
+	lldev->nr_tres = nr_tres;
+
+	/* the TRE ring has to be TRE_SIZE aligned */
+	if (!IS_ALIGNED(lldev->tre_ring_handle, TRE_SIZE)) {
+		u8 tre_ring_shift;
+
+		tre_ring_shift = lldev->tre_ring_handle % TRE_SIZE;
+		tre_ring_shift = TRE_SIZE - tre_ring_shift;
+		lldev->tre_ring_handle += tre_ring_shift;
+		lldev->tre_ring += tre_ring_shift;
+	}
+
+	lldev->evre_ring = dmam_alloc_coherent(dev, (EVRE_SIZE + 1) * nr_tres,
+				&lldev->evre_ring_handle, GFP_KERNEL);
+	if (!lldev->evre_ring)
+		return NULL;
+
+	memset(lldev->evre_ring, 0, (EVRE_SIZE + 1) * nr_tres);
+	lldev->evre_ring_size = EVRE_SIZE * nr_tres;
+
+	/* the EVRE ring has to be EVRE_SIZE aligned */
+	if (!IS_ALIGNED(lldev->evre_ring_handle, EVRE_SIZE)) {
+		u8 evre_ring_shift;
+
+		evre_ring_shift = lldev->evre_ring_handle % EVRE_SIZE;
+		evre_ring_shift = EVRE_SIZE - evre_ring_shift;
+		lldev->evre_ring_handle += evre_ring_shift;
+		lldev->evre_ring += evre_ring_shift;
+	}
+	lldev->nr_tres = nr_tres;
+	lldev->evridx = evridx;
+
+	rc = kfifo_alloc(&lldev->handoff_fifo,
+			nr_tres * sizeof(struct hidma_tre *), GFP_KERNEL);
+	if (rc)
+		return NULL;
+
+	rc = hidma_ll_setup(lldev);
+	if (rc)
+		return NULL;
+
+	spin_lock_init(&lldev->lock);
+	tasklet_init(&lldev->task, hidma_ll_tre_complete, (unsigned long)lldev);
+	lldev->initialized = 1;
+	hidma_ll_enable_irq(lldev, ENABLE_IRQS);
+	return lldev;
+}
+
+int hidma_ll_uninit(struct hidma_lldev *lldev)
+{
+	int rc = 0;
+	u32 val;
+
+	if (!lldev)
+		return -ENODEV;
+
+	if (lldev->initialized) {
+		u32 required_bytes;
+
+		lldev->initialized = 0;
+
+		required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
+		tasklet_kill(&lldev->task);
+		memset(lldev->trepool, 0, required_bytes);
+		lldev->trepool = NULL;
+		lldev->pending_tre_count = 0;
+		lldev->tre_write_offset = 0;
+
+		rc = hidma_ll_reset(lldev);
+
+		/*
+		 * Clear all pending interrupts again.
+		 * Otherwise, we observe reset complete interrupts.
+		 */
+		val = readl(lldev->evca + EVCA_IRQ_STAT_OFFSET);
+		writel(val, lldev->evca + EVCA_IRQ_CLR_OFFSET);
+		hidma_ll_enable_irq(lldev, 0);
+	}
+	return rc;
+}
+
+irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
+{
+	struct hidma_lldev *lldev = arg;
+
+	hidma_ll_int_handler_internal(lldev);
+	return IRQ_HANDLED;
+}
+
+enum dma_status hidma_ll_status(struct hidma_lldev *lldev, u32 tre_ch)
+{
+	enum dma_status ret = DMA_ERROR;
+	unsigned long flags;
+	u8 err_code;
+
+	spin_lock_irqsave(&lldev->lock, flags);
+	err_code = lldev->tx_status_list[tre_ch].err_code;
+
+	if (err_code & EVRE_STATUS_COMPLETE)
+		ret = DMA_COMPLETE;
+	else if (err_code & EVRE_STATUS_ERROR)
+		ret = DMA_ERROR;
+	else
+		ret = DMA_IN_PROGRESS;
+	spin_unlock_irqrestore(&lldev->lock, flags);
+
+	return ret;
+}
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
