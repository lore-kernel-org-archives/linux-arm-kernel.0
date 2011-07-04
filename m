From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  4 Jul 2011 21:18:34 +0900
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309781915-31549-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds to support DMA generic API to transfer raw
SPI data. Basiclly the spi driver uses DMA generic API if
architecture supports it. Otherwise, uses Samsung specific
S3C-PL330 APIs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/spi/spi_s3c64xx.c |  234 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 194 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 795828b..848487b 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -26,6 +26,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#if defined(CONFIG_DMADEV_PL330)
+#include <linux/dmaengine.h>
+#include <linux/amba/pl330.h>
+#endif
 
 #include <mach/dma.h>
 #include <plat/s3c64xx-spi.h>
@@ -174,11 +178,19 @@ struct s3c64xx_spi_driver_data {
 	unsigned                        state;
 	unsigned                        cur_mode, cur_bpw;
 	unsigned                        cur_speed;
+#if defined(CONFIG_DMADEV_PL330)
+	struct dma_chan *rx_chan;
+	struct dma_chan *tx_chan;
+	struct dma_async_tx_descriptor *rx_desc;
+	struct dma_async_tx_descriptor *tx_desc;
+#endif
 };
 
+#if !defined(CONFIG_DMADEV_PL330)
 static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
 	.name = "samsung-spi-dma",
 };
+#endif
 
 static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 {
@@ -229,6 +241,80 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_CH_CFG);
 }
 
+#if defined(CONFIG_DMADEV_PL330)
+static void s3c64xx_spi_dma_rxcb(void *data)
+{
+	struct s3c64xx_spi_driver_data *sdd
+		= (struct s3c64xx_spi_driver_data *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdd->lock, flags);
+
+	sdd->state &= ~RXBUSY;
+	/* If the other done */
+	if (!(sdd->state & TXBUSY))
+		complete(&sdd->xfer_completion);
+
+	spin_unlock_irqrestore(&sdd->lock, flags);
+}
+
+static void s3c64xx_spi_dma_txcb(void *data)
+{
+	struct s3c64xx_spi_driver_data *sdd
+		= (struct s3c64xx_spi_driver_data *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdd->lock, flags);
+
+	sdd->state &= ~TXBUSY;
+	/* If the other done */
+	if (!(sdd->state & RXBUSY))
+		complete(&sdd->xfer_completion);
+
+	spin_unlock_irqrestore(&sdd->lock, flags);
+}
+#else
+static void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
+				 int size, enum s3c2410_dma_buffresult res)
+{
+	struct s3c64xx_spi_driver_data *sdd = buf_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdd->lock, flags);
+
+	if (res == S3C2410_RES_OK)
+		sdd->state &= ~RXBUSY;
+	else
+		dev_err(&sdd->pdev->dev, "DmaAbrtRx-%d\n", size);
+
+	/* If the other done */
+	if (!(sdd->state & TXBUSY))
+		complete(&sdd->xfer_completion);
+
+	spin_unlock_irqrestore(&sdd->lock, flags);
+}
+
+static void s3c64xx_spi_dma_txcb(struct s3c2410_dma_chan *chan, void *buf_id,
+				 int size, enum s3c2410_dma_buffresult res)
+{
+	struct s3c64xx_spi_driver_data *sdd = buf_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdd->lock, flags);
+
+	if (res == S3C2410_RES_OK)
+		sdd->state &= ~TXBUSY;
+	else
+		dev_err(&sdd->pdev->dev, "DmaAbrtTx-%d\n", size);
+
+	/* If the other done */
+	if (!(sdd->state & RXBUSY))
+		complete(&sdd->xfer_completion);
+
+	spin_unlock_irqrestore(&sdd->lock, flags);
+}
+#endif
+
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi,
 				struct spi_transfer *xfer, int dma_mode)
@@ -236,6 +322,11 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
+#if defined(CONFIG_DMADEV_PL330)
+	struct dma_slave_config slave_config;
+	struct scatterlist tx_sg;
+	struct scatterlist rx_sg;
+#endif
 
 	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
 	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
