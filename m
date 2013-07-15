From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:58 +0200
Subject: =?UTF-8?q?=5BPATCH=2013/22=5D=20lcd=3A=20Add=20GPIO=20LCD=20driver=2E?=
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-14-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../bindings/video/backlight/gpio-lcd.txt          |   15 ++
 drivers/video/backlight/Kconfig                    |    8 +
 drivers/video/backlight/Makefile                   |    1 +
 drivers/video/backlight/gpio_lcd.c                 |  178 ++++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
 create mode 100644 drivers/video/backlight/gpio_lcd.c

diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt b/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
new file mode 100644
index 0000000..4ff409d
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
@@ -0,0 +1,15 @@
+gpio-lcd bindings
+
+Required properties:
+  - compatible: "gpio-lcd"
+  - gpios: describes the gpio that is used for enabling/disabling the lcd
+     (see GPIO binding[0] for more details).
+
+[0]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+	lcd {
+		compatible = "gpio-lcd";
+		gpios = <&gpio3 13 0>;
+	};
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 70e7706..eaf0525 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -34,6 +34,14 @@ config LCD_CORGI
 	  Say y here to support the LCD panels usually found on SHARP
 	  corgi (C7x0) and spitz (Cxx00) models.
 
+config LCD_GPIO
+	tristate "LCD GPIO Driver"
+	depends on OF && GPIOLIB
+	help
+	  If your LCD enbling/disabling is controlled by a GPIO
+	  and that you use the device tree for booting,
+	  say y to enable the LCD GPIO driver.
+
 config LCD_L4F00242T03
 	tristate "Epson L4F00242T03 LCD"
 	depends on SPI_MASTER && GPIOLIB
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 8cde337..5c25955 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_LCD_AMS369FG06)		+= ams369fg06.o
 obj-$(CONFIG_LCD_CLASS_DEVICE)		+= lcd.o
 obj-$(CONFIG_LCD_CORGI)			+= corgi_lcd.o
+obj-$(CONFIG_LCD_GPIO)			+= gpio_lcd.o
 obj-$(CONFIG_LCD_HP700)			+= jornada720_lcd.o
 obj-$(CONFIG_LCD_HX8357)		+= hx8357.o
 obj-$(CONFIG_LCD_ILI922X)		+= ili922x.o
