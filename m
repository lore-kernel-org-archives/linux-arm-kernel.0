From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 15:44:18 +0900
Subject: [PATCH V3 05/13] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
References: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1310798666-7659-6-git-send-email-kgene.kim@samsung.com>
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
 arch/arm/mach-s3c2410/include/mach/dma.h       |    8 ++-
 arch/arm/mach-s3c64xx/include/mach/dma.h       |    4 +
 arch/arm/plat-samsung/Makefile                 |    6 +-
 arch/arm/plat-samsung/dma-ops.c                |  130 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/dma-ops.h   |   72 +++++++++++++
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    7 ++
 arch/arm/plat-samsung/include/plat/dma.h       |    1 +
 arch/arm/plat-samsung/s3c-dma-ops.c            |  129 +++++++++++++++++++++++
 8 files changed, 354 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dma-ops.c
 create mode 100644 arch/arm/plat-samsung/include/plat/dma-ops.h
 create mode 100644 arch/arm/plat-samsung/s3c-dma-ops.c

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index b2b2a5b..e61a91f 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -13,7 +13,6 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H __FILE__
 
-#include <plat/dma.h>
 #include <linux/sysdev.h>
 
 #define MAX_DMA_TRANSFER_SIZE   0x100000 /* Data Unit is half word  */
@@ -51,6 +50,13 @@ enum dma_ch {
 	DMACH_MAX,		/* the end entry */
 };
 
+static inline bool samsung_dma_is_dmadev(void)
+{
+	return false;
+}
+
+#include <plat/dma.h>
+
 #define DMACH_LOW_LEVEL	(1<<28)	/* use this to specifiy hardware ch no */
 
 /* we have 4 dma channels */
diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
index 0a5d926..49c3a53 100644
--- a/arch/arm/mach-s3c64xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c64xx/include/mach/dma.h
@@ -63,6 +63,10 @@ static __inline__ bool s3c_dma_has_circular(void)
 	return true;
 }
 
+static inline bool samsung_dma_is_dmadev(void)
+{
+	return false;
+}
 #define S3C2410_DMAF_CIRCULAR		(1 << 0)
 
 #include <plat/dma.h>
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
index 0000000..4474c38
--- /dev/null
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -0,0 +1,130 @@
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/amba/pl330.h>
+
+#include <mach/dma.h>
+
+static bool pl330_filter(struct dma_chan *chan, void *param)
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
+static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
+				struct samsung_dma_info *info)
+{
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	struct dma_slave_config slave_config;
+
+	dma_cap_zero(mask);
+	dma_cap_set(info->cap, mask);
+
+	chan = dma_request_channel(mask, pl330_filter, (void *)dma_ch);
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
+static int samsung_dmadev_release(unsigned ch,
+			struct s3c2410_dma_client *client)
+{
+	dma_release_channel((struct dma_chan *)ch);
+
+	return 0;
+}
+
+static int samsung_dmadev_prepare(unsigned ch,
+			struct samsung_dma_prep_info *info)
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
+static inline int samsung_dmadev_trigger(unsigned ch)
+{
+	dma_async_issue_pending((struct dma_chan *)ch);
+
+	return 0;
+}
+
+static inline int samsung_dmadev_flush(unsigned ch)
+{
+	return dmaengine_terminate_all((struct dma_chan *)ch);
+}
+
+void samsung_dmadev_set_ops(struct samsung_dma_ops *ops)
+{
+	ops->init	= true;
+	ops->request	= samsung_dmadev_request;
+	ops->release	= samsung_dmadev_release;
+	ops->prepare	= samsung_dmadev_prepare;
+	ops->trigger	= samsung_dmadev_trigger;
+	ops->started	= NULL;
+	ops->flush	= samsung_dmadev_flush;
+	ops->stop	= samsung_dmadev_flush;
+}
+EXPORT_SYMBOL(samsung_dmadev_set_ops);
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
new file mode 100644
index 0000000..09a20eb
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -0,0 +1,72 @@
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
+ */
+
+#ifndef __SAMSUNG_DMA_OPS_H_
+#define __SAMSUNG_DMA_OPS_H_ __FILE__
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
+	bool init;
+	unsigned (*request)(enum dma_ch ch, struct samsung_dma_info *info);
+	int (*release)(unsigned ch, struct s3c2410_dma_client *client);
+	int (*prepare)(unsigned ch, struct samsung_dma_prep_info *info);
+	int (*trigger)(unsigned ch);
+	int (*started)(unsigned ch);
+	int (*flush)(unsigned ch);
+	int (*stop)(unsigned ch);
+};
+
+static struct samsung_dma_ops dmadev_ops;
+static struct samsung_dma_ops s3c_dma_ops;
+
+void samsung_dmadev_set_ops(struct samsung_dma_ops *);
+void s3c_dma_set_ops(struct samsung_dma_ops *);
+
+static inline void *__samsung_dma_get_ops(void)
+{
+	if (samsung_dma_is_dmadev()) {
+		if (!dmadev_ops.init)
+			samsung_dmadev_set_ops(&dmadev_ops);
+		return &dmadev_ops;
+	} else {
+		if (!s3c_dma_ops.init)
+			s3c_dma_set_ops(&s3c_dma_ops);
+		return &s3c_dma_ops;
+	}
+}
+
+/*
+ * samsung_dma_get_ops
+ * get the set of samsung dma operations
+ */
+#define samsung_dma_get_ops() __samsung_dma_get_ops()
+
+#endif /* __SAMSUNG_DMA_OPS_H_ */
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index c402719..91933e0 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -100,6 +100,10 @@ static inline bool s3c_dma_has_circular(void)
 	return true;
 }
 
