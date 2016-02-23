From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Feb 2016 10:23:56 +0100
Subject: [PATCH 7/9] spi: imx: make some register defines simpler
In-Reply-To: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
References: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1456219438-21205-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watermark levels in the DMA register are write only, the driver
should never have to read them back from the hardware. Replace the
current _MASK and _OFFSET defines with defines taking the watermark
level directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 287ec0c..96e32d4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -256,12 +256,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
 
 #define MX51_ECSPI_DMA      0x14
-#define MX51_ECSPI_DMA_TX_WML_OFFSET	0
-#define MX51_ECSPI_DMA_TX_WML_MASK	0x3F
-#define MX51_ECSPI_DMA_RX_WML_OFFSET	16
-#define MX51_ECSPI_DMA_RX_WML_MASK	(0x3F << 16)
-#define MX51_ECSPI_DMA_RXT_WML_OFFSET	24
-#define MX51_ECSPI_DMA_RXT_WML_MASK	(0x3F << 24)
+#define MX51_ECSPI_DMA_TX_WML(wml)	((wml) & 0x3f)
+#define MX51_ECSPI_DMA_RX_WML(wml)	(((wml) & 0x3f) << 16)
+#define MX51_ECSPI_DMA_RXT_WML(wml)	(((wml) & 0x3f) << 24)
 
 #define MX51_ECSPI_DMA_TEDEN		(1 << 7)
 #define MX51_ECSPI_DMA_RXDEN		(1 << 23)
@@ -408,9 +405,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	 * and enable DMA request.
 	 */
 
-	writel(spi_imx->wml << MX51_ECSPI_DMA_RX_WML_OFFSET |
-		spi_imx->wml << MX51_ECSPI_DMA_TX_WML_OFFSET |
-		spi_imx->wml << MX51_ECSPI_DMA_RXT_WML_OFFSET |
+	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 
-- 
2.7.0