@@ -261,10 +352,34 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
+#if defined(CONFIG_DMADEV_PL330)
+			memset(&slave_config, 0, sizeof(slave_config));
+			slave_config.direction = DMA_TO_DEVICE;
+			slave_config.src_addr = xfer->tx_dma;
+			slave_config.dst_addr =
+				sdd->sfr_start + S3C64XX_SPI_TX_DATA;
+			slave_config.dst_addr_width = sdd->cur_bpw / 8;
+			dmaengine_slave_config(sdd->tx_chan, &slave_config);
+
+			sg_init_table(&tx_sg, 1);
+			sg_set_page(&tx_sg, pfn_to_page(PFN_DOWN(xfer->tx_dma)),
+				xfer->len, offset_in_page(xfer->tx_dma));
+			sg_dma_len(&tx_sg) =  xfer->len;
+			sg_dma_address(&tx_sg) = xfer->tx_dma;
+			sdd->tx_desc =
+				sdd->tx_chan->device->device_prep_slave_sg(
+				sdd->tx_chan, &tx_sg, 1, DMA_TO_DEVICE,
+				DMA_PREP_INTERRUPT);
+			sdd->tx_desc->callback = s3c64xx_spi_dma_txcb;
+			sdd->tx_desc->callback_param = sdd;
+			dmaengine_submit(sdd->tx_desc);
+			dma_async_issue_pending(sdd->tx_chan);
+#else
 			s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8);
 			s3c2410_dma_enqueue(sdd->tx_dmach, (void *)sdd,
 						xfer->tx_dma, xfer->len);
 			s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
+#endif
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -296,10 +411,33 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
+#if defined(CONFIG_DMADEV_PL330)
+			slave_config.direction = DMA_FROM_DEVICE;
+			slave_config.dst_addr = xfer->rx_dma;
+			slave_config.src_addr =
+				sdd->sfr_start + S3C64XX_SPI_RX_DATA;
+			slave_config.src_addr_width = sdd->cur_bpw / 8;
+			dmaengine_slave_config(sdd->rx_chan, &slave_config);
+
+			sg_init_table(&rx_sg, 1);
+			sg_set_page(&rx_sg, pfn_to_page(PFN_DOWN(xfer->rx_dma)),
+				xfer->len, offset_in_page(xfer->rx_dma));
+			sg_dma_len(&rx_sg) =  xfer->len;
+			sg_dma_address(&rx_sg) = xfer->rx_dma;
+			sdd->rx_desc =
+				sdd->rx_chan->device->device_prep_slave_sg(
+				sdd->rx_chan, &rx_sg, 1, DMA_FROM_DEVICE,
+				DMA_PREP_INTERRUPT);
+			sdd->rx_desc->callback = s3c64xx_spi_dma_rxcb;
+			sdd->rx_desc->callback_param = sdd;
+			dmaengine_submit(sdd->rx_desc);
+			dma_async_issue_pending(sdd->rx_chan);
+#else
 			s3c2410_dma_config(sdd->rx_dmach, sdd->cur_bpw / 8);
 			s3c2410_dma_enqueue(sdd->rx_dmach, (void *)sdd,
 						xfer->rx_dma, xfer->len);
 			s3c2410_dma_ctrl(sdd->rx_dmach, S3C2410_DMAOP_START);
+#endif
 		}
 	}
 
@@ -485,46 +623,6 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	}
 }
 
-static void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
-				 int size, enum s3c2410_dma_buffresult res)
-{
-	struct s3c64xx_spi_driver_data *sdd = buf_id;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdd->lock, flags);
-
-	if (res == S3C2410_RES_OK)
-		sdd->state &= ~RXBUSY;
-	else
-		dev_err(&sdd->pdev->dev, "DmaAbrtRx-%d\n", size);
-
-	/* If the other done */
-	if (!(sdd->state & TXBUSY))
-		complete(&sdd->xfer_completion);
-
-	spin_unlock_irqrestore(&sdd->lock, flags);
-}
-
-static void s3c64xx_spi_dma_txcb(struct s3c2410_dma_chan *chan, void *buf_id,
-				 int size, enum s3c2410_dma_buffresult res)
-{
-	struct s3c64xx_spi_driver_data *sdd = buf_id;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdd->lock, flags);
-
-	if (res == S3C2410_RES_OK)
-		sdd->state &= ~TXBUSY;
-	else
-		dev_err(&sdd->pdev->dev, "DmaAbrtTx-%d \n", size);
-
-	/* If the other done */
-	if (!(sdd->state & RXBUSY))
-		complete(&sdd->xfer_completion);
-
-	spin_unlock_irqrestore(&sdd->lock, flags);
-}
-
 #define XFER_DMAADDR_INVALID DMA_BIT_MASK(32)
 
 static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