+static inline bool samsung_dma_is_dmadev(void)
+{
+	return true;
+}
 #include <plat/dma.h>
 
 #endif	/* __DMA_PL330_H_ */
diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
index 2e8f8c6..e87c6be 100644
--- a/arch/arm/plat-samsung/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -125,3 +125,4 @@ extern int s3c2410_dma_set_opfn(unsigned int, s3c2410_dma_opfn_t rtn);
 extern int s3c2410_dma_set_buffdone_fn(unsigned int, s3c2410_dma_cbfn_t rtn);
 
 
+#include <plat/dma-ops.h>
diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-dma-ops.c
new file mode 100644
index 0000000..b534663
--- /dev/null
+++ b/arch/arm/plat-samsung/s3c-dma-ops.c
@@ -0,0 +1,130 @@
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
+ */
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
+static void s3c_dma_cb(struct s3c2410_dma_chan *channel, void *param,
+		       int size, enum s3c2410_dma_buffresult res)
+{
+	struct cb_data *data = param;
+
+	data->fp(data->fp_param);
+}
+
+static unsigned s3c_dma_request(enum dma_ch dma_ch,
+				 struct samsung_dma_info *info)
+{
+	struct cb_data *data;
+
+	if (s3c2410_dma_request(dma_ch, info->client, NULL) < 0) {
+		s3c2410_dma_free(dma_ch, info->client);
+		return 0;
+	}
+
+	data = kzalloc(sizeof(struct cb_data), GFP_KERNEL);
+	data->ch = dma_ch;
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
+static int s3c_dma_release(unsigned ch, struct s3c2410_dma_client *client)
+{
+	struct cb_data *data;
+
+	list_for_each_entry(data, &dma_list, node)
+		if (data->ch == ch)
+			break;
+	list_del(&data->node);
+
+	s3c2410_dma_free((enum dma_ch)ch, client);
+	kfree(data);
+
+	return 0;
+}
+
+static int s3c_dma_prepare(unsigned ch, struct samsung_dma_prep_info *info)
+{
+	struct cb_data *data;
+
+	list_for_each_entry(data, &dma_list, node)
+		if (data->ch == ch)
+			break;
+
+	if (!data->fp) {
+		s3c2410_dma_set_buffdone_fn((enum dma_ch)ch, s3c_dma_cb);
+		data->fp = info->fp;
+		data->fp_param = info->fp_param;
+	}
+
+	s3c2410_dma_enqueue((enum dma_ch)ch,
+			(void *)data, info->buf, info->period);
+
+	return 0;
+}
+
+static inline int s3c_dma_trigger(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_START);
+}
+
+static inline int s3c_dma_started(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STARTED);
+}
+
+static inline int s3c_dma_flush(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_FLUSH);
+}
+
+static inline int s3c_dma_stop(unsigned ch)
+{
+	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STOP);
+}
+
+void s3c_dma_set_ops(struct samsung_dma_ops *ops)
+{
+	ops->init	= true;
+	ops->request	= s3c_dma_request;
+	ops->release	= s3c_dma_release;
+	ops->prepare	= s3c_dma_prepare;
+	ops->trigger	= s3c_dma_trigger;
+	ops->started	= s3c_dma_started;
+	ops->flush	= s3c_dma_flush;
+	ops->stop	= s3c_dma_stop;
+}
+EXPORT_SYMBOL(s3c_dma_set_ops);
-- 
1.7.1
