From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sun,  1 Nov 2015 15:41:35 +0100
Subject: [PATCH v3 1/7] spi: imx: Fix DMA transfer
In-Reply-To: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1446388901-6073-2-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anton Bondarenko <anton_bondarenko@mentor.com>

RX DMA tail data handling doesn't work correctly in many cases with
current implementation. It happens because SPI core was setup
to generates both RX watermark level and RX DATA TAIL events
incorrectly. SPI transfer triggering for DMA also done in wrong way.

SPI client wants to transfer 70 words for example. The old DMA
implementation setup RX DATA TAIL equal 6 words. In this case
RX DMA event will be generated after 6 words read from RX FIFO.
The garbage can be read out from RX FIFO because SPI HW does
not receive all required words to trigger RX watermark event.

New implementation change handling of RX data tail. DMA is used to process
all TX data and only full chunks of RX data with size aligned to FIFO/2.
Driver is waiting until both TX and RX DMA transaction done and all
TX data are pushed out. At that moment there is only RX data tail in
the RX FIFO. This data read out using PIO.

Transfer triggering changed to avoid RX data loss.

Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 drivers/spi/spi-imx.c | 115 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 0e5723a..bd7b721 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -53,6 +53,7 @@
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
+#define MXC_INT_TCEN	BIT(7)   /* Transfer complete */
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
@@ -104,9 +105,7 @@ struct spi_imx_data {
 	unsigned int dma_is_inited;
 	unsigned int dma_finished;
 	bool usedma;
-	u32 rx_wml;
-	u32 tx_wml;
-	u32 rxt_wml;
+	u32 wml;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
 
@@ -201,9 +200,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (spi_imx->dma_is_inited
-	    && transfer->len > spi_imx->rx_wml * sizeof(u32)
-	    && transfer->len > spi_imx->tx_wml * sizeof(u32))
+	if (spi_imx->dma_is_inited && transfer->len > spi_imx->wml)
 		return true;
 	return false;
 }
@@ -228,6 +225,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
+#define MX51_ECSPI_INT_TCEN		BIT(7)
 
 #define MX51_ECSPI_DMA      0x14
 #define MX51_ECSPI_DMA_TX_WML_OFFSET	0
@@ -292,6 +290,9 @@ static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int
 	if (enable & MXC_INT_RR)
 		val |= MX51_ECSPI_INT_RREN;
 
+	if (enable & MXC_INT_TCEN)
+		val |= MX51_ECSPI_INT_TCEN;
+
 	writel(val, spi_imx->base + MX51_ECSPI_INT);
 }
 
