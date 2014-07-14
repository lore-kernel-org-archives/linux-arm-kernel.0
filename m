From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 14 Jul 2014 11:11:44 +0530
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the driver
In-Reply-To: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, (3146bee spi: s3c64xx: Added provision for dedicated cs pin)

spi-s3c64xx.c driver expects
1. chip select gpios from "cs-gpio"(singular) under the
   "controller-data" node of the client/slave device of the SPI.

2. "cs-gpio"(singular) entry to be present in the SPI device node.

Eg of current broken usage:
&spi_1 {
	cs-gpio <>;	/* this entry is checked during probe */
	...
	slave_node {
		controller-data {
			cs-gpio <&gpioa2 5 0>;
			/* This field is parsed during .setup() */
		}
	};
};

The following dts files which were using this driver. But,
din't have the "cs-gpio" entry under SPI node.
-- arch/arm/boot/dts/exynos4210-smdkv310.dts
-- arch/arm/boot/dts/exynos4412-trats2.dts
-- arch/arm/boot/dts/exynos5250-smdk5250.dts

Also, the SPI core and many drivers moved on to using "cs-gpios"
from SPI node and removed the gpio handling code from drivers
(including spi-s3c64xx.c).

Hence, spi-s3c64xx.c is broken since "Jun 21 11:26:12 2013" and
considering the time with no compliants about the breakage.

We are assuming it is safe to remove the "cs-gpio"(singular) usage
from device tree binding of spi-samsung.txt and makes appropriate
changes in the driver to use "cs-gpios"(plural) from
SPI device node.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <t.figa@samsung.com>
---
Changes since v5:
Fixed the "making a GPIO chip select mandatory" bug.

Changes since v4:
1. Added reviewed by from Javier and Tested by from Doug

Changes since v3:
1. Remove the sdd->cs_gpio and use gpio_is_valid(spi->cs_gpio) instead
2. Keep cs->line only for Non-DT platforms and use spi->cs_gpio
   for DT platforms
 .../devicetree/bindings/spi/spi-samsung.txt        |    8 ++---
 drivers/spi/spi-s3c64xx.c                          |   38 ++++++++------------
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 655b665..792efba 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -39,15 +39,13 @@ Optional Board Specific Properties:
 - num-cs: Specifies the number of chip select lines supported. If
   not specified, the default number of chip select lines is set to 1.
 
+- cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
+
 SPI Controller specific data in SPI slave nodes:
 
 - The spi slave nodes should provide the following information which is required
   by the spi controller.
 
-  - cs-gpio: A gpio specifier that specifies the gpio line used as
-    the slave select line by the spi controller. The format of the gpio
-    specifier depends on the gpio controller.
-
   - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
     miso line (to account for any lag in the miso line). The following are the
     valid values.
@@ -85,6 +83,7 @@ Example:
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_bus>;
+		cs-gpios = <&gpa2 5 0>;
 
 		w25q80bw at 0 {
 			#address-cells = <1>;
@@ -94,7 +93,6 @@ Example:
 			spi-max-frequency = <10000>;
 
 			controller-data {
-				cs-gpio = <&gpa2 5 1 0 3>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 75a5696..b61ff3d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -197,7 +197,6 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
-	bool				cs_gpio;
 };
 
 static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
@@ -776,17 +775,6 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* The CS line is asserted/deasserted by the gpio pin */
-	if (sdd->cs_gpio)
-		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
-
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
@@ -812,6 +800,10 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		spi->controller_data = cs;
 	}
 
+	/* For the non-DT platforms derive chip selects from controller data */
+	if (!spi->dev.of_node)
+		spi->cs_gpio = cs->line;
+
 	if (IS_ERR_OR_NULL(cs)) {
 		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
 		return -ENODEV;
@@ -819,17 +811,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	if (!spi_get_ctldata(spi)) {
 		/* Request gpio only if cs line is asserted by gpio pins */
-		if (sdd->cs_gpio) {
-			err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
-					dev_name(&spi->dev));
+		if (gpio_is_valid(spi->cs_gpio)) {
+			err = gpio_request_one(spi->cs_gpio,
+						GPIOF_OUT_INIT_HIGH,
+						dev_name(&spi->dev));
 			if (err) {
 				dev_err(&spi->dev,
 					"Failed to get /CS gpio [%d]: %d\n",
-					cs->line, err);
+					spi->cs_gpio, err);
 				goto err_gpio_req;
 			}
-
-			spi->cs_gpio = cs->line;
 		}
 
 		spi_set_ctldata(spi, cs);
@@ -884,7 +875,8 @@ setup_exit:
 	/* setup() returns with device de-selected */
 	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
-	gpio_free(cs->line);
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_free(spi->cs_gpio);
 	spi_set_ctldata(spi, NULL);
 
 err_gpio_req:
@@ -900,10 +892,12 @@ static void s3c64xx_spi_cleanup(struct spi_device *spi)
 	struct s3c64xx_spi_driver_data *sdd;
 
 	sdd = spi_master_get_devdata(spi->master);
-	if (spi->cs_gpio) {
+	if (gpio_is_valid(spi->cs_gpio)) {
 		gpio_free(spi->cs_gpio);
 		if (spi->dev.of_node)
 			kfree(cs);
+		else
+			spi->cs_gpio = -ENOENT;
 	}
 	spi_set_ctldata(spi, NULL);
 }
@@ -1075,11 +1069,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
-	sdd->cs_gpio = true;
 	if (pdev->dev.of_node) {
-		if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
-			sdd->cs_gpio = false;
-
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
-- 
1.7.9.5
