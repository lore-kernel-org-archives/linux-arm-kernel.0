From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:49 +0800
Subject: [PATCH 4/8] [ARM] pxa: correct SSCR0_SCR to support multiple SoCs
In-Reply-To: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1268740373-27407-5-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous definitions of SSCR0_SCR and SSCR0_SerClkDiv() prevented
them being used simultaneously when supporting multiple PXA SoCs, esp.
in drivers/spi/pxa2xx_spi.c, make them correct.

The change from SSCR0_SerClkDiv(2) to SSCR0_SCR(2), will make the result
a little bit different in pxa2xx_spi_probe(), however, since that's only
used as a default initialization value, it's acceptable.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |    9 +--------
 drivers/spi/pxa2xx_spi.c                  |   14 +++++++-------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h b/arch/arm/mach-pxa/include/mach/regs-ssp.h
index 6a2ed35..dd15dc3 100644
--- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
+++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
@@ -33,14 +33,7 @@
 #define SSCR0_National	(0x2 << 4)	/* National Microwire */
 #define SSCR0_ECS	(1 << 6)	/* External clock select */
 #define SSCR0_SSE	(1 << 7)	/* Synchronous Serial Port Enable */
-
-#if defined(CONFIG_PXA25x)
-#define SSCR0_SCR	(0x0000ff00)	/* Serial Clock Rate (mask) */
-#define SSCR0_SerClkDiv(x) ((((x) - 2)/2) << 8) /* Divisor [2..512] */
-#elif defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-#define SSCR0_SCR	(0x000fff00)	/* Serial Clock Rate (mask) */
-#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
-#endif
+#define SSCR0_SCR(x)	((x) << 8)	/* Serial Clock Rate (mask) */
 
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 #define SSCR0_EDSS	(1 << 20)	/* Extended data size select */
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index c2f707e..62f3d8d 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1317,14 +1317,14 @@ static int setup(struct spi_device *spi)
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	if (drv_data->ssp_type != PXA25x_SSP)
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
-				clk_get_rate(ssp->clk)
-					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				chip->enable_dma ? "DMA" : "PIO");
+			clk_get_rate(ssp->clk)
+				/ (1 + ((chip->cr0 & SSCR0_SCR(0xfff)) >> 8)),
+			chip->enable_dma ? "DMA" : "PIO");
 	else
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
-				clk_get_rate(ssp->clk) / 2
-					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				chip->enable_dma ? "DMA" : "PIO");
+			clk_get_rate(ssp->clk) / 2
+				/ (1 + ((chip->cr0 & SSCR0_SCR(0x0ff)) >> 8)),
+			chip->enable_dma ? "DMA" : "PIO");
 
 	if (spi->bits_per_word <= 8) {
 		chip->n_bytes = 1;
@@ -1557,7 +1557,7 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
 	write_SSCR1(SSCR1_RxTresh(RX_THRESH_DFLT) |
 				SSCR1_TxTresh(TX_THRESH_DFLT),
 				drv_data->ioaddr);
-	write_SSCR0(SSCR0_SerClkDiv(2)
+	write_SSCR0(SSCR0_SCR(2)
 			| SSCR0_Motorola
 			| SSCR0_DataSize(8),
 			drv_data->ioaddr);
-- 
1.6.3.3
