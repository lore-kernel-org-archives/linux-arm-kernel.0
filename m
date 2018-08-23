From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Aug 2018 12:33:32 +0200
Subject: [PATCH 4/4] bus: 96boards Low-Speed Connector
In-Reply-To: <20180823103332.32047-1-linus.walleij@linaro.org>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
Message-ID: <20180823103332.32047-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This creates a bus for using a small connector driver to
plug in "mezzanine boards" on the 96boards low-speed connector
either by a very simple compatible string for the entire board,
or by simply inserting the board device from userspace.

These "mezzanine boards" are no different than "capes", "logic
modules", etc. This thing, a non-discoverable connector where
a user can plug in a few peripherals has been reinvented a few
times.

As a proof-of-concept we add the Secure96, a quite minimal
mezzanine board.

Users can register their boards in a simple way. Either just
add their compatible-string in the device tree:

board {
        compatible = "96boards,secure96";
};

And if they can't even change three lines in their device tree,
or if they at runtime decide to plug in some board and test it,
they can use sysfs, as exemplified by plugging in the secure96
security board at runtime:

> cd /sys/bus/96boards-ls-connector-bus
> cat supported
secure96
> echo secure96 > inject
[   61.014629] lscon connector: called mezzanine_store on secure96
[   61.020530] lscon connector: populate secure96
[   61.027081] at24 1-0050: 2048 byte 24c128 EEPROM, writable, 128 bytes/write
[   61.053569] atmel-ecc 1-0060: configuration zone is unlocked
[   61.502535] tpm_tis_spi spi0.0: 2.0 TPM (device-id 0x1B, rev-id 16)
(...)

The plug-in board can be removed from sysfs and added back
again multiple times like this with the devices being runtime
added and removed by two writes to sysfs.

> echo secure96 > eject
> echo secure96 > inject
> echo secure96 > eject
(...)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog RFC->v1:
- Create a new bus type as recommended by Arnd, fixing a bunch of
  scalability issues and making the whole thing look like most
  other kernel device driver cores.
- Create LS connector devices that have .probe() and .remove()
  functions like any other device.
- Move dynamic device creation to bus attribute files.
---
 drivers/bus/Kconfig                           |   2 +
 drivers/bus/Makefile                          |   4 +-
 drivers/bus/daughterboards/96boards-ls-bus.c  |  39 ++
 .../daughterboards/96boards-ls-connector.c    | 367 ++++++++++++++++++
 .../bus/daughterboards/96boards-mezzanines.h  |  77 ++++
 .../bus/daughterboards/96boards-secure96.c    | 265 +++++++++++++
 drivers/bus/daughterboards/Kconfig            |  50 +++
 drivers/bus/daughterboards/Makefile           |   6 +
 8 files changed, 809 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/daughterboards/96boards-ls-bus.c
 create mode 100644 drivers/bus/daughterboards/96boards-ls-connector.c
 create mode 100644 drivers/bus/daughterboards/96boards-mezzanines.h
 create mode 100644 drivers/bus/daughterboards/96boards-secure96.c
 create mode 100644 drivers/bus/daughterboards/Kconfig
 create mode 100644 drivers/bus/daughterboards/Makefile

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60e9326..98393c6e2190 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -173,4 +173,6 @@ config DA8XX_MSTPRI
 
 source "drivers/bus/fsl-mc/Kconfig"
 
