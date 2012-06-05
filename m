From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 05 Jun 2012 16:17:27 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config() function in DMA common
 operations
Message-ID: <011501cd42eb$436c9630$ca45c290$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds config() that configures DMA transmit option.
This function was originally included in request().
But, Some DMA client driver requires to change the configuration after request().
So, This patch picks up it from request().

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/plat-samsung/dma-ops.c              |   77 ++++++++++++++-----------
 arch/arm/plat-samsung/include/plat/dma-ops.h |   20 ++++---
 arch/arm/plat-samsung/s3c-dma-ops.c          |   39 +++++++------
 3 files changed, 77 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index eb9f4f5..51d8590 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -19,72 +19,80 @@
 #include <mach/dma.h>

 static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
-				struct samsung_dma_info *info)
+				struct samsung_dma_req *param)
 {
-	struct dma_chan *chan;
 	dma_cap_mask_t mask;
-	struct dma_slave_config slave_config;
 	void *filter_param;

 	dma_cap_zero(mask);
-	dma_cap_set(info->cap, mask);
+	dma_cap_set(param->cap, mask);

 	/*
 	 * If a dma channel property of a device node from device tree is
 	 * specified, use that as the fliter parameter.
 	 */
-	filter_param = (dma_ch == DMACH_DT_PROP) ? (void *)info->dt_dmach_prop :
-				(void *)dma_ch;
-	chan = dma_request_channel(mask, pl330_filter, filter_param);
+	filter_param = (dma_ch == DMACH_DT_PROP) ?
+		(void *)param->dt_dmach_prop : (void *)dma_ch;
+	return (unsigned)dma_request_channel(mask, pl330_filter, filter_param);
+}

