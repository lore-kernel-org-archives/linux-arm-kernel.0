From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sat, 25 Jun 2016 22:24:54 -0700
Subject: [PATCH] usb: misc: Add driver for usb4604
Message-ID: <20160626052454.7743-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a minimal driver to support bringing a usb4604 device
from microchip out of reset and into hub mode. The usb4604 device
is related to the usb3503 device, but it didn't seem close enough
to warrant putting both into the same file. This patch borrows
some of the usb3503 structure and trims it down to just handle
the optional reset gpio and adds the i2c command to put the
device into hub mode.

Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/00001716A.pdf
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 Documentation/devicetree/bindings/usb/usb4604.txt |  19 +++
 drivers/usb/misc/Kconfig                          |   6 +
 drivers/usb/misc/Makefile                         |   1 +
 drivers/usb/misc/usb4604.c                        | 175 ++++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/usb4604.txt
 create mode 100644 drivers/usb/misc/usb4604.c

diff --git a/Documentation/devicetree/bindings/usb/usb4604.txt b/Documentation/devicetree/bindings/usb/usb4604.txt
new file mode 100644
index 000000000000..82506d17712c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb4604.txt
@@ -0,0 +1,19 @@
+SMSC USB4604 High-Speed Hub Controller
+
+Required properties:
+- compatible: Should be "smsc,usb4604"
+
+Optional properties:
+- reg: Specifies the i2c slave address, it is required and should be 0x2d
+       if I2C is used.
+- reset-gpios: Should specify GPIO for reset.
+- initial-mode: Should specify initial mode.
+                (1 for HUB mode, 2 for STANDBY mode)
+
+Examples:
+	usb-hub at 2d {
+		compatible = "smsc,usb4604";
+		reg = <0x2d>;
+		reset-gpios = <&gpx3 5 1>;
+		initial-mode = <1>;
+	};
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index e9e5ae521fa6..ac9ca570b26d 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -249,6 +249,12 @@ config USB_HSIC_USB3503
        help
          This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
 
+config USB_HSIC_USB4604
+       tristate "USB4604 HSIC to USB20 Driver"
+       depends on I2C
+       help
+         This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
+
 config USB_LINK_LAYER_TEST
 	tristate "USB Link Layer Test driver"
 	help
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 2769cf6351b4..95e897dff681 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_USB_USS720)		+= uss720.o
 obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
 obj-$(CONFIG_USB_YUREX)			+= yurex.o
 obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
+obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
 obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 obj-$(CONFIG_UCSI)			+= ucsi.o
 
diff --git a/drivers/usb/misc/usb4604.c b/drivers/usb/misc/usb4604.c
new file mode 100644
index 000000000000..e9f37fb746ac
--- /dev/null
+++ b/drivers/usb/misc/usb4604.c
@@ -0,0 +1,175 @@
+/*
+ * Driver for SMSC USB4604 USB HSIC 4-port 2.0 hub controller driver
+ * Based on usb3503 driver
+ *
+ * Copyright (c) 2012-2013 Dongjin Kim (tobetter at gmail.com)
+ * Copyright (c) 2016 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+
+enum usb4604_mode {
+	USB4604_MODE_UNKNOWN,
+	USB4604_MODE_HUB,
+	USB4604_MODE_STANDBY,
+};
+
+struct usb4604 {
+	enum usb4604_mode	mode;
+	struct device		*dev;
+	struct gpio_desc	*gpio_reset;
+};
+
+static void usb4604_reset(struct usb4604 *hub, int state)
+{
+	gpiod_set_value_cansleep(hub->gpio_reset, state);
+
+	/* Wait for i2c logic to come up */
+	if (state)
+		msleep(250);
+}
+
+static int usb4604_connect(struct usb4604 *hub)
+{
+	struct device *dev = hub->dev;
+	struct i2c_client *client = to_i2c_client(dev);
+	int err;
+	u8 connect_cmd[] = { 0xaa, 0x55, 0x00 };
+
+	usb4604_reset(hub, 1);
+
+	err = i2c_master_send(client, connect_cmd, ARRAY_SIZE(connect_cmd));
+	if (err < 0) {
+		usb4604_reset(hub, 0);
+		return err;
+	}
+
+	hub->mode = USB4604_MODE_HUB;
+	dev_dbg(dev, "switched to HUB mode\n");
+
+	return 0;
+}
+
+static int usb4604_switch_mode(struct usb4604 *hub, enum usb4604_mode mode)
+{
+	struct device *dev = hub->dev;
+	int err = 0;
+
+	switch (mode) {
+	case USB4604_MODE_HUB:
+		err = usb4604_connect(hub);
+		break;
+
+	case USB4604_MODE_STANDBY:
+		usb4604_reset(hub, 0);
+		dev_dbg(dev, "switched to STANDBY mode\n");
+		break;
+
+	default:
+		dev_err(dev, "unknown mode is requested\n");
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+static int usb4604_probe(struct usb4604 *hub)
+{
+	struct device *dev = hub->dev;
+	struct device_node *np = dev->of_node;
+	struct gpio_desc *gpio;
+	u32 mode = USB4604_MODE_HUB;
+
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+	hub->gpio_reset = gpio;
+
+	if (of_property_read_u32(np, "initial-mode", &hub->mode))
+		hub->mode = mode;
+
+	return usb4604_switch_mode(hub, hub->mode);
+}
+
+static int usb4604_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct usb4604 *hub;
+
+	hub = devm_kzalloc(&i2c->dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, hub);
+	hub->dev = &i2c->dev;
+
+	return usb4604_probe(hub);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int usb4604_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct usb4604 *hub = i2c_get_clientdata(client);
+
+	usb4604_switch_mode(hub, USB4604_MODE_STANDBY);
+
+	return 0;
+}
+
+static int usb4604_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct usb4604 *hub = i2c_get_clientdata(client);
+
+	usb4604_switch_mode(hub, hub->mode);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(usb4604_i2c_pm_ops, usb4604_i2c_suspend,
+		usb4604_i2c_resume);
+
+static const struct i2c_device_id usb4604_id[] = {
+	{ "usb4604", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, usb4604_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id usb4604_of_match[] = {
+	{ .compatible = "smsc,usb4604" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, usb4604_of_match);
+#endif
+
+static struct i2c_driver usb4604_i2c_driver = {
+	.driver = {
+		.name = "usb4604",
+		.pm = &usb4604_i2c_pm_ops,
+		.of_match_table = of_match_ptr(usb4604_of_match),
+	},
+	.probe		= usb4604_i2c_probe,
+	.id_table	= usb4604_id,
+};
+module_i2c_driver(usb4604_i2c_driver);
+
+MODULE_DESCRIPTION("USB4604 USB HUB driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0.rc2.8.ga28705d
