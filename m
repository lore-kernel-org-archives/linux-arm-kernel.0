From: juha.lumme@gmail.com (Juha Lumme)
Date: Wed, 26 Dec 2012 14:48:51 +0900
Subject: [PATCH V2] mxs: spi: clear XFER_COUNT in ctrl0 field in DMA descriptor
Message-ID: <1356500931-31861-1-git-send-email-juha.lumme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MX23 the XFER_COUNT part in ctrl0 field in DMA descriptor was improperly
OR'd during the construction of DMA descriptor chain, instead of being
freshly set.
Because of that too many bytes were being expected from SPI during the last
DMA cycle.
This caused a timeout (SSP_TIMEOUT) to happen in the processing of the last
DMA descriptor, and thus reads and writes were failing.
This is a fix for the problem, by clearing XFER_COUNT bytes in ctrl0 before
setting the new XFER_COUNT for DMA descriptor.

Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Juha Lumme <juha.lumme@gmail.com>
Acked-by: Marek Vasut <marex@denx.de>
---
 drivers/spi/spi-mxs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

 Changelog, v2:
 changed the description of the patch, to better describe the patch

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
