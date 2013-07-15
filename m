From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:57 +0200
Subject: =?UTF-8?q?=5BPATCH=2012/22=5D=20video=3A=20backlight=3A=20Add=20GPIO=20Backlight=20driver=2E?=
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-13-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This initial driver uses and depends on DT bindings.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../bindings/video/backlight/gpio-backlight.txt    |   18 ++
 drivers/video/backlight/Kconfig                    |    7 +
 drivers/video/backlight/Makefile                   |    1 +
 drivers/video/backlight/gpio_bl.c                  |  226 ++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
 create mode 100644 drivers/video/backlight/gpio_bl.c

diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
new file mode 100644
index 0000000..362dd40
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
@@ -0,0 +1,18 @@
+gpio-backlight bindings
+
+Required properties:
+  - compatible: "gpio-backlight"
+  - gpios: describes the gpio that is used for enabling/disabling the backlight
+     (see GPIO binding[0] for more details).
+  - default-brightness-level: the default brightness level (can be 0(off) or
+      1(on) since GPIOs only support theses levels).
+
+[0]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+	backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpio3 4 0>;
+		default-brightness-level = <1>;
+	};
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d5ab658..70e7706 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -207,6 +207,13 @@ config BACKLIGHT_GENERIC
 	  known as the Corgi backlight driver. If you have a Sharp Zaurus
 	  SL-C7xx, SL-Cxx00 or SL-6000x say y.
 
+config BACKLIGHT_GPIO
+	tristate "GPIO Backlight Driver"
+	depends on OF && GPIOLIB
+	help
+	  If you have a GPIO backlight and that you use the device tree
+	  for booting, say y to enable the GPIO backlight driver.
+
 config BACKLIGHT_LM3533
 	tristate "Backlight Driver for LM3533"
 	depends on BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 92711fe..8cde337 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
 obj-$(CONFIG_BACKLIGHT_DA9052)		+= da9052_bl.o
 obj-$(CONFIG_BACKLIGHT_EP93XX)		+= ep93xx_bl.o
 obj-$(CONFIG_BACKLIGHT_GENERIC)		+= generic_bl.o
