From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 15 Jul 2014 17:50:58 +0530
Subject: [PATCH 1/3] spi: s3c64xx: move "cs-gpio" from subnode to SPI DT node
In-Reply-To: <1405426860-18404-1-git-send-email-ch.naveen@samsung.com>
References: <1405426860-18404-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405426860-18404-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the spi-s3c64xx.c driver to fetch the 
Chip select or Slave select gpio line property "cs-gpios"
from SPI node instead of "controller_data" subnode.

Rename the property "cs-gpio" to "cs-gpios" in accordance
with the SPI core. Such that s3c64xx.c can use spi->cs_gpio
instead of parsing the property in the driver.

Update the dt-bindings ion spi/spi-samsung.txt

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Tomasz Figa <t.figa@samsung.com>
---
This patch is a rework of the change @
http://www.mail-archive.com/devicetree at vger.kernel.org/msg34500.html

I'm not sure if i can carry forward the other Signed-offs and Tested-bys

 .../devicetree/bindings/spi/spi-samsung.txt        |   10 +++++-----
 drivers/spi/spi-s3c64xx.c                          |   18 ++++++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 655b665..ff3c4c9 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -39,15 +39,15 @@ Optional Board Specific Properties:
 - num-cs: Specifies the number of chip select lines supported. If
   not specified, the default number of chip select lines is set to 1.
 
+- cs-gpios: A gpio specifier that specifies the gpio line used as
+  the slave select line by the spi controller. The format of the gpio
+  specifier depends on the gpio controller (Also read spi-bus.txt).
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
@@ -85,6 +85,7 @@ Example:
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_bus>;
+		cs-gpios = <&gpa2 5 1 0 3>;
 
 		w25q80bw at 0 {
 			#address-cells = <1>;
@@ -94,7 +95,6 @@ Example:
 			spi-max-frequency = <10000>;
 
 			controller-data {
-				cs-gpio = <&gpa2 5 1 0 3>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 75a5696..72bfba6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -764,12 +764,6 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-EINVAL);
 	}
 
-	data_np = of_get_child_by_name(slave_np, "controller-data");
-	if (!data_np) {
-		dev_err(&spi->dev, "child node 'controller-data' not found\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs) {
 		of_node_put(data_np);
@@ -777,13 +771,17 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 	}
 
 	/* The CS line is asserted/deasserted by the gpio pin */
-	if (sdd->cs_gpio)
-		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
+	cs->line = spi->cs_gpio;
 
 	if (!gpio_is_valid(cs->line)) {
 		dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
 		kfree(cs);
-		of_node_put(data_np);
+		return ERR_PTR(-EINVAL);
+	}
+
+	data_np = of_get_child_by_name(slave_np, "controller-data");
+	if (!data_np) {
+		dev_err(&spi->dev, "child node 'controller-data' not found\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1077,7 +1075,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->sfr_start = mem_res->start;
 	sdd->cs_gpio = true;
 	if (pdev->dev.of_node) {
-		if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
+		if (!of_find_property(pdev->dev.of_node, "cs-gpios", NULL))
 			sdd->cs_gpio = false;
 
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-- 
1.7.9.5
