From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 22 Aug 2012 15:36:23 +0400
Subject: [PATCH] GPIO: Add support for GPIO on CLPS711X-target platform
Message-ID: <1345635383-12224-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLPS711X CPUs provide some GPIOs for use in the system. This
driver provides support for these via gpiolib. Due to platform
limitations, driver does not support interrupts, only inputs and
outputs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-clps711x/include/mach/gpio.h |   13 ++
 drivers/gpio/Kconfig                       |    4 +
 drivers/gpio/Makefile                      |    1 +
 drivers/gpio/gpio-clps711x.c               |  178 ++++++++++++++++++++++++++++
 5 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/include/mach/gpio.h
 create mode 100644 drivers/gpio/gpio-clps711x.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d6e18f..1f718b0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -384,6 +384,7 @@ config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select CPU_ARM720T
 	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_REQUIRE_GPIOLIB
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
diff --git a/arch/arm/mach-clps711x/include/mach/gpio.h b/arch/arm/mach-clps711x/include/mach/gpio.h
new file mode 100644
index 0000000..8ac6889
--- /dev/null
+++ b/arch/arm/mach-clps711x/include/mach/gpio.h
@@ -0,0 +1,13 @@
+/*
+ *  This file contains the CLPS711X GPIO definitions.
+ *
+ *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+/* Simple helper for convert port & pin to GPIO number */
+#define CLPS711X_GPIO(port, bit)	((port) * 8 + (bit))
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b16c8a7..72b9d2f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -91,6 +91,10 @@ config GPIO_MAX730X
 
 comment "Memory mapped GPIO drivers:"
 
+config GPIO_CLPS711X
+	def_bool y
+	depends on ARCH_CLPS711X
+
 config GPIO_GENERIC_PLATFORM
 	tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
 	select GPIO_GENERIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 153cace..6a41f79 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
+obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
 obj-$(CONFIG_ARCH_DAVINCI)	+= gpio-davinci.o
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
new file mode 100644
index 0000000..c527609
--- /dev/null
+++ b/drivers/gpio/gpio-clps711x.c
@@ -0,0 +1,178 @@
+/*
+ *  CLPS711X GPIO driver
+ *
+ *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+
+#define CLPS711X_GPIO_PORTS	5
+
+struct clps711x_gpio {
+	struct gpio_chip	chip[CLPS711X_GPIO_PORTS];
+	struct mutex		lock;
+};
+
+static inline u32 gpio_clps711x_port_dataaddr(struct gpio_chip *chip)
+{
+	switch (chip->base) {
+	case 0:
+		return PADR;
+	case 8:
+		return PBDR;
+	case 16:
+		return PCDR;
+	case 24:
+		return PDDR;
+	}
+
+	return PEDR;
+}
+
+static inline u32 gpio_clps711x_port_diraddr(struct gpio_chip *chip)
+{
+	switch (chip->base) {
+	case 0:
+		return PADDR;
+	case 8:
+		return PBDDR;
+	case 16:
+		return PCDDR;
+	case 24:
+		return PDDDR;
+	}
+
+	return PEDDR;
+}
+
+static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
+{
+	int ret;
+	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+
+	mutex_lock(&gpio->lock);
+	ret = clps_readb(gpio_clps711x_port_dataaddr(chip)) & (1 << offset);
+	mutex_unlock(&gpio->lock);
+
+	return !!ret;
+}
+
+static void gpio_clps711x_set(struct gpio_chip *chip, unsigned offset,
+			      int value)
+{
+	int tmp;
+	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+
+	mutex_lock(&gpio->lock);
+	tmp = clps_readb(gpio_clps711x_port_dataaddr(chip)) & ~(1 << offset);
+	if (value)
+		tmp |= 1 << offset;
+	clps_writeb(tmp, gpio_clps711x_port_dataaddr(chip));
+	mutex_unlock(&gpio->lock);
+}
+
+static int gpio_clps711x_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	int tmp;
+	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+
+	mutex_lock(&gpio->lock);
+	tmp = clps_readb(gpio_clps711x_port_diraddr(chip)) & ~(1 << offset);
+	clps_writeb(tmp, gpio_clps711x_port_diraddr(chip));
+	mutex_unlock(&gpio->lock);
+
+	return 0;
+}
+
+static int gpio_clps711x_direction_out(struct gpio_chip *chip, unsigned offset,
+				       int value)
+{
+	int tmp;
+	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+
+	mutex_lock(&gpio->lock);
+	tmp = clps_readb(gpio_clps711x_port_diraddr(chip)) | (1 << offset);
+	clps_writeb(tmp, gpio_clps711x_port_diraddr(chip));
+	tmp = clps_readb(gpio_clps711x_port_dataaddr(chip)) & ~(1 << offset);
+	if (value)
+		tmp |= 1 << offset;
+	clps_writeb(tmp, gpio_clps711x_port_dataaddr(chip));
+	mutex_unlock(&gpio->lock);
+
+	return 0;
+}
+
+struct clps711x_gpio_port {
+	char	*name;
+	int	nr;
+};
+
+static const struct clps711x_gpio_port clps711x_gpio_ports[] __devinitconst = {
+	{ "PORTA", 8, },
+	{ "PORTB", 8, },
+	{ "PORTC", 8, },
+	{ "PORTD", 8, },
+	{ "PORTE", 3, },
+};
+
+static int __devinit gpio_clps711x_probe(struct platform_device *pdev)
+{
+	int i;
+	struct clps711x_gpio *gpio;
+
+	gpio = kzalloc(sizeof(struct clps711x_gpio), GFP_KERNEL);
+	if (!gpio) {
+		dev_err(&pdev->dev, "GPIO allocating memory error\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&pdev->dev, gpio);
+
+	mutex_init(&gpio->lock);
+
+	for (i = 0; i < ARRAY_SIZE(clps711x_gpio_ports); i++) {
+		gpio->chip[i].owner		= THIS_MODULE;
+		gpio->chip[i].dev		= &pdev->dev;
+		gpio->chip[i].label		= clps711x_gpio_ports[i].name;
+		gpio->chip[i].base		= i * 8;
+		gpio->chip[i].ngpio		= clps711x_gpio_ports[i].nr;
+		gpio->chip[i].direction_input	= gpio_clps711x_direction_in;
+		gpio->chip[i].get		= gpio_clps711x_get;
+		gpio->chip[i].direction_output	= gpio_clps711x_direction_out;
+		gpio->chip[i].set		= gpio_clps711x_set;
+		gpiochip_add(&gpio->chip[i]);
+	}
+
+	dev_info(&pdev->dev, "GPIO driver initialized\n");
+
+	return 0;
+}
+
+static struct platform_driver clps711x_gpio_driver = {
+	.driver	= {
+		.name	= "gpio-clps711x",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= gpio_clps711x_probe,
+};
+
+static int __init gpio_clps711x_init(void)
+{
+	return platform_driver_register(&clps711x_gpio_driver);
+}
+postcore_initcall(gpio_clps711x_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("CLPS711X GPIO driver");
-- 
1.7.3.4
