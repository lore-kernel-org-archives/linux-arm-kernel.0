From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 00:23:10 +0800
Subject: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead
of '0xffff'.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3b622d6..27ccabf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -341,6 +341,7 @@ struct sdma_desc {
  * @pc_from_device:	script address for those device_2_memory
  * @pc_to_device:	script address for those memory_2_device
  * @device_to_device:	script address for those device_2_device
+ * @pc_to_pc:		script address for those memory_2_memory
  * @flags:		loop mode or not
  * @per_address:	peripheral source or destination address in common case
  *                      destination address in p_2_p case
@@ -366,6 +367,7 @@ struct sdma_channel {
 	enum dma_slave_buswidth		word_size;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
+	unsigned int                    pc_to_pc;
 	unsigned long			flags;
 	dma_addr_t			per_address, per_address2;
 	unsigned long			event_mask[2];
@@ -385,6 +387,8 @@ struct sdma_channel {
 
 #define SDMA_FIRMWARE_MAGIC 0x414d4453
 
+#define SDMA_BD_MAX_CNT	0xffff
+
 /**
  * struct sdma_firmware_header - Layout of the firmware image
  *
@@ -868,14 +872,16 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	 * These are needed once we start to support transfers between
 	 * two peripherals or memory-to-memory transfers
 	 */
-	int per_2_per = 0;
+	int per_2_per = 0, emi_2_emi = 0;
 
 	sdmac->pc_from_device = 0;
 	sdmac->pc_to_device = 0;
 	sdmac->device_to_device = 0;
+	sdmac->pc_to_pc = 0;
 
 	switch (peripheral_type) {
 	case IMX_DMATYPE_MEMORY:
+		emi_2_emi = sdma->script_addrs->ap_2_ap_addr;
 		break;
 	case IMX_DMATYPE_DSP:
 		emi_2_per = sdma->script_addrs->bp_2_ap_addr;
@@ -948,6 +954,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	sdmac->pc_from_device = per_2_emi;
 	sdmac->pc_to_device = emi_2_per;
 	sdmac->device_to_device = per_2_per;
+	sdmac->pc_to_pc = emi_2_emi;
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -964,6 +971,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
 		load_address = sdmac->device_to_device;
+	else if (sdmac->direction == DMA_MEM_TO_MEM)
+		load_address = sdmac->pc_to_pc;
 	else
 		load_address = sdmac->pc_to_device;
 
@@ -1317,6 +1326,84 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *sdma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst,
+		dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+	size_t count;
+	int i = 0, param;
+	struct sdma_buffer_descriptor *bd;
+	struct sdma_desc *desc;
+
+	if (!chan || !len)
+		return NULL;
+
+	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
+		&dma_src, &dma_dst, len, channel);
+
+	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len / SDMA_BD_MAX_CNT
+					+ 1);
+	if (!desc)
+		goto err_out;
+
+	do {
+		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
+		bd = &desc->bd[i];
+		bd->buffer_addr = dma_src;
+		bd->ext_buffer_addr = dma_dst;
+		bd->mode.count = count;
+		desc->chn_count += count;
+
+		switch (sdmac->word_size) {
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+			bd->mode.command = 0;
+			if ((count | dma_src | dma_dst) & 3)
+				goto err_bd_out;
+			break;
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+			bd->mode.command = 2;
+			if ((count | dma_src | dma_dst) & 1)
+				goto err_bd_out;
+			break;
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+			bd->mode.command = 1;
+			break;
+		default:
+			goto err_bd_out;
+		}
+
+		dma_src += count;
+		dma_dst += count;
+		len -= count;
+		i++;
+
+		param = BD_DONE | BD_EXTD | BD_CONT;
+		/* last bd */
+		if (!len) {
+			param |= BD_INTR;
+			param |= BD_LAST;
+			param &= ~BD_CONT;
+		}
+
+		dev_dbg(sdma->dev, "entry %d: count: %zd dma: 0x%x %s%s\n",
+				i, count, bd->buffer_addr,
+				param & BD_WRAP ? "wrap" : "",
+				param & BD_INTR ? " intr" : "");
+
+		bd->mode.status = param;
+	} while (len);
+
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
+err_out:
+	return NULL;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1344,9 +1431,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		count = sg_dma_len(sg);
 
-		if (count > 0xffff) {
+		if (count > SDMA_BD_MAX_CNT) {
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
-					channel, count, 0xffff);
+					channel, count, SDMA_BD_MAX_CNT);
 			goto err_bd_out;
 		}
 
@@ -1421,9 +1508,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
-	if (period_len > 0xffff) {
+	if (period_len > SDMA_BD_MAX_CNT) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-				channel, period_len, 0xffff);
+				channel, period_len, SDMA_BD_MAX_CNT);
 		goto err_bd_out;
 	}
 
@@ -1486,6 +1573,8 @@ static int sdma_config(struct dma_chan *chan,
 		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16) &
 			SDMA_WATERMARK_LEVEL_HWML;
 		sdmac->word_size = dmaengine_cfg->dst_addr_width;
+	} else if (dmaengine_cfg->direction == DMA_MEM_TO_MEM) {
+		sdmac->word_size = dmaengine_cfg->dst_addr_width;
 	} else {
 		sdmac->per_address = dmaengine_cfg->dst_addr;
 		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
@@ -1902,6 +1991,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
@@ -1968,9 +2058,11 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
-	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
+	sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
+	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
 
-- 
2.7.4
