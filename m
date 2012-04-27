From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 27 Apr 2012 13:19:06 +0200
Subject: [PATCH 2/2] netX: add generic GPIO suppport
In-Reply-To: <1335525546-13546-1-git-send-email-jbe@pengutronix.de>
References: <1335525546-13546-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1335525546-13546-3-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This family of processors has three kinds of GPIO/PIO/HIFPIO pins with
different features each. This patch adds generic (G)PIO support to hide
the details for the users.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/mach-netx/Kconfig             |    4 +
 arch/arm/mach-netx/generic.c           |   42 +++
 arch/arm/mach-netx/include/mach/gpio.h |   27 ++
 drivers/gpio/Makefile                  |    1 +
 drivers/gpio/gpio-netX.c               |  464 ++++++++++++++++++++++++++++++++
 5 files changed, 538 insertions(+)
 create mode 100644 arch/arm/mach-netx/include/mach/gpio.h
 create mode 100644 drivers/gpio/gpio-netX.c

diff --git a/arch/arm/mach-netx/Kconfig b/arch/arm/mach-netx/Kconfig
index 3d90ef1..6625598 100644
--- a/arch/arm/mach-netx/Kconfig
+++ b/arch/arm/mach-netx/Kconfig
@@ -1,6 +1,10 @@
 menu "NetX Implementations"
 	depends on ARCH_NETX
 
+config ARCH_NETX_GPIOLIB
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+
 config MACH_NXDKN
 	bool "Enable Hilscher nxdkn Eval Board support"
 	depends on ARCH_NETX
diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index 5a7b575..13eb4bf 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -58,7 +58,49 @@ static struct platform_device netx_rtc_device = {
 	.resource	= netx_rtc_resources,
 };
 
