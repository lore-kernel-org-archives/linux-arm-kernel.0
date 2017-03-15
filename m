From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 19:37:19 +0000
Subject: Applied "spi: davinci: use rx buffer as dummy tx buffer" to the spi
 tree
In-Reply-To: <1487327904-28311-4-git-send-email-fisaksen@baylibre.com>
Message-ID: <E1coEjX-0004ho-PR@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: davinci: use rx buffer as dummy tx buffer

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

>From 6b3a631e7f8eca75a987ed760898d28fb3628143 Mon Sep 17 00:00:00 2001
From: Frode Isaksen <fisaksen@baylibre.com>
Date: Thu, 23 Feb 2017 19:01:58 +0100
Subject: [PATCH] spi: davinci: use rx buffer as dummy tx buffer

When doing rx-only transfer, the transfer will fail
if the number of SG entries exceeds 20.
This happens because the eDMA DMA engine is limited
to 20 SG entries in one transaction, and when the
DMA transcation is resumed (which takes > 150us),
rx errors occurs because the slave is still transmitting.
Fix this by using the rx buffer as the dummy tx buffer,
so that resuming the rx transcation happens at the same
time as resuming the tx transcation.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-davinci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 1e24395a04f2..ca122165a3c6 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -655,6 +655,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (!rxdesc)
 			goto err_desc;
 
+		if (!t->tx_buf) {
+			/* use rx buffer as dummy tx buffer */
+			t->tx_sg.sgl = t->rx_sg.sgl;
+			t->tx_sg.nents = t->rx_sg.nents;
+		}
+
 		txdesc = dmaengine_prep_slave_sg(dspi->dma_tx,
 				t->tx_sg.sgl, t->tx_sg.nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -957,7 +963,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
+	master->flags = SPI_MASTER_MUST_RX;
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
 	master->can_dma = davinci_spi_can_dma;
-- 
2.11.0
