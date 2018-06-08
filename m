From: yibin.gong@nxp.com (Robin Gong)
Date: Fri,  8 Jun 2018 21:44:46 +0800
Subject: [PATCH v2 1/5] dmaengine: imx-sdma: add virt-dma support
In-Reply-To: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1528465490-19684-2-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

The main changes as below:
  --new "sdma_desc" structure containing virt_dma_desc and some members
    which moved from "sdma_channel" such as "num_bd","bd_phys","bd",etc,
    since multi descriptors may exist on virtual dma framework
    rather than only one as before.
  --remove some members of "sdma_channel" structure since it's handled
    by virtual dma common framework, such as "tasklet", "dma_chan",etc.
  --add specific BD0 for channel0 since such bd descriptor is must and
    basic for other dma channel, no need alloc/free as other channel,so
    request it during probe.
  --remove sdma_request_channel(),sdma_tx_submit(),etc.
  --alloc/free bd descriptor added and code changes for virtual dma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 332 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 220 insertions(+), 113 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680a..d4a4230 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -250,6 +250,7 @@ config IMX_SDMA
 	tristate "i.MX SDMA support"
 	depends on ARCH_MXC
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
 	  Freescale i.MX25/31/35/51/53/6 chips.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccd03c3..8d0c1fd 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -48,6 +48,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
@@ -296,6 +297,31 @@ struct sdma_context_data {
 struct sdma_engine;
 
 /**
+ * struct sdma_desc - descriptor structor for one transfer
+ * @vd			descriptor for virt dma
+ * @num_bd		max NUM_BD. number of descriptors currently handling
+ * @buf_tail		ID of the buffer that was processed
+ * @buf_ptail		ID of the previous buffer that was processed
+ * @period_len		period length, used in cyclic.
+ * @chn_real_count	the real count updated from bd->mode.count
+ * @chn_count		the transfer count setuped
+ * @sdmac		sdma_channel pointer
+ * @bd			pointer of alloced bd
+ */
+struct sdma_desc {
+	struct virt_dma_desc	vd;
+	unsigned int		num_bd;
+	dma_addr_t		bd_phys;
+	unsigned int		buf_tail;
+	unsigned int		buf_ptail;
+	unsigned int		period_len;
+	unsigned int		chn_real_count;
+	unsigned int		chn_count;
+	struct sdma_channel	*sdmac;
+	struct sdma_buffer_descriptor *bd;
+};
+
+/**
  * struct sdma_channel - housekeeping for a SDMA channel
  *
  * @sdma		pointer to the SDMA engine for this channel
@@ -305,11 +331,10 @@ struct sdma_engine;
  * @event_id0		aka dma request line
  * @event_id1		for channels that use 2 events
  * @word_size		peripheral access size
- * @buf_tail		ID of the buffer that was processed
- * @buf_ptail		ID of the previous buffer that was processed
- * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
+	struct virt_dma_chan		vc;
+	struct sdma_desc		*desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -317,12 +342,6 @@ struct sdma_channel {
 	unsigned int			event_id0;
 	unsigned int			event_id1;
 	enum dma_slave_buswidth		word_size;
-	unsigned int			buf_tail;
-	unsigned int			buf_ptail;
-	unsigned int			num_bd;
-	unsigned int			period_len;
-	struct sdma_buffer_descriptor	*bd;
-	dma_addr_t			bd_phys;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
 	unsigned long			flags;
@@ -330,13 +349,10 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	struct dma_chan			chan;
 	spinlock_t			lock;
-	struct dma_async_tx_descriptor	desc;
 	enum dma_status			status;
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
-	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
 };
@@ -398,6 +414,8 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+	dma_addr_t			bd0_phys;
+	struct sdma_buffer_descriptor	*bd0;
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -632,7 +650,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 		u32 address)
 {
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
@@ -688,6 +706,35 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 	writel_relaxed(val, sdma->regs + chnenbl);
 }
 
+static struct sdma_desc *to_sdma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct sdma_desc, vd.tx);
+}
+
+static void sdma_start_desc(struct sdma_channel *sdmac)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
+	struct sdma_desc *desc;
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+
+	if (!vd) {
+		sdmac->desc = NULL;
+		return;
+	}
+	sdmac->desc = desc = to_sdma_desc(&vd->tx);
+	/*
+	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
+	 * the desc alloced will never be freed in vchan_dma_desc_free_list
+	 */
+	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
+		list_del(&vd->node);
+
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma_enable_channel(sdma, sdmac->channel);
+}
+
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
@@ -706,8 +753,10 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (1) {
-		bd = &sdmac->bd[sdmac->buf_tail];
+	while (sdmac->desc) {
+		struct sdma_desc *desc = sdmac->desc;
+
+		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
@@ -723,11 +772,11 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		* the number of bytes present in the current buffer descriptor.
 		*/
 
-		sdmac->chn_real_count = bd->mode.count;
+		desc->chn_real_count = bd->mode.count;
 		bd->mode.status |= BD_DONE;
-		bd->mode.count = sdmac->period_len;
-		sdmac->buf_ptail = sdmac->buf_tail;
-		sdmac->buf_tail = (sdmac->buf_tail + 1) % sdmac->num_bd;
+		bd->mode.count = desc->period_len;
+		desc->buf_ptail = desc->buf_tail;
+		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
 
 		/*
 		 * The callback is called from the interrupt context in order
@@ -736,40 +785,36 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * executed.
 		 */
 
-		dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 
 		if (error)
 			sdmac->status = old_status;
 	}
 }
 
