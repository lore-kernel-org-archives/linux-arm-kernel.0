From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:42 +0900
Subject: [PATCH v8 14/16] spi/s3c64xx: Merge dma control code
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-15-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies to merge the dma control code. Original
s3c64xx spi driver has each dma control code for rx and tx
channel. This patch merges these dma control codes into one.
With this patch, a dma setup function and callback function
handle for both rx and tx channel.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |  140 ++++++++++++++++++++++++--------------------
 1 files changed, 76 insertions(+), 64 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 24f4903..019a716 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -131,6 +131,12 @@
 #define RXBUSY    (1<<2)
 #define TXBUSY    (1<<3)
 
+struct s3c64xx_spi_dma_data {
+	unsigned		ch;
+	enum dma_data_direction direction;
+	enum dma_ch	dmach;
+};
+
 /**
  * struct s3c64xx_spi_driver_data - Runtime info holder for SPI driver.
  * @clk: Pointer to the spi clock.
@@ -164,15 +170,13 @@ struct s3c64xx_spi_driver_data {
 	struct work_struct              work;
 	struct list_head                queue;
 	spinlock_t                      lock;
-	enum dma_ch                     rx_dmach;
-	enum dma_ch                     tx_dmach;
 	unsigned long                   sfr_start;
 	struct completion               xfer_completion;
 	unsigned                        state;
 	unsigned                        cur_mode, cur_bpw;
 	unsigned                        cur_speed;
-	unsigned			rx_ch;
-	unsigned			tx_ch;
+	struct s3c64xx_spi_dma_data	rx_dma;
+	struct s3c64xx_spi_dma_data	tx_dma;
 	struct samsung_dma_ops		*ops;
 };
 
@@ -229,36 +233,76 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_CH_CFG);
 }
 
-static void s3c64xx_spi_dma_rxcb(void *data)
+static void s3c64xx_spi_dmacb(void *data)
 {
-	struct s3c64xx_spi_driver_data *sdd
-		= (struct s3c64xx_spi_driver_data *)data;
+	struct s3c64xx_spi_driver_data *sdd;
+	struct s3c64xx_spi_dma_data *dma = data;
 	unsigned long flags;
 
+	if (dma->direction == DMA_FROM_DEVICE)
+		sdd = container_of(data,
+			struct s3c64xx_spi_driver_data, rx_dma);
+	else
+		sdd = container_of(data,
+			struct s3c64xx_spi_driver_data, tx_dma);
+
 	spin_lock_irqsave(&sdd->lock, flags);
 
-	sdd->state &= ~RXBUSY;
-	/* If the other done */
-	if (!(sdd->state & TXBUSY))
-		complete(&sdd->xfer_completion);
+	if (dma->direction == DMA_FROM_DEVICE) {
+		sdd->state &= ~RXBUSY;
+		if (!(sdd->state & TXBUSY))
+			complete(&sdd->xfer_completion);
+	} else {
+		sdd->state &= ~TXBUSY;
+		if (!(sdd->state & RXBUSY))
+			complete(&sdd->xfer_completion);
+	}
 
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static void s3c64xx_spi_dma_txcb(void *data)
+static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
+					unsigned len, dma_addr_t buf)
 {
-	struct s3c64xx_spi_driver_data *sdd
-		= (struct s3c64xx_spi_driver_data *)data;
-	unsigned long flags;
+	struct s3c64xx_spi_driver_data *sdd;
+	struct samsung_dma_prep_info info;
 
-	spin_lock_irqsave(&sdd->lock, flags);
+	if (dma->direction == DMA_FROM_DEVICE)
+		sdd = container_of((void *)dma,
+			struct s3c64xx_spi_driver_data, rx_dma);
+	else
+		sdd = container_of((void *)dma,
+			struct s3c64xx_spi_driver_data, tx_dma);
 
-	sdd->state &= ~TXBUSY;
-	/* If the other done */
-	if (!(sdd->state & RXBUSY))
-		complete(&sdd->xfer_completion);
+	info.cap = DMA_SLAVE;
+	info.len = len;
+	info.fp = s3c64xx_spi_dmacb;
+	info.fp_param = dma;
+	info.direction = dma->direction;
+	info.buf = buf;
+
+	sdd->ops->prepare(dma->ch, &info);
+	sdd->ops->trigger(dma->ch);
+}
 
