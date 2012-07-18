From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 12:28:39 +0100
Subject: [PATCH 2/4] spi/s3c64xx: Put the /CS GPIO into output mode
In-Reply-To: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1342610921-31986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No call was being made by the GPIO driver to put the GPIO into output
mode meaning that the calls to gpio_set_value() which were being done
were not valid. A similar issue appears to exist with the DT GPIO
requests but as they appear to be being used for pinmux it's less clear
to me that we want to configure them.

Without this fix Cragganmore systems can't talk to their SPI devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7258b18..6ed3ba8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -892,7 +892,8 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	if (!spi_get_ctldata(spi)) {
-		err = gpio_request(cs->line, dev_name(&spi->dev));
+		err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
+				       dev_name(&spi->dev));
 		if (err) {
 			dev_err(&spi->dev,
 				"Failed to get /CS gpio [%d]: %d\n",
-- 
1.7.10.4
