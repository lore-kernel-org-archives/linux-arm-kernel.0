From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:57:07 +0100
Subject: [PATCH v5 09/11] spi: imx: remove dead RX DMA tail handling code
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <1449334629-4715-10-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

transfer->len % wml for DMA capable transactions will always be 0
due to recent change in can_dma checks. So it's safe to remove dead code
in processing DMA.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7a68c62..adfa9cf 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -917,8 +917,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	int ret;
 	unsigned long timeout;
-	u32 dma;
-	int left;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 
@@ -952,13 +950,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	/* Trigger the cspi module. */
 	spi_imx->dma_finished = 0;
 
-	dma = readl(spi_imx->base + MX51_ECSPI_DMA);
-	dma = dma & (~MX51_ECSPI_DMA_RXT_WML_MASK);
-	/* Change RX_DMA_LENGTH trigger dma fetch tail data */
-	left = transfer->len % spi_imx->wml;
-	if (left)
-		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
-				spi_imx->base + MX51_ECSPI_DMA);
 	/*
 	 * Set these order to avoid potential RX overflow. The overflow may
 	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
@@ -990,10 +981,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 			spi_imx->devtype_data->reset(spi_imx);
 			dmaengine_terminate_all(master->dma_rx);
 		}
-		dma &= ~MX51_ECSPI_DMA_RXT_WML_MASK;
-		writel(dma |
-		       spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET,
-		       spi_imx->base + MX51_ECSPI_DMA);
 	}
 
 	spi_imx->dma_finished = 1;
-- 
2.6.3
