From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 12:28:41 +0100
Subject: [PATCH 4/4] spi/s3c64xx: Expand S3C64XX_SPI_{DE,
 }ACT macros at call sites
In-Reply-To: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1342610921-31986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They have very few users and they're both just doing a single register
write so the advantage of having the macro is a bit limited. An inline
function might make sense but it's as easy to just do the writes directly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-s3c64xx.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1781365..d24ec80 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -79,11 +79,6 @@
 #define S3C64XX_SPI_SLAVE_AUTO			(1<<1)
 #define S3C64XX_SPI_SLAVE_SIG_INACT		(1<<0)
 
-#define S3C64XX_SPI_ACT(c) writel(0, (c)->regs + S3C64XX_SPI_SLAVE_SEL)
-
-#define S3C64XX_SPI_DEACT(c) writel(S3C64XX_SPI_SLAVE_SIG_INACT, \
-					(c)->regs + S3C64XX_SPI_SLAVE_SEL)
-
 #define S3C64XX_SPI_INT_TRAILING_EN		(1<<6)
 #define S3C64XX_SPI_INT_RX_OVERRUN_EN		(1<<5)
 #define S3C64XX_SPI_INT_RX_UNDERRUN_EN		(1<<4)
@@ -737,14 +732,15 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
 		enable_cs(sdd, spi);
 
 		/* Start the signals */
-		S3C64XX_SPI_ACT(sdd);
+		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 		spin_unlock_irqrestore(&sdd->lock, flags);
 
 		status = wait_for_xfer(sdd, xfer, use_dma);
 
 		/* Quiese the signals */
-		S3C64XX_SPI_DEACT(sdd);
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT,
+		       sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 		if (status) {
 			dev_err(&spi->dev, "I/O Error: "
@@ -1030,7 +1026,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 
 	sdd->cur_speed = 0;
 
-	S3C64XX_SPI_DEACT(sdd);
+	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 	/* Disable Interrupts - we use Polling if not DMA mode */
 	writel(0, regs + S3C64XX_SPI_INT_EN);
-- 
1.7.10.4
