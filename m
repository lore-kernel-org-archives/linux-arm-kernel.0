From: marex@denx.de (Marek Vasut)
Date: Sun, 14 Oct 2012 04:32:56 +0200
Subject: [PATCH 2/2] spi: mxs: Terminate DMA in case of DMA timeout
In-Reply-To: <1350181976-18233-1-git-send-email-marex@denx.de>
References: <1350181976-18233-1-git-send-email-marex@denx.de>
Message-ID: <1350181976-18233-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the SPI DMA times out, the DMA might still be in some kind of
inconsistent state. Issue dmaengine_terminate_all() on the particular
channel to kill off all operations before continuing.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 5a63bcd..86dd04d 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -323,6 +323,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	if (!ret) {
 		dev_err(ssp->dev, "DMA transfer timeout\n");
 		ret = -ETIMEDOUT;
+		dmaengine_terminate_all(ssp->dmach);
 		goto err_vmalloc;
 	}
 
-- 
1.7.10.4