diff --git a/drivers/video/backlight/gpio_lcd.c b/drivers/video/backlight/gpio_lcd.c
new file mode 100644
index 0000000..e1c9d4a
--- /dev/null
+++ b/drivers/video/backlight/gpio_lcd.c
@@ -0,0 +1,178 @@
+/*
+ * drivers/video/backlight/gpio_lcd.c
+ *
+ * simple GPIO based lcd control.
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
+ * Based on drivers/video/backlight/platform_lcd.c
+ */
+
+#include <linux/lcd.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+
+struct gpio_lcd {
+	unsigned gpio;
+	u32 active_low; /* 1 if active_low, 0 otherwise */
+	struct lcd_device *lcd;
+	unsigned int power;
+	unsigned int suspended;
+};
+
+static int gpio_lcd_get_power(struct lcd_device *lcd)
+{
+	struct gpio_lcd *glcd = lcd_get_data(lcd);
+
+	return glcd->power;
+}
+
+static int gpio_lcd_set_power(struct lcd_device *lcd, int power)
+{
+	struct gpio_lcd *glcd = lcd_get_data(lcd);
+	int lcd_power = 1;
+	unsigned ret = 0;
+
+	if (power == FB_BLANK_POWERDOWN || glcd->suspended)
+		lcd_power = 0;
+
+	ret = gpio_direction_output(glcd->gpio,
+			    lcd_power ? !glcd->active_low : glcd->active_low);
+
+	glcd->power = power;
+
+	return ret;
+}
+
+static struct lcd_ops gpio_lcd_ops = {
+	.get_power	= gpio_lcd_get_power,
+	.set_power	= gpio_lcd_set_power,
+};
+
+static int gpio_lcd_probe(struct platform_device *pdev)
+{
+	struct gpio_lcd *glcd;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	enum of_gpio_flags gpio_flags;
+	int ret = 0;
+
+	dev_info(&pdev->dev, "Initializing.\n");
+
+	glcd = devm_kzalloc(&pdev->dev, sizeof(*glcd), GFP_KERNEL);
+	if (!glcd) {
+		dev_err(&pdev->dev, "No memory for gpio_lcd.\n");
+		return -ENOMEM;
+	};
+
+	glcd->gpio = of_get_gpio_flags(np, 0, &gpio_flags);
+	glcd->active_low = gpio_flags & OF_GPIO_ACTIVE_LOW;
+	if (glcd->gpio == -EPROBE_DEFER) {
+		ret = ERR_PTR(-EPROBE_DEFER);
+		goto err_free_pdata;
+	} else if (glcd->gpio < 0) {
+		ret = glcd->gpio;
+		dev_err(&pdev->dev, "Error: gpios is a required parameter.\n");
+		goto err_free_pdata;
+	}
+
+	/* Request the LCD gpio */
+	ret = gpio_request(glcd->gpio, "LCDRST");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failled to request LCD reset"
+		" GPIO %u.\n", glcd->gpio);
+		goto err_free_pdata;
+	}
+
+	glcd->lcd = lcd_device_register(dev_name(dev), dev,
+					glcd, &gpio_lcd_ops);
+	if (IS_ERR(glcd->lcd)) {
+		dev_err(dev, "Cannot register lcd device.\n");
+		ret = PTR_ERR(glcd->lcd);
+		goto err_free_pdata;
+	}
+
+	platform_set_drvdata(pdev, glcd);
+	gpio_lcd_set_power(glcd->lcd, FB_BLANK_NORMAL);
+
+	dev_info(&pdev->dev, "The LCD was Enabled by the GPIO %u which is %s.\n",
+			     glcd->gpio,
+			     glcd->active_low ? "active low" : "active high");
+
+	dev_info(&pdev->dev, "Initialized.\n");
+
+	return 0;
+
+err_free_pdata:
+	devm_kfree(&pdev->dev, glcd);
+	return ret;
+}
+
+static int gpio_lcd_remove(struct platform_device *pdev)
+{
+	struct gpio_lcd *glcd = platform_get_drvdata(pdev);
+
+	lcd_device_unregister(glcd->lcd);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int gpio_lcd_suspend(struct device *dev)
+{
+	struct gpio_lcd *glcd = dev_get_drvdata(dev);
+
+	glcd->suspended = 1;
+	return gpio_lcd_set_power(glcd->lcd, glcd->power);
+}
+
+static int gpio_lcd_resume(struct device *dev)
+{
+	struct gpio_lcd *glcd = dev_get_drvdata(dev);
+
+	glcd->suspended = 0;
+	return gpio_lcd_set_power(glcd->lcd, glcd->power);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(gpio_lcd_pm_ops, gpio_lcd_suspend,
+			gpio_lcd_resume);
+
+static struct of_device_id gpio_lcd_of_match[] = {
+	{ .compatible = "gpio-lcd" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, gpio_lcd_of_match);
+
+static struct platform_driver gpio_lcd_driver = {
+	.driver		= {
+		.name           = "gpio-lcd",
+		.owner          = THIS_MODULE,
+		.pm		= &gpio_lcd_pm_ops,
+		.of_match_table = of_match_ptr(gpio_lcd_of_match),
+	},
+	.probe          = gpio_lcd_probe,
+	.remove         = gpio_lcd_remove,
+};
+
+module_platform_driver(gpio_lcd_driver);
+
+MODULE_DESCRIPTION("GPIO based LCD Driver");
+MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:gpio-lcd");
-- 
1.7.9.5
