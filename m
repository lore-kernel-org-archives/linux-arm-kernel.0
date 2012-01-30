From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Jan 2012 16:27:49 +0100
Subject: [PATCH 1/3] of_spi: add generic binding support to specify ncs gpio
 in the slave
Message-ID: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to use gpio for chip select with no modification in the
driver binding

When use the ncs-gpio, the gpio number will be passed via the controller_data
and the number of chip select will automatically increased.

When a spi master have only gpio chip select and is probe via dt check the
number of chip select only when adding slave.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |    9 ++++++-
 drivers/of/of_spi.c                               |   27 ++++++++++++++------
 drivers/spi/spi.c                                 |    2 +-
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index e782add..1dccf35 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -21,9 +21,16 @@ assumption that board specific platform code will be used to manage
 chip selects.  Individual drivers can define additional properties to
 support describing the chip select layout.
 
+If a gpio a specified to the SPI slave and no hardware chip select is present
+the reg property #address-cells and #size-cells are not needed.
+
+When use the ncs-gpio the gpio number will be passed via the controller_data
+and the number of chip select will automatically increased.
+
 SPI slave nodes must be children of the SPI master node and can
 contain the following properties.
-- reg             - (required) chip select address of device.
+- reg             - (required if no ncs-gpio) chip select address of device.
+- ncs-gpio        - (required if no reg) chip select gpio of device.
 - compatible      - (required) name of SPI device following generic names
     		recommended practice
 - spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz
diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index 6dbc074..0d41407 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -12,6 +12,7 @@
 #include <linux/spi/spi.h>
 #include <linux/of_irq.h>
 #include <linux/of_spi.h>
+#include <linux/of_gpio.h>
 
 /**
  * of_register_spi_devices - Register child devices onto the SPI bus
@@ -27,6 +28,7 @@ void of_register_spi_devices(struct spi_master *master)
 	const __be32 *prop;
 	int rc;
 	int len;
+	int ncs_pin;
 
 	if (!master->dev.of_node)
 		return;
@@ -50,15 +52,24 @@ void of_register_spi_devices(struct spi_master *master)
 			continue;
 		}
 
-		/* Device address */
-		prop = of_get_property(nc, "reg", &len);
-		if (!prop || len < sizeof(*prop)) {
-			dev_err(&master->dev, "%s has no 'reg' property\n",
-				nc->full_name);
-			spi_dev_put(spi);
-			continue;
+		/* ncs gpio */
+		ncs_pin = of_get_named_gpio(nc, "ncs-gpio", 0);
+
+		if (gpio_is_valid(ncs_pin)) {
+			spi->controller_data = (void *)ncs_pin;
+			spi->chip_select = master->num_chipselect;
+			master->num_chipselect++;
+		} else {
+			/* Device address */
+			prop = of_get_property(nc, "reg", &len);
+			if (!prop || len < sizeof(*prop)) {
+				dev_err(&master->dev, "%s has no 'reg' property\n",
+					nc->full_name);
+				spi_dev_put(spi);
+				continue;
+			}
+			spi->chip_select = be32_to_cpup(prop);
 		}
-		spi->chip_select = be32_to_cpup(prop);
 
 		/* Mode (clock phase/polarity/etc.) */
 		if (of_find_property(nc, "spi-cpha", NULL))
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2ccdea..ccd1a6f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -595,7 +595,7 @@ int spi_register_master(struct spi_master *master)
 	/* even if it's just one always-selected device, there must
 	 * be at least one chipselect
 	 */
-	if (master->num_chipselect == 0)
+	if (!master->dev.of_node && master->num_chipselect == 0)
 		return -EINVAL;
 
 	/* convention:  dynamically assigned bus IDs count down from the max */
-- 
1.7.7
