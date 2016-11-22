From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 17:26:55 +0000
Subject: Applied "spi: spi-fsl-dspi: Fix incorrect freeing of DMA allocated
 buffers" to the spi tree
In-Reply-To: <fd3b1fa5d9fb2a0c2d1f6ded314acf20f5081a89.1479796821.git.maitysanchayan@gmail.com>
Message-ID: <E1c9EqN-0005yc-Dr@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-fsl-dspi: Fix incorrect freeing of DMA allocated buffers

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

>From 27d21e9f988e527982a7516fcf411994f498787d Mon Sep 17 00:00:00 2001
From: Sanchayan Maity <maitysanchayan@gmail.com>
Date: Tue, 22 Nov 2016 12:31:32 +0530
Subject: [PATCH] spi: spi-fsl-dspi: Fix incorrect freeing of DMA allocated
 buffers

Buffers allocated with a call to dma_alloc_coherent should be
freed with dma_free_coherent instead of the currently used
devm_kfree.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b1ee1f521ba0..22f7ce1279bd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -427,9 +427,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	devm_kfree(dev, dma->rx_dma_buf);
+	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
+			dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	devm_kfree(dev, dma->tx_dma_buf);
+	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
+			dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
-- 
2.10.2
