From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:28:51 +0100
Subject: [PATCH 05/13] spi: imx: initialize usedma earlier
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1455715739-25161-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that the SoC specific config function can know if we will do
DMA or not. Will be needed in following patches.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5a48d07..7047453 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -815,6 +815,11 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->tx = spi_imx_buf_tx_u32;
 	}
 
+	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
+		spi_imx->usedma = 1;
+	else
+		spi_imx->usedma = 0;
+
 	spi_imx->devtype_data->config(spi_imx, &config);
 
 	return 0;
@@ -1038,14 +1043,10 @@ static int spi_imx_transfer(struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
-	if (spi_imx->bitbang.master->can_dma &&
-	    spi_imx_can_dma(spi_imx->bitbang.master, spi, transfer)) {
-		spi_imx->usedma = true;
+	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
-	}
-	spi_imx->usedma = false;
-
-	return spi_imx_pio_transfer(spi, transfer);
+	else
+		return spi_imx_pio_transfer(spi, transfer);
 }
 
 static int spi_imx_setup(struct spi_device *spi)
-- 
2.7.0