+source "drivers/bus/daughterboards/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index b8f036cca7ff..7a792e3e2cc2 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -29,5 +29,7 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
-
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
+
+# Non-discoverable daughterboards
+obj-$(CONFIG_DAUGHTERBOARDS)	+= daughterboards/
diff --git a/drivers/bus/daughterboards/96boards-ls-bus.c b/drivers/bus/daughterboards/96boards-ls-bus.c
new file mode 100644
index 000000000000..23de06b3fce3
--- /dev/null
+++ b/drivers/bus/daughterboards/96boards-ls-bus.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 96boards Low-speed Connector bus initialization
+ * (C) 2018 Linus Walleij <linus.walleij@linaro.org>
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include "96boards-mezzanines.h"
+
+static int ls_match(struct device *dev, struct device_driver *drv)
+{
+	/* First match on OF node */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	/* Second match on name */
+	return !strcmp(dev_name(dev), drv->name);
+}
+
+struct bus_type ls_bus_type = {
+	.name = "96boards-ls-connector-bus",
+	.match = ls_match,
+};
+EXPORT_SYMBOL_GPL(ls_bus_type);
+
+static int __init ls_bus_init(void)
+{
+	int ret;
+
+	/* Register the LS connector bus so devices can start to probe */
+	ret = bus_register(&ls_bus_type);
+	if (ret) {
+		pr_err("could not register LS connector bus\n");
+		return ret;
+	}
+	return 0;
+}
+postcore_initcall(ls_bus_init);
diff --git a/drivers/bus/daughterboards/96boards-ls-connector.c b/drivers/bus/daughterboards/96boards-ls-connector.c
new file mode 100644
index 000000000000..5c958f47b23e
--- /dev/null
+++ b/drivers/bus/daughterboards/96boards-ls-connector.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 96boards Low-speed Connector driver
+ * (C) 2018 Linus Walleij <linus.walleij@linaro.org>
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/idr.h>
+#include "96boards-mezzanines.h"
+
+static DEFINE_IDA(ls_device_ida);
+
+static int ls_driver_probe(struct device *dev)
+{
+	struct ls_device *lsdev = to_ls_device(dev);
+	struct ls_driver *lsdrv = to_ls_driver(dev->driver);
+
+	if (lsdrv->probe)
+		return lsdrv->probe(lsdev);
+	return 0;
+}
+
+static int ls_driver_remove(struct device *dev)
+{
+	struct ls_device *lsdev = to_ls_device(dev);
+	struct ls_driver *lsdrv = to_ls_driver(dev->driver);
+
+	if (lsdrv->remove)
+		lsdrv->remove(lsdev);
+	return 0;
+}
+
+int ls_driver_register(struct ls_driver *lsdrv)
+{
+	lsdrv->drv.bus = &ls_bus_type;
+	lsdrv->drv.probe = ls_driver_probe;
+	lsdrv->drv.remove = ls_driver_remove;
+
+	return driver_register(&lsdrv->drv);
+}
+EXPORT_SYMBOL_GPL(ls_driver_register);
+
+void ls_driver_unregister(struct ls_driver *lsdrv)
+{
+	driver_unregister(&lsdrv->drv);
+}
+EXPORT_SYMBOL_GPL(ls_driver_unregister);
+
+struct gpio_desc *ls_get_gpiod(struct ls_device *ls,
+			       enum ls_gpio pin,
+			       const char *consumer_name,
+			       enum gpiod_flags flags)
+{
+	struct gpio_desc *retdesc;
+
+	/*
+	 * TODO: get all the LS GPIOs as an array on probe() then
+	 * the consumers can skip error handling of IS_ERR() descriptors
+	 * and this need only set the consumer name.
+	 */
+	retdesc = devm_gpiod_get_index(ls->dev.parent, NULL, pin, flags);
+	if (!IS_ERR(retdesc) && consumer_name)
+		gpiod_set_consumer_name(retdesc, consumer_name);
+
+	return retdesc;
+}
+EXPORT_SYMBOL_GPL(ls_get_gpiod);
+
+/*
+ * Mezzanine boards will call this to orderly remove their claimed
+ * gpio descriptors, since we acquired them all with devm_gpiod_get()
+ * they will eventually be released once this connector device
+ * disappears if the board do not release them in order.
+ */
+void ls_put_gpiod(struct ls_device *ls, struct gpio_desc *gpiod)
+{
+	devm_gpiod_put(ls->dev.parent, gpiod);
+}
+EXPORT_SYMBOL_GPL(ls_put_gpiod);
+
+static int lscon_add_device(struct ls_connector *ls,
+			    const char *name,
+			    struct device_node *np)
+{
+	struct ls_device *lsdev;
+	int ret;
+
+	lsdev = kzalloc(sizeof(*lsdev), GFP_KERNEL);
+	if (!lsdev)
+		return -ENOMEM;
+
+	lsdev->id = ida_simple_get(&ls_device_ida, 0, 0, GFP_KERNEL);
+	if (lsdev->id < 0)
+		return lsdev->id;
+	lsdev->dev.bus = &ls_bus_type;
+	lsdev->dev.of_node = np;
+	lsdev->dev.parent = ls->dev;
+	/* Propagate resources to the device */
+	lsdev->i2c0 = ls->i2c0;
+	lsdev->i2c1 = ls->i2c1;
+	lsdev->spi = ls->spi;
+	/*
+	 * In /sys/bus/96boards-ls-connector-bus/devices/ we find
+	 * mezzanine0, mezzanine1 etc OR the device name if inserted
+	 * from userspace.
+	 */
+	if (name)
+		dev_set_name(&lsdev->dev, "%s", name);
+	else
+		dev_set_name(&lsdev->dev, "mezzanine%d", lsdev->id);
+	device_initialize(&lsdev->dev);
+	ret = device_add(&lsdev->dev);
+	if (ret) {
+		dev_err(ls->dev, "failed to add device %s\n",
+			dev_name(&lsdev->dev));
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lscon_del_device(struct ls_device *lsdev)
+{
+	device_del(&lsdev->dev);
+	ida_simple_remove(&ls_device_ida, lsdev->id);
+	kfree(lsdev);
+}
+
+struct ls_supported_buf {
+	char *buf;
+	size_t count;
+};
+
+static int ls_supported_print(struct device_driver *drv, void *data)
+{
+	struct ls_supported_buf *buf = data;
+	size_t count;
+
+	count = snprintf(buf->buf + buf->count,
+			 PAGE_SIZE, "%s\n", drv->name);
+	buf->count += count;
+	return 0;
+}
+
+static ssize_t ls_supported_show(struct bus_type *bus, char *buf)
+{
+	struct ls_supported_buf sbuf;
+
+	/* Loop over the driver list and show supported devices */
+	sbuf.buf = buf;
+	sbuf.count = 0;
+	bus_for_each_drv(&ls_bus_type, NULL, &sbuf, ls_supported_print);
+
+	return sbuf.count;
+}
+
+static BUS_ATTR(supported, 0444, ls_supported_show, NULL);
+
+/*
+ * Match the supplied string to a driver name, if we find
+ * a match we return 1, saying this device is elegible for
+ * insertion.
+ */
+static int ls_inject_match(struct device_driver *drv, void *data)
+{
+	const char *devname = data;
+
+	if (!strcmp(devname, drv->name))
+		return 1;
+	return 0;
+}
+
+static ssize_t ls_inject_store(struct bus_type *bus,
+			       const char *buf, size_t count)
+{
+	struct device *dev = ls_bus_type.dev_root;
+	struct ls_connector *ls = dev_get_drvdata(dev);
+	char *devname;
+	int ret;
+
+	devname = kstrdup(buf, GFP_KERNEL);
+	devname = strstrip(devname);
+	/* Look if we have a driver for this device */
+	ret = bus_for_each_drv(&ls_bus_type, NULL, devname, ls_inject_match);
+	if (!ret) {
+		kfree(devname);
+		return count;
+	}
+
+	dev_info(ls->dev, "create %s device\n", devname);
+	/*
+	 * No corresponding DT node
+	 *
+	 * TODO: when we have device tree overlays, this is a good
+	 * place to start when inserting dynamic devices.
+	 */
+	lscon_add_device(ls, devname, NULL);
+
+	kfree(devname);
+	return count;
+}
+
+static BUS_ATTR(inject, 0644, NULL, ls_inject_store);
+
+static ssize_t ls_eject_store(struct bus_type *bus,
+			      const char *buf, size_t count)
+{
+	struct device *busdev = ls_bus_type.dev_root;
+	struct ls_connector *ls = dev_get_drvdata(busdev);
+	struct ls_device *lsdev;
+	struct device *dev;
+	char *devname;
+
+	devname = kstrdup(buf, GFP_KERNEL);
+	devname = strstrip(devname);
+	/* Look if we have this device */
+	dev = bus_find_device_by_name(&ls_bus_type, NULL, devname);
+	if (!dev) {
+		kfree(devname);
+		return count;
+	}
+
+	dev_info(ls->dev, "destroy %s device\n", devname);
+
+	lsdev = to_ls_device(dev);
+	lscon_del_device(lsdev);
+	kfree(devname);
+
+	return count;
+}
+
+static BUS_ATTR(eject, 0644, NULL, ls_eject_store);
+
+static int lscon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	struct spi_controller *spi;
+	struct ls_connector *ls;
+	int ret;
+
+	ls = devm_kzalloc(dev, sizeof(*ls), GFP_KERNEL);
+	if (!ls)
+		return -ENOMEM;
+	ls->dev = dev;
+
+	/* Bridge I2C busses */
+	child = of_parse_phandle(np, "i2c0", 0);
+	if (!child) {
+		dev_err(dev, "no i2c0 phandle\n");
+		return -ENODEV;
+	}
+	ls->i2c0 = of_get_i2c_adapter_by_node(child);
+	if (!ls->i2c0) {
+		dev_err(dev, "no i2c0 adapter, deferring\n");
+		return -EPROBE_DEFER;
+	}
+
+	child = of_parse_phandle(np, "i2c1", 0);
+	if (!child) {
+		dev_err(dev, "no i2c1 phandle\n");
+		ret = -ENODEV;
+		goto out_put_i2c0;
+	}
+	ls->i2c1 = of_get_i2c_adapter_by_node(child);
+	if (!ls->i2c1) {
+		dev_err(dev, "no i2c0 adapter, deferring\n");
+		ret = -EPROBE_DEFER;
+		goto out_put_i2c0;
+	}
+
+	/* Bridge SPI bus */
+	child = of_parse_phandle(np, "spi", 0);
+	if (!child) {
+		dev_err(dev, "no spi phandle\n");
+		ret = -ENODEV;
+		goto out_put_i2c1;
+	}
+	spi = of_find_spi_controller_by_node(child);
+	if (!spi) {
+		dev_err(dev, "no spi controller, deferring\n");
+		ret = -EPROBE_DEFER;
+		goto out_put_i2c1;
+	}
+	ls->spi = spi_controller_get(spi);
+	if (!ls->spi) {
+		dev_err(dev, "no spi reference\n");
+		ret = -ENODEV;
+		goto out_put_i2c1;
+	}
+
+	platform_set_drvdata(pdev, ls);
+
+	ls_bus_type.dev_root = dev;
+	ret = bus_create_file(&ls_bus_type, &bus_attr_supported);
+	if (ret)
+		goto out_put_i2c1;
+	ret = bus_create_file(&ls_bus_type, &bus_attr_inject);
+	if (ret)
+		goto out_put_i2c1;
+	ret = bus_create_file(&ls_bus_type, &bus_attr_eject);
+	if (ret)
+		goto out_put_i2c1;
+
+	/*
+	 * Add mezzanine boards as children, stacking possible.
+	 * All direct children of the LS connector will be considered
+	 * mezzanines.
+	 */
+	for_each_available_child_of_node(np, child)
+		lscon_add_device(ls, NULL, child);
+
+	return 0;
+
+out_put_i2c1:
+	i2c_put_adapter(ls->i2c1);
+out_put_i2c0:
+	i2c_put_adapter(ls->i2c0);
+	return ret;
+}
+
+static int lscon_del_dev(struct device *dev, void *data)
+{
+	struct ls_device *lsdev = to_ls_device(dev);
+
+	lscon_del_device(lsdev);
+	return 0;
+}
+
+static int lscon_remove(struct platform_device *pdev)
+{
+	struct ls_connector *ls = platform_get_drvdata(pdev);
+
+	/* Make sure we remove any registered devices */
+	bus_for_each_dev(&ls_bus_type, NULL, NULL, lscon_del_dev);
+
+	ls_bus_type.dev_root = NULL;
+	spi_controller_put(ls->spi);
+	i2c_put_adapter(ls->i2c1);
+	i2c_put_adapter(ls->i2c0);
+
+	return 0;
+}
+
+static const struct of_device_id lscon_of_match[] = {
+	{
+		.compatible = "96boards,low-speed-connector",
+	},
+	{ },
+};
+
+static struct platform_driver lscon_driver = {
+	.driver = {
+		.name = "lscon",
+		.of_match_table = of_match_ptr(lscon_of_match),
+	},
+	.probe  = lscon_probe,
+	.remove = lscon_remove,
+};
+builtin_platform_driver(lscon_driver);
diff --git a/drivers/bus/daughterboards/96boards-mezzanines.h b/drivers/bus/daughterboards/96boards-mezzanines.h
new file mode 100644
index 000000000000..93d2c6c910ed
--- /dev/null
+++ b/drivers/bus/daughterboards/96boards-mezzanines.h
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+
+/**
+ * enum ls_gpio - the GPIO lines on the low-speed connector
+ */
+enum ls_gpio {
+	LS_GPIO_A = 0,
+	LS_GPIO_B,
+	LS_GPIO_C,
+	LS_GPIO_D,
+	LS_GPIO_E,
+	LS_GPIO_F,
+	LS_GPIO_G,
+	LS_GPIO_H,
+	LS_GPIO_I,
+	LS_GPIO_J,
+	LS_GPIO_K,
+	LS_GPIO_L,
+};
+
+/*
+ * We try to use the most simplistic device model: here is the LS
+ * connector, it is a custom bus with its own type of devices and drivers
+ * on it.
+ */
+
+extern struct bus_type ls_bus_type;
+
+/**
+ * struct ls_connector - the connector per se
+ * @dev: parent device (platform device in the device tree case)
+ * @i2c0: upward i2c0 I2C bus
+ * @i2c1: upward i2c1 I2C bus
+ * @spi: upward SPI bus
+ */
+struct ls_connector {
+	struct device *dev;
+	struct i2c_adapter *i2c0;
+	struct i2c_adapter *i2c1;
+	struct spi_controller *spi;
+};
+
+struct ls_device {
+	struct device dev;
+	const char *compatible;
+	int id;
+	struct i2c_adapter *i2c0;
+	struct i2c_adapter *i2c1;
+	struct spi_controller *spi;
+};
+
+struct ls_driver {
+	struct device_driver drv;
+	struct dev_ext_attribute ext_attr;
+	int (*probe)(struct ls_device *);
+	void (*remove)(struct ls_device *);
+};
+
+#define to_ls_device(d) \
+	container_of(d, struct ls_device, dev)
+#define to_ls_driver(d) \
+	container_of(d, struct ls_driver, drv)
+
+extern int ls_driver_register(struct ls_driver *);
+extern void ls_driver_unregister(struct ls_driver *);
+
+struct gpio_desc *ls_get_gpiod(struct ls_device *ls,
+			       enum ls_gpio pin,
+			       const char *consumer_name,
+			       enum gpiod_flags flags);
+void ls_put_gpiod(struct ls_device *ls,
+		  struct gpio_desc *gpiod);
diff --git a/drivers/bus/daughterboards/96boards-secure96.c b/drivers/bus/daughterboards/96boards-secure96.c
new file mode 100644
index 000000000000..28053c646ba9
--- /dev/null
+++ b/drivers/bus/daughterboards/96boards-secure96.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 96boards Secure96 mezzanine board driver
+ * (C) 2018 Linus Walleij <linus.walleij@linaro.org>
+ */
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/sizes.h>
+#include <linux/platform_data/at24.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include "96boards-mezzanines.h"
+
+struct secure96 {
+	struct device *dev;
+	struct ls_device *ls;
+	struct platform_device *leds_device;
+	struct gpio_led *secure96_leds;
+	struct i2c_client *eeprom;
+	struct i2c_client *crypto;
+	struct i2c_client *hash;
+	struct gpio_desc *tpm_reset;
+	struct gpio_desc *tpm_irq;
+	struct spi_device *tpm;
+};
+
+struct secure96_ledinfo {
+	enum ls_gpio pin;
+	const char *ledname;
+};
+
+/*
+ * GPIO-F, G, H and I are connected to LEDs, two red and two green
+ */
+static const struct secure96_ledinfo ledinfos[] = {
+	{
+		.pin = LS_GPIO_F,
+		.ledname = "secure96:red:0",
+	},
+	{
+		.pin = LS_GPIO_G,
+		.ledname = "secure96:red:1",
+	},
+	{
+		.pin = LS_GPIO_H,
+		.ledname = "secure96:green:0",
+	},
+	{
+		.pin = LS_GPIO_I,
+		.ledname = "secure96:green:1",
+	},
+};
+
+/*
+ * The On Semiconductor CAT21M01 is 131072bits i.e. 16KB. This should be
+ * mostly compatible to 24c128 so we register that with special pdata so
+ * that we can fill in the GPIO descriptor for write protect.
+ */
+static struct at24_platform_data secure96_eeprom_pdata = {
+	.byte_len = SZ_16K / 8,
+	.page_size = 256,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static const struct i2c_board_info secure96_eeprom = {
+	I2C_BOARD_INFO("24c128", 0x50),
+	.platform_data  = &secure96_eeprom_pdata,
+};
+
+/* Crypto chip */
+static const struct i2c_board_info secure96_crypto = {
+	I2C_BOARD_INFO("atecc508a", 0x60),
+};
+
+/* SHA hash chip */
+static const struct i2c_board_info secure96_hash = {
+	I2C_BOARD_INFO("atsha204a", 0x64),
+};
+
+/* Infineon SLB9670 TPM 2.0 chip */
+static struct spi_board_info secure96_tpm = {
+	.modalias = "tpm_tis_spi",
+	/* The manual says 22.5MHz for 1.8V supply */
+	.max_speed_hz = 22500000,
+	.chip_select = 0,
+};
+
+int secure96_probe(struct ls_device *ls)
+{
+	struct device *dev = &ls->dev;
+	struct secure96 *sec;
+	struct gpio_desc *gpiod;
+	struct gpio_led_platform_data secure96_leds_pdata;
+	int ret;
+	int i;
+
+	sec = devm_kzalloc(dev, sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+	sec->dev = dev;
+	sec->ls = ls;
+
+	sec->secure96_leds = devm_kzalloc(dev,
+			ARRAY_SIZE(ledinfos) * sizeof(*sec->secure96_leds),
+			GFP_KERNEL);
+	if (!sec->secure96_leds)
+		return -ENOMEM;
+
+	dev_info(dev, "populate secure96\n");
+
+	/* Populate the four LEDs */
+	for (i = 0; i < ARRAY_SIZE(ledinfos); i++) {
+		const struct secure96_ledinfo *linfo;
+
+		linfo = &ledinfos[i];
+
+		gpiod = ls_get_gpiod(ls, linfo->pin, linfo->ledname,
+				     GPIOD_OUT_LOW);
+		if (IS_ERR(gpiod)) {
+			dev_err(dev, "failed to get GPIO line %d\n",
+				linfo->pin);
+			return -ENODEV;
+		}
+		sec->secure96_leds[i].gpiod = gpiod;
+		sec->secure96_leds[i].name = linfo->ledname;
+		/* Heartbeat on first LED */
+		if (i == 0)
+			sec->secure96_leds[i].default_trigger = "heartbeat";
+	}
+
+	secure96_leds_pdata.num_leds = ARRAY_SIZE(ledinfos);
+	secure96_leds_pdata.leds = sec->secure96_leds;
+
+	sec->leds_device = platform_device_register_data(dev,
+					"leds-gpio",
+					PLATFORM_DEVID_AUTO,
+					&secure96_leds_pdata,
+					sizeof(secure96_leds_pdata));
+	if (IS_ERR(sec->leds_device)) {
+		dev_err(dev, "failed to populate LEDs device\n");
+		return -ENODEV;
+	}
+
+	/* Populate the three I2C0 devices */
+	gpiod = ls_get_gpiod(ls, LS_GPIO_B, "cat21m01-wp",
+			     GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		dev_err(dev, "no CAT21M01 write-protect GPIO\n");
+	else
+		secure96_eeprom_pdata.wp_gpiod = gpiod;
+	sec->eeprom = i2c_new_device(ls->i2c0, &secure96_eeprom);
+	if (!sec->eeprom) {
+		dev_err(dev, "failed to populate EEPROM\n");
+		ret = -ENODEV;
+		goto out_unreg_leds;
+	}
+
+	sec->crypto = i2c_new_device(ls->i2c0, &secure96_crypto);
+	if (!sec->eeprom) {
+		dev_err(dev, "failed to populate crypto device\n");
+		ret = -ENODEV;
+		goto out_remove_eeprom;
+	}
+
+	sec->hash = i2c_new_device(ls->i2c0, &secure96_hash);
+	if (!sec->eeprom) {
+		dev_err(dev, "failed to populate hash device\n");
+		ret = -ENODEV;
+		goto out_remove_crypto;
+	}
+
+	/* Populate the SPI TPM device */
+	gpiod = ls_get_gpiod(ls, LS_GPIO_D,
+			     "tpm-slb9670-rst",
+			     GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		dev_err(dev, "failed to get TPM RESET\n");
+		ret = -ENODEV;
+		goto out_remove_hash;
+	}
+	udelay(80);
+	/* Deassert RST */
+	gpiod_set_value(gpiod, 1);
+	sec->tpm_reset = gpiod;
+
+	gpiod = ls_get_gpiod(ls, LS_GPIO_C,
+			     "tpm-slb9670-irq",
+			     GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		dev_err(dev, "failed to get TPM IRQ GPIO\n");
+		ret = -ENODEV;
+		goto out_remove_tpm_reset;
+	}
+	sec->tpm_irq = gpiod;
+	secure96_tpm.irq = gpiod_to_irq(gpiod);
+	sec->tpm = spi_new_device(ls->spi, &secure96_tpm);
+	if (!sec->tpm) {
+		dev_err(dev, "failed to populate TPM device\n");
+		ret = -ENODEV;
+		goto out_remove_tpm_irq;
+	}
+
+	dev_set_drvdata(&ls->dev, sec);
+
+	return 0;
+
+out_remove_tpm_irq:
+	ls_put_gpiod(ls, sec->tpm_irq);
+out_remove_tpm_reset:
+	ls_put_gpiod(ls, sec->tpm_reset);
+out_remove_hash:
+	i2c_unregister_device(sec->hash);
+out_remove_crypto:
+	i2c_unregister_device(sec->crypto);
+out_remove_eeprom:
+	i2c_unregister_device(sec->eeprom);
+	if (secure96_eeprom_pdata.wp_gpiod)
+		ls_put_gpiod(ls, secure96_eeprom_pdata.wp_gpiod);
+out_unreg_leds:
+	platform_device_unregister(sec->leds_device);
+	for (i = 0; i < ARRAY_SIZE(ledinfos); i++)
+		ls_put_gpiod(ls, sec->secure96_leds[i].gpiod);
+	return ret;
+}
+
+static void secure96_remove(struct ls_device *ls)
+{
+	struct secure96 *sec = dev_get_drvdata(&ls->dev);
+	int i;
+
+	spi_unregister_device(sec->tpm);
+	ls_put_gpiod(sec->ls, sec->tpm_irq);
+	ls_put_gpiod(sec->ls, sec->tpm_reset);
+	i2c_unregister_device(sec->hash);
+	i2c_unregister_device(sec->crypto);
+	i2c_unregister_device(sec->eeprom);
+	if (secure96_eeprom_pdata.wp_gpiod)
+		ls_put_gpiod(sec->ls, secure96_eeprom_pdata.wp_gpiod);
+	platform_device_unregister(sec->leds_device);
+	for (i = 0; i < ARRAY_SIZE(ledinfos); i++)
+		ls_put_gpiod(sec->ls, sec->secure96_leds[i].gpiod);
+	dev_set_drvdata(&ls->dev, NULL);
+}
+
+static const struct of_device_id secure96_of_match[] = {
+	{
+		.compatible = "96boards,secure96",
+	},
+	{},
+};
+
+struct ls_driver secure96_driver = {
+	.drv = {
+		.owner = THIS_MODULE,
+		.name = "secure96",
+		.of_match_table = of_match_ptr(secure96_of_match),
+	},
+	.probe = secure96_probe,
+	.remove = secure96_remove,
+};
+module_driver(secure96_driver, ls_driver_register, ls_driver_unregister);
diff --git a/drivers/bus/daughterboards/Kconfig b/drivers/bus/daughterboards/Kconfig
new file mode 100644
index 000000000000..9855346c8b4d
--- /dev/null
+++ b/drivers/bus/daughterboards/Kconfig
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Non-discoverable daughterboards
+
+menuconfig DAUGHTERBOARDS
+	bool "Non-discoverable daughterboards"
+	help
+	  These bus drivers deal with non-discoverable daughterboards,
+	  which means daughterboards (plug-in complex logic circuit
+	  boards) that can not reliably be discovered by software.
+	  The physical connector is defined for the host hardware,
+	  but we need to indicate what is on it at runtime using
+	  sysfs.
+
+if DAUGHTERBOARDS
+
+menuconfig 96BOARDS_MEZZANINES
+	bool "96boards mezzanine boards"
+
+if 96BOARDS_MEZZANINES
+
+config 96BOARDS_LS_CONNECTOR
+	bool "96boards low speed connector driver"
+	depends on OF
+	depends on I2C
+	depends on SPI_MASTER
+	depends on GPIOLIB
+	help
+	 Driver for the 96boards low speed connector
+
+config 96BOARDS_SECURE96
+	bool "96boards Secure96 board driver"
+	depends on 96BOARDS_LS_CONNECTOR
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_GPIO
+	select EEPROM_AT24
+	select CRYPTO_HW
+	select CRYPTO_DEV_ATMEL_ECC
+	select HW_RANDOM
+	select TCG_TPM
+	select HW_RANDOM_TPM
+	select TCG_TIS
+	select TCG_TIS_SPI
+	help
+	 Driver for the 96boards Secure96 mezzanine
+
+endif # 96BOARDS_MEZZANINES
+
+endif # DAUGHTERBOARDS
diff --git a/drivers/bus/daughterboards/Makefile b/drivers/bus/daughterboards/Makefile
new file mode 100644
index 000000000000..c9691b470fc5
--- /dev/null
+++ b/drivers/bus/daughterboards/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for non-discoverable daughterboards
+#
+obj-$(CONFIG_96BOARDS_LS_CONNECTOR)	+= 96boards-ls-bus.o 96boards-ls-connector.o
+obj-$(CONFIG_96BOARDS_SECURE96)		+= 96boards-secure96.o
-- 
2.17.0
