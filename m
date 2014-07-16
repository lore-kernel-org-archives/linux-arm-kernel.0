From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 16 Jul 2014 17:19:08 +0200
Subject: [PATCH 2/4] spi: s3c64xx: use the generic SPI "cs-gpios" property
In-Reply-To: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1405523950-2231-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

The s3c64xx SPI driver uses a custom DT binding to specify
the GPIO used to drive the chip select (CS) line instead of
using the generic "cs-gpios" property already defined in:
Documentation/devicetree/bindings/spi/spi-bus.txt.

It's unfortunate that drivers are not using standard bindings
and creating custom ones instead but in most cases this can't
be changed without breaking Device Tree backward compatibility.

But in the case of this driver, its DT binding has been broken
for more than a year. Since after commit (dated June, 21 2013):

3146bee ("spi: s3c64xx: Added provision for dedicated cs pin")

DT backward compatibility was broken and nobody noticed until
now when the commit was reverted. So it seems to be safe to
change the binding to use the standard SPI "cs-gpios" property
instead of using a custom one just for this driver.

This patch also allows boards that don't use a GPIO pin for the
CS to work with the driver since the SPI core will take care of
setting spi->cs_gpio to -ENOENT if a board wants to use the built
in CS instead of a GPIO as explained in the SPI bus DT binding:
Documentation/devicetree/bindings/spi/spi-bus.txt.

For non-DT platforms, spi->cs_gpio will be set to -ENOENT as well
unless they specify a GPIO pin in their platform data. So both
native and GPIO chip select is also supported for legacy boards.

The above use case was what motivated commit 3146bee which broke
the DT binding backward compatibility in the first place.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
[javier.martinez at collabora.co.uk: split changes and improve commit message]
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 49 ++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e48c6fa..480133e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -773,14 +773,6 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-ENOMEM);
 	}
 
-	cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
-	if (!gpio_is_valid(cs->line)) {
-		dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
-		kfree(cs);
-		of_node_put(data_np);
-		return ERR_PTR(-EINVAL);
-	}
-
 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
 	cs->fb_delay = fb_delay;
 	of_node_put(data_np);
@@ -801,9 +793,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	int err;
 
 	sdd = spi_master_get_devdata(spi->master);
-	if (!cs && spi->dev.of_node) {
+	if (spi->dev.of_node) {
 		cs = s3c64xx_get_slave_ctrldata(spi);
 		spi->controller_data = cs;
+	} else if (cs) {
+		/* On non-DT platforms the SPI core will set spi->cs_gpio
+		 * to -ENOENT. The GPIO pin used to drive the chip select
+		 * is defined by using platform data so spi->cs_gpio value
+		 * has to be override to have the proper GPIO pin number.
+		 */
+		spi->cs_gpio = cs->line;
 	}
 
 	if (IS_ERR_OR_NULL(cs)) {
@@ -812,17 +811,17 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	if (!spi_get_ctldata(spi)) {
-		err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
-				       dev_name(&spi->dev));
-		if (err) {
-			dev_err(&spi->dev,
-				"Failed to get /CS gpio [%d]: %d\n",
-				cs->line, err);
-			goto err_gpio_req;
+		if (gpio_is_valid(spi->cs_gpio)) {
+			err = gpio_request_one(spi->cs_gpio, GPIOF_OUT_INIT_HIGH,
+					       dev_name(&spi->dev));
+			if (err) {
+				dev_err(&spi->dev,
+					"Failed to get /CS gpio [%d]: %d\n",
+					spi->cs_gpio, err);
+				goto err_gpio_req;
+			}
 		}
 
-		spi->cs_gpio = cs->line;
-
 		spi_set_ctldata(spi, cs);
 	}
 
@@ -875,7 +874,8 @@ setup_exit:
 	/* setup() returns with device de-selected */
 	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
-	gpio_free(cs->line);
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_free(spi->cs_gpio);
 	spi_set_ctldata(spi, NULL);
 
 err_gpio_req:
@@ -889,11 +889,20 @@ static void s3c64xx_spi_cleanup(struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs = spi_get_ctldata(spi);
 
-	if (cs) {
+	if (gpio_is_valid(spi->cs_gpio)) {
 		gpio_free(spi->cs_gpio);
 		if (spi->dev.of_node)
 			kfree(cs);
+		else {
+			/* On non-DT platforms, the SPI core sets
+			 * spi->cs_gpio to -ENOENT and .setup()
+			 * overrides it with the GPIO pin value
+			 * passed using platform data.
+			 */
+			spi->cs_gpio = -ENOENT;
+		}
 	}
+
 	spi_set_ctldata(spi, NULL);
 }
 
-- 
2.0.0.rc2
