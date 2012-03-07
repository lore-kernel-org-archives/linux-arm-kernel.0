From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 13:23:06 +0100
Subject: [PATCH 1/4 v4] of_spi: add generic binding support to specify cs gpio
Message-ID: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to use gpio for chip select with no modification in the
driver binding

When use the cs-gpios, the gpio number will be passed via the cs_gpio field
and the number of chip select will automatically increased.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
---
v4:
	use cs_gpio to pass the gpio number

Best Regards,
J.
 Documentation/devicetree/bindings/spi/spi-bus.txt |    6 ++
 drivers/spi/spi.c                                 |   57 +++++++++++++++++++-
 include/linux/spi/spi.h                           |    6 ++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index e782add..c253379 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -12,6 +12,7 @@ The SPI master node requires the following properties:
 - #size-cells     - should be zero.
 - compatible      - name of SPI bus controller following generic names
     		recommended practice.
+- cs-gpios	  - (optional) gpios chip select.
 No other properties are required in the SPI bus node.  It is assumed
 that a driver for an SPI bus device will understand that it is an SPI bus.
 However, the binding does not attempt to define the specific method for
@@ -21,6 +22,8 @@ assumption that board specific platform code will be used to manage
 chip selects.  Individual drivers can define additional properties to
 support describing the chip select layout.
 
+If cs-gpios is used the number of chip select will automatically increased.
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
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2ccdea..c1d0955 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -28,6 +28,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/of_spi.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
 
@@ -322,6 +323,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 	spi->dev.parent = &master->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
+	spi->cs_gpio = -EINVAL;
 	device_initialize(&spi->dev);
 	return spi;
 }
@@ -339,15 +341,16 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
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
 
@@ -371,6 +374,13 @@ int spi_add_device(struct spi_device *spi)
 		goto done;
 	}
 
+	if (master->num_gpio_cs &&
+	    spi->chip_select >= master->first_gpio_cs) {
+		int num = spi->chip_select - master->first_gpio_cs;
+
+		spi->cs_gpio = master->cs_gpios[num];
+	}
+
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
@@ -561,6 +571,43 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_master);
 
+#ifdef CONFIG_OF
+static int of_spi_register_master(struct spi_master *master)
+{
+	int nb, i;
+	int *cs;
+	struct device_node *np = master->dev.of_node;
+
+	if (!np)
+		return 0;
+
+	nb = of_gpio_named_count(np, "cs-gpios");
+
+	if (nb < 1)
+		return 0;
+
+	cs = devm_kzalloc(&master->dev, sizeof(int) * nb, GFP_KERNEL);
+	master->cs_gpios = cs;
+
+	if (!master->cs_gpios)
+		return -ENOMEM;
+
+	master->first_gpio_cs = master->num_chipselect;
+	master->num_chipselect += nb;
+	master->num_gpio_cs = nb;
+
+	for (i = 0; i < nb; i++)
+		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
+
+	return 0;
+}
+#else
+static int of_spi_register_master(struct spi_master *master)
+{
+	return 0;
+}
+#endif
+
 /**
  * spi_register_master - register SPI master controller
  * @master: initialized master, originally from spi_alloc_master()
@@ -592,6 +639,10 @@ int spi_register_master(struct spi_master *master)
 	if (!dev)
 		return -ENODEV;
 
+	status = of_spi_register_master(master);
+	if (status)
+		return status;
+
 	/* even if it's just one always-selected device, there must
 	 * be@least one chipselect
 	 */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 176fce9..7dcf031 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -89,6 +89,7 @@ struct spi_device {
 	void			*controller_state;
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
+	int			cs_gpio;	/* chip select gpio */
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
@@ -318,6 +319,11 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	/* gpio chip select */
+	int			*cs_gpios;
+	int			first_gpio_cs;
+	int			num_gpio_cs;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.7.7
