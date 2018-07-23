From: yibin.gong@nxp.com (Robin Gong)
Date: Tue, 24 Jul 2018 01:46:11 +0800
Subject: [PATCH v3 2/3] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1532367972-29707-3-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MEMCPY capability for imx-sdma driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e3d5e73..b4ec2d2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -342,6 +342,7 @@ struct sdma_desc {
  * @pc_from_device:	script address for those device_2_memory
  * @pc_to_device:	script address for those memory_2_device
  * @device_to_device:	script address for those device_2_device
+ * @pc_to_pc:		script address for those memory_2_memory
  * @flags:		loop mode or not
  * @per_address:	peripheral source or destination address in common case
  *                      destination address in p_2_p case
@@ -367,6 +368,7 @@ struct sdma_channel {
 	enum dma_slave_buswidth		word_size;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
+	unsigned int                    pc_to_pc;
 	unsigned long			flags;
 	dma_addr_t			per_address, per_address2;
 	unsigned long			event_mask[2];
@@ -869,14 +871,16 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
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
@@ -949,6 +953,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	sdmac->pc_from_device = per_2_emi;
 	sdmac->pc_to_device = emi_2_per;
 	sdmac->device_to_device = per_2_per;
+	sdmac->pc_to_pc = emi_2_emi;
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -965,6 +970,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
 		load_address = sdmac->device_to_device;
+	else if (sdmac->direction == DMA_MEM_TO_MEM)
+		load_address = sdmac->pc_to_pc;
 	else
 		load_address = sdmac->pc_to_device;
 
@@ -1214,10 +1221,28 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct imx_dma_data *data = chan->private;
+	struct imx_dma_data mem_data;
 	int prio, ret;
 
-	if (!data)
-		return -EINVAL;
+	/*
+	 * MEMCPY may never setup chan->private by filter function such as
+	 * dmatest, thus create 'struct imx_dma_data mem_data' for this case.
+	 * Please note in any other slave case, you have to setup chan->private
+	 * with 'struct imx_dma_data' in your own filter function if you want to
+	 * request dma channel by dma_request_channel() rather than
+	 * dma_request_slave_channel(). Othwise, 'MEMCPY in case?' will appear
+	 * to warn you to correct your filter function.
+	 */
+	if (!data) {
+		dev_dbg(sdmac->sdma->dev, "MEMCPY in case?\n");
+		mem_data.priority = 2;
+		mem_data.peripheral_type = IMX_DMATYPE_MEMORY;
+		mem_data.dma_request = 0;
+		mem_data.dma_request2 = 0;
+		data = &mem_data;
+
+		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+	}
 
 	switch (data->priority) {
 	case DMA_PRIO_HIGH:
@@ -1307,6 +1332,10 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	if (sdma_alloc_bd(desc))
 		goto err_desc_out;
 
+	/* No slave_config called in MEMCPY case, so do here */
+	if (direction == DMA_MEM_TO_MEM)
+		sdma_config_ownership(sdmac, false, true, false);
+
 	if (sdma_load_context(sdmac))
 		goto err_desc_out;
 
@@ -1318,6 +1347,62 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
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
+	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
+					len / SDMA_BD_MAX_CNT + 1);
+	if (!desc)
+		return NULL;
+
+	do {
+		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
+		bd = &desc->bd[i];
+		bd->buffer_addr = dma_src;
+		bd->ext_buffer_addr = dma_dst;
+		bd->mode.count = count;
+		desc->chn_count += count;
+		bd->mode.command = 0;
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
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1903,6 +1988,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
@@ -1969,6 +2055,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
 	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
-- 
2.7.4