@@ -699,12 +797,20 @@ static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
 			if (use_dma) {
 				if (xfer->tx_buf != NULL
 						&& (sdd->state & TXBUSY))
+#if defined(CONFIG_DMADEV_PL330)
+					dmaengine_terminate_all(sdd->tx_chan);
+#else
 					s3c2410_dma_ctrl(sdd->tx_dmach,
 							S3C2410_DMAOP_FLUSH);
+#endif
 				if (xfer->rx_buf != NULL
 						&& (sdd->state & RXBUSY))
+#if defined(CONFIG_DMADEV_PL330)
+					dmaengine_terminate_all(sdd->rx_chan);
+#else
 					s3c2410_dma_ctrl(sdd->rx_dmach,
 							S3C2410_DMAOP_FLUSH);
+#endif
 			}
 
 			goto out;
@@ -742,8 +848,50 @@ out:
 		msg->complete(msg->context);
 }
 
+#if defined(CONFIG_DMADEV_PL330)
+static bool rxfilter(struct dma_chan *chan, void *param)
+{
+	struct s3c64xx_spi_driver_data *sdd
+		= (struct s3c64xx_spi_driver_data *)param;
+	struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
+
+	if (peri->peri_id != sdd->rx_dmach)
+		return false;
+
+	return true;
+}
+static bool txfilter(struct dma_chan *chan, void *param)
+{
+	struct s3c64xx_spi_driver_data *sdd
+		= (struct s3c64xx_spi_driver_data *)param;
+	struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
+
+	if (peri->peri_id != sdd->tx_dmach)
+		return false;
+
+	return true;
+}
+#endif
+
 static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
 {
+#if defined(CONFIG_DMADEV_PL330)
+	dma_cap_mask_t mask;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	sdd->rx_chan =
+		dma_request_channel(mask, rxfilter, (void *)sdd);
+	if (!sdd->rx_chan) {
+		dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");
+		return 0;
+	}
+	sdd->tx_chan =
+		dma_request_channel(mask, txfilter, (void *)sdd);
+	if (!sdd->tx_chan) {
+		dev_err(&sdd->pdev->dev, "cannot get TxDMA\n");
+		return 0;
+	}
+#else
 	if (s3c2410_dma_request(sdd->rx_dmach,
 					&s3c64xx_spi_dma_client, NULL) < 0) {
 		dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");
@@ -762,6 +910,7 @@ static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
 	s3c2410_dma_set_buffdone_fn(sdd->tx_dmach, s3c64xx_spi_dma_txcb);
 	s3c2410_dma_devconfig(sdd->tx_dmach, S3C2410_DMASRC_MEM,
 					sdd->sfr_start + S3C64XX_SPI_TX_DATA);
+#endif
 
 	return 1;
 }
@@ -802,8 +951,13 @@ static void s3c64xx_spi_work(struct work_struct *work)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	/* Free DMA channels */
+#if defined(CONFIG_DMADEV_PL330)
+	dma_release_channel(sdd->tx_chan);
+	dma_release_channel(sdd->rx_chan);
+#else
 	s3c2410_dma_free(sdd->tx_dmach, &s3c64xx_spi_dma_client);
 	s3c2410_dma_free(sdd->rx_dmach, &s3c64xx_spi_dma_client);
+#endif
 }
 
 static int s3c64xx_spi_transfer(struct spi_device *spi,
-- 
1.7.1