-	if (info->direction == DMA_DEV_TO_MEM) {
+static int samsung_dmadev_release(unsigned ch,
+			struct s3c2410_dma_client *client)
+{
+	dma_release_channel((struct dma_chan *)ch);
+
+	return 0;
+}
+
+static int samsung_dmadev_config(unsigned ch,
+				struct samsung_dma_config *param)
+{
+	struct dma_chan *chan = (struct dma_chan *)ch;
+	struct dma_slave_config slave_config;
+
+	if (param->direction == DMA_DEV_TO_MEM) {
 		memset(&slave_config, 0, sizeof(struct dma_slave_config));
-		slave_config.direction = info->direction;
-		slave_config.src_addr = info->fifo;
-		slave_config.src_addr_width = info->width;
+		slave_config.direction = param->direction;
+		slave_config.src_addr = param->fifo;
+		slave_config.src_addr_width = param->width;
 		slave_config.src_maxburst = 1;
 		dmaengine_slave_config(chan, &slave_config);
-	} else if (info->direction == DMA_MEM_TO_DEV) {
+	} else if (param->direction == DMA_MEM_TO_DEV) {
 		memset(&slave_config, 0, sizeof(struct dma_slave_config));
-		slave_config.direction = info->direction;
-		slave_config.dst_addr = info->fifo;
-		slave_config.dst_addr_width = info->width;
+		slave_config.direction = param->direction;
+		slave_config.dst_addr = param->fifo;
+		slave_config.dst_addr_width = param->width;
 		slave_config.dst_maxburst = 1;
 		dmaengine_slave_config(chan, &slave_config);
+	} else {
+		printk(KERN_WARNING "unsupported direction\n");
+		return -EINVAL;
 	}

-	return (unsigned)chan;
-}
-
-static int samsung_dmadev_release(unsigned ch,
-			struct s3c2410_dma_client *client)
-{
-	dma_release_channel((struct dma_chan *)ch);
-
 	return 0;
 }

 static int samsung_dmadev_prepare(unsigned ch,
-			struct samsung_dma_prep_info *info)
+			struct samsung_dma_prep *param)
 {
 	struct scatterlist sg;
 	struct dma_chan *chan = (struct dma_chan *)ch;
 	struct dma_async_tx_descriptor *desc;

-	switch (info->cap) {
+	switch (param->cap) {
 	case DMA_SLAVE:
 		sg_init_table(&sg, 1);
-		sg_dma_len(&sg) = info->len;
-		sg_set_page(&sg, pfn_to_page(PFN_DOWN(info->buf)),
-			    info->len, offset_in_page(info->buf));
-		sg_dma_address(&sg) = info->buf;
+		sg_dma_len(&sg) = param->len;
+		sg_set_page(&sg, pfn_to_page(PFN_DOWN(param->buf)),
+			    param->len, offset_in_page(param->buf));
+		sg_dma_address(&sg) = param->buf;

 		desc = dmaengine_prep_slave_sg(chan,
-			&sg, 1, info->direction, DMA_PREP_INTERRUPT);
+			&sg, 1, param->direction, DMA_PREP_INTERRUPT);
 		break;
 	case DMA_CYCLIC:
-		desc = dmaengine_prep_dma_cyclic(chan,
-			info->buf, info->len, info->period, info->direction);
+		desc = dmaengine_prep_dma_cyclic(chan, param->buf,
+			param->len, param->period, param->direction);
 		break;
 	default:
 		dev_err(&chan->dev->device, "unsupported format\n");
@@ -96,8 +104,8 @@ static int samsung_dmadev_prepare(unsigned ch,
 		return -EFAULT;
 	}

-	desc->callback = info->fp;
-	desc->callback_param = info->fp_param;
+	desc->callback = param->fp;
+	desc->callback_param = param->fp_param;

 	dmaengine_submit((struct dma_async_tx_descriptor *)desc);

@@ -119,6 +127,7 @@ static inline int samsung_dmadev_flush(unsigned ch)
 static struct samsung_dma_ops dmadev_ops = {
 	.request	= samsung_dmadev_request,
 	.release	= samsung_dmadev_release,
+	.config		= samsung_dmadev_config,
 	.prepare	= samsung_dmadev_prepare,
 	.trigger	= samsung_dmadev_trigger,
 	.started	= NULL,
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
index 71a6827..f5144cd 100644
--- a/arch/arm/plat-samsung/include/plat/dma-ops.h
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -16,7 +16,13 @@
 #include <linux/dmaengine.h>
 #include <mach/dma.h>

-struct samsung_dma_prep_info {
+struct samsung_dma_req {
+	enum dma_transaction_type cap;
+	struct property *dt_dmach_prop;
+	struct s3c2410_dma_client *client;
+};
+
+struct samsung_dma_prep {
 	enum dma_transaction_type cap;
 	enum dma_transfer_direction direction;
 	dma_addr_t buf;
@@ -26,19 +32,17 @@ struct samsung_dma_prep_info {
 	void *fp_param;
 };

-struct samsung_dma_info {
-	enum dma_transaction_type cap;
+struct samsung_dma_config {
 	enum dma_transfer_direction direction;
 	enum dma_slave_buswidth width;
 	dma_addr_t fifo;
-	struct s3c2410_dma_client *client;
-	struct property *dt_dmach_prop;
 };

 struct samsung_dma_ops {
-	unsigned (*request)(enum dma_ch ch, struct samsung_dma_info *info);
-	int (*release)(unsigned ch, struct s3c2410_dma_client *client);
-	int (*prepare)(unsigned ch, struct samsung_dma_prep_info *info);
+	unsigned (*request)(enum dma_ch ch, struct samsung_dma_req *param);
+	int (*release)(unsigned ch, void *param);
+	int (*config)(unsigned ch, struct samsung_dma_config *param);
+	int (*prepare)(unsigned ch, struct samsung_dma_prep *param);
 	int (*trigger)(unsigned ch);
 	int (*started)(unsigned ch);
 	int (*flush)(unsigned ch);
diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-dma-ops.c
index 7814949..f99448c 100644
--- a/arch/arm/plat-samsung/s3c-dma-ops.c
+++ b/arch/arm/plat-samsung/s3c-dma-ops.c
@@ -36,30 +36,26 @@ static void s3c_dma_cb(struct s3c2410_dma_chan *channel, void *param,
 }

 static unsigned s3c_dma_request(enum dma_ch dma_ch,
-				 struct samsung_dma_info *info)
+					struct samsung_dma_req *param)
 {
 	struct cb_data *data;

-	if (s3c2410_dma_request(dma_ch, info->client, NULL) < 0) {
-		s3c2410_dma_free(dma_ch, info->client);
+	if (s3c2410_dma_request(dma_ch, param->client, NULL) < 0) {
+		s3c2410_dma_free(dma_ch, param->client);
 		return 0;
 	}

+	if (param->cap == DMA_CYCLIC)
+		s3c2410_dma_setflags(dma_ch, S3C2410_DMAF_CIRCULAR);
+
 	data = kzalloc(sizeof(struct cb_data), GFP_KERNEL);
 	data->ch = dma_ch;
 	list_add_tail(&data->node, &dma_list);

-	s3c2410_dma_devconfig(dma_ch, info->direction, info->fifo);
-
-	if (info->cap == DMA_CYCLIC)
-		s3c2410_dma_setflags(dma_ch, S3C2410_DMAF_CIRCULAR);
-
-	s3c2410_dma_config(dma_ch, info->width);
-
 	return (unsigned)dma_ch;
 }

-static int s3c_dma_release(unsigned ch, struct s3c2410_dma_client *client)
+static int s3c_dma_release(unsigned ch, void *param)
 {
 	struct cb_data *data;

@@ -68,16 +64,24 @@ static int s3c_dma_release(unsigned ch, struct s3c2410_dma_client *client)
 			break;
 	list_del(&data->node);

-	s3c2410_dma_free(ch, client);
+	s3c2410_dma_free(ch, param);
 	kfree(data);

 	return 0;
 }

-static int s3c_dma_prepare(unsigned ch, struct samsung_dma_prep_info *info)
+static int s3c_dma_config(unsigned ch, struct samsung_dma_config *param)
+{
+	s3c2410_dma_devconfig(ch, param->direction, param->fifo);
+	s3c2410_dma_config(ch, param->width);
+
+	return 0;
+}
+
+static int s3c_dma_prepare(unsigned ch, struct samsung_dma_prep *param)
 {
 	struct cb_data *data;
-	int len = (info->cap == DMA_CYCLIC) ? info->period : info->len;
+	int len = (param->cap == DMA_CYCLIC) ? param->period : param->len;

 	list_for_each_entry(data, &dma_list, node)
 		if (data->ch == ch)
@@ -85,11 +89,11 @@ static int s3c_dma_prepare(unsigned ch, struct samsung_dma_prep_info *info)

 	if (!data->fp) {
 		s3c2410_dma_set_buffdone_fn(ch, s3c_dma_cb);
-		data->fp = info->fp;
-		data->fp_param = info->fp_param;
+		data->fp = param->fp;
+		data->fp_param = param->fp_param;
 	}

-	s3c2410_dma_enqueue(ch, (void *)data, info->buf, len);
+	s3c2410_dma_enqueue(ch, (void *)data, param->buf, len);

 	return 0;
 }
@@ -117,6 +121,7 @@ static inline int s3c_dma_stop(unsigned ch)
 static struct samsung_dma_ops s3c_dma_ops = {
 	.request	= s3c_dma_request,
 	.release	= s3c_dma_release,
+	.config		= s3c_dma_config,
 	.prepare	= s3c_dma_prepare,
 	.trigger	= s3c_dma_trigger,
 	.started	= s3c_dma_started,
--
1.7.1