+obj-$(CONFIG_BACKLIGHT_GPIO)		+= gpio_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
diff --git a/drivers/video/backlight/gpio_bl.c b/drivers/video/backlight/gpio_bl.c
new file mode 100644
index 0000000..76b9c99
--- /dev/null
+++ b/drivers/video/backlight/gpio_bl.c
@@ -0,0 +1,226 @@
+/*
+ * drivers/video/backlight/gpio_bl.c
+ *
+ * simple GPIO based backlight control.
+ *
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Based on drivers/video/backlight/pwm_bl.c
+ */
+
+#include <linux/backlight.h>
+#include <linux/fb.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+
+struct gpio_bl_data {
+	unsigned gpio;
+	u32 dft_brightness;
+	u32 active_low; /* 1 if active_low, 0 otherwise */
+};
+
+static int gpio_backlight_update_status(struct backlight_device *bl)
+{
+	struct gpio_bl_data *gb = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & BL_CORE_FBBLANK)
+		brightness = 0;
+
+	return gpio_direction_output(gb->gpio,
+				     brightness ?
+				     !gb->active_low : gb->active_low);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int gpio_backlight_suspend(struct device *dev)
+{
+	struct backlight_device *bl = dev_get_drvdata(dev);
+	struct gpio_bl_data *gb = bl_get_data(bl);
+
+	/* Power down the backlight */
+	return gpio_direction_output(gb->gpio, gb->active_low);
+}
+
+static int gpio_backlight_resume(struct device *dev)
+{
+	struct backlight_device *bl = dev_get_drvdata(dev);
+
+	backlight_update_status(bl);
+
+	return 0;
+}
+#endif
+
+static int gpio_backlight_get_brightness(struct backlight_device *bl)
+{
+	return bl->props.brightness;
+}
+
+static const struct backlight_ops gpio_backlight_ops = {
+	.update_status = gpio_backlight_update_status,
+	.get_brightness = gpio_backlight_get_brightness,
+};
+
+static int gpio_backlight_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bl = platform_get_drvdata(pdev);
+	struct gpio_bl_data *gb = bl_get_data(bl);
+	int ret;
+
+	backlight_device_unregister(bl);
+
+	/* Power down the backlight */
+	ret = gpio_direction_output(gb->gpio, gb->active_low);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Failled to set GPIO %u to output direction\n",
+				    gb->gpio);
+
+	return 0;
+}
+
+static int gpio_backlight_probe(struct platform_device *pdev)
+{
+	struct backlight_properties props;
+	struct backlight_device *bl;
+	struct gpio_bl_data *gb;
+	struct device_node *np = pdev->dev.of_node;
+	enum of_gpio_flags gpio_flags;
+	int ret = 0;
+
+	dev_info(&pdev->dev, "Initializing.\n");
+
+	gb = devm_kzalloc(&pdev->dev, sizeof(*gb), GFP_KERNEL);
+	if (!gb) {
+		dev_err(&pdev->dev, "No memory for gpio_bl_data.\n");
+		return -ENOMEM;
+	}
+
+	ret = of_property_read_u32(np, "default-brightness-level",
+				   &gb->dft_brightness);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error: default-brightness-level is a required parameter.\n");
+		goto err_free_pdata;
+	}
+
+	if (gb->dft_brightness < 0 || gb->dft_brightness > 1) {
+		dev_err(&pdev->dev, "Error: Invalid default-brightness-level value."
+		" Its value can be either 0(off) or 1(on).\n");
+		goto err_free_pdata;
+	}
+
+	ret = of_property_read_u32(np, "active-level", &gb->active_low);
+	/* By default, the GPIO activating the backlight is active high. */
+	if (ret < 0)
+		gb->active_low = 0;
+	else
+		if (gb->active_low < 0 || gb->active_low > 1) {
+			dev_err(&pdev->dev, "Error: Invalid active-level value."
+			" Its value can be either 0(active low)"
+			"or 1(active high).\n");
+		}
+
+	gb->gpio = of_get_gpio_flags(np, 0, &gpio_flags);
+	gb->active_low = gpio_flags & OF_GPIO_ACTIVE_LOW;
+	if (gb->gpio == -EPROBE_DEFER) {
+		ret = ERR_PTR(-EPROBE_DEFER);
+		goto err_free_pdata;
+	} else if (gb->gpio < 0) {
+		ret = gb->gpio;
+		dev_err(&pdev->dev, "Error: gpios is a required parameter.\n");
+		goto err_free_pdata;
+	}
+
+	/* Request the backlight gpio */
+	ret = gpio_request(gb->gpio, "LCDBL");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failled to request LCD Backlight"
+		" GPIO %u.\n", gb->gpio);
+		goto err_free_pdata;
+	}
+	/* If the default brightness is 1, enable the backlight,
+	 * else power it down */
+	ret = gpio_direction_output(gb->gpio,
+				    gb->dft_brightness ?
+				    !gb->active_low : gb->active_low);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "The LCD GPIO %u failed to "
+				    "%s the backlight.\n",
+				    gb->gpio,
+				    gb->dft_brightness ? "enable" : "disable");
+		goto err_free_pdata;
+	}
+
+	dev_info(&pdev->dev, "The backlight was %s by the GPIO %u "
+			     "which is %s.\n",
+			     gb->dft_brightness ? "Enabled" : "Disabled",
+			     gb->gpio,
+			     gb->active_low ? "active low" : "active high");
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = 1; /* A GPIO can only be at level 0 or 1 */
+
+	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, gb,
+				       &gpio_backlight_ops, &props);
+	if (IS_ERR(bl)) {
+		dev_err(&pdev->dev, "Failed to register backlight\n");
+		ret = PTR_ERR(bl);
+		goto err_free_pdata;
+	}
+
+	bl->props.brightness = 1;
+	backlight_update_status(bl);
+	platform_set_drvdata(pdev, bl);
+
+	dev_info(&pdev->dev, "Initialized.\n");
+
+	return 0;
+
+err_free_pdata:
+	devm_kfree(&pdev->dev, bl);
+	return ret;
+}
+
+MODULE_DEVICE_TABLE(of, gpio_backlight_of_match);
+static SIMPLE_DEV_PM_OPS(gpio_backlight_pm_ops, gpio_backlight_suspend,
+			gpio_backlight_resume);
+
+static struct of_device_id gpio_backlight_of_match[] = {
+	{ .compatible = "gpio-backlight" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver gpio_backlight_driver = {
+	.driver         = {
+		.name           = "gpio-backlight",
+		.owner          = THIS_MODULE,
+		.pm             = &gpio_backlight_pm_ops,
+		.of_match_table = of_match_ptr(gpio_backlight_of_match),
+	},
+	.probe          = gpio_backlight_probe,
+	.remove         = gpio_backlight_remove,
+};
+
+module_platform_driver(gpio_backlight_driver);
+
+MODULE_DESCRIPTION("GPIO based Backlight Driver");
+MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:gpio-backlight");
-- 
1.7.9.5
