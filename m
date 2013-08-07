From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:50 +0200
Subject: [PATCH 01/20] mtd: pxa3xx-nand: replace pxa_request_dma with dmaengine
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@marvell.com>

[zonque at gmail.com: rebased in top of l2-mtd.git. The newly introduced
ARCH_HAS_DMA hack was changed into a check for CONFIG_HAS_DMA]

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 115 ++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 52 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index a2a54f6..736673a 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -24,14 +24,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-
-#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
-#define ARCH_HAS_DMA
-#endif
-
-#ifdef ARCH_HAS_DMA
-#include <mach/dma.h>
-#endif
+#include <linux/dmaengine.h>
 
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
@@ -172,9 +165,7 @@ struct pxa3xx_nand_info {
 	unsigned char		*data_buff;
 	unsigned char		*oob_buff;
 	dma_addr_t 		data_buff_phys;
-	int 			data_dma_ch;
-	struct pxa_dma_desc	*data_desc;
-	dma_addr_t 		data_desc_addr;
+	struct dma_chan		*data_dma_ch;
 
 	struct pxa3xx_nand_host *host[NUM_CHIP_SELECT];
 	unsigned int		state;
@@ -388,25 +379,39 @@ static void handle_data_pio(struct pxa3xx_nand_info *info)
 	}
 }
 
-#ifdef ARCH_HAS_DMA
+#ifdef CONFIG_HAS_DMA
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
@@ -414,26 +419,25 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
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
 }
 #else
 static void start_data_dma(struct pxa3xx_nand_info *info)
@@ -455,6 +459,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	}
 
 	status = nand_readl(info, NDSR);
+	nand_writel(info, NDSR, status);
 
 	if (status & NDSR_DBERR)
 		info->retcode = ERR_DBERR;
@@ -463,7 +468,6 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {
 		/* whether use dma to transfer data */
 		if (info->use_dma) {
-			disable_int(info, NDCR_INT_MASK);
 			info->state = (status & NDSR_RDDREQ) ?
 				      STATE_DMA_READING : STATE_DMA_WRITING;
 			start_data_dma(info);
@@ -792,6 +796,9 @@ static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
+	if (len > mtd->oobsize)
+		info->use_dma = use_dma;
+
 	memcpy(buf, info->data_buff + info->buf_start, real_len);
 	info->buf_start += real_len;
 }
@@ -803,6 +810,9 @@ static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
+	if (len > mtd->oobsize)
+		info->use_dma = use_dma;
+
 	memcpy(info->data_buff + info->buf_start, buf, real_len);
 	info->buf_start += real_len;
 }
@@ -908,11 +918,11 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
  */
 #define MAX_BUFF_SIZE	(PAGE_SIZE*2)
 
-#ifdef ARCH_HAS_DMA
+#ifdef CONFIG_HAS_DMA
 static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
-	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
+	dma_cap_mask_t mask;
 
 	if (use_dma == 0) {
 		info->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
@@ -928,26 +938,27 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 		return -ENOMEM;
 	}
 
-	info->data_desc = (void *)info->data_buff + data_desc_offset;
-	info->data_desc_addr = info->data_buff_phys + data_desc_offset;
-
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
 
 	return 0;
+
+dma_request_fail:
+	dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
+			info->data_buff, info->data_buff_phys);
+	return -EAGAIN;
 }
 
 static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
 	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
+		dma_release_channel(info->data_dma_ch);
 		dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
 				  info->data_buff, info->data_buff_phys);
 	} else {
@@ -1295,7 +1306,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	struct pxa3xx_nand_info *info;
 	int ret, cs, probe_success;
 
-#ifndef ARCH_HAS_DMA
+#ifndef CONFIG_HAS_DMA
 	if (use_dma) {
 		use_dma = 0;
 		dev_warn(&pdev->dev,
-- 
1.8.3.1
