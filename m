From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  2 May 2015 23:11:34 +0200
Subject: [PATCH v2 1/2] gpio: add lpc18xx gpio driver
In-Reply-To: <1430601095-31984-1-git-send-email-manabian@gmail.com>
References: <1430601095-31984-1-git-send-email-manabian@gmail.com>
Message-ID: <1430601095-31984-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for the GPIO block found on NXP LPC18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/gpio/Kconfig        |   8 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-lpc18xx.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/gpio/gpio-lpc18xx.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index caefe806db5e..c2211258231b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -230,6 +230,14 @@ config GPIO_LOONGSON
 	help
 	  driver for GPIO functionality on Loongson-2F/3A/3B processors.
 
+config GPIO_LPC18XX
+	bool "NXP LPC18XX/43XX GPIO support"
+	default y if ARCH_LPC18XX
+	depends on OF_GPIO && (ARCH_LPC18XX || COMPILE_TEST)
+	help
+	  Select this option to enable GPIO driver for
+	  NXP LPC18XX/43XX devices.
+
 config GPIO_LYNXPOINT
 	tristate "Intel Lynxpoint GPIO support"
 	depends on ACPI && X86
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index f71bb971329c..7b7f5d2e8ad4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
 obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
 obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
+obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
new file mode 100644
index 000000000000..eb68603136b0
--- /dev/null
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -0,0 +1,180 @@
+/*
+ * GPIO driver for NXP LPC18xx/43xx.
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+
+/* LPC18xx GPIO register offsets */
+#define LPC18XX_REG_DIR(n)	(0x2000 + n * sizeof(u32))
+
+#define LPC18XX_MAX_PORTS	8
+#define LPC18XX_PINS_PER_PORT	32
+
+struct lpc18xx_gpio_chip {
+	struct gpio_chip gpio;
+	void __iomem *base;
+	struct clk *clk;
+	spinlock_t lock;
+};
+
+static inline struct lpc18xx_gpio_chip *to_lpc18xx_gpio(struct gpio_chip *chip)
+{
+	return container_of(chip, struct lpc18xx_gpio_chip, gpio);
+}
+
+static int lpc18xx_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(offset);
+}
+
+static void lpc18xx_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(offset);
+}
+
+static void lpc18xx_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct lpc18xx_gpio_chip *gc = to_lpc18xx_gpio(chip);
+	writeb(value ? 1 : 0, gc->base + offset);
+}
+
+static int lpc18xx_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct lpc18xx_gpio_chip *gc = to_lpc18xx_gpio(chip);
+	return !!readb(gc->base + offset);
+}
+
+static int lpc18xx_gpio_direction(struct gpio_chip *chip, unsigned offset,
+				  bool out)
+{
+	struct lpc18xx_gpio_chip *gc = to_lpc18xx_gpio(chip);
+	unsigned long flags;
+	u32 port, pin, dir;
+
+	port = offset / LPC18XX_PINS_PER_PORT;
+	pin  = offset % LPC18XX_PINS_PER_PORT;
+
+	spin_lock_irqsave(&gc->lock, flags);
+	dir = readl(gc->base + LPC18XX_REG_DIR(port));
+	if (out)
+		dir |= BIT(pin);
+	else
+		dir &= ~BIT(pin);
+	writel(dir, gc->base + LPC18XX_REG_DIR(port));
+	spin_unlock_irqrestore(&gc->lock, flags);
+
+	return 0;
+}
+
+static int lpc18xx_gpio_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	return lpc18xx_gpio_direction(chip, offset, false);
+}
+
+static int lpc18xx_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned offset, int value)
+{
+	lpc18xx_gpio_set(chip, offset, value);
+	return lpc18xx_gpio_direction(chip, offset, true);
+}
+
+static struct gpio_chip lpc18xx_chip = {
+	.label			= "lpc18xx/43xx-gpio",
+	.request		= lpc18xx_gpio_request,
+	.free			= lpc18xx_gpio_free,
+	.direction_input	= lpc18xx_gpio_direction_input,
+	.direction_output	= lpc18xx_gpio_direction_output,
+	.set			= lpc18xx_gpio_set,
+	.get			= lpc18xx_gpio_get,
+	.ngpio			= LPC18XX_MAX_PORTS * LPC18XX_PINS_PER_PORT,
+	.owner			= THIS_MODULE,
+};
+
+static int lpc18xx_gpio_probe(struct platform_device *pdev)
+{
+	struct lpc18xx_gpio_chip *gc;
+	struct resource *res;
+	int ret;
+
+	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->gpio = lpc18xx_chip;
+	platform_set_drvdata(pdev, gc);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gc->base))
+		return PTR_ERR(gc->base);
+
+	gc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(gc->clk)) {
+		dev_err(&pdev->dev, "input clock not found\n");
+		return PTR_ERR(gc->clk);
+	}
+
+	ret = clk_prepare_enable(gc->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
+		return ret;
+	}
+
+	spin_lock_init(&gc->lock);
+
+	gc->gpio.dev = &pdev->dev;
+
+	ret = gpiochip_add(&gc->gpio);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add gpio chip\n");
+		clk_disable_unprepare(gc->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lpc18xx_gpio_remove(struct platform_device *pdev)
+{
+	struct lpc18xx_gpio_chip *gc = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&gc->gpio);
+	clk_disable_unprepare(gc->clk);
+
+	return 0;
+}
+
+static const struct of_device_id lpc18xx_gpio_match[] = {
+	{ .compatible = "nxp,lpc1850-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_gpio_match);
+
+static struct platform_driver lpc18xx_gpio_driver = {
+	.probe	= lpc18xx_gpio_probe,
+	.remove	= lpc18xx_gpio_remove,
+	.driver	= {
+		.name		= "lpc18xx-gpio",
+		.of_match_table	= lpc18xx_gpio_match,
+	},
+};
+module_platform_driver(lpc18xx_gpio_driver);
+
+MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
+MODULE_DESCRIPTION("GPIO driver for LPC18xx/43xx");
+MODULE_LICENSE("GPL v2");
-- 
1.8.0
