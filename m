From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:38 +0200
Subject: [PATCH 3/8] mxcmmc: use new dma api
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the mxcmmc driver to use the new DMA API. Unlike
the old one this one is always present in the tree, even if no DMA
is implement, hence we can remove all the #ifdefs in from the driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxcmmc.c |  129 +++++++++++++++++++++++---------------------
 1 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 350f78e..a71c2a6 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -37,10 +37,7 @@
 #include <asm/sizes.h>
 #include <mach/mmc.h>
 
-#ifdef CONFIG_ARCH_MX2
-#include <mach/dma-mx1-mx2.h>
-#define HAS_DMA
-#endif
+#include <mach/dma.h>
 
 #define DRIVER_NAME "mxc-mmc"
 
@@ -141,6 +138,9 @@ struct mxcmci_host {
 
 	struct work_struct	datawork;
 	spinlock_t		lock;
+
+	int			burstlen;
+	int			dmareq;
 };
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
@@ -166,17 +166,17 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 
 	writew(0xff, host->base + MMC_REG_RES_TO);
 }
+static int mxcmci_setup_dma(struct mmc_host *mmc);
 
 static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 {
 	unsigned int nob = data->blocks;
 	unsigned int blksz = data->blksz;
 	unsigned int datasize = nob * blksz;
-#ifdef HAS_DMA
 	struct scatterlist *sg;
 	int i;
 	int ret;
-#endif
+
 	if (data->flags & MMC_DATA_STREAM)
 		nob = 0xffff;
 
@@ -187,7 +187,9 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	writew(blksz, host->base + MMC_REG_BLK_LEN);
 	host->datasize = datasize;
 
-#ifdef HAS_DMA
+	if (!mxcmci_use_dma(host))
+		return 0;
+
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		if (sg->offset & 3 || sg->length & 3) {
 			host->do_dma = 0;
@@ -200,19 +202,15 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		host->dma_nents = dma_map_sg(mmc_dev(host->mmc), data->sg,
 					     data->sg_len,  host->dma_dir);
 
-		ret = imx_dma_setup_sg(host->dma, data->sg, host->dma_nents,
-				datasize,
-				host->res->start + MMC_REG_BUFFER_ACCESS,
-				DMA_MODE_READ);
+		ret = imxdma_setup_sg(host->dma, data->sg, host->dma_nents,
+			datasize, DMA_MODE_READ);
 	} else {
 		host->dma_dir = DMA_TO_DEVICE;
 		host->dma_nents = dma_map_sg(mmc_dev(host->mmc), data->sg,
 					     data->sg_len,  host->dma_dir);
 
-		ret = imx_dma_setup_sg(host->dma, data->sg, host->dma_nents,
-				datasize,
-				host->res->start + MMC_REG_BUFFER_ACCESS,
-				DMA_MODE_WRITE);
+		ret = imxdma_setup_sg(host->dma, data->sg, host->dma_nents,
+			datasize, DMA_MODE_WRITE);
 	}
 
 	if (ret) {
@@ -221,8 +219,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	}
 	wmb();
 
-	imx_dma_enable(host->dma);
-#endif /* HAS_DMA */
+	imxdma_enable(host->dma);
+
 	return 0;
 }
 
@@ -297,13 +295,11 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	int data_error;
 
-#ifdef HAS_DMA
 	if (mxcmci_use_dma(host)) {
-		imx_dma_disable(host->dma);
+		imxdma_disable(host->dma);
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_nents,
 				host->dma_dir);
 	}
-#endif
 
 	if (stat & STATUS_ERR_MASK) {
 		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
@@ -505,7 +501,6 @@ static void mxcmci_datawork(struct work_struct *work)
 	}
 }
 
-#ifdef HAS_DMA
 static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 {
 	struct mmc_data *data = host->data;
@@ -528,7 +523,6 @@ static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 		mxcmci_finish_request(host, host->req);
 	}
 }
-#endif /* HAS_DMA */
 
 static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
 {
@@ -566,12 +560,10 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 	sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-#ifdef HAS_DMA
 	if (mxcmci_use_dma(host) &&
 	    (stat & (STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE)))
 		writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
 			host->base + MMC_REG_STATUS);
