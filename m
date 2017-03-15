From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 19:37:11 +0000
Subject: Applied "spi: davinci: do not use DMA for vmalloc'ed buffers" to the
 spi tree
In-Reply-To: <1487872921-26628-6-git-send-email-fisaksen@baylibre.com>
Message-ID: <E1coEjP-0004fu-Dt@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: davinci: do not use DMA for vmalloc'ed buffers

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

>From 4dd9becbce4f10009322c3e2297f9db3ace94a10 Mon Sep 17 00:00:00 2001
From: Frode Isaksen <fisaksen@baylibre.com>
Date: Thu, 23 Feb 2017 19:02:00 +0100
Subject: [PATCH] spi: davinci: do not use DMA for vmalloc'ed buffers

Using vmalloc'ed buffers will fail since daVinci has
VIVT cache and only the kernel lowmem virtual address
is invalidated/flushed when performing DMA.
The virtual address returned from vmalloc() is not
invalidated/flushed and may contain stale data when
returning from spi_sync().
Fixes errors when running UBIFS over SPI NOR.
Revert this when all upper layer users of vmalloc'ed
buffers sent to SPI handles cache flushing/invalidating.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 75c658e4e487..f37bbdd18d61 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -482,7 +482,9 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 
 	if (spicfg)
 		can_dma = (spicfg->io_type == SPI_IO_TYPE_DMA) &&
-			(xfer->len >= DMA_MIN_BYTES);
+			(xfer->len >= DMA_MIN_BYTES) &&
+			!is_vmalloc_addr(xfer->rx_buf) &&
+			!is_vmalloc_addr(xfer->tx_buf);
 
 	return can_dma;
 }
-- 
2.11.0
