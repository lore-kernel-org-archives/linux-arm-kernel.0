From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Jun 2016 13:15:42 +0100
Subject: Applied "spi: s3c64xx: simplify if statement in prepare_transfer
 function" to the spi tree
In-Reply-To: <1466150245-2648-6-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bIasg-0001CB-06@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: simplify if statement in prepare_transfer function

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

>From 730d9d4d11cf48b17d07daaff1f0540642317e09 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 28 Jun 2016 11:41:14 +0900
Subject: [PATCH] spi: s3c64xx: simplify if statement in prepare_transfer
 function

The whole function is inside an 'if' statement
("!is_polling(sdd)").

Check the opposite of that statement at the beginning and exit,
this way we can have one level less of indentation.

Remove the goto paths as they are redundant.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c65a9e6baefd..6d8486fc668f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -341,38 +341,32 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	dma_filter_fn filter = sdd->cntrlr_info->filter;
 	struct device *dev = &sdd->pdev->dev;
 	dma_cap_mask_t mask;
-	int ret;
 
-	if (!is_polling(sdd)) {
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		/* Acquire DMA channels */
-		sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   sdd->cntrlr_info->dma_rx, dev, "rx");
-		if (!sdd->rx_dma.ch) {
-			dev_err(dev, "Failed to get RX DMA channel\n");
-			ret = -EBUSY;
-			goto out;
-		}
-		spi->dma_rx = sdd->rx_dma.ch;
-
-		sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   sdd->cntrlr_info->dma_tx, dev, "tx");
-		if (!sdd->tx_dma.ch) {
-			dev_err(dev, "Failed to get TX DMA channel\n");
-			ret = -EBUSY;
-			goto out_rx;
-		}
-		spi->dma_tx = sdd->tx_dma.ch;
+	if (is_polling(sdd))
+		return 0;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* Acquire DMA channels */
+	sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
+			   sdd->cntrlr_info->dma_rx, dev, "rx");
+	if (!sdd->rx_dma.ch) {
+		dev_err(dev, "Failed to get RX DMA channel\n");
+		return -EBUSY;
 	}
+	spi->dma_rx = sdd->rx_dma.ch;
 
-	return 0;
+	sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
+			   sdd->cntrlr_info->dma_tx, dev, "tx");
+	if (!sdd->tx_dma.ch) {
+		dev_err(dev, "Failed to get TX DMA channel\n");
+		dma_release_channel(sdd->rx_dma.ch);
+		return -EBUSY;
+	}
+	spi->dma_tx = sdd->tx_dma.ch;
 
-out_rx:
-	dma_release_channel(sdd->rx_dma.ch);
-out:
-	return ret;
+	return 0;
 }
 
 static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
-- 
2.8.1
