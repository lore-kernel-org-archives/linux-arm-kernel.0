From: juha.lumme@gmail.com (Juha Lumme)
Date: Wed, 26 Dec 2012 14:01:28 +0900
Subject: [PATCH] mxs: spi: clear XFER_LEN in CTRL0 register during DMA
Message-ID: <1356498088-31176-1-git-send-email-juha.lumme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MX23 the XFER_LEN part in CTRL0 register was improperly OR'd, and because
of that too many characters were being expected from SPI.
This caused a timeout (SSP_TIMEOUT) to happen in the last package in the DMA
chain, and resulted into a corrupted read.
This is a workaround for the problem, by clearing the XFER_LEN bytes always
before reading the new size for XFER_LEN.

Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo at linaro.org
Signed-off-by: Juha Lumme <juha.lumme@gmail.com>
---
 drivers/spi/spi-mxs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 86dd04d..265c33f 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -241,6 +241,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	INIT_COMPLETION(spi->c);
 
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
+	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
 	if (*first)
@@ -256,8 +257,10 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 		if ((sg_count + 1 == sgs) && *last)
 			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
 
-		if (ssp->devid == IMX23_SSP)
+		if (ssp->devid == IMX23_SSP) {
+			ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 			ctrl0 |= min;
+		}
 
 		dma_xfer[sg_count].pio[0] = ctrl0;
 		dma_xfer[sg_count].pio[3] = min;
-- 
1.7.10.4