-#endif
 
 	if (sdio_irq) {
 		writel(STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
@@ -581,14 +573,14 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 	if (stat & STATUS_END_CMD_RESP)
 		mxcmci_cmd_done(host, stat);
 
-#ifdef HAS_DMA
 	if (mxcmci_use_dma(host) &&
 		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
 		mxcmci_data_done(host, stat);
-#endif
+
 	if (host->default_irq_mask &&
 		  (stat & (STATUS_CARD_INSERTION | STATUS_CARD_REMOVAL)))
 		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
+
 	return IRQ_HANDLED;
 }
 
@@ -602,9 +594,7 @@ static void mxcmci_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	host->req = req;
 	host->cmdat &= ~CMD_DAT_CONT_INIT;
-#ifdef HAS_DMA
-	host->do_dma = 1;
-#endif
+
 	if (req->data) {
 		error = mxcmci_setup_data(host, req->data);
 		if (error) {
@@ -658,22 +648,48 @@ static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios)
 			prescaler, divider, clk_in, clk_ios);
 }
 
+static int mxcmci_setup_dma(struct mmc_host *mmc)
+{
+	struct mxcmci_host *host = mmc_priv(mmc);
+	struct imx_dma_config cfg;
+
+	cfg.burstlen = host->burstlen;
+	cfg.dma_address = host->res->start + MMC_REG_BUFFER_ACCESS;
+	cfg.word_size = 4;
+	cfg.peripheral_type = IMX_DMATYPE_SDHC;
+	cfg.dma_request = host->dmareq;
+	cfg.completion_handler = NULL;
+	cfg.driver_data = NULL;
+	cfg.flags = 0;
+
+	return imxdma_config(host->dma, &cfg);
+}
+
 static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mxcmci_host *host = mmc_priv(mmc);
-#ifdef HAS_DMA
-	unsigned int blen;
+	int burstlen, ret;
+
 	/*
 	 * use burstlen of 64 in 4 bit mode (--> reg value  0)
 	 * use burstlen of 16 in 1 bit mode (--> reg value 16)
 	 */
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
-		blen = 0;
+		burstlen = 64;
 	else
-		blen = 16;
+		burstlen = 16;
+
+	if (mxcmci_use_dma(host) && burstlen != host->burstlen) {
+		host->burstlen = burstlen;
+		ret = mxcmci_setup_dma(mmc);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to config DMA channel. Falling back to PIO\n");
+			imxdma_free(host->dma);
+			host->do_dma = 0;
+		}
+	}
 
-	imx_dma_config_burstlen(host->dma, blen);
-#endif
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		host->cmdat |= CMD_DAT_CONT_BUS_WIDTH_4;
 	else
@@ -795,7 +811,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
+	mmc->max_seg_size = 65535;
 
 	host = mmc_priv(mmc);
 	host->base = ioremap(r->start, resource_size(r));
@@ -847,29 +863,18 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	writel(host->default_irq_mask, host->base + MMC_REG_INT_CNTR);
 
-#ifdef HAS_DMA
-	host->dma = imx_dma_request_by_prio(DRIVER_NAME, DMA_PRIO_LOW);
-	if (host->dma < 0) {
-		dev_err(mmc_dev(host->mmc), "imx_dma_request_by_prio failed\n");
-		ret = -EBUSY;
-		goto out_clk_put;
+	host->dma = imxdma_request(DMA_PRIO_LOW);
+	if (host->dma >= 0) {
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (r) {
+			host->dmareq = r->start;
+			host->do_dma = 1;
+		}
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r) {
-		ret = -EINVAL;
-		goto out_free_dma;
-	}
+	if (!host->do_dma)
+		dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
 
-	ret = imx_dma_config_channel(host->dma,
-				     IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_FIFO,
-				     IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR,
-				     r->start, 0);
-	if (ret) {
-		dev_err(mmc_dev(host->mmc), "failed to config DMA channel\n");
-		goto out_free_dma;
-	}
-#endif
 	INIT_WORK(&host->datawork, mxcmci_datawork);
 
 	ret = request_irq(host->irq, mxcmci_irq, 0, DRIVER_NAME, host);
@@ -892,9 +897,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 out_free_irq:
 	free_irq(host->irq, host);
 out_free_dma:
-#ifdef HAS_DMA
-	imx_dma_free(host->dma);
-#endif
+	if (host->dma >= 0)
+		imxdma_free(host->dma);
 out_clk_put:
 	clk_disable(host->clk);
 	clk_put(host->clk);
@@ -921,9 +925,10 @@ static int mxcmci_remove(struct platform_device *pdev)
 
 	free_irq(host->irq, host);
 	iounmap(host->base);
-#ifdef HAS_DMA
-	imx_dma_free(host->dma);
-#endif
+
+	if (host->dma >= 0)
+		imxdma_free(host->dma);
+
 	clk_disable(host->clk);
 	clk_put(host->clk);
 
-- 
1.7.1
