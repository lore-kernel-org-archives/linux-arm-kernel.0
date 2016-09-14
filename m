From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 13 Sep 2016 18:42:46 -0700
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
Message-ID: <20160914014246.31847-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the db410c 96boards platform we have a TC7USB40MU[1] on the
board to mux the D+/D- lines from the SoC between a micro usb
"device" port and a USB hub for "host" roles. Upon a role switch,
we need to change this mux to forward the D+/D- lines to either
the port or the hub. Therefore, introduce a driver for this
device that intercepts extcon USB_HOST events and logically
asserts a gpio to mux the "host" D+/D- lines when a host cable is
attached. When the cable goes away, it will logically deassert
the gpio and mux the "device" lines.

[1] https://toshiba.semicon-storage.com/ap-en/product/logic/bus-switch/detail.TC7USB40MU.html

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

Should I make the extcon part optional? I could see a case where there are two
"OTG" ports connected to the mux (or two hubs), and for some reason the
software may want to mux between them at runtime. If we mandate an extcon,
that won't be possible to support. Perhaps it would be better to have
the node, but connect it to the usb controller with a phandle (maybe of_graph
endpoints would be useful too) so that when the controller wants to mux over
a port it can do so.

Muxing the ports this way based on ID cable is pretty much a software
design decision. We could mux the ports during the role switch, and the
role switch can be entirely userspace driven with the chipidea controller
that I'm using (see the role switching support in the "role" file for
debugfs support in that driver). So extcon cables don't come into the picture
in that scenario.

 .../devicetree/bindings/usb/toshiba,tc7usb40mu.txt |  34 +++++++
 drivers/usb/misc/Kconfig                           |   9 ++
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/tc7usb40mu.c                      | 107 +++++++++++++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
 create mode 100644 drivers/usb/misc/tc7usb40mu.c

diff --git a/Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt b/Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
new file mode 100644
index 000000000000..18e6607408fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
@@ -0,0 +1,34 @@
+Toshiba TC7USB40MU
+
+This device muxes USB D+/D- lines between two outputs called 1D+/1D- and 2D+/2D-.
+When the switch pin is asserted, we mux out 2D+/2D-, and when it's deasserted we
+select 1D+/1D-.
+
+This can be used to mux USB D+/D- lines between a USB hub and an OTG port.
+
+PROPERTIES
+
+- compatible:
+    Usage: required
+    Value type: <string>
+    Definition: Should contain "toshiba,tc7usb40mu"
+
+- switch-gpios:
+    Usage: required
+    Value type: <prop-encoded-array>
+    Definition: Should contain the gpio used to toggle the switch. Logically
+                asserting the gpio will cause the device to mux the "host"
+                D+/D- lines instead of the "device" lines.
+
+- extcon:
+    Usage: required
+    Value type: <prop-encoded-array>
+    Definition: Should contain the extcon device for USB_HOST cable events
+
+Example:
+
+	usb-switch {
+		compatible = "toshiba,tc7usb40mu";
+		switch-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+		extcon = <&usb_id>;
+	};
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 47b357760afc..3da568c751d2 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -46,6 +46,15 @@ config USB_SEVSEG
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbsevseg.
 
+config USB_TC7USB40MU
+	tristate "TC7USB40MU USB mux support"
+	depends on (GPIOLIB && EXTCON) || COMPILE_TEST
+	help
+	  Say Y here if you have a TC7USB40MU by Toshiba. If a USB ID cable is
+	  present, a gpio will be asserted to mux out "host" D+/D- lines and when
+	  the ID cable is removed, a gpio will be deasserted to mux out "device"
+	  D+/D- lines.
+
 config USB_RIO500
 	tristate "USB Diamond Rio500 support"
 	help
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 3d1992750da4..d8f9ad1dee13 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_USB_LEGOTOWER)		+= legousbtower.o
 obj-$(CONFIG_USB_RIO500)		+= rio500.o
 obj-$(CONFIG_USB_TEST)			+= usbtest.o
 obj-$(CONFIG_USB_EHSET_TEST_FIXTURE)    += ehset.o
+obj-$(CONFIG_USB_TC7USB40MU)		+= tc7usb40mu.o
 obj-$(CONFIG_USB_TRANCEVIBRATOR)	+= trancevibrator.o
 obj-$(CONFIG_USB_USS720)		+= uss720.o
 obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
diff --git a/drivers/usb/misc/tc7usb40mu.c b/drivers/usb/misc/tc7usb40mu.c
new file mode 100644
index 000000000000..9edcfe577ae4
--- /dev/null
+++ b/drivers/usb/misc/tc7usb40mu.c
@@ -0,0 +1,107 @@
+/**
+ * Copyright (C) 2016 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/extcon.h>
+#include <linux/gpio/consumer.h>
+#include <linux/notifier.h>
+
+struct tc7usb40mu_drv {
+	struct gpio_desc *gpio;
+	struct extcon_dev *edev;
+	struct notifier_block notify;
+};
+
+static int tc7usb40mu_notify(struct notifier_block *nb, unsigned long event,
+			     void *ptr)
+{
+	struct tc7usb40mu_drv *drv;
+
+	drv = container_of(nb, struct tc7usb40mu_drv, notify);
+	if (event)
+		gpiod_set_value_cansleep(drv->gpio, 1); /* USB HUB */
+	else
+		gpiod_set_value_cansleep(drv->gpio, 0); /* device connector */
+
+	return NOTIFY_OK;
+}
+
+static int tc7usb40mu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tc7usb40mu_drv *drv;
+	int state, ret;
+	enum gpiod_flags flags;
+
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->edev = extcon_get_edev_by_phandle(dev, 0);
+	if (IS_ERR(drv->edev))
+		return PTR_ERR(drv->edev);
+
+	/*
+	 * TODO: This can race with extcon changing state before we request the
+	 * gpio or the extcon changing state before we register the notifier
+	 */
+	state = extcon_get_cable_state_(drv->edev, EXTCON_USB_HOST);
+	if (state)
+		flags = GPIOD_OUT_HIGH;
+	else
+		flags = GPIOD_OUT_LOW;
+
+	drv->gpio = devm_gpiod_get(dev, "switch", flags);
+	if (IS_ERR(drv->gpio))
+		return PTR_ERR(drv->gpio);
+
+	drv->notify.notifier_call = tc7usb40mu_notify;
+	ret = extcon_register_notifier(drv->edev, EXTCON_USB_HOST, &drv->notify);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, drv);
+
+	return 0;
+}
+
+static int tc7usb40mu_remove(struct platform_device *pdev)
+{
+	struct tc7usb40mu_drv *drv;
+
+	drv = platform_get_drvdata(pdev);
+	extcon_unregister_notifier(drv->edev, EXTCON_USB_HOST, &drv->notify);
+
+	return 0;
+}
+
+static const struct of_device_id tc7usb40mu_dt_match[] = {
+	{ .compatible = "toshiba,tc7usb40mu", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tc7usb40mu_dt_match);
+
+static struct platform_driver tc7usb40mu_driver = {
+	.probe		= tc7usb40mu_probe,
+	.remove		= tc7usb40mu_remove,
+	.driver		= {
+		.name	= "tc7usb40mu",
+		.of_match_table = tc7usb40mu_dt_match,
+	},
+};
+module_platform_driver(tc7usb40mu_driver);
+
+MODULE_AUTHOR("Stephen Boyd <stephen.boyd@linaro.org>");
+MODULE_DESCRIPTION("TC7USB40MU USB multiplexer driver");
+MODULE_LICENSE("GPL");
-- 
2.9.0.rc2.8.ga28705d
