From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:12 +0100
Subject: Applied "spi: stm32: enhance DMA error management" to the spi tree
In-Reply-To: <1498578321-13980-8-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIaO-0004bE-7Y@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: enhance DMA error management

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c67ad368cf75d4999d5ef86543d082b4b35dd2d7 Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:19 +0200
Subject: [PATCH] spi: stm32: enhance DMA error management

This patch reworks DMA error management. In case the DMA callback is
called while EOT (End Of Transfer) flag is not set, that means that DMA
encountered an error. This error will result in an auto-suspend of SPI
flow, which could also result in an overrun. So, in DMA mode, SUSP and
OVR flags are a condition to stop the current transfer.

Moreover, stm32_spi_can_dma doesn't care about the state of dma channels.
During driver probe, master->can_dma is initialised if dma channel request
is successful. That's why we must use master->can_dma to know if dma
use is possible (dma channel are successfully requested and the transfer
size is greater than fifo size).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 392c9453c2e6..8a6bff379b21 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -514,6 +514,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
+		/*
+		 * If communication is suspended while using DMA, it means
+		 * that something went wrong, so stop the current transfer
+		 */
+		if (spi->cur_usedma)
+			end = true;
 	}
 
 	if (sr & SPI_SR_MODF) {
@@ -525,6 +531,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
+		/*
+		 * If overrun is detected while using DMA, it means that
+		 * something went wrong, so stop the current transfer
+		 */
+		if (spi->cur_usedma)
+			end = true;
 	}
 
 	if (sr & SPI_SR_EOT) {
@@ -645,12 +657,10 @@ static void stm32_spi_dma_cb(void *data)
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	if (!(sr & SPI_SR_EOT)) {
-		dev_warn(spi->dev, "DMA callback (sr=0x%08x)\n", sr);
+	if (!(sr & SPI_SR_EOT))
+		dev_warn(spi->dev, "DMA error (sr=0x%08x)\n", sr);
 
-		spi_finalize_current_transfer(spi->master);
-		stm32_spi_disable(spi);
-	}
+	/* Now wait for EOT, or SUSP or OVR in case of error */
 }
 
 /**
@@ -986,7 +996,8 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	spi->tx_len = spi->tx_buf ? transfer->len : 0;
 	spi->rx_len = spi->rx_buf ? transfer->len : 0;
 
-	spi->cur_usedma = stm32_spi_can_dma(master, spi_dev, transfer);
+	spi->cur_usedma = (master->can_dma &&
+			   stm32_spi_can_dma(master, spi_dev, transfer));
 
 	ret = stm32_spi_transfer_one_setup(spi, spi_dev, transfer);
 	if (ret) {
-- 
2.13.2
