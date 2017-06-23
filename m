From: cyrille.pitchen@microchip.com (Cyrille Pitchen)
Date: Fri, 23 Jun 2017 17:39:16 +0200
Subject: [PATCH 1/1] spi: atmel: fix corrupted data issue on SAM9 family SoCs
Message-ID: <d174da00f48503eba84dd0f4068749b968628bbb.1498231873.git.cyrille.pitchen@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/spi/spi-atmel.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 4e5e51fe6f73..f95da364c283 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -269,6 +269,7 @@ struct atmel_spi_caps {
 	bool	is_spi2;
 	bool	has_wdrbt;
 	bool	has_dma_support;
+	bool	has_pdc_support;
 };
 
 /*
@@ -1425,7 +1426,28 @@ static void atmel_get_caps(struct atmel_spi *as)
 
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
@@ -1566,7 +1588,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		} else if (ret == -EPROBE_DEFER) {
 			return ret;
 		}
-	} else {
+	} else if (as->caps.has_pdc_support) {
 		as->use_pdc = true;
 	}
 
-- 
2.7.4
