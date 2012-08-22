From: marex@denx.de (Marek Vasut)
Date: Wed, 22 Aug 2012 22:57:45 +0200
Subject: [PATCH] mxs/spi: Fix misuse of init_completion
Message-ID: <1345669065-17750-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/spi/spi-mxs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 331f600..c965cc6 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -230,7 +230,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 		return -EINVAL;
 	}
 
-	init_completion(&spi->c);
+	INIT_COMPLETION(spi->c);
 
 	if (*first)
 		pio |= BM_SSP_CTRL0_LOCK_CS;
@@ -560,6 +560,8 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	ssp->devid = devid;
 	ssp->dma_channel = dma_channel;
 
+	init_completion(&spi->c);
+
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
 			       DRIVER_NAME, ssp);
 	if (ret)
-- 
1.7.10.4