-static void mxc_sdma_handle_channel_normal(unsigned long data)
+static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
 	struct sdma_buffer_descriptor *bd;
 	int i, error = 0;
 
-	sdmac->chn_real_count = 0;
+	sdmac->desc->chn_real_count = 0;
 	/*
 	 * non loop mode. Iterate over all descriptors, collect
 	 * errors and call callback function
 	 */
-	for (i = 0; i < sdmac->num_bd; i++) {
-		bd = &sdmac->bd[i];
+	for (i = 0; i < sdmac->desc->num_bd; i++) {
+		bd = &sdmac->desc->bd[i];
 
 		 if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
-		 sdmac->chn_real_count += bd->mode.count;
+		 sdmac->desc->chn_real_count += bd->mode.count;
 	}
 
 	if (error)
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->desc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -785,13 +830,22 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 	while (stat) {
 		int channel = fls(stat) - 1;
 		struct sdma_channel *sdmac = &sdma->channel[channel];
-
-		if (sdmac->flags & IMX_DMA_SG_LOOP)
-			sdma_update_channel_loop(sdmac);
-		else
-			tasklet_schedule(&sdmac->tasklet);
+		struct sdma_desc *desc;
+
+		spin_lock(&sdmac->vc.lock);
+		desc = sdmac->desc;
+		if (desc) {
+			if (sdmac->flags & IMX_DMA_SG_LOOP) {
+				sdma_update_channel_loop(sdmac);
+			} else {
+				mxc_sdma_handle_channel_normal(sdmac);
+				vchan_cookie_complete(&desc->vd);
+				sdma_start_desc(sdmac);
+			}
+		}
 
 		__clear_bit(channel, &stat);
+		spin_unlock(&sdmac->vc.lock);
 	}
 
 	return IRQ_HANDLED;
@@ -897,7 +951,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	int ret;
 	unsigned long flags;
 
@@ -946,7 +1000,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -968,7 +1022,16 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
 static int sdma_disable_channel_with_delay(struct dma_chan *chan)
 {
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
 	sdma_disable_channel(chan);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	sdmac->desc = NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
 
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
@@ -1097,42 +1160,55 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 	return 0;
 }
 
-static int sdma_request_channel(struct sdma_channel *sdmac)
+static int sdma_request_channel0(struct sdma_engine *sdma)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
-	int ret = -EBUSY;
+	int ret = 0;
 
-	sdmac->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdmac->bd_phys,
+	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
 					GFP_KERNEL);
-	if (!sdmac->bd) {
+	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	sdma->channel_control[0].base_bd_ptr = sdma->bd0_phys;
+	sdma->channel_control[0].current_bd_ptr = sdma->bd0_phys;
 
-	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
+	sdma_set_channel_priority(&sdma->channel[0], MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
 out:
-
 	return ret;
 }
 
-static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
+static int sdma_alloc_bd(struct sdma_desc *desc)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
-	dma_cookie_t cookie;
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	int ret = 0;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
+	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
+					GFP_KERNEL);
+	if (!desc->bd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+out:
+
+	return ret;
+}
 
-	cookie = dma_cookie_assign(tx);
+static void sdma_free_bd(struct sdma_desc *desc)
+{
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 
-	spin_unlock_irqrestore(&sdmac->lock, flags);
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+}
+
+static void sdma_desc_free(struct virt_dma_desc *vd)
+{
+	struct sdma_desc *desc = container_of(vd, struct sdma_desc, vd);
 
-	return cookie;
+	sdma_free_bd(desc);
+	kfree(desc);
 }
 
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
@@ -1168,19 +1244,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ipg;
 
