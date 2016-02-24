From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Feb 2016 09:20:27 +0100
Subject: [PATCH 3/9] spi: imx: drop unnecessary read/modify/write
In-Reply-To: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1456302033-25638-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the MX51_ECSPI_DMA is configured we control every single bit
of the register, so there's no need to read/modify/write it. Instead
just write the value we want to have in the register. Also, drop
unnecessary check if we are actually doing DMA. The values written
to the register have no effect in PIO mode and value written there
during the last DMA transfer is still in the register, so we can
equally well always write a value.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5792918..ec03304 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -240,9 +240,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_DMA_RXT_WML_OFFSET	24
 #define MX51_ECSPI_DMA_RXT_WML_MASK	(0x3F << 24)
 
-#define MX51_ECSPI_DMA_TEDEN_OFFSET	7
-#define MX51_ECSPI_DMA_RXDEN_OFFSET	23
-#define MX51_ECSPI_DMA_RXTDEN_OFFSET	31
+#define MX51_ECSPI_DMA_TEDEN		(1 << 7)
+#define MX51_ECSPI_DMA_RXDEN		(1 << 23)
+#define MX51_ECSPI_DMA_RXTDEN		(1 << 31)
 
 #define MX51_ECSPI_STAT		0x18
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
@@ -318,8 +318,7 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
-	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
 	u32 clk = config->speed_hz, delay, reg;
 
 	/*
@@ -392,22 +391,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
 	 */
-	if (spi_imx->dma_is_inited) {
-		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
-
-		rx_wml_cfg = spi_imx->wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
-		tx_wml_cfg = spi_imx->wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
-		rxt_wml_cfg = spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET;
-		dma = (dma & ~MX51_ECSPI_DMA_TX_WML_MASK
-			   & ~MX51_ECSPI_DMA_RX_WML_MASK
-			   & ~MX51_ECSPI_DMA_RXT_WML_MASK)
-			   | rx_wml_cfg | tx_wml_cfg | rxt_wml_cfg
-			   |(1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
-			   |(1 << MX51_ECSPI_DMA_RXDEN_OFFSET)
-			   |(1 << MX51_ECSPI_DMA_RXTDEN_OFFSET);
-
-		writel(dma, spi_imx->base + MX51_ECSPI_DMA);
-	}
+
+	writel(spi_imx->wml << MX51_ECSPI_DMA_RX_WML_OFFSET |
+		spi_imx->wml << MX51_ECSPI_DMA_TX_WML_OFFSET |
+		spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET |
+		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
+		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 
 	return 0;
 }
-- 
2.7.0
