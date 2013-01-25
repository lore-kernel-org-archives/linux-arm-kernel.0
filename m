From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Jan 2013 09:39:34 +0100
Subject: [PATCH 1/2] spi: spi-gpio: Add checks for the dt properties
In-Reply-To: <1359103175-26304-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359103175-26304-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359103175-26304-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings assumed that the gpios properties were always there, which
made the NO_TX and NO_RX mode not usable from device tree. Add extra
checks to make sure that the driver can work if either MOSI or MISO is
not used.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-gpio.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index c7cf0b7..9ddef55 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -365,9 +365,26 @@ static int spi_gpio_probe_dt(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->sck = of_get_named_gpio(np, "gpio-sck", 0);
-	pdata->miso = of_get_named_gpio(np, "gpio-miso", 0);
-	pdata->mosi = of_get_named_gpio(np, "gpio-mosi", 0);
+	ret = of_get_named_gpio(np, "gpio-sck", 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gpio-sck property not found\n");
+		goto error_free;
+	}
+	pdata->sck = ret;
+
+	ret = of_get_named_gpio(np, "gpio-miso", 0);
+	if (ret < 0) {
+		dev_info(&pdev->dev, "gpio-miso property not found, switching to no-rx mode\n");
+		pdata->miso = SPI_GPIO_NO_MISO;
+	} else
+		pdata->miso = ret;
+
+	ret = of_get_named_gpio(np, "gpio-mosi", 0);
+	if (ret < 0) {
+		dev_info(&pdev->dev, "gpio-mosi property not found, switching to no-tx mode\n");
+		pdata->mosi = SPI_GPIO_NO_MOSI;
+	} else
+		pdata->mosi = ret;
 
 	ret = of_property_read_u32(np, "num-chipselects", &tmp);
 	if (ret < 0) {
-- 
1.7.10.4
