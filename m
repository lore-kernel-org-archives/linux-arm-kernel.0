From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:57:01 +0100
Subject: [PATCH v5 03/11] spi: imx: replace multiple watermarks with single
 for RX, TX and RXT
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-4-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to have different watermarks levels since they are the same.
Merge them into one WML parameter.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 17e8f9e..f811f68 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -104,9 +104,7 @@ struct spi_imx_data {
 	unsigned int dma_is_inited;
 	unsigned int dma_finished;
 	bool usedma;
-	u32 rx_wml;
-	u32 tx_wml;
-	u32 rxt_wml;
+	u32 wml;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
 
@@ -201,9 +199,8 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (spi_imx->dma_is_inited
-	    && transfer->len > spi_imx->rx_wml * sizeof(u32)
-	    && transfer->len > spi_imx->tx_wml * sizeof(u32))
+	if (spi_imx->dma_is_inited &&
+	    transfer->len > spi_imx->wml * sizeof(u32))
 		return true;
 	return false;
 }
@@ -378,10 +375,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (spi_imx->dma_is_inited) {
 		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
 
-		spi_imx->rxt_wml = spi_imx_get_fifosize(spi_imx) / 2;
-		rx_wml_cfg = spi_imx->rx_wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
-		tx_wml_cfg = spi_imx->tx_wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
-		rxt_wml_cfg = spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET;
+		rx_wml_cfg = spi_imx->wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
+		tx_wml_cfg = spi_imx->wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
+		rxt_wml_cfg = spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET;
 		dma = (dma & ~MX51_ECSPI_DMA_TX_WML_MASK
 			   & ~MX51_ECSPI_DMA_RX_WML_MASK
 			   & ~MX51_ECSPI_DMA_RXT_WML_MASK)
@@ -832,6 +828,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	if (of_machine_is_compatible("fsl,imx6dl"))
 		return 0;
 
+	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel(dev, "tx");
 	if (!master->dma_tx) {
@@ -843,7 +841,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	slave_config.direction = DMA_MEM_TO_DEV;
 	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
+	slave_config.dst_maxburst = spi_imx->wml;
 	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
 	if (ret) {
 		dev_err(dev, "error in TX dma configuration.\n");
@@ -861,7 +859,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	slave_config.direction = DMA_DEV_TO_MEM;
 	slave_config.src_addr = res->start + MXC_CSPIRXDATA;
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
+	slave_config.src_maxburst = spi_imx->wml;
 	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
 	if (ret) {
 		dev_err(dev, "error in RX dma configuration.\n");
@@ -874,8 +872,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
 					 SPI_MASTER_MUST_TX;
-	spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
-	spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
 	spi_imx->dma_is_inited = 1;
 
 	return 0;
@@ -942,7 +938,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	dma = readl(spi_imx->base + MX51_ECSPI_DMA);
 	dma = dma & (~MX51_ECSPI_DMA_RXT_WML_MASK);
 	/* Change RX_DMA_LENGTH trigger dma fetch tail data */
-	left = transfer->len % spi_imx->rxt_wml;
+	left = transfer->len % spi_imx->wml;
 	if (left)
 		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
 				spi_imx->base + MX51_ECSPI_DMA);
@@ -977,8 +973,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 			spi_imx->devtype_data->reset(spi_imx);
 			dmaengine_terminate_all(master->dma_rx);
 		}
+		dma &= ~MX51_ECSPI_DMA_RXT_WML_MASK;
 		writel(dma |
-		       spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET,
+		       spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET,
 		       spi_imx->base + MX51_ECSPI_DMA);
 	}
 
-- 
2.6.3
