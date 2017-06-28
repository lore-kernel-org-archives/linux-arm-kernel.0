From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:04 +0100
Subject: Applied "spi: stm32: fix potential dereference null return value" to
 the spi tree
In-Reply-To: <1498222550-19092-9-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIaG-0004aF-4V@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: fix potential dereference null return value

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

>From 7b821a6485c943edc752a94260a29116237f9153 Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:20 +0200
Subject: [PATCH] spi: stm32: fix potential dereference null return value

This patch fixes the usage of rx_dma_desc and tx_dma_desc pointers
returned by dmaengine_prep_slave_sg, which can be null.

Detected by CoverityScan, CID#1446587 ("Dereference null return value")

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8a6bff379b21..75644bcd938b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -775,9 +775,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					xfer->rx_sg.nents,
 					rx_dma_conf.direction,
 					DMA_PREP_INTERRUPT);
-
-		rx_dma_desc->callback = stm32_spi_dma_cb;
-		rx_dma_desc->callback_param = spi;
 	}
 
 	tx_dma_desc = NULL;
@@ -790,11 +787,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					xfer->tx_sg.nents,
 					tx_dma_conf.direction,
 					DMA_PREP_INTERRUPT);
-
-		if (spi->cur_comm == SPI_SIMPLEX_TX) {
-			tx_dma_desc->callback = stm32_spi_dma_cb;
-			tx_dma_desc->callback_param = spi;
-		}
 	}
 
 	if ((spi->tx_buf && !tx_dma_desc) ||
@@ -802,6 +794,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
+		rx_dma_desc->callback = stm32_spi_dma_cb;
+		rx_dma_desc->callback_param = spi;
+
 		if (dma_submit_error(dmaengine_submit(rx_dma_desc))) {
 			dev_err(spi->dev, "Rx DMA submit failed\n");
 			goto dma_desc_error;
@@ -811,6 +806,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	if (tx_dma_desc) {
+		if (spi->cur_comm == SPI_SIMPLEX_TX) {
+			tx_dma_desc->callback = stm32_spi_dma_cb;
+			tx_dma_desc->callback_param = spi;
+		}
+
 		if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
 			dev_err(spi->dev, "Tx DMA submit failed\n");
 			goto dma_submit_error;
-- 
2.13.2
