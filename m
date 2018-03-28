From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Mar 2018 03:44:45 +0100 (BST)
Subject: Applied "spi: spi-atmel: Use correct enum for DMA transfer direction"
 to the spi tree
In-Reply-To: <20180324104800.9934-1-stefan@agner.ch>
Message-ID: <20180328024445.5DF1744007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-atmel: Use correct enum for DMA transfer direction

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 357325764d7eabc4d2169d26af079b441fd48bc5 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Sat, 24 Mar 2018 11:48:00 +0100
Subject: [PATCH] spi: spi-atmel: Use correct enum for DMA transfer direction

Use enum dma_transfer_direction as required by the functions
dmaengine_prep_slave_(sg|single)() instead of enum dma_data_direction.
This won't change behavior in practice as the enum values are
equivalent.

This fixes two warnings when building with clang:
  drivers/spi/spi-atmel.c:771:12: warning: implicit conversion from enumeration
      type 'enum dma_data_direction' to different enumeration type
      'enum dma_transfer_direction'
      [-Wenum-conversion]
                                                     DMA_FROM_DEVICE,
                                                     ^~~~~~~~~~~~~~~
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index b7936f815373..3f890d162934 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -768,14 +768,14 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 		rxdesc = dmaengine_prep_slave_single(rxchan,
 						     as->dma_addr_rx_bbuf,
 						     xfer->len,
-						     DMA_FROM_DEVICE,
+						     DMA_DEV_TO_MEM,
 						     DMA_PREP_INTERRUPT |
 						     DMA_CTRL_ACK);
 	} else {
 		rxdesc = dmaengine_prep_slave_sg(rxchan,
 						 xfer->rx_sg.sgl,
 						 xfer->rx_sg.nents,
-						 DMA_FROM_DEVICE,
+						 DMA_DEV_TO_MEM,
 						 DMA_PREP_INTERRUPT |
 						 DMA_CTRL_ACK);
 	}
@@ -787,14 +787,14 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 		memcpy(as->addr_tx_bbuf, xfer->tx_buf, xfer->len);
 		txdesc = dmaengine_prep_slave_single(txchan,
 						     as->dma_addr_tx_bbuf,
-						     xfer->len, DMA_TO_DEVICE,
+						     xfer->len, DMA_MEM_TO_DEV,
 						     DMA_PREP_INTERRUPT |
 						     DMA_CTRL_ACK);
 	} else {
 		txdesc = dmaengine_prep_slave_sg(txchan,
 						 xfer->tx_sg.sgl,
 						 xfer->tx_sg.nents,
-						 DMA_TO_DEVICE,
+						 DMA_MEM_TO_DEV,
 						 DMA_PREP_INTERRUPT |
 						 DMA_CTRL_ACK);
 	}
-- 
2.16.2
