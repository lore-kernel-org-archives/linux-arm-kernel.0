From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Thu, 20 Nov 2014 20:37:03 +0800
Subject: [PATCH 5/9] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1416487023-25426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for Fujitsu MB86S7x SoCs that have a memory mapped GPIO controller.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 .../bindings/gpio/fujitsu,mb86s70-gpio.txt         |  18 ++
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-mb86s7x.c                        | 211 +++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
 create mode 100644 drivers/gpio/gpio-mb86s7x.c

diff --git a/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
new file mode 100644
index 0000000..38300ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
@@ -0,0 +1,18 @@
+Fujitsu MB86S7x GPIO Controller
+-------------------------------
+
+Required properties:
+- compatible: Should be "fujitsu,mb86s70-gpio"
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be <2>. The first cell is the pin number and the
+  second cell is used to specify optional parameters:
+   - bit 0 specifies polarity (0 for normal, 1 for inverted).
+
+Examples:
+	gpio0: gpio at 31000000 {
+		compatible = "fujitsu,mb86s70-gpio";
+		reg = <0 0x31000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		clocks = <&clk_alw_2_1>;
+	};
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0959ca9..493b7fe 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -181,6 +181,12 @@ config GPIO_F7188X
 	  To compile this driver as a module, choose M here: the module will
 	  be called f7188x-gpio.
 
+config GPIO_MB86S7X
+	bool "GPIO support for Fujitsu MB86S7x Platforms"
+	depends on ARCH_MB86S7X
+	help
+	  Say yes here to support the GPIO controller in LSI ZEVIO SoCs.
+
 config GPIO_MOXART
 	bool "MOXART GPIO support"
 	depends on ARCH_MOXART
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index e5d346c..eec0664 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)	+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX732X)	+= gpio-max732x.o
+obj-$(CONFIG_GPIO_MB86S7X)	+= gpio-mb86s7x.o
 obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
new file mode 100644
index 0000000..f0b2dc0
--- /dev/null
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -0,0 +1,211 @@
+/*
+ *  linux/drivers/gpio/gpio-mb86s7x.c
+ *
+ *  Copyright (C) 2014 Fujitsu Semiconductor Limited
+ *  Copyright (C) 2014 Linaro Ltd.
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+
+#define PDR(x)	(0x0 + x)
+#define DDR(x)	(0x10 + x)
+#define PFR(x)	(0x20 + x)
+
+struct mb86s70_gpio_chip {
+	spinlock_t lock;
+	struct clk *clk;
+	void __iomem *base;
+	struct gpio_chip gc;
+};
+
+static int mb86s70_gpio_request(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip = container_of(gc,
+					struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	val = readl(gchip->base + PFR(offset / 8 * 4));
+	val &= ~(1 << (offset % 8)); /* as gpio-port */
+	writel(val, gchip->base + PFR(offset / 8 * 4));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static void mb86s70_gpio_free(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip = container_of(gc,
+					struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	val = readl(gchip->base + PFR(offset / 8 * 4));
+	val |= (1 << (offset % 8)); /* as peri-port */
+	writel(val, gchip->base + PFR(offset / 8 * 4));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+}
+
+static int mb86s70_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	unsigned char val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+	val = readl(gchip->base + DDR(offset / 8 * 4));
+	val &= ~(1 << (offset % 8));
+	writel(val, gchip->base + DDR(offset / 8 * 4));
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static int mb86s70_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned offset, int value)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	unsigned char val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+
+	val = readl(gchip->base + PDR(offset / 8 * 4));
+	if (value)
+		val |= (1 << (offset % 8));
+	else
+		val &= ~(1 << (offset % 8));
+	writel(val, gchip->base + PDR(offset / 8 * 4));
+
+	val = readl(gchip->base + DDR(offset / 8 * 4));
+	val |= (1 << (offset % 8));
+	writel(val, gchip->base + DDR(offset / 8 * 4));
+
+	spin_unlock_irqrestore(&gchip->lock, flags);
+
+	return 0;
+}
+
+static int mb86s70_gpio_get(struct gpio_chip *gc, unsigned offset)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned char val;
+
+	val = readl(gchip->base + PDR(offset / 8 * 4));
+	val &= (1 << (offset % 8));
+	return val ? 1 : 0;
+}
+
+static void mb86s70_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+{
+	struct mb86s70_gpio_chip *gchip =
+			container_of(gc, struct mb86s70_gpio_chip, gc);
+	unsigned long flags;
+	unsigned char val;
+
+	spin_lock_irqsave(&gchip->lock, flags);
+
+	val = readl(gchip->base + PDR(offset / 8 * 4));
+	if (value)
+		val |= (1 << (offset % 8));
+	else
+		val &= ~(1 << (offset % 8));
+	writel(val, gchip->base + PDR(offset / 8 * 4));
+
+	spin_unlock_irqrestore(&gchip->lock, flags);
+}
+
+static int mb86s70_gpio_probe(struct platform_device *pdev)
+{
+	struct mb86s70_gpio_chip *gchip;
+	struct resource *res;
+	int ret;
+
+	gchip = devm_kzalloc(&pdev->dev, sizeof(*gchip), GFP_KERNEL);
+	if (gchip == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, gchip);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gchip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gchip->base))
+		return PTR_ERR(gchip->base);
+
+	gchip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(gchip->clk))
+		return PTR_ERR(gchip->clk);
+
+	clk_prepare_enable(gchip->clk);
+
+	spin_lock_init(&gchip->lock);
+
+	gchip->gc.direction_output = mb86s70_gpio_direction_output;
+	gchip->gc.direction_input = mb86s70_gpio_direction_input;
+	gchip->gc.request = mb86s70_gpio_request;
+	gchip->gc.free = mb86s70_gpio_free;
+	gchip->gc.get = mb86s70_gpio_get;
+	gchip->gc.set = mb86s70_gpio_set;
+	gchip->gc.label = dev_name(&pdev->dev);
+	gchip->gc.ngpio = 32;
+	gchip->gc.owner = THIS_MODULE;
+	gchip->gc.dev = &pdev->dev;
+	gchip->gc.base = -1;
+
+	ret = gpiochip_add(&gchip->gc);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't register gpio driver\n");
+		clk_disable_unprepare(gchip->clk);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id mb86s70_gpio_dt_ids[] = {
+	{ .compatible = "fujitsu,mb86s70-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mb86s70_gpio_dt_ids);
+
+static struct platform_driver mb86s70_gpio_driver = {
+	.probe     = mb86s70_gpio_probe,
+	.driver    = {
+		.name  = "mb86s70-gpio",
+		.of_match_table = mb86s70_gpio_dt_ids,
+	},
+};
+
+static int __init mb86s70_gpio_init(void)
+{
+	return platform_driver_register(&mb86s70_gpio_driver);
+}
+subsys_initcall(mb86s70_gpio_init);
+
+MODULE_DESCRIPTION("MB86S7x GPIO Driver");
+MODULE_ALIAS("platform:mb86s70-gpio");
+MODULE_LICENSE("GPL");
-- 
1.9.0
