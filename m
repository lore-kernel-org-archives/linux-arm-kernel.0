From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:53 -0700
Subject: [PATCH V2 10/12] spi/mxs: Clean up setup_transfer function
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-10-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can't be called with a NULL transfer anymore so it can be
simplified to not check for that.

Change printouts to more closely match what the spi core would print.
I.e., don't print function names.  Try to make them clearer.

Fix indention of line-wrapped code to Linux standard.

The transfer pointer can be const.

It's not necessary to check if the spi_transfer's bit per word is
zero.  The spi core automatically inserts the spi_device's bits per
word in that case.

It's not necessary to check if the spi_transfer's speed_hz is zero, as
the spi core also fills it in from the spi_device.  However, the spi
core does not check if spi_device's speed is zero so we have to do
that still.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index d71029e..a7d5f85 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -71,28 +71,20 @@ struct mxs_spi {
 };
 
 static int mxs_spi_setup_transfer(struct spi_device *dev,
-				struct spi_transfer *t)
+				  const struct spi_transfer *t)
 {
 	struct mxs_spi *spi = spi_master_get_devdata(dev->master);
 	struct mxs_ssp *ssp = &spi->ssp;
-	uint8_t bits_per_word;
-	uint32_t hz = 0;
+	const unsigned int hz = min(dev->max_speed_hz, t->speed_hz);
 
-	bits_per_word = dev->bits_per_word;
-	if (t && t->bits_per_word)
-		bits_per_word = t->bits_per_word;
-
-	if (bits_per_word != 8) {
-		dev_err(&dev->dev, "%s, unsupported bits_per_word=%d\n",
-					__func__, bits_per_word);
+	if (t->bits_per_word != 8) {
+		dev_err(&dev->dev, "Unsupported bits per word of %d\n",
+			t->bits_per_word);
 		return -EINVAL;
 	}
 
-	hz = dev->max_speed_hz;
-	if (t && t->speed_hz)
-		hz = min(hz, t->speed_hz);
 	if (hz == 0) {
-		dev_err(&dev->dev, "Cannot continue with zero clock\n");
+		dev_err(&dev->dev, "SPI clock rate of zero not possible\n");
 		return -EINVAL;
 	}
 
@@ -100,12 +92,12 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 
 	writel(BM_SSP_CTRL0_LOCK_CS,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+
 	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
-		     BF_SSP_CTRL1_WORD_LENGTH
-		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
-		     ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
-		     ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
-		     ssp->base + HW_SSP_CTRL1(ssp));
+	       BF_SSP_CTRL1_WORD_LENGTH(BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
+	       ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
+	       ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
+	       ssp->base + HW_SSP_CTRL1(ssp));
 
 	writel(0x0, ssp->base + HW_SSP_CMD0);
 	writel(0x0, ssp->base + HW_SSP_CMD1);
-- 
1.7.10.4
