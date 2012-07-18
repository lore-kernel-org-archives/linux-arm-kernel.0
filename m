From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 12:28:38 +0100
Subject: [PATCH 1/4] spi/s3c64xx: Fix handling of errors in gpio_request()
Message-ID: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When gpio_request() fails the driver logged the failure but while it'd
try to print an error code in the non-DT case it didn't pass the error
code in so garbage would be logged and in the DT case the error wasn't
logged.

Further, in the non-DT case the error code was then overwritten with -EBUSY
depriving the caller of information and breaking automatic probe deferral
pushing back from the GPIO level.  Also reformat the non-DT log message
so it's not word wrapped and we can grep for it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 999154a0..7258b18 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -894,9 +894,9 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	if (!spi_get_ctldata(spi)) {
 		err = gpio_request(cs->line, dev_name(&spi->dev));
 		if (err) {
-			dev_err(&spi->dev, "request for slave select gpio "
-					"line [%d] failed\n", cs->line);
-			err = -EBUSY;
+			dev_err(&spi->dev,
+				"Failed to get /CS gpio [%d]: %d\n",
+				cs->line, err);
 			goto err_gpio_req;
 		}
 		spi_set_ctldata(spi, cs);
@@ -1114,7 +1114,8 @@ static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
 
 		ret = gpio_request(gpio, "spi-bus");
 		if (ret) {
-			dev_err(dev, "gpio [%d] request failed\n", gpio);
+			dev_err(dev, "gpio [%d] request failed: %d\n",
+				gpio, ret);
 			goto free_gpio;
 		}
 	}
-- 
1.7.10.4
