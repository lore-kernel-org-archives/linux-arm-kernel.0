From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Jul 2012 11:57:47 +0200
Subject: [PATCH 1/7] MFD: Fix mc13xxx SPI regmap
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1342087073-3892-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe R?tornaz <philippe.retornaz@epfl.ch>

This fix the SPI regmap configuration, the wrong write flag was used.
Also, bits_per_word should not be set as the regmap spi implementation
uses a 8bits transfert granularity.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Marc Reilly <marc@cpdesign.com.au>
Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Origin: next-20120712, commit:e4ecf6ea84d68aea5a9785e89f52672e1e126998
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mc13xxx-spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 3fcdab3..5d1969f 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -49,6 +49,7 @@ static struct regmap_config mc13xxx_regmap_spi_config = {
 	.reg_bits = 7,
 	.pad_bits = 1,
 	.val_bits = 24,
+	.write_flag_mask = 0x80,
 
 	.max_register = MC13XXX_NUMREGS,
 
@@ -73,7 +74,6 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 
 	dev_set_drvdata(&spi->dev, mc13xxx);
 	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
-	spi->bits_per_word = 32;
 
 	mc13xxx->dev = &spi->dev;
 	mutex_init(&mc13xxx->lock);
-- 
1.7.10.4
