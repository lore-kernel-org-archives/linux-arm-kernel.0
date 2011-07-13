From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Jul 2011 17:47:30 +0900
Subject: [PATCH V2 05/12] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1310546857-6304-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds common DMA operations which are used for Samsung DMA
drivers. Currently there are two types of DMA driver for Samsung SoCs.
The one is S3C-DMA for S3C SoCs and the other is PL330-DMA for S5P SoCs.
This patch provides funcion pointers for common DMA operations to DMA
client driver like SPI and Audio. It makes DMA client drivers support
multi-platform.
In addition, this common DMA operations implement the shared actions
that are needed for DMA client driver. For example shared actions are
filter() function for dma_request_channel() and parameter passing for
device_prep_slave_sg().

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/dma.h       |    3 +-
 arch/arm/plat-samsung/Makefile                 |    6 +-
 arch/arm/plat-samsung/dma-ops.c                |  131 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/dma-ops.h   |   47 +++++++++
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    3 +
 arch/arm/plat-samsung/include/plat/dma.h       |    2 +-
 arch/arm/plat-samsung/s3c-dma-ops.c            |  132 ++++++++++++++++++++++++
 7 files changed, 320 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dma-ops.c
 create mode 100644 arch/arm/plat-samsung/include/plat/dma-ops.h
 create mode 100644 arch/arm/plat-samsung/s3c-dma-ops.c

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index b2b2a5b..71a662d 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -13,7 +13,6 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H __FILE__
 
-#include <plat/dma.h>
 #include <linux/sysdev.h>
 
 #define MAX_DMA_TRANSFER_SIZE   0x100000 /* Data Unit is half word  */
@@ -51,6 +50,8 @@ enum dma_ch {
 	DMACH_MAX,		/* the end entry */
 };
 
+#include <plat/dma.h>
+
 #define DMACH_LOW_LEVEL	(1<<28)	/* use this to specifiy hardware ch no */
 
 /* we have 4 dma channels */
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 53eb15b..9ecf2aa 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -62,9 +62,11 @@ obj-$(CONFIG_SAMSUNG_DEV_PWM)	+= dev-pwm.o
 
 # DMA support
 
-obj-$(CONFIG_S3C_DMA)		+= dma.o
+obj-$(CONFIG_S3C_DMA)		+= dma.o s3c-dma-ops.o
 
-obj-$(CONFIG_S3C_PL330_DMA)	+= s3c-pl330.o
+obj-$(CONFIG_DMADEV_PL330)	+= dma-ops.o
+
+obj-$(CONFIG_S3C_PL330_DMA)	+= s3c-pl330.o s3c-dma-ops.o
 
 # PM support
 
diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
new file mode 100644
index 0000000..94a9d33
--- /dev/null
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -0,0 +1,131 @@
+/* linux/arch/arm/plat-samsung/dma-ops.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung DMA Operations
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/dmaengine.h>
+#include <linux/amba/pl330.h>
+
+#include <mach/dma.h>
+
+static bool filter(struct dma_chan *chan, void *param)
+{
+	struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
+	unsigned dma_ch = (unsigned)param;
+
+	if (peri->peri_id != dma_ch)
+		return false;
+
+	return true;
+}
+
+static unsigned dma_request(enum dma_ch dma_ch, struct samsung_dma_info *info)
+{
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	struct dma_slave_config slave_config;
+
+	dma_cap_zero(mask);
+	dma_cap_set(info->cap, mask);
+
+	chan = dma_request_channel(mask, filter, (void *)dma_ch);
+
+	if (info->direction == DMA_FROM_DEVICE) {
+		memset(&slave_config, 0, sizeof(struct dma_slave_config));
+		slave_config.direction = info->direction;
+		slave_config.src_addr = info->fifo;
+		slave_config.src_addr_width = info->width;
+		dmaengine_slave_config(chan, &slave_config);
+	} else if (info->direction == DMA_TO_DEVICE) {
+		memset(&slave_config, 0, sizeof(struct dma_slave_config));
+		slave_config.direction = info->direction;
+		slave_config.dst_addr = info->fifo;
+		slave_config.dst_addr_width = info->width;
+		dmaengine_slave_config(chan, &slave_config);
+	}
+
+	return (unsigned)chan;
+}
+
+static int dma_release(unsigned ch, struct s3c2410_dma_client *client)
+{
+	dma_release_channel((struct dma_chan *)ch);
+
+	return 0;
+}
+
+static int dma_prepare(unsigned ch, struct samsung_dma_prep_info *info)
+{
+	struct scatterlist sg;
+	struct dma_chan *chan = (struct dma_chan *)ch;
+	struct dma_async_tx_descriptor *desc;
+
+	switch (info->cap) {
+	case DMA_SLAVE:
+		sg_init_table(&sg, 1);
+		sg_dma_len(&sg) = info->len;
+		sg_set_page(&sg, pfn_to_page(PFN_DOWN(info->buf)),
+			    info->len, offset_in_page(info->buf));
+		sg_dma_address(&sg) = info->buf;
+
+		desc = chan->device->device_prep_slave_sg(chan,
+			&sg, 1, info->direction, DMA_PREP_INTERRUPT);
+		break;
+	case DMA_CYCLIC:
+		desc = chan->device->device_prep_dma_cyclic(chan,
+			info->buf, info->len, info->period, info->direction);
+		break;
+	default:
+		dev_err(&chan->dev->device, "unsupported format\n");
+		return -EFAULT;
+	}
+
+	if (!desc) {
+		dev_err(&chan->dev->device, "cannot prepare cyclic dma\n");
+		return -EFAULT;
+	}
+
+	desc->callback = info->fp;
+	desc->callback_param = info->fp_param;
+
+	dmaengine_submit((struct dma_async_tx_descriptor *)desc);
+
+	return 0;
+}
+
+static inline int dma_trigger(unsigned ch)
+{
+	dma_async_issue_pending((struct dma_chan *)ch);
+
+	return 0;
+}
+
+static inline int dma_flush(unsigned ch)
+{
+	return dmaengine_terminate_all((struct dma_chan *)ch);
+}
+
+static struct samsung_dma_ops dmaeng_ops = {
+	.request	= dma_request,
+	.release	= dma_release,
+	.prepare	= dma_prepare,
+	.trigger	= dma_trigger,
+	.started	= NULL,
+	.flush		= dma_flush,
+	.stop		= dma_flush,
+};
+
+void *samsung_dma_get_ops(void)
+{
+	return (void *)&dmaeng_ops;
+}
+EXPORT_SYMBOL(samsung_dma_get_ops);
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
new file mode 100644
index 0000000..eea4130
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -0,0 +1,47 @@
+/* arch/arm/plat-samsung/include/plat/dma-ops.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung DMA support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/dmaengine.h>
+
+struct samsung_dma_prep_info {
+	enum dma_transaction_type cap;
+	enum dma_data_direction direction;
+	unsigned buf;
+	unsigned long period;
+	unsigned long len;
+	void (*fp)(void *data);
+	void *fp_param;
+};
+
+struct samsung_dma_info {
+	enum dma_transaction_type cap;
+	enum dma_data_direction direction;
+	enum dma_slave_buswidth width;
+	unsigned fifo;
+	struct s3c2410_dma_client *client;
+};
+
+struct samsung_dma_ops {
+	unsigned (*request)(enum dma_ch ch, struct samsung_dma_info *info);
+	int (*release)(unsigned ch, struct s3c2410_dma_client *client);
+	int (*prepare)(unsigned ch, struct samsung_dma_prep_info *info);
+	int (*trigger)(unsigned ch);
+	int (*started)(unsigned ch);
+	int (*flush)(unsigned ch);
+	int (*stop)(unsigned ch);
+};
+
+/*
+ * samsung_dma_get_ops
+ * get the set of dma operations
+ */
+extern void *samsung_dma_get_ops(void);
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index c402719..be84bec 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -1,4 +1,7 @@
 /*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
  *	Jaswinder Singh <jassi.brar@samsung.com>
  *
diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
index 2e8f8c6..90da162 100644
--- a/arch/arm/plat-samsung/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -124,4 +124,4 @@ extern int s3c2410_dma_getposition(unsigned int channel,
 extern int s3c2410_dma_set_opfn(unsigned int, s3c2410_dma_opfn_t rtn);
 extern int s3c2410_dma_set_buffdone_fn(unsigned int, s3c2410_dma_cbfn_t rtn);
 
-
+#include <plat/dma-ops.h>
diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-dma-ops.c
new file mode 100644
index 0000000..17b1be0
--- /dev/null
+++ b/arch/arm/plat-samsung/s3c-dma-ops.c
@@ -0,0 +1,132 @@
+/* linux/arch/arm/plat-samsung/s3c-dma-ops.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung S3C-DMA Operations
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <mach/dma.h>
+
+struct cb_data {
+	void (*fp) (void *);
+	void *fp_param;
+	unsigned ch;
+	struct list_head node;
+};
+
+static LIST_HEAD(dma_list);
+
+static void dma_cb(struct s3c2410_dma_chan *channel,
+		   void *param, int size, enum s3c2410_dma_buffresult res)
+{
+	struct cb_data *data = (struct cb_data *)param;
+
+	data->fp(data->fp_param);
+}
+
+static unsigned dma_request(enum dma_ch dma_ch, struct samsung_dma_info *info)
+{
+	struct cb_data *data;
+
+	if (s3c2410_dma_request(dma_ch, info->client, NULL) < 0) {
+		s3c2410_dma_free(dma_ch, info->client);
+		return 0;
+	}
+
+	data = kmalloc(sizeof(struct cb_data), GFP_KERNEL);
+	data->fp = NULL;
+	data->ch = (unsigned)dma_ch;
+	list_add_tail(&data->node, &dma_list);
+
+	if (info->direction == DMA_FROM_DEVICE)
+		s3c2410_dma_devconfig(dma_ch, S3C2410_DMASRC_HW, info->fifo);
+	else
+		s3c2410_dma_devconfig(dma_ch, S3C2410_DMASRC_MEM, info->fifo);
+
+	if (info->cap == DMA_CYCLIC)
+		s3c2410_dma_setflags(dma_ch, S3C2410_DMAF_CIRCULAR);
+
+	s3c2410_dma_config(dma_ch, info->width);
+
+	return (unsigned)dma_ch;
+}
+
+static int dma_release(unsigned ch, struct s3c2410_dma_client *client)
+{
+	struct cb_data *data;
+
+	list_for_each_entry(data, &dma_list, node)
+	    if (data->ch == ch)
+		break;
+	list_del(&data->node);
+
+	s3c2410_dma_free((enum dma_ch)ch, client);
+	kfree(data);
+
+	return 0;
+}
+
+static int dma_prepare(unsigned ch, struct samsung_dma_prep_info *info)
+{
+	struct cb_data *data;
+
+	list_for_each_entry(data, &dma_list, node)
+	    if (data->ch == ch)
+		break;
+
+	if (!data->fp) {
+		s3c2410_dma_set_buffdone_fn((enum dma_ch)ch, dma_cb);
+		data->fp = info->fp;
+		data->fp_param = info->fp_param;
+	}
+	s3c2410_dma_enqueue((enum dma_ch)ch, (void *)data, info->buf,
+			    info->period);
+
+	return 0;
+}
+
+static inline int dma_trigger(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_START);
+}
+
+static inline int dma_started(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STARTED);
+}
+
+static inline int dma_flush(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_FLUSH);
+}
+
+static inline int dma_stop(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STOP);
+}
+
+static struct samsung_dma_ops s3c_dma_ops = {
+	.request	= dma_request,
+	.release	= dma_release,
+	.prepare	= dma_prepare,
+	.trigger	= dma_trigger,
+	.started	= dma_started,
+	.flush		= dma_flush,
+	.stop		= dma_stop,
+};
+
+void *samsung_dma_get_ops(void)
+{
+	return (void *)&s3c_dma_ops;
+}
+EXPORT_SYMBOL(samsung_dma_get_ops);
-- 
1.7.1