-	ret = sdma_request_channel(sdmac);
-	if (ret)
-		goto disable_clk_ahb;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->desc, chan);
-	sdmac->desc.tx_submit = sdma_tx_submit;
-	/* txd.flags will be overwritten in prep funcs */
-	sdmac->desc.flags = DMA_CTRL_ACK;
-
 	return 0;
 
 disable_clk_ahb:
@@ -1195,7 +1262,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 
-	sdma_disable_channel(chan);
+	sdma_disable_channel_with_delay(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1207,8 +1274,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
@@ -1223,6 +1288,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
+	struct sdma_desc *desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1230,9 +1296,20 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = sg_len;
+	desc->chn_real_count = 0;
+
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_out;
+	}
 
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
@@ -1240,18 +1317,18 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	sdmac->direction = direction;
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (sg_len > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, sg_len, NUM_BD);
 		ret = -EINVAL;
-		goto err_out;
+		goto err_bd_out;
 	}
 
-	sdmac->chn_count = 0;
+	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = sg->dma_address;
@@ -1262,33 +1339,33 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
-		sdmac->chn_count += count;
+		desc->chn_count += count;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		switch (sdmac->word_size) {
 		case DMA_SLAVE_BUSWIDTH_4_BYTES:
 			bd->mode.command = 0;
 			if (count & 3 || sg->dma_address & 3)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_1_BYTE:
 			bd->mode.command = 1;
 			break;
 		default:
-			return NULL;
+			goto err_bd_out;
 		}
 
 		param = BD_DONE | BD_EXTD | BD_CONT;
@@ -1307,10 +1384,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	sdmac->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
-
-	return &sdmac->desc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1326,6 +1403,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1334,31 +1412,43 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
-	sdmac->period_len = period_len;
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = num_periods;
+	desc->chn_real_count = 0;
+	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
+
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_out;
+	}
+
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (num_periods > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, num_periods, NUM_BD);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	while (buf < buf_len) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = dma_addr;
@@ -1366,7 +1456,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1389,10 +1479,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	sdmac->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
-
-	return &sdmac->desc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1432,12 +1522,30 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	u32 residue;
+	struct virt_dma_desc *vd;
+	struct sdma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
 
-	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (sdmac->num_bd - sdmac->buf_ptail) *
-			   sdmac->period_len - sdmac->chn_real_count;
-	else
-		residue = sdmac->chn_count - sdmac->chn_real_count;
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vd = vchan_find_desc(&sdmac->vc, cookie);
+	if (vd) {
+		desc = to_sdma_desc(&vd->tx);
+		if (sdmac->flags & IMX_DMA_SG_LOOP)
+			residue = (desc->num_bd - desc->buf_ptail) *
+				desc->period_len - desc->chn_real_count;
+		else
+			residue = desc->chn_count - desc->chn_real_count;
+	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie) {
+		residue = sdmac->desc->chn_count - sdmac->desc->chn_real_count;
+	} else {
+		residue = 0;
+	}
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
@@ -1448,10 +1556,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 static void sdma_issue_pending(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	unsigned long flags;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		sdma_enable_channel(sdma, sdmac->channel);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	if (vchan_issue_pending(&sdmac->vc) && !sdmac->desc)
+		sdma_start_desc(sdmac);
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
@@ -1657,7 +1767,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++)
 		writel_relaxed(0, sdma->regs + SDMA_CHNPRI_0 + i * 4);
 
-	ret = sdma_request_channel(&sdma->channel[0]);
+	ret = sdma_request_channel0(sdma);
 	if (ret)
 		goto err_dma_alloc;
 
@@ -1821,20 +1931,15 @@ static int sdma_probe(struct platform_device *pdev)
 		sdmac->sdma = sdma;
 		spin_lock_init(&sdmac->lock);
 
-		sdmac->chan.device = &sdma->dma_device;
-		dma_cookie_init(&sdmac->chan);
 		sdmac->channel = i;
-
-		tasklet_init(&sdmac->tasklet, mxc_sdma_handle_channel_normal,
-			     (unsigned long) sdmac);
+		sdmac->vc.desc_free = sdma_desc_free;
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
 		 * that channel 0 in dmaengine counting matches sdma channel 1.
 		 */
 		if (i)
-			list_add_tail(&sdmac->chan.device_node,
-					&sdma->dma_device.channels);
+			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
 	ret = sdma_init(sdma);
@@ -1939,7 +2044,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4
