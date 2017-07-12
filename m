From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 11 Jul 2017 18:02:53 -0700
Subject: [PATCH 1/3] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <20170712010255.26855-1-stephen.boyd@linaro.org>
References: <20170712010255.26855-1-stephen.boyd@linaro.org>
Message-ID: <20170712010255.26855-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the db410c 96boards platform we have a TC7USB40MU[1] on the
board to mux the D+/D- lines from the SoC between a micro usb
"device" port and a USB hub for "host" roles. Upon a role switch,
we need to change this mux to forward the D+/D- lines to either
the port or the hub. Introduce a driver for this device that
hooks into the generic mux framework logically asserts a gpio to
mux the D+/D- lines to the 2D+/2D- output when the state is set
to "1". Similary, deassert the gpio and mux the D+/D- lines to
the 1D+/1D- output when the state is set to "0".

[1] https://toshiba.semicon-storage.com/ap-en/product/logic/bus-switch/detail.TC7USB40MU.html

Cc: Peter Rosin <peda@axentia.se>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

We may be able to ignore this patch and just use mux-gpio.c file. I'll
investigate that approach but I'd like to keep the compatible string
in case we need to do something later.

 .../devicetree/bindings/usb/toshiba,tc7usb40mu.txt | 31 +++++++++
 drivers/usb/misc/Kconfig                           | 11 ++++
 drivers/usb/misc/Makefile                          |  1 +
 drivers/usb/misc/tc7usb40mu.c                      | 74 ++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
 create mode 100644 drivers/usb/misc/tc7usb40mu.c

diff --git a/Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt b/Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
new file mode 100644
index 000000000000..5c6b2b39825f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
@@ -0,0 +1,31 @@
+Toshiba TC7USB40MU
+
+This device muxes USB D+/D- lines between two outputs called 1D+/1D- and
+2D+/2D-. When the switch pin is asserted, the device muxes out 2D+/2D-, and
+when it's deasserted it muxes out 1D+/1D-.
+
+This can be used to mux USB D+/D- lines between a USB hub and a micro-USB port
+to provide host mode and device modes with the same USB controller.
+
+PROPERTIES
+
+- compatible:
+    Usage: required
+    Value type: <string>
+    Definition: Should contain "toshiba,tc7usb40mu"
+
+- mux-gpios:
+    Usage: required
+    Value type: <prop-encoded-array>
+    Definition: Should contain the gpio used to toggle the switch. Logically
+                asserting the gpio will cause the device to mux the 2D+/2D-
+                lines and deasserting the gpio will cause the device to mux
+		the 1D+/1D- lines.
+
+Example:
+
+	usb-switch {
+		compatible = "toshiba,tc7usb40mu";
+		mux-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+		#mux-control-cells = <0>;
+	};
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 0f9f25db9163..df44c9d16eb1 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -46,6 +46,17 @@ config USB_SEVSEG
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbsevseg.
 
+config USB_TC7USB40MU
+	tristate "TC7USB40MU USB mux support"
+	depends on (GPIOLIB && MULTIPLEXER) || COMPILE_TEST
+	help
+	  Say Y here if you have a TC7USB40MU by Toshiba. A USB controller
+	  driver can then use the mux controller provided by this driver to
+	  route the D+/D- lines to two different devices downstream. For
+	  example, one downstream device could be a micro-USB port, and the
+	  other could be a USB hub, allowing a device to provide either
+	  device or host mode via a single USB controller.
+
 config USB_RIO500
 	tristate "USB Diamond Rio500 support"
 	help
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 7fdb45fc976f..42268fcb8a60 100644
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
index 000000000000..fbccd2fc0030
--- /dev/null
+++ b/drivers/usb/misc/tc7usb40mu.c
@@ -0,0 +1,74 @@
+/**
+ * Copyright (C) 2016-2017 Linaro Ltd.
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
+#include <linux/gpio/consumer.h>
+#include <linux/mux/driver.h>
+
+struct tc7usb40mu_drv {
+	struct gpio_desc *gpio;
+};
+
+static int tc7usb40mu_mux_set(struct mux_control *mux, int state)
+{
+	struct tc7usb40mu_drv *drv = mux_chip_priv(mux->chip);
+
+	gpiod_set_value_cansleep(drv->gpio, state);
+
+	return 0;
+}
+
+static const struct mux_control_ops tc7usb40mu_mux_ops = {
+	.set = tc7usb40mu_mux_set,
+};
+
+static int tc7usb40mu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tc7usb40mu_drv *drv;
+	struct mux_chip *mux_chip;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*drv));
+	if (!mux_chip)
+		return -ENOMEM;
+
+	mux_chip->ops = &tc7usb40mu_mux_ops;
+	mux_chip->mux->states = 2; /* 1D+/1D- and 2D+/2D- */
+
+	drv = mux_chip_priv(mux_chip);
+	drv->gpio = devm_gpiod_get(dev, "mux", GPIOD_ASIS);
+	if (IS_ERR(drv->gpio))
+		return PTR_ERR(drv->gpio);
+
+	return devm_mux_chip_register(dev, mux_chip);
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
2.10.0.297.gf6727b0