@@ -311,8 +312,9 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
-	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
+	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+
 	u32 clk = config->speed_hz, delay;
 
 	/*
@@ -376,19 +378,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * and enable DMA request.
 	 */
 	if (spi_imx->dma_is_inited) {
-		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
-
-		spi_imx->rxt_wml = spi_imx_get_fifosize(spi_imx) / 2;
-		rx_wml_cfg = spi_imx->rx_wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
-		tx_wml_cfg = spi_imx->tx_wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
-		rxt_wml_cfg = spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET;
-		dma = (dma & ~MX51_ECSPI_DMA_TX_WML_MASK
-			   & ~MX51_ECSPI_DMA_RX_WML_MASK
-			   & ~MX51_ECSPI_DMA_RXT_WML_MASK)
-			   | rx_wml_cfg | tx_wml_cfg | rxt_wml_cfg
-			   |(1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
-			   |(1 << MX51_ECSPI_DMA_RXDEN_OFFSET)
-			   |(1 << MX51_ECSPI_DMA_RXTDEN_OFFSET);
+		dma = (spi_imx->wml - 1) << MX51_ECSPI_DMA_RX_WML_OFFSET
+		      | (1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
+		      | (1 << MX51_ECSPI_DMA_RXDEN_OFFSET);
 
 		writel(dma, spi_imx->base + MX51_ECSPI_DMA);
 	}
@@ -832,6 +824,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	if (of_machine_is_compatible("fsl,imx6dl"))
 		return 0;
 
+	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel(dev, "tx");
 	if (!master->dma_tx) {
@@ -843,7 +837,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	slave_config.direction = DMA_MEM_TO_DEV;
 	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
+	slave_config.dst_maxburst = spi_imx->wml;
 	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
 	if (ret) {
 		dev_err(dev, "error in TX dma configuration.\n");
@@ -861,7 +855,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	slave_config.direction = DMA_DEV_TO_MEM;
 	slave_config.src_addr = res->start + MXC_CSPIRXDATA;
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
+	slave_config.src_maxburst = spi_imx->wml;
 	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
 	if (ret) {
 		dev_err(dev, "error in RX dma configuration.\n");
@@ -874,8 +868,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
 					 SPI_MASTER_MUST_TX;
-	spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
-	spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
 	spi_imx->dma_is_inited = 1;
 
 	return 0;
@@ -904,8 +896,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	int ret;
 	unsigned long timeout;
-	u32 dma;
-	int left;
+	const int left = transfer->len % spi_imx->wml;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 
@@ -922,9 +913,23 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	}
 
 	if (rx) {
+		/* Cut RX data tail */
+		const unsigned int old_nents = rx->nents;
+
+		WARN_ON(sg_dma_len(&rx->sgl[rx->nents - 1]) < left);
+		sg_dma_len(&rx->sgl[rx->nents - 1]) -= left;
+		if (sg_dma_len(&rx->sgl[rx->nents - 1]) == 0)
+			--rx->nents;
+
 		desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
 					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+		/* Restore old SG table state */
+		if (old_nents > rx->nents)
+			++rx->nents;
+		sg_dma_len(&rx->sgl[rx->nents - 1]) += left;
+
 		if (!desc_rx)
 			goto no_dma;
 
@@ -939,17 +944,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	/* Trigger the cspi module. */
 	spi_imx->dma_finished = 0;
 
-	dma = readl(spi_imx->base + MX51_ECSPI_DMA);
-	dma = dma & (~MX51_ECSPI_DMA_RXT_WML_MASK);
-	/* Change RX_DMA_LENGTH trigger dma fetch tail data */
-	left = transfer->len % spi_imx->rxt_wml;
-	if (left)
-		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
-				spi_imx->base + MX51_ECSPI_DMA);
+	/*
+	 * Set these order to avoid potential RX overflow. The overflow may
+	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
+	 * for another task and/or interrupt.
+	 * So RX DMA enabled first to make sure data would be read out from FIFO
+	 * ASAP. TX DMA enabled next to start filling TX FIFO with new data.
+	 * And finaly SPI HW enabled to start actual data transfer.
+	 */
+	dma_async_issue_pending(master->dma_rx);
+	dma_async_issue_pending(master->dma_tx);
 	spi_imx->devtype_data->trigger(spi_imx);
 
-	dma_async_issue_pending(master->dma_tx);
-	dma_async_issue_pending(master->dma_rx);
 	/* Wait SDMA to finish the data transfer.*/
 	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
 						IMX_DMA_TIMEOUT);
@@ -958,6 +964,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 			dev_driver_string(&master->dev),
 			dev_name(&master->dev));
 		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(master->dma_rx);
 	} else {
 		timeout = wait_for_completion_timeout(
 				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
@@ -967,10 +974,40 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				dev_name(&master->dev));
 			spi_imx->devtype_data->reset(spi_imx);
 			dmaengine_terminate_all(master->dma_rx);
+		} else if (left) {
+			void *pio_buffer = transfer->rx_buf
+						+ (transfer->len - left);
+
+			dma_sync_sg_for_cpu(master->dma_rx->device->dev,
+					    &rx->sgl[rx->nents - 1], 1,
+					    DMA_FROM_DEVICE);
+
+			spi_imx->rx_buf = pio_buffer;
+			spi_imx->txfifo = left;
+			reinit_completion(&spi_imx->xfer_done);
+
+			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
+
+			timeout = wait_for_completion_timeout(
+					&spi_imx->xfer_done, IMX_DMA_TIMEOUT);
+			if (!timeout) {
+				pr_warn("%s %s: I/O Error in RX tail\n",
+					dev_driver_string(&master->dev),
+					dev_name(&master->dev));
+			}
+
+			/*
+			 * WARNING: this call will cause DMA debug complains
+			 * about wrong combination of DMA direction and sync
+			 * function. But we must use it to make sure the data
+			 * read by PIO mode will be cleared from CPU cache.
+			 * Otherwise SPI core will invalidate it during unmap of
+			 * SG buffers.
+			 */
+			dma_sync_sg_for_device(master->dma_rx->device->dev,
+					       &rx->sgl[rx->nents - 1], 1,
+					       DMA_TO_DEVICE);
 		}
-		writel(dma |
-		       spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET,
-		       spi_imx->base + MX51_ECSPI_DMA);
 	}
 
 	spi_imx->dma_finished = 1;
-- 
2.6.2
