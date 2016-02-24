From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Feb 2016 09:20:32 +0100
Subject: [PATCH 8/9] spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
In-Reply-To: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1456302033-25638-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the config function knows whether we are doing DMA or not we
can do the necessary register setup in the config function and no longer
have to do this in the trigger function. With this the trigger function
becomes a no-op for DMA, so instead of testing if we are doing DMA or
not in the trigger function we simply no longer call it in the DMA case.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 96e32d4..91890b2 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -106,7 +106,6 @@ struct spi_imx_data {
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
 	/* DMA */
-	unsigned int dma_finished;
 	bool usedma;
 	u32 wml;
 	struct completion dma_rx_completion;
@@ -324,14 +323,10 @@ static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int
 
 static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
-	u32 reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	u32 reg;
 
-	if (!spi_imx->usedma)
-		reg |= MX51_ECSPI_CTRL_XCH;
-	else if (!spi_imx->dma_finished)
-		reg |= MX51_ECSPI_CTRL_SMC;
-	else
-		reg &= ~MX51_ECSPI_CTRL_SMC;
+	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	reg |= MX51_ECSPI_CTRL_XCH;
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
@@ -371,6 +366,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
+	if (spi_imx->usedma)
+		ctrl |= MX51_ECSPI_CTRL_SMC;
+
 	/* CTRL register always go first to bring out controller from reset */
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -1012,9 +1010,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_rx_completion);
 	reinit_completion(&spi_imx->dma_tx_completion);
 
-	/* Trigger the cspi module. */
-	spi_imx->dma_finished = 0;
-
 	/*
 	 * Set these order to avoid potential RX overflow. The overflow may
 	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
@@ -1025,7 +1020,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	 */
 	dma_async_issue_pending(master->dma_rx);
 	dma_async_issue_pending(master->dma_tx);
-	spi_imx->devtype_data->trigger(spi_imx);
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
@@ -1046,9 +1040,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		}
 	}
 
-	spi_imx->dma_finished = 1;
-	spi_imx->devtype_data->trigger(spi_imx);
-
 	if (!timeout)
 		ret = -ETIMEDOUT;
 	else
-- 
2.7.0
