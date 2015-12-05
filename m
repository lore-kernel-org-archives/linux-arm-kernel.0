From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:56:59 +0100
Subject: [PATCH v5 01/11] spi: imx: terminate RX DMA transaction in case of TX
 DMA timeout
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-2-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not only TX DMA should be terminated, but RX DMA also. It's required
to avoid accidential DMA memory writes from RX DMA channel and properly
terminate transaction.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 0e5723a..fb3bcc4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -958,6 +958,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 			dev_driver_string(&master->dev),
 			dev_name(&master->dev));
 		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(master->dma_rx);
 	} else {
 		timeout = wait_for_completion_timeout(
 				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
-- 
2.6.3
