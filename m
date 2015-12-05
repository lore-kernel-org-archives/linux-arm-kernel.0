From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:57:00 +0100
Subject: [PATCH v5 02/11] spi: imx: reorder HW operations enable order to
 avoid possible RX data loss
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-3-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The overflow may happen due to rescheduling for another task and/or interrupt
if we enable SPI HW before starting RX DMA. So RX DMA enabled first to make
sure data would be read out from FIFO ASAP. TX DMA enabled next to start
filling TX FIFO with new data. And finaly SPI HW enabled to start actual
data transfer.

The risk rise in case of heavy system load and high SPI clock.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fb3bcc4..17e8f9e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -946,10 +946,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	if (left)
 		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
 				spi_imx->base + MX51_ECSPI_DMA);
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
-- 
2.6.3
