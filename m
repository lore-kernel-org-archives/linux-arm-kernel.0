From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:28:53 +0100
Subject: [PATCH 07/13] spi: imx: drop unncessary dma_is_inited variable
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1455715739-25161-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need for an extra dma_is_inited variable when we can
equally well check for the existence of a DMA channel.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 073a134..57b7af8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -102,7 +102,6 @@ struct spi_imx_data {
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
 	/* DMA */
-	unsigned int dma_is_inited;
 	unsigned int dma_finished;
 	bool usedma;
 	u32 wml;
@@ -205,7 +204,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (spi_imx->dma_is_inited && transfer->len >= spi_imx->wml &&
+	if (master->dma_rx && transfer->len >= spi_imx->wml &&
 	    (transfer->len % spi_imx->wml) == 0)
 		return true;
 	return false;
@@ -827,8 +826,6 @@ static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
 		dma_release_channel(master->dma_tx);
 		master->dma_tx = NULL;
 	}
-
-	spi_imx->dma_is_inited = 0;
 }
 
 static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
@@ -888,7 +885,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
 					 SPI_MASTER_MUST_TX;
-	spi_imx->dma_is_inited = 1;
 
 	return 0;
 err:
-- 
2.7.0
