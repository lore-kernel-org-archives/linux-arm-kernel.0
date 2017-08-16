From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:48:59 +0530
Subject: [PATCH 06/18] rpmsg: glink: Introduce glink smem based transport
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The glink protocol supports different types of
transports (shared memory). With the core protocol
remaining the same, the way the transport's memory is
probed and accessed is different. So add support for
glink's smem based transports.

Adding a new smem transport register function and the
fifo accessors for the same.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/Kconfig            |  10 ++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/qcom_glink_smem.c  | 304 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg/qcom_glink.h |  27 ++++
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/rpmsg/qcom_glink_smem.c
 create mode 100644 include/linux/rpmsg/qcom_glink.h

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index ac33688..4bd9ba3 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -27,6 +27,16 @@ config RPMSG_QCOM_GLINK_RPM
 	  which serves as a channel for communication with the RPM in GLINK
 	  enabled systems.
 
+config RPMSG_QCOM_GLINK_SMEM
+	tristate "Qualcomm SMEM Glink driver"
+	select RPMSG_QCOM_GLINK_NATIVE
+	depends on HAS_IOMEM
+	depends on MAILBOX
+	help
+	  Say y here to enable support for the GLINK SMEM communication driver,
+	  which provides support for using the GLINK communication protocol
+	  over SMEM.
+
 config RPMSG_QCOM_SMD
 	tristate "Qualcomm Shared Memory Driver (SMD)"
 	depends on QCOM_SMEM
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 09a756c..c71f4ab 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -2,5 +2,6 @@ obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
+obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
 obj-$(CONFIG_RPMSG_QCOM_SMD)	+= qcom_smd.o
 obj-$(CONFIG_RPMSG_VIRTIO)	+= virtio_rpmsg_bus.o
diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
new file mode 100644
index 0000000..defa10b
--- /dev/null
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -0,0 +1,304 @@
+/*
+ * Copyright (c) 2016, Linaro Ltd
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
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+#include <linux/rpmsg.h>
+#include <linux/idr.h>
+#include <linux/circ_buf.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/sizes.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+#include <linux/list.h>
+
+#include <linux/delay.h>
+#include <linux/rpmsg.h>
+#include <linux/rpmsg/qcom_glink.h>
+
+#include "qcom_glink_native.h"
+
+#define FIFO_FULL_RESERVE 8
+#define FIFO_ALIGNMENT 8
+#define TX_BLOCKED_CMD_RESERVE 8 /* size of struct read_notif_request */
+
+#define SMEM_GLINK_NATIVE_XPRT_DESCRIPTOR	478
+#define SMEM_GLINK_NATIVE_XPRT_FIFO_0		479
+#define SMEM_GLINK_NATIVE_XPRT_FIFO_1		480
+
+struct glink_smem_pipe {
+	struct qcom_glink_pipe native;
+
+	__le32 *tail;
+	__le32 *head;
+
+	void *fifo;
+
+	int remote_pid;
+};
+
+#define to_smem_pipe(p) container_of(p, struct glink_smem_pipe, native)
+
+static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
+{
+	struct glink_smem_pipe *pipe = to_smem_pipe(np);
+	size_t len;
+	void *fifo;
+	u32 head;
+	u32 tail;
+
+	if (!pipe->fifo) {
+		fifo = qcom_smem_get(pipe->remote_pid,
+				     SMEM_GLINK_NATIVE_XPRT_FIFO_1, &len);
+		if (IS_ERR(fifo)) {
+			pr_err("failed to acquire RX fifo handle: %ld\n",
+			       PTR_ERR(fifo));
+			return 0;
+		}
+
+		pipe->fifo = fifo;
+		pipe->native.length = len;
+	}
+
+	head = le32_to_cpu(*pipe->head);
+	tail = le32_to_cpu(*pipe->tail);
+
+	if (head < tail)
+		return pipe->native.length - tail + head;
+	else
+		return head - tail;
+}
+
+static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
+			       void *data, size_t count)
+{
+	struct glink_smem_pipe *pipe = to_smem_pipe(np);
+	size_t len;
+	u32 tail;
+
+	tail = le32_to_cpu(*pipe->tail);
+
+	len = min_t(size_t, count, pipe->native.length - tail);
+	if (len) {
+		__ioread32_copy(data, pipe->fifo + tail,
+				len / sizeof(u32));
+	}
+
+	if (len != count) {
+		__ioread32_copy(data + len, pipe->fifo,
+				(count - len) / sizeof(u32));
+	}
+}
+
+static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
+				  size_t count)
+{
+	struct glink_smem_pipe *pipe = to_smem_pipe(np);
+	u32 tail;
+
+	tail = le32_to_cpu(*pipe->tail);
+
+	tail += count;
+	if (tail > pipe->native.length)
+		tail -= pipe->native.length;
+
+	*pipe->tail = cpu_to_le32(tail);
+}
+
+static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
+{
+	struct glink_smem_pipe *pipe = to_smem_pipe(np);
+	u32 head;
+	u32 tail;
+	u32 avail;
+
+	head = le32_to_cpu(*pipe->head);
+	tail = le32_to_cpu(*pipe->tail);
+
+	if (tail <= head)
+		avail = pipe->native.length - head + tail;
+	else
+		avail = tail - head;
+
+	if (avail < (FIFO_FULL_RESERVE + TX_BLOCKED_CMD_RESERVE))
+		avail = 0;
+	else
+		avail -= FIFO_FULL_RESERVE + TX_BLOCKED_CMD_RESERVE;
+
+	return avail;
+}
+
+static unsigned int glink_smem_tx_write_one(struct glink_smem_pipe *pipe,
+					    unsigned int head,
+					    const void *data, size_t count)
+{
+	size_t len;
+
+	len = min_t(size_t, count, pipe->native.length - head);
+	if (len)
+		memcpy(pipe->fifo + head, data, len);
+
+	if (len != count)
+		memcpy(pipe->fifo, data + len, count - len);
+
+	head += count;
+	if (head >= pipe->native.length)
+		head -= pipe->native.length;
+
+	return head;
+}
+
+static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
+				const void *hdr, size_t hlen,
+				const void *data, size_t dlen)
+{
+	struct glink_smem_pipe *pipe = to_smem_pipe(glink_pipe);
+	unsigned int head;
+
+	head = le32_to_cpu(*pipe->head);
+
+	head = glink_smem_tx_write_one(pipe, head, hdr, hlen);
+	head = glink_smem_tx_write_one(pipe, head, data, dlen);
+
+	/* Ensure head is always aligned to 8 bytes */
+	head = ALIGN(head, 8);
+	if (head >= pipe->native.length)
+		head -= pipe->native.length;
+
+	*pipe->head = cpu_to_le32(head);
+}
+
+struct qcom_glink *qcom_glink_smem_register(struct device *parent,
+					    struct device_node *node)
+{
+	struct glink_smem_pipe *rx_pipe;
+	struct glink_smem_pipe *tx_pipe;
+	struct qcom_glink *glink;
+	struct device *dev;
+	u32 remote_pid;
+	__le32 *descs;
+	size_t size;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->parent = parent;
+	dev->of_node = node;
+	dev_set_name(dev, "%s:%s", dev_name(parent), node->name);
+	ret = device_register(dev);
+	if (ret) {
+		pr_err("failed to register glink edge\n");
+		return ERR_PTR(ret);
+	}
+
+	ret = of_property_read_u32(dev->of_node, "qcom,remote-pid",
+				   &remote_pid);
+	if (ret) {
+		dev_err(dev, "failed to parse qcom,remote-pid\n");
+		goto err_put_dev;
+	}
+
+	rx_pipe = devm_kzalloc(dev, sizeof(*rx_pipe), GFP_KERNEL);
+	tx_pipe = devm_kzalloc(dev, sizeof(*tx_pipe), GFP_KERNEL);
+	if (!rx_pipe || !tx_pipe) {
+		ret = -ENOMEM;
+		goto err_put_dev;
+	}
+
+	ret = qcom_smem_alloc(remote_pid,
+			      SMEM_GLINK_NATIVE_XPRT_DESCRIPTOR, 32);
+	if (ret && ret != -EEXIST) {
+		dev_err(dev, "failed to allocate glink descriptors\n");
+		goto err_put_dev;
+	}
+
+	descs = qcom_smem_get(remote_pid,
+			      SMEM_GLINK_NATIVE_XPRT_DESCRIPTOR, &size);
+	if (IS_ERR(descs)) {
+		dev_err(dev, "failed to acquire xprt descriptor\n");
+		ret = PTR_ERR(descs);
+		goto err_put_dev;
+	}
+
+	if (size != 32) {
+		dev_err(dev, "glink descriptor of invalid size\n");
+		ret = -EINVAL;
+		goto err_put_dev;
+	}
+
+	tx_pipe->tail = &descs[0];
+	tx_pipe->head = &descs[1];
+	rx_pipe->tail = &descs[2];
+	rx_pipe->head = &descs[3];
+
+	ret = qcom_smem_alloc(remote_pid, SMEM_GLINK_NATIVE_XPRT_FIFO_0,
+			      SZ_16K);
+	if (ret && ret != -EEXIST) {
+		dev_err(dev, "failed to allocate TX fifo\n");
+		goto err_put_dev;
+	}
+
+	tx_pipe->fifo = qcom_smem_get(remote_pid, SMEM_GLINK_NATIVE_XPRT_FIFO_0,
+				      &tx_pipe->native.length);
+	if (IS_ERR(tx_pipe->fifo)) {
+		dev_err(dev, "failed to acquire TX fifo\n");
+		ret = PTR_ERR(tx_pipe->fifo);
+		goto err_put_dev;
+	}
+
+	rx_pipe->native.avail = glink_smem_rx_avail;
+	rx_pipe->native.peak = glink_smem_rx_peak;
+	rx_pipe->native.advance = glink_smem_rx_advance;
+	rx_pipe->remote_pid = remote_pid;
+
+	tx_pipe->native.avail = glink_smem_tx_avail;
+	tx_pipe->native.write = glink_smem_tx_write;
+	tx_pipe->remote_pid = remote_pid;
+
+	*rx_pipe->tail = 0;
+	*tx_pipe->head = 0;
+
+	glink = qcom_glink_native_probe(dev,
+					&rx_pipe->native, &tx_pipe->native);
+	if (IS_ERR(glink)) {
+		ret = PTR_ERR(glink);
+		goto err_put_dev;
+	}
+
+	return glink;
+
+err_put_dev:
+	put_device(dev);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(qcom_glink_smem_register);
+
+void qcom_glink_smem_unregister(struct qcom_glink *glink)
+{
+	qcom_glink_native_remove(glink);
+}
+EXPORT_SYMBOL_GPL(qcom_glink_smem_unregister);
+
+MODULE_AUTHOR("Bjorn Andersson <bjorn.andersson@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm GLINK SMEM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/rpmsg/qcom_glink.h b/include/linux/rpmsg/qcom_glink.h
new file mode 100644
index 0000000..a622f02
--- /dev/null
+++ b/include/linux/rpmsg/qcom_glink.h
@@ -0,0 +1,27 @@
+#ifndef _LINUX_RPMSG_QCOM_GLINK_H
+#define _LINUX_RPMSG_QCOM_GLINK_H
+
+#include <linux/device.h>
+
+struct qcom_glink;
+
+#if IS_ENABLED(CONFIG_RPMSG_QCOM_GLINK_SMEM)
+
+struct qcom_glink *qcom_glink_smem_register(struct device *parent,
+					    struct device_node *node);
+void qcom_glink_smem_unregister(struct qcom_glink *glink);
+
+#else
+
+static inline struct qcom_glink *
+qcom_glink_smem_register(struct device *parent,
+			 struct device_node *node)
+{
+	return NULL;
+}
+
+static inline void qcom_glink_smem_unregister(struct qcom_glink *glink) {}
+
+#endif
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
