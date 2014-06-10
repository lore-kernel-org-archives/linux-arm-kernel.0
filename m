From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 10 Jun 2014 15:38:00 +0530
Subject: [PATCH 1/2 v2] spi: s3c64xx: use "cs-gpios" from spi node instead of
 "cs-gpio"
In-Reply-To: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>
References: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1402394881-31564-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, spi-s3c64xx.c needs "cs-gpio" chip select GPIO to be
defined under "controller-data" node under each slave node.

&spi_x {
	cs-gpios <>;
	...
	slave_node {

		controller-data {
			cs-gpio = <>;
			...
		};
		...
	};
	...
};

Where as, SPI core and many other drivers uses "cs-gpios" for
from device tree node.

Hence, make changes in spi-s3c64xx.c driver to make use of
"cs-gpios" from SPI node(parent) instead of "cs-gpio" defined in
slaves "controller-data"(child) node.

Also updates the Device tree Documentation.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Doug Anderson <dianders@chromium.org>
---
Changes since v1:
1. fixed a compilation warning thus squashing the other patch into this.
2. Updated device tree description in spi-samsung.txt

 .../devicetree/bindings/spi/spi-samsung.txt        |    8 ++-
 drivers/spi/spi-s3c64xx.c                          |   56 ++++++++++++--------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 86aa061..13bfcb5 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -42,15 +42,13 @@ Optional Board Specific Properties:
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
+		cs-gpios = <&gpa2 5 1 0 3>;
 
 		w25q80bw at 0 {
 			#address-cells = <1>;
@@ -94,7 +93,6 @@ Example:
 			spi-max-frequency = <10000>;
 
 			controller-data {
-				cs-gpio = <&gpa2 5 1 0 3>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 75a5696..4594dde 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -750,47 +750,56 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 }
 
 static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
-				struct spi_device *spi)
+				struct spi_device *spi,
+				struct s3c64xx_spi_csinfo *cs)
 {
-	struct s3c64xx_spi_csinfo *cs;
-	struct device_node *slave_np, *data_np = NULL;
-	struct s3c64xx_spi_driver_data *sdd;
+	struct device_node *data_np = NULL;
 	u32 fb_delay = 0;
 
-	sdd = spi_master_get_devdata(spi->master);
-	slave_np = spi->dev.of_node;
-	if (!slave_np) {
-		dev_err(&spi->dev, "device node not found\n");
+	data_np = of_get_child_by_name(spi->dev.of_node, "controller-data");
+	if (!data_np) {
+		dev_err(&spi->dev, "child node 'controller-data' not found\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	data_np = of_get_child_by_name(slave_np, "controller-data");
-	if (!data_np) {
-		dev_err(&spi->dev, "child node 'controller-data' not found\n");
+	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
+	cs->fb_delay = fb_delay;
+	of_node_put(data_np);
+
+	return cs;
+}
+
+static struct s3c64xx_spi_csinfo *s3c64xx_get_cs_gpios(struct spi_device *spi)
+{
+	struct device_node *parent_np = NULL;
+	struct s3c64xx_spi_driver_data *sdd;
+	struct s3c64xx_spi_csinfo *cs;
+
+	parent_np = of_get_parent(spi->dev.of_node);
+	if (!parent_np) {
+		dev_err(&spi->dev, "Parent node not found\n");
 		return ERR_PTR(-EINVAL);
 	}
 
+	sdd = spi_master_get_devdata(spi->master);
+
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs) {
-		of_node_put(data_np);
+		of_node_put(parent_np);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	/* The CS line is asserted/deasserted by the gpio pin */
 	if (sdd->cs_gpio)
-		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
+		cs->line = of_get_named_gpio(parent_np, "cs-gpios", 0);
 
 	if (!gpio_is_valid(cs->line)) {
 		dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
-		kfree(cs);
-		of_node_put(data_np);
+		of_node_put(parent_np);
 		return ERR_PTR(-EINVAL);
 	}
 
-	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
-	cs->fb_delay = fb_delay;
-	of_node_put(data_np);
-	return cs;
+	return s3c64xx_get_slave_ctrldata(spi, cs);
 }
 
 /*
@@ -806,9 +815,14 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	struct s3c64xx_spi_info *sci;
 	int err;
 
+	if (!spi->dev.of_node) {
+		dev_err(&spi->dev, "device node not found\n");
+		return -EINVAL;
+	}
+
 	sdd = spi_master_get_devdata(spi->master);
 	if (!cs && spi->dev.of_node) {
-		cs = s3c64xx_get_slave_ctrldata(spi);
+		cs = s3c64xx_get_cs_gpios(spi);
 		spi->controller_data = cs;
 	}
 
@@ -1077,7 +1091,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->sfr_start = mem_res->start;
 	sdd->cs_gpio = true;
 	if (pdev->dev.of_node) {
-		if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
+		if (!of_find_property(pdev->dev.of_node, "cs-gpios", NULL))
 			sdd->cs_gpio = false;
 
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-- 
1.7.9.5
