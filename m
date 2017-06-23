From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Jun 2017 17:15:58 +0100
Subject: Applied "spi: atmel: fix corrupted data issue on SAM9 family SoCs" to
 the spi tree
In-Reply-To: <d174da00f48503eba84dd0f4068749b968628bbb.1498231873.git.cyrille.pitchen@microchip.com>
Message-ID: <E1dORFW-00037E-N8@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: fix corrupted data issue on SAM9 family SoCs

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

>From 7094576ccdc3acfe1e06a1e2ab547add375baf7f Mon Sep 17 00:00:00 2001
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Fri, 23 Jun 2017 17:39:16 +0200
Subject: [PATCH] spi: atmel: fix corrupted data issue on SAM9 family SoCs

This patch disables the use of the DMA for data transfer and forces the
use of PIO transfers instead as a quick fixup to solve the cache aliasing
issue on ARM9 based cores, which embeds a VIVT data cache.

Indeed in the case of VIVT data caches, it is not safe to call dma_map_*()
functions to map buffers for DMA transfers when those buffers have been
allocated by vmalloc() or from any DMA-unsafe area.

Further patches may propose a better solution based on the use of a bounce
buffer at the SPI sub-system level but such solution needs more time to be
discussed. Then the use of DMA transfers could be enabled again to improve
the performances but before that, this patch already solves the issue.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 drivers/spi/spi-atmel.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1eb83c9613d5..78c885d80c96 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -269,6 +269,7 @@ struct atmel_spi_caps {
 	bool	is_spi2;
 	bool	has_wdrbt;
 	bool	has_dma_support;
+	bool	has_pdc_support;
 };
 
 /*
@@ -1426,7 +1427,28 @@ static void atmel_get_caps(struct atmel_spi *as)
 
 	as->caps.is_spi2 = version > 0x121;
 	as->caps.has_wdrbt = version >= 0x210;
+#ifdef CONFIG_SOC_SAM_V4_V5
+	/*
+	 * Atmel SoCs based on ARM9 (SAM9x) cores should not use spi_map_buf()
+	 * since this later function tries to map buffers with dma_map_sg()
+	 * even if they have not been allocated inside DMA-safe areas.
+	 * On SoCs based on Cortex A5 (SAMA5Dx), it works anyway because for
+	 * those ARM cores, the data cache follows the PIPT model.
+	 * Also the L2 cache controller of SAMA5D2 uses the PIPT model too.
+	 * In case of PIPT caches, there cannot be cache aliases.
+	 * However on ARM9 cores, the data cache follows the VIVT model, hence
+	 * the cache aliases issue can occur when buffers are allocated from
+	 * DMA-unsafe areas, by vmalloc() for instance, where cache coherency is
+	 * not taken into account or at least not handled completely (cache
+	 * lines of aliases are not invalidated).
+	 * This is not a theorical issue: it was reproduced when trying to mount
+	 * a UBI file-system on a at91sam9g35ek board.
+	 */
+	as->caps.has_dma_support = false;
+#else
 	as->caps.has_dma_support = version >= 0x212;
+#endif
+	as->caps.has_pdc_support = version < 0x212;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1567,7 +1589,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		} else if (ret == -EPROBE_DEFER) {
 			return ret;
 		}
-	} else {
+	} else if (as->caps.has_pdc_support) {
 		as->use_pdc = true;
 	}
 
-- 
2.13.1