-	spin_unlock_irqrestore(&sdd->lock, flags);
+static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
+{
+	struct samsung_dma_info info;
+
+	sdd->ops = samsung_dma_get_ops();
+
+	info.cap = DMA_SLAVE;
+	info.client = &s3c64xx_spi_dma_client;
+	info.width = sdd->cur_bpw / 8;
+
+	info.direction = sdd->rx_dma.direction;
+	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
+	sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &info);
+	info.direction =  sdd->tx_dma.direction;
+	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
+	sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &info);
+
+	return 1;
 }
 
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
@@ -268,7 +312,6 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
-	struct samsung_dma_prep_info info;
 
 	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
 	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
@@ -294,14 +337,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			info.cap = DMA_SLAVE;
-			info.direction = DMA_TO_DEVICE;
-			info.buf = xfer->tx_dma;
-			info.len = xfer->len;
-			info.fp = s3c64xx_spi_dma_txcb;
-			info.fp_param = sdd;
-			sdd->ops->prepare(sdd->tx_ch, &info);
-			sdd->ops->trigger(sdd->tx_ch);
+			prepare_dma(&sdd->tx_dma, xfer->len, xfer->tx_dma);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -333,14 +369,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			info.cap = DMA_SLAVE;
-			info.direction = DMA_FROM_DEVICE;
-			info.buf = xfer->rx_dma;
-			info.len = xfer->len;
-			info.fp = s3c64xx_spi_dma_rxcb;
-			info.fp_param = sdd;
-			sdd->ops->prepare(sdd->rx_ch, &info);
-			sdd->ops->trigger(sdd->rx_ch);
+			prepare_dma(&sdd->rx_dma, xfer->len, xfer->rx_dma);
 		}
 	}
 
@@ -700,10 +729,10 @@ static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
 			if (use_dma) {
 				if (xfer->tx_buf != NULL
 						&& (sdd->state & TXBUSY))
-					sdd->ops->stop(sdd->tx_ch);
+					sdd->ops->stop(sdd->tx_dma.ch);
 				if (xfer->rx_buf != NULL
 						&& (sdd->state & RXBUSY))
-					sdd->ops->stop(sdd->rx_ch);
+					sdd->ops->stop(sdd->rx_dma.ch);
 			}
 
 			goto out;
@@ -741,25 +770,6 @@ out:
 		msg->complete(msg->context);
 }
 
-static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
-{
-
-	struct samsung_dma_info info;
-	sdd->ops = samsung_dma_get_ops();
-
-	info.cap = DMA_SLAVE;
-	info.client = &s3c64xx_spi_dma_client;
-	info.direction = DMA_FROM_DEVICE;
-	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
-	info.width = sdd->cur_bpw / 8;
-	sdd->rx_ch = sdd->ops->request(sdd->rx_dmach, &info);
-	info.direction = DMA_TO_DEVICE;
-	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
-	sdd->tx_ch = sdd->ops->request(sdd->tx_dmach, &info);
-
-	return 1;
-}
-
 static void s3c64xx_spi_work(struct work_struct *work)
 {
 	struct s3c64xx_spi_driver_data *sdd = container_of(work,
@@ -796,8 +806,8 @@ static void s3c64xx_spi_work(struct work_struct *work)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	/* Free DMA channels */
-	sdd->ops->release(sdd->rx_ch, &s3c64xx_spi_dma_client);
-	sdd->ops->release(sdd->tx_ch, &s3c64xx_spi_dma_client);
+	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
+	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
 }
 
 static int s3c64xx_spi_transfer(struct spi_device *spi,
@@ -1014,8 +1024,10 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
-	sdd->tx_dmach = dmatx_res->start;
-	sdd->rx_dmach = dmarx_res->start;
+	sdd->tx_dma.dmach = dmatx_res->start;
+	sdd->tx_dma.direction = DMA_TO_DEVICE;
+	sdd->rx_dma.dmach = dmarx_res->start;
+	sdd->rx_dma.direction = DMA_FROM_DEVICE;
 
 	sdd->cur_bpw = 8;
 
@@ -1103,7 +1115,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 					pdev->id, master->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
 					mem_res->end, mem_res->start,
-					sdd->rx_dmach, sdd->tx_dmach);
+					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
 	return 0;
 
-- 
1.7.1
