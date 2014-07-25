From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 15:23:43 +0200
Subject: [PATCH 1/6] leds: add a driver for syscon-based LEDs
In-Reply-To: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1406294628-16079-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to create a set of LEDs from a syscon
MFD instance, which is lean mean and clean on the ARM
reference designs and can replace the Versatile LEDs driver
in the long run, as well as other custom syscon LEDs drivers.

Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/Kconfig       |  10 +++
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-syscon.c | 152 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/leds/leds-syscon.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a1b044e7eaad..f5f2110d8e7c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -479,6 +479,16 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_SYSCON
+	bool "LED support for LEDs on system controllers"
+	depends on LEDS_CLASS
+	depends on MFD_SYSCON
+	depends on OF
+	help
+	  This option enabled support for the LEDs on syscon type
+	  devices. This will only work with device tree enabled
+	  devices.
+
 config LEDS_VERSATILE
 	tristate "LED support for the ARM Versatile and RealView"
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 79c5155199a7..2c81971633f7 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
+obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
 obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 
 # LED SPI Drivers
diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
new file mode 100644
index 000000000000..00f60f447f10
--- /dev/null
+++ b/drivers/leds/leds-syscon.c
@@ -0,0 +1,152 @@
+/*
+ * Generic Syscon LEDs Driver
+ *
+ * Copyright (c) 2014, Linaro Limited
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ * This driver provides system reboot functionality for APM X-Gene SoC.
+ * For system shutdown, this is board specify. If a board designer
+ * implements GPIO shutdown, use the gpio-poweroff.c driver.
+ */
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/stat.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/leds.h>
+
+/**
+ * struct syscon_led - state container for syscon based LEDs
+ * @cdev: LED class device for this LED
+ * @map: regmap to access the syscon device backing this LED
+ * @offset: the offset into the syscon regmap for the LED register
+ * @mask: the bit in the register corresponding to the LED
+ * @state: current state of the LED
+ */
+struct syscon_led {
+	struct led_classdev cdev;
+	struct regmap *map;
+	u32 offset;
+	u32 mask;
+	bool state;
+};
+
+static void syscon_led_set(struct led_classdev *led_cdev,
+	enum led_brightness value)
+{
+	struct syscon_led *sled =
+		container_of(led_cdev, struct syscon_led, cdev);
+	u32 val;
+	int ret;
+
+	if (value == LED_OFF) {
+		val = 0;
+		sled->state = false;
+	} else {
+		val = sled->mask;
+		sled->state = true;
+	}
+
+	ret = regmap_update_bits(sled->map, sled->offset, sled->mask, val);
+	if (ret < 0)
+		dev_err(sled->cdev.dev, "error updating LED status\n");
+}
+
+static int syscon_leds_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node, *child;
+	struct regmap *map;
+	int ret;
+
+	map = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	for_each_available_child_of_node(np, child) {
+		struct syscon_led *sled;
+		const char *state;
+
+		sled = devm_kzalloc(dev, sizeof(*sled), GFP_KERNEL);
+		if (!sled)
+			return -ENOMEM;
+
+		sled->map = map;
+
+		if (of_property_read_u32(child, "offset", &sled->offset))
+			return -EINVAL;
+		if (of_property_read_u32(child, "mask", &sled->mask))
+			return -EINVAL;
+		sled->cdev.name =
+			of_get_property(child, "label", NULL) ? : child->name;
+		sled->cdev.default_trigger =
+			of_get_property(child, "linux,default-trigger", NULL);
+
+		state = of_get_property(child, "default-state", NULL);
+		if (state) {
+			if (!strcmp(state, "keep")) {
+				u32 val;
+
+				ret = regmap_read(map, sled->offset, &val);
+				if (ret < 0)
+					return ret;
+				sled->state = !!(val & sled->mask);
+			} else if (!strcmp(state, "on")) {
+				sled->state = true;
+				ret = regmap_update_bits(map, sled->offset,
+							 sled->mask,
+							 sled->mask);
+				if (ret < 0)
+					return ret;
+			} else {
+				sled->state = false;
+				ret = regmap_update_bits(map, sled->offset,
+							 sled->mask, 0);
+				if (ret < 0)
+					return ret;
+			}
+
+		}
+		sled->cdev.brightness_set = syscon_led_set;
+
+		ret = led_classdev_register(dev, &sled->cdev);
+		if (ret < 0)
+			return ret;
+
+		dev_info(dev, "registered LED %s\n", sled->cdev.name);
+	}
+
+       return 0;
+}
+
+static struct of_device_id syscon_leds_of_match[] = {
+	{ .compatible = "syscon-leds" },
+	{}
+};
+
+static struct platform_driver syscon_leds_driver = {
+	.probe = syscon_leds_probe,
+	.driver = {
+		.name = "syscon-leds",
+		.of_match_table = syscon_leds_of_match,
+	},
+};
+module_platform_driver(syscon_leds_driver);
-- 
1.9.3