+static struct resource netx_gpio_res = {
+	.name = "gpio",
+	.start = NETX_PA_GPIO,
+	.end = NETX_PA_GPIO + 0xdf,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device netx_gpio_device = {
+	.name = "netx-gpio",
+	.num_resources = 1,
+	.resource = &netx_gpio_res,
+};
+
+static struct resource netx_pio_res = {
+	.name = "pio",
+	.start = NETX_PA_PIO,
+	.end = NETX_PA_PIO + 0x0f,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device netx_pio_device = {
+	.name = "netx-pio",
+	.num_resources = 1,
+	.resource = &netx_pio_res,
+};
+
+static struct resource netx_hifpio_res = {
+	.name = "hifpio",
+	.start = NETX_PA_EXTBUS + 0x20,
+	.end = NETX_PA_EXTBUS + 0x20 + 0x1b,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device netx_hifpio_device = {
+	.name = "netx-hifpio",
+	.num_resources = 1,
+	.resource = &netx_hifpio_res,
+};
+
 static struct platform_device *devices[] __initdata = {
+	&netx_gpio_device,
+	&netx_pio_device,
+	&netx_hifpio_device,
 	&netx_rtc_device,
 };
 
diff --git a/arch/arm/mach-netx/include/mach/gpio.h b/arch/arm/mach-netx/include/mach/gpio.h
new file mode 100644
index 0000000..640148b
--- /dev/null
+++ b/arch/arm/mach-netx/include/mach/gpio.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2012 Juergen Beisert <kernel@pengutronix.de>, Pengutronix
+ * On behalf of Hilscher GmbH, http://www.hilscher.com/
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
+ */
+
+#ifndef _MACH_NETX_GPIO_H_
+# define _MACH_NETX_GPIO_H_
+
+#define ARCH_NR_GPIOS 128
+
+#define NETX_GPIO_BASE_NO 0
+#define NETX_PIO_BASE_NO 16
+#define NETX_HIFPIO_BASE_NO 48
+
+#include <asm-generic/gpio.h>
+
+#endif /* _MACH_NETX_GPIO_H_ */
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 007f54b..10b7275 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
 obj-$(CONFIG_PLAT_NOMADIK)	+= gpio-nomadik.o
 obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
+obj-$(CONFIG_ARCH_NETX)		+= gpio-netX.o
 obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
diff --git a/drivers/gpio/gpio-netX.c b/drivers/gpio/gpio-netX.c
new file mode 100644
index 0000000..9ba9d6c
--- /dev/null
+++ b/drivers/gpio/gpio-netX.c
@@ -0,0 +1,464 @@
+/*
+ * Copyright (c) 2012 Juergen Beisert <kernel@pengutronix.de>, Pengutronix
+ * On behalf of Hilscher GmbH, http://www.hilscher.com/
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
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#define NETX_GPIO_DRIVER_NAME "netx-gpio"
+#define NETX_GPIO_CFG(x) ((x) << 2)
+# define NETX_GPIO_CFG_MASK 0x03
+# define NETX_GPIO_CFG_IN 0x0
+# define NETX_GPIO_CFG_OUT 0x1
+# define NETX_GPIO_CFG_MODE_IN (0x0 << 3)
+# define NETX_GPIO_CFG_MODE_OUT (0x2 << 3)
+#define NETX_GPIO_OUT 0xc8
+#define NETX_GPIO_IN 0xcc
+
+#define NETX_PIO_DRIVER_NAME "netx-pio"
+#define NETX_PIO_IN 0x0
+#define NETX_PIO_OUT 0x4
+#define NETX_PIO_OUT_EN 0x8
+
+#define NETX_HIFPIO_DRIVER_NAME "netx-hifpio"
+#define NETX_HIFPIO_MODE 0x00
+# define NETX_HIFPIO_MODE_SAMPLE_EN (0x1 << 30)
+#define NETX_HIFPIO_DRV_EN 0x04
+#define NETX_HIFPIO_DATA 0x08
+
+struct netx_io_port {
+	void __iomem *base;
+	spinlock_t lock;
+	struct gpio_chip chip;
+};
+
+#define to_netx_io_port(x) container_of((x), struct netx_io_port, chip)
+
+/* ---- GPIOs share pins with the peripherals, interrupts and counter ----- */
+
+static int netx_gpio_get(struct gpio_chip *chip, unsigned pin)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 mask = 1 << pin;
+
+	return !!(readl(port->base + NETX_GPIO_IN) & mask);
+}
+
+static int netx_gpio_input(struct gpio_chip *chip, unsigned pin)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+
+	/* swtch off every different function than GPIO */
+	writel(NETX_GPIO_CFG_IN | NETX_GPIO_CFG_MODE_IN,
+				port->base + NETX_GPIO_CFG(pin));
+
+	return 0;
+}
+
+static void netx_gpio_set(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 reg, mask = 1 << pin;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	reg = readl(port->base + NETX_GPIO_OUT) & ~mask;
+	writel(reg | (!!value) << pin, port->base + NETX_GPIO_OUT);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int netx_gpio_output(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+
+	netx_gpio_set(chip, pin, value);
+
+	/* swtch off every different function than GPIO */
+	writel(NETX_GPIO_CFG_OUT | NETX_GPIO_CFG_MODE_OUT,
+				port->base + NETX_GPIO_CFG(pin));
+
+	return 0;
+}
+
+static int __devinit netx_gpio_probe(struct platform_device *pd)
+{
+	struct netx_io_port *port;
+	struct resource *res;
+	int err;
+
+	port = kzalloc(sizeof(struct netx_io_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	res = platform_get_resource(pd, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pd->dev, "No resource defined\n");
+		err = -ENODEV;
+		goto out_kfree;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pd->name)) {
+		dev_err(&pd->dev, "Resource already in use\n");
+		err = -EBUSY;
+		goto out_kfree;
+	}
+
+	port->base = ioremap(res->start, resource_size(res));
+	if (!port->base) {
+		dev_err(&pd->dev, "Failed to map the registers\n");
+		err = -ENOMEM;
+		goto out_release_mem;
+	}
+
+	port->chip.base = NETX_GPIO_BASE_NO;
+	port->chip.ngpio = 16;
+	port->chip.label = "netX-GPIO";
+	port->chip.dev = &pd->dev;
+	port->chip.owner = THIS_MODULE;
+	port->chip.can_sleep = false;
+
+	port->chip.direction_input = netx_gpio_input;
+	port->chip.get = netx_gpio_get;
+	port->chip.direction_output = netx_gpio_output;
+	port->chip.set = netx_gpio_set;
+
+	spin_lock_init(&port->lock);
+
+	err = gpiochip_add(&port->chip);
+	if (err)
+		goto out_iounmap;
+
+	return 0;
+
+out_iounmap:
+	iounmap(port->base);
+out_release_mem:
+	release_mem_region(res->start, resource_size(res));
+out_kfree:
+	kfree(port);
+	dev_err(&pd->dev, "%s failed with errno %d\n", __func__, err);
+	return err;
+}
+
+static struct platform_driver netx_gpio_driver = {
+	.driver = {
+		.name = NETX_GPIO_DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = netx_gpio_probe,
+};
+
+/* ----------- PIOs share pins with peripherals ------------------- */
+
+static int netx_pio_get(struct gpio_chip *chip, unsigned pin)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 mask = 1 << pin;
+
+	return !!(readl(port->base + NETX_PIO_IN) & mask);
+}
+
+static int netx_pio_input(struct gpio_chip *chip, unsigned pin)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 mask = 1 << pin, reg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	reg = readl(port->base + NETX_PIO_OUT_EN) & ~mask;
+	writel(reg, port->base + NETX_PIO_OUT_EN);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
+static void netx_pio_set(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 reg, mask = 1 << pin;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	reg = readl(port->base + NETX_PIO_OUT) & ~mask;
+	writel(reg | (!!value) << pin, port->base + NETX_PIO_OUT);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int netx_pio_output(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 mask = 1 << pin, reg;
+	unsigned long flags;
+
+	netx_gpio_set(chip, pin, value);
+
+	spin_lock_irqsave(&port->lock, flags);
+	reg = readl(port->base + NETX_PIO_OUT_EN) | mask;
+	writel(reg, port->base + NETX_PIO_OUT_EN);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
+static int __devinit netx_pio_probe(struct platform_device *pd)
+{
+	struct netx_io_port *port;
+	struct resource *res;
+	int err;
+
+	port = kzalloc(sizeof(struct netx_io_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	res = platform_get_resource(pd, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pd->dev, "No resource defined\n");
+		err = -ENODEV;
+		goto out_kfree;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pd->name)) {
+		dev_err(&pd->dev, "Resource already in use\n");
+		err = -EBUSY;
+		goto out_kfree;
+	}
+
+	port->base = ioremap(res->start, resource_size(res));
+	if (!port->base) {
+		dev_err(&pd->dev, "Failed to map the registers\n");
+		err = -ENOMEM;
+		goto out_release_mem;
+	}
+
+	port->chip.base = NETX_PIO_BASE_NO;
+	port->chip.ngpio = 31; /* note: really! 31 */
+	port->chip.label = "netX-PIO";
+	port->chip.dev = &pd->dev;
+	port->chip.owner = THIS_MODULE;
+	port->chip.can_sleep = false;
+
+	port->chip.direction_input = netx_pio_input;
+	port->chip.get = netx_pio_get;
+	port->chip.direction_output = netx_pio_output;
+	port->chip.set = netx_pio_set;
+
+	spin_lock_init(&port->lock);
+
+	err = gpiochip_add(&port->chip);
+	if (err)
+		goto out_iounmap;
+
+	return 0;
+
+out_iounmap:
+	iounmap(port->base);
+out_release_mem:
+	release_mem_region(res->start, resource_size(res));
+out_kfree:
+	kfree(port);
+	dev_err(&pd->dev, "%s failed with errno %d\n", __func__, err);
+	return err;
+}
+
+static struct platform_driver netx_pio_driver = {
+	.driver = {
+		.name = NETX_PIO_DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = netx_pio_probe,
+};
+
+/* ---------- HIFPIOs share pins with the host interface ----------------- */
+
+static void netx_hifpio_enable_sampling_ondemand(struct gpio_chip *chip)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	u32 mode0, mode1, en0, en1, check0, check1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	mode0 = readl(port->base + NETX_HIFPIO_MODE);
+	mode1 = readl(port->base + NETX_HIFPIO_MODE + 0x10) &
+						~NETX_HIFPIO_MODE_SAMPLE_EN;
+	en0 = readl(port->base + NETX_HIFPIO_DRV_EN);
+	en1 = readl(port->base + NETX_HIFPIO_DRV_EN + 0x10);
+	check0 = ~mode0 & ~en0;
+	check1 = ~(mode1 | 0xffe00000) & ~(en1 | 0xffe00000);
+	if (check0 || check1) {
+		/* at least one PIO is enabled and configured for input */
+		writel(mode1 | NETX_HIFPIO_MODE_SAMPLE_EN,
+			port->base + NETX_HIFPIO_MODE + 0x10);
+	} else
+		writel(mode1, port->base + NETX_HIFPIO_MODE + 0x10);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int netx_hifpio_get(struct gpio_chip *chip, unsigned pin)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	unsigned offset = pin > 31 ? 0x10 : 0x00;
+	unsigned shift = pin > 31 ? pin - 32 : pin;
+	u32 mask = 1 << shift;
+
+	return !!(readl(port->base + NETX_HIFPIO_DATA + offset) & mask);
+}
+
+static int netx_hifpio_input(struct gpio_chip *chip, unsigned pin)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	unsigned offset = pin > 31 ? 0x10 : 0x00;
+	unsigned shift = pin > 31 ? pin - 32 : pin;
+	u32 mask = 1 << shift, mode, drv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	/* swtch off every different function than PIO */
+	mode = readl(port->base + NETX_HIFPIO_MODE + offset) & ~mask;
+	drv = readl(port->base + NETX_HIFPIO_DRV_EN + offset) & ~mask;
+
+	writel(drv, port->base + NETX_HIFPIO_DRV_EN + offset);
+	writel(mode, port->base + NETX_HIFPIO_MODE + offset);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	netx_hifpio_enable_sampling_ondemand(chip);
+
+	return 0;
+}
+
+static void netx_hifpio_set(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	unsigned offset = pin > 31 ? 0x10 : 0x00;
+	unsigned shift = pin > 31 ? pin - 32 : pin;
+	u32 mask = 1 << shift, reg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	reg = readl(port->base + NETX_HIFPIO_DATA + offset) & ~mask;
+	if (value)
+		reg |= mask;
+	writel(reg, port->base + NETX_HIFPIO_DATA + offset);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int netx_hifpio_output(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct netx_io_port *port = to_netx_io_port(chip);
+	unsigned offset = pin > 31 ? 0x10 : 0x00;
+	unsigned shift = pin > 31 ? pin - 32 : pin;
+	u32 mask = 1 << shift, mode, drv;
+	unsigned long flags;
+
+	netx_gpio_set(chip, pin, value);
+
+	spin_lock_irqsave(&port->lock, flags);
+	/* swtch off every different function than PIO */
+	mode = readl(port->base + NETX_HIFPIO_MODE + offset) & ~mask;
+	/* enable the output driver */
+	drv = readl(port->base + NETX_HIFPIO_DRV_EN + offset) | mask;
+
+	writel(drv, port->base + NETX_HIFPIO_DRV_EN + offset);
+	writel(mode, port->base + NETX_HIFPIO_MODE + offset);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	netx_hifpio_enable_sampling_ondemand(chip);
+
+	return 0;
+}
+
+static int __devinit netx_hifpio_probe(struct platform_device *pd)
+{
+	struct netx_io_port *port;
+	struct resource *res;
+	int err;
+
+	port = kzalloc(sizeof(struct netx_io_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	res = platform_get_resource(pd, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pd->dev, "No resource defined\n");
+		err = -ENODEV;
+		goto out_kfree;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pd->name)) {
+		dev_err(&pd->dev, "Resource already in use\n");
+		err = -EBUSY;
+		goto out_kfree;
+	}
+
+	port->base = ioremap(res->start, resource_size(res));
+	if (!port->base) {
+		dev_err(&pd->dev, "Failed to map the registers\n");
+		err = -ENOMEM;
+		goto out_release_mem;
+	}
+
+	port->chip.base = NETX_HIFPIO_BASE_NO;
+	port->chip.ngpio = 53;
+	port->chip.label = "netX-HIFPIO";
+	port->chip.dev = &pd->dev;
+	port->chip.owner = THIS_MODULE;
+	port->chip.can_sleep = false;
+
+	port->chip.direction_input = netx_hifpio_input;
+	port->chip.get = netx_hifpio_get;
+	port->chip.direction_output = netx_hifpio_output;
+	port->chip.set = netx_hifpio_set;
+
+	spin_lock_init(&port->lock);
+
+	err = gpiochip_add(&port->chip);
+	if (err)
+		goto out_iounmap;
+
+	return 0;
+
+out_iounmap:
+	iounmap(port->base);
+out_release_mem:
+	release_mem_region(res->start, resource_size(res));
+out_kfree:
+	kfree(port);
+	dev_err(&pd->dev, "%s failed with errno %d\n", __func__, err);
+	return err;
+}
+
+static struct platform_driver netx_hifpio_driver = {
+	.driver = {
+		.name = NETX_HIFPIO_DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = netx_hifpio_probe,
+};
+
+static int __init netx_gpio_init(void)
+{
+	platform_driver_register(&netx_gpio_driver);
+	platform_driver_register(&netx_pio_driver);
+	platform_driver_register(&netx_hifpio_driver);
+	return 0;
+}
+postcore_initcall(netx_gpio_init);
+
+MODULE_AUTHOR("Juergen Beisert <kernel@pengutronix.de>");
+MODULE_DESCRIPTION("Hilscher netX GPIO");
+MODULE_LICENSE("GPL");
-- 
1.7.10
