From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  9 Feb 2012 17:14:36 +0100
Subject: [PATCH 2/3] of_spi: add generic binding support to specify ncs gpio
In-Reply-To: <1328804077-6121-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328804077-6121-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328804077-6121-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to use gpio for chip select with no modification in the
driver binding

When use the ncs-gpios, the gpio number will be passed via the controller_data
and the number of chip select will automatically increased.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |    6 +++
 drivers/of/of_spi.c                               |   27 ++++++++---
 drivers/spi/spi.c                                 |   51 +++++++++++++++++++-
 include/linux/spi/spi.h                           |    5 ++
 4 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index e782add..5a24729 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -12,6 +12,7 @@ The SPI master node requires the following properties:
 - #size-cells     - should be zero.
 - compatible      - name of SPI bus controller following generic names
     		recommended practice.
+- ncs-gpios       - (optional) gpios chip select.
 No other properties are required in the SPI bus node.  It is assumed
 that a driver for an SPI bus device will understand that it is an SPI bus.
 However, the binding does not attempt to define the specific method for
@@ -21,6 +22,8 @@ assumption that board specific platform code will be used to manage
 chip selects.  Individual drivers can define additional properties to
 support describing the chip select layout.
 
+If ncs-gpios is used the number of chip select will automatically increased.
+
 SPI slave nodes must be children of the SPI master node and can
 contain the following properties.
 - reg             - (required) chip select address of device.
@@ -34,6 +37,9 @@ contain the following properties.
 - spi-cs-high     - (optional) Empty property indicating device requires
     		chip select active high
 
+If a gpio chipselect is used for the SPI slave the gpio number will be passed
+via the controller_data
+
 SPI example for an MPC5200 SPI bus:
 	spi at f00 {
 		#address-cells = <1>;
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
index e2f4ca0..1f5ffa6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -28,6 +28,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/of_spi.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
 
@@ -339,15 +340,16 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 int spi_add_device(struct spi_device *spi)
 {
 	static DEFINE_MUTEX(spi_add_lock);
-	struct device *dev = spi->master->dev.parent;
+	struct spi_master *master = spi->master;
+	struct device *dev = master->dev.parent;
 	struct device *d;
 	int status;
 
 	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= spi->master->num_chipselect) {
+	if (spi->chip_select >= master->num_chipselect) {
 		dev_err(dev, "cs%d >= max %d\n",
 			spi->chip_select,
-			spi->master->num_chipselect);
+			master->num_chipselect);
 		return -EINVAL;
 	}
 
@@ -371,6 +373,13 @@ int spi_add_device(struct spi_device *spi)
 		goto done;
 	}
 
+	if (master->num_gpio_chipselect &&
+	    spi->chip_select >= master->first_gpio_chipselect) {
+		int num = spi->chip_select = master->first_gpio_chipselect;
+
+		spi->controller_data = (void*)master->chipselect_gpios[num];
+	}
+
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
@@ -562,6 +571,38 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_master);
 
+static int of_spi_register_master(struct spi_master *master)
+{
+	int nb, i;
+	int *cs;
+	struct device_node *np = master->dev.of_node;
+
+	if (!np)
+		return 0;
+
+	nb = of_gpio_named_count(np, "ncs-gpios");
+
+	if (nb < 1)
+		return 0;
+
+	master->chipselect_gpios = kzalloc(sizeof(int) * nb, GFP_KERNEL);
+
+	if (!master->chipselect_gpios)
+		return -ENOMEM;
+
+	master->first_gpio_chipselect = master->num_chipselect;
+	master->num_chipselect += nb;
+	master->num_gpio_chipselect = nb;
+
+	for (i = 0; i < nb; i++) {
+		cs = &master->chipselect_gpios[i];
+
+		*cs = of_get_named_gpio(np, "ncs-gpios", i);
+	}
+
+	return 0;
+}
+
 /**
  * spi_register_master - register SPI master controller
  * @master: initialized master, originally from spi_alloc_master()
@@ -593,6 +634,10 @@ int spi_register_master(struct spi_master *master)
 	if (!dev)
 		return -ENODEV;
 
+	status = of_spi_register_master(master);
+	if (status)
+		return status;
+
 	/* even if it's just one always-selected device, there must
 	 * be at least one chipselect
 	 */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 176fce9..d21c267 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -318,6 +318,11 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	/* gpio chip select */
+	int			*chipselect_gpios;
+	int			first_gpio_chipselect;
+	int			num_gpio_chipselect;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.7.7
