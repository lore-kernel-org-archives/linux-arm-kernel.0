From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 25 Aug 2011 11:13:42 +0900
Subject: [PATCH v7 12/15] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314238425-6480-13-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to support DMA generic API to transfer raw
SPI data. Basiclly the spi driver uses DMA generic API if
architecture supports it. Otherwise, uses Samsung specific
S3C-PL330 APIs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |  141 ++++++++++++++++++++++-----------------------
 1 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 595dacc..24f4903 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -171,6 +171,9 @@ struct s3c64xx_spi_driver_data {
 	unsigned                        state;
 	unsigned                        cur_mode, cur_bpw;
 	unsigned                        cur_speed;
+	unsigned			rx_ch;
+	unsigned			tx_ch;
+	struct samsung_dma_ops		*ops;
 };
 
 static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
@@ -226,6 +229,38 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_CH_CFG);
 }
 
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
+
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi,
 				struct spi_transfer *xfer, int dma_mode)
@@ -233,6 +268,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
+	struct samsung_dma_prep_info info;
 
 	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
 	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
@@ -258,10 +294,14 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8);
-			s3c2410_dma_enqueue(sdd->tx_dmach, (void *)sdd,
-						xfer->tx_dma, xfer->len);
-			s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
+			info.cap = DMA_SLAVE;
+			info.direction = DMA_TO_DEVICE;
+			info.buf = xfer->tx_dma;
+			info.len = xfer->len;
+			info.fp = s3c64xx_spi_dma_txcb;
+			info.fp_param = sdd;
+			sdd->ops->prepare(sdd->tx_ch, &info);
+			sdd->ops->trigger(sdd->tx_ch);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -293,10 +333,14 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			s3c2410_dma_config(sdd->rx_dmach, sdd->cur_bpw / 8);
-			s3c2410_dma_enqueue(sdd->rx_dmach, (void *)sdd,
-						xfer->rx_dma, xfer->len);
-			s3c2410_dma_ctrl(sdd->rx_dmach, S3C2410_DMAOP_START);
+			info.cap = DMA_SLAVE;
+			info.direction = DMA_FROM_DEVICE;
+			info.buf = xfer->rx_dma;
+			info.len = xfer->len;
+			info.fp = s3c64xx_spi_dma_rxcb;
+			info.fp_param = sdd;
+			sdd->ops->prepare(sdd->rx_ch, &info);
+			sdd->ops->trigger(sdd->rx_ch);
 		}
 	}
 
@@ -482,46 +526,6 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
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
@@ -696,12 +700,10 @@ static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
 			if (use_dma) {
 				if (xfer->tx_buf != NULL
 						&& (sdd->state & TXBUSY))
-					s3c2410_dma_ctrl(sdd->tx_dmach,
-							S3C2410_DMAOP_FLUSH);
+					sdd->ops->stop(sdd->tx_ch);
 				if (xfer->rx_buf != NULL
 						&& (sdd->state & RXBUSY))
-					s3c2410_dma_ctrl(sdd->rx_dmach,
-							S3C2410_DMAOP_FLUSH);
+					sdd->ops->stop(sdd->rx_ch);
 			}
 
 			goto out;
@@ -741,24 +743,19 @@ out:
 
 static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
 {
-	if (s3c2410_dma_request(sdd->rx_dmach,
-					&s3c64xx_spi_dma_client, NULL) < 0) {
-		dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");
-		return 0;
-	}
-	s3c2410_dma_set_buffdone_fn(sdd->rx_dmach, s3c64xx_spi_dma_rxcb);
-	s3c2410_dma_devconfig(sdd->rx_dmach, S3C2410_DMASRC_HW,
-					sdd->sfr_start + S3C64XX_SPI_RX_DATA);
-
-	if (s3c2410_dma_request(sdd->tx_dmach,
-					&s3c64xx_spi_dma_client, NULL) < 0) {
-		dev_err(&sdd->pdev->dev, "cannot get TxDMA\n");
-		s3c2410_dma_free(sdd->rx_dmach, &s3c64xx_spi_dma_client);
-		return 0;
-	}
-	s3c2410_dma_set_buffdone_fn(sdd->tx_dmach, s3c64xx_spi_dma_txcb);
-	s3c2410_dma_devconfig(sdd->tx_dmach, S3C2410_DMASRC_MEM,
-					sdd->sfr_start + S3C64XX_SPI_TX_DATA);
+
+	struct samsung_dma_info info;
+	sdd->ops = samsung_dma_get_ops();
+
+	info.cap = DMA_SLAVE;
+	info.client = &s3c64xx_spi_dma_client;
+	info.direction = DMA_FROM_DEVICE;
+	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
+	info.width = sdd->cur_bpw / 8;
+	sdd->rx_ch = sdd->ops->request(sdd->rx_dmach, &info);
+	info.direction = DMA_TO_DEVICE;
+	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
+	sdd->tx_ch = sdd->ops->request(sdd->tx_dmach, &info);
 
 	return 1;
 }
@@ -799,8 +796,8 @@ static void s3c64xx_spi_work(struct work_struct *work)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	/* Free DMA channels */
-	s3c2410_dma_free(sdd->tx_dmach, &s3c64xx_spi_dma_client);
-	s3c2410_dma_free(sdd->rx_dmach, &s3c64xx_spi_dma_client);
+	sdd->ops->release(sdd->rx_ch, &s3c64xx_spi_dma_client);
+	sdd->ops->release(sdd->tx_ch, &s3c64xx_spi_dma_client);
 }
 
 static int s3c64xx_spi_transfer(struct spi_device *spi,
-- 
1.7.1
