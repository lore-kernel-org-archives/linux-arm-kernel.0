From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Wed,  8 Aug 2012 11:15:01 +0800
Subject: [PATCH v2 4/4] mtd: pxa3xx-nand: replace pxa_request_dma with
 dmaengine
In-Reply-To: <1344395701-30888-1-git-send-email-zhangfei.gao@marvell.com>
References: <1344395701-30888-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1344395701-30888-5-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  113 ++++++++++++++++++++++------------------
 1 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index c5ea313..2768826 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -22,8 +22,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/dmaengine.h>
 
-#include <mach/dma.h>
 #include <plat/pxa3xx_nand.h>
 
 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
@@ -162,8 +162,7 @@ struct pxa3xx_nand_info {
 	unsigned char		*data_buff;
 	unsigned char		*oob_buff;
 	dma_addr_t 		data_buff_phys;
-	int 			data_dma_ch;
-	struct pxa_dma_desc	*data_desc;
+	struct dma_chan		*data_dma_ch;
 	dma_addr_t 		data_desc_addr;
 
 	struct pxa3xx_nand_host *host[NUM_CHIP_SELECT];
@@ -332,14 +331,6 @@ static void pxa3xx_nand_stop(struct pxa3xx_nand_info *info)
 	nand_writel(info, NDSR, NDSR_MASK);
 }
 
-static void enable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
-{
-	uint32_t ndcr;
-
-	ndcr = nand_readl(info, NDCR);
-	nand_writel(info, NDCR, ndcr & ~int_mask);
-}
-
 static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
 {
 	uint32_t ndcr;
@@ -372,24 +363,38 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
 	}
 }
 
+static void dma_complete_func(void *data)
+{
+	struct pxa3xx_nand_info *info = data;
+
+	info->state = STATE_DMA_DONE;
+}
+
 static void start_data_dma(struct pxa3xx_nand_info *info)
 {
-	struct pxa_dma_desc *desc = info->data_desc;
+	struct dma_device *dma_dev;
+	struct dma_async_tx_descriptor *tx = NULL;
+	dma_addr_t dma_src_addr, dma_dst_addr;
+	dma_cookie_t cookie;
 	int dma_len = ALIGN(info->data_size + info->oob_size, 32);
+	struct dma_slave_config conf;
 
-	desc->ddadr = DDADR_STOP;
-	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
+	dma_dev = info->data_dma_ch->device;
 
 	switch (info->state) {
 	case STATE_DMA_WRITING:
-		desc->dsadr = info->data_buff_phys;
-		desc->dtadr = info->mmio_phys + NDDB;
-		desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG;
+		dma_src_addr = info->data_buff_phys;
+		dma_dst_addr = info->mmio_phys + NDDB;
+		conf.direction = DMA_MEM_TO_DEV;
+		conf.dst_maxburst = 32;
+		conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	case STATE_DMA_READING:
-		desc->dtadr = info->data_buff_phys;
-		desc->dsadr = info->mmio_phys + NDDB;
-		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
+		dma_src_addr = info->mmio_phys + NDDB;
+		dma_dst_addr = info->data_buff_phys;
+		conf.direction = DMA_DEV_TO_MEM;
+		conf.src_maxburst = 32;
+		conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	default:
 		dev_err(&info->pdev->dev, "%s: invalid state %d\n", __func__,
@@ -397,26 +402,27 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
 		BUG();
 	}
 
-	DRCMR(info->drcmr_dat) = DRCMR_MAPVLD | info->data_dma_ch;
-	DDADR(info->data_dma_ch) = info->data_desc_addr;
-	DCSR(info->data_dma_ch) |= DCSR_RUN;
-}
-
-static void pxa3xx_nand_data_dma_irq(int channel, void *data)
-{
-	struct pxa3xx_nand_info *info = data;
-	uint32_t dcsr;
+	conf.slave_id = info->drcmr_dat;
+	dmaengine_slave_config(info->data_dma_ch, &conf);
+	tx = dma_dev->device_prep_dma_memcpy(info->data_dma_ch, dma_dst_addr,
+					     dma_src_addr, dma_len, 0);
+	if (!tx) {
+		dev_err(&info->pdev->dev, "Failed to prepare DMA memcpy\n");
+		return;
+	}
 
-	dcsr = DCSR(channel);
-	DCSR(channel) = dcsr;
+	tx->callback = dma_complete_func;
+	tx->callback_param = info;
 
-	if (dcsr & DCSR_BUSERR) {
-		info->retcode = ERR_DMABUSERR;
+	cookie = tx->tx_submit(tx);
+	if (dma_submit_error(cookie)) {
+		dev_err(&info->pdev->dev, "Failed to do DMA tx_submit\n");
+		return;
 	}
 
-	info->state = STATE_DMA_DONE;
-	enable_int(info, NDCR_INT_MASK);
-	nand_writel(info, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
+	dma_async_issue_pending(info->data_dma_ch);
+
+	return;
 }
 
 static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
@@ -434,6 +440,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	}
 
 	status = nand_readl(info, NDSR);
+	nand_writel(info, NDSR, status);
 
 	if (status & NDSR_DBERR)
 		info->retcode = ERR_DBERR;
@@ -442,7 +449,6 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {
 		/* whether use dma to transfer data */
 		if (info->use_dma) {
-			disable_int(info, NDCR_INT_MASK);
 			info->state = (status & NDSR_RDDREQ) ?
 				      STATE_DMA_READING : STATE_DMA_WRITING;
 			start_data_dma(info);
@@ -757,6 +763,9 @@ static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
+	if (len > mtd->oobsize)
+		info->use_dma = use_dma;
+
 	memcpy(buf, info->data_buff + info->buf_start, real_len);
 	info->buf_start += real_len;
 }
@@ -768,6 +777,9 @@ static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
+	if (len > mtd->oobsize)
+		info->use_dma = use_dma;
+
 	memcpy(info->data_buff + info->buf_start, buf, real_len);
 	info->buf_start += real_len;
 }
@@ -886,7 +898,7 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
-	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
+	dma_cap_mask_t mask;
 
 	if (use_dma == 0) {
 		info->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
@@ -902,19 +914,20 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 		return -ENOMEM;
 	}
 
-	info->data_desc = (void *)info->data_buff + data_desc_offset;
-	info->data_desc_addr = info->data_buff_phys + data_desc_offset;
 
-	info->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
-				pxa3xx_nand_data_dma_irq, info);
-	if (info->data_dma_ch < 0) {
-		dev_err(&pdev->dev, "failed to request data dma\n");
-		dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
-				info->data_buff, info->data_buff_phys);
-		return info->data_dma_ch;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	info->data_dma_ch = dma_request_channel(mask, NULL, NULL);
+	if (!info->data_dma_ch) {
+		dev_info(&pdev->dev, "Failed to request DMA channel\n");
+		goto dma_request_fail;
 	}
-
 	return 0;
+
+dma_request_fail:
+	dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
+			info->data_buff, info->data_buff_phys);
+	return -EAGAIN;
 }
 
 static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
@@ -1149,7 +1162,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 fail_free_buf:
 	free_irq(irq, info);
 	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
+		dma_release_channel(info->data_dma_ch);
 		dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
 			info->data_buff, info->data_buff_phys);
 	} else
@@ -1183,7 +1196,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	if (irq >= 0)
 		free_irq(irq, info);
 	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
+		dma_release_channel(info->data_dma_ch);
 		dma_free_writecombine(&pdev->dev, MAX_BUFF_SIZE,
 				info->data_buff, info->data_buff_phys);
 	} else
-- 
1.7.1
