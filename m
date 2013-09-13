From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 09:38:26 +0200
Subject: [PATCH 1/8 v2] ARM: plat-iop: move the GPIO driver to drivers/gpio
Message-ID: <1379057906-2024-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the IOP GPIO driver to live with its siblings in the
GPIO subsystem.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix spelling error ICP->IOP
---
 arch/arm/Kconfig           |  2 +
 arch/arm/plat-iop/Makefile |  2 -
 arch/arm/plat-iop/gpio.c   | 93 ----------------------------------------------
 drivers/gpio/Kconfig       |  9 +++++
 drivers/gpio/Makefile      |  1 +
 drivers/gpio/gpio-iop.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 105 insertions(+), 95 deletions(-)
 delete mode 100644 arch/arm/plat-iop/gpio.c
 create mode 100644 drivers/gpio/gpio-iop.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a00f4c1..4ef9fc8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -456,6 +456,7 @@ config ARCH_IOP32X
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
+	select GPIO_IOP
 	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
 	select PCI
@@ -469,6 +470,7 @@ config ARCH_IOP33X
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
+	select GPIO_IOP
 	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
 	select PCI
diff --git a/arch/arm/plat-iop/Makefile b/arch/arm/plat-iop/Makefile
index a99dc15..224e56c 100644
--- a/arch/arm/plat-iop/Makefile
+++ b/arch/arm/plat-iop/Makefile
@@ -5,7 +5,6 @@
 obj-y :=
 
 # IOP32X
-obj-$(CONFIG_ARCH_IOP32X) += gpio.o
 obj-$(CONFIG_ARCH_IOP32X) += i2c.o
 obj-$(CONFIG_ARCH_IOP32X) += pci.o
 obj-$(CONFIG_ARCH_IOP32X) += setup.o
@@ -16,7 +15,6 @@ obj-$(CONFIG_ARCH_IOP32X) += pmu.o
 obj-$(CONFIG_ARCH_IOP32X) += restart.o
 
 # IOP33X
-obj-$(CONFIG_ARCH_IOP33X) += gpio.o
 obj-$(CONFIG_ARCH_IOP33X) += i2c.o
 obj-$(CONFIG_ARCH_IOP33X) += pci.o
 obj-$(CONFIG_ARCH_IOP33X) += setup.o
diff --git a/arch/arm/plat-iop/gpio.c b/arch/arm/plat-iop/gpio.c
deleted file mode 100644
index 697de6d..0000000
--- a/arch/arm/plat-iop/gpio.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * arch/arm/plat-iop/gpio.c
- * GPIO handling for Intel IOP3xx processors.
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- */
-
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/gpio.h>
-#include <linux/export.h>
-#include <asm/hardware/iop3xx.h>
-#include <mach/gpio.h>
-
-void gpio_line_config(int line, int direction)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (direction == GPIO_IN) {
-		*IOP3XX_GPOE |= 1 << line;
-	} else if (direction == GPIO_OUT) {
-		*IOP3XX_GPOE &= ~(1 << line);
-	}
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(gpio_line_config);
-
-int gpio_line_get(int line)
-{
-	return !!(*IOP3XX_GPID & (1 << line));
-}
-EXPORT_SYMBOL(gpio_line_get);
-
-void gpio_line_set(int line, int value)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (value == GPIO_LOW) {
-		*IOP3XX_GPOD &= ~(1 << line);
-	} else if (value == GPIO_HIGH) {
-		*IOP3XX_GPOD |= 1 << line;
-	}
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(gpio_line_set);
-
-static int iop3xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-{
-	gpio_line_config(gpio, GPIO_IN);
-	return 0;
-}
-
-static int iop3xx_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int level)
-{
-	gpio_line_set(gpio, level);
-	gpio_line_config(gpio, GPIO_OUT);
-	return 0;
-}
-
-static int iop3xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
-{
-	return gpio_line_get(gpio);
-}
-
-static void iop3xx_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
-{
-	gpio_line_set(gpio, value);
-}
-
-static struct gpio_chip iop3xx_chip = {
-	.label			= "iop3xx",
-	.direction_input	= iop3xx_gpio_direction_input,
-	.get			= iop3xx_gpio_get_value,
-	.direction_output	= iop3xx_gpio_direction_output,
-	.set			= iop3xx_gpio_set_value,
-	.base			= 0,
-	.ngpio			= IOP3XX_N_GPIOS,
-};
-
-static int __init iop3xx_gpio_setup(void)
-{
-	return gpiochip_add(&iop3xx_chip);
-}
-arch_initcall(iop3xx_gpio_setup);
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 349b161..a856778 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -312,6 +312,15 @@ config GPIO_ICH
 
 	  If unsure, say N.
 
+config GPIO_IOP
+	tristate "Intel IOP GPIO"
+	depends on ARM && (ARCH_IOP32X || ARCH_IOP33X)
+	help
+	  Say yes here to support the GPIO functionality of a number of Intel
+	  IOP32X or IOP33X.
+
+	  If unsure, say N.
+
 config GPIO_VX855
 	tristate "VIA VX855/VX875 GPIO"
 	depends on PCI && GENERIC_HARDIRQS
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 97438bf..66fb17e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT8761E)	+= gpio-it8761e.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
new file mode 100644
index 0000000..697de6d
--- /dev/null
+++ b/drivers/gpio/gpio-iop.c
@@ -0,0 +1,93 @@
+/*
+ * arch/arm/plat-iop/gpio.c
+ * GPIO handling for Intel IOP3xx processors.
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/gpio.h>
+#include <linux/export.h>
+#include <asm/hardware/iop3xx.h>
+#include <mach/gpio.h>
+
+void gpio_line_config(int line, int direction)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (direction == GPIO_IN) {
+		*IOP3XX_GPOE |= 1 << line;
+	} else if (direction == GPIO_OUT) {
+		*IOP3XX_GPOE &= ~(1 << line);
+	}
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(gpio_line_config);
+
+int gpio_line_get(int line)
+{
+	return !!(*IOP3XX_GPID & (1 << line));
+}
+EXPORT_SYMBOL(gpio_line_get);
+
+void gpio_line_set(int line, int value)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (value == GPIO_LOW) {
+		*IOP3XX_GPOD &= ~(1 << line);
+	} else if (value == GPIO_HIGH) {
+		*IOP3XX_GPOD |= 1 << line;
+	}
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(gpio_line_set);
+
+static int iop3xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	gpio_line_config(gpio, GPIO_IN);
+	return 0;
+}
+
+static int iop3xx_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int level)
+{
+	gpio_line_set(gpio, level);
+	gpio_line_config(gpio, GPIO_OUT);
+	return 0;
+}
+
+static int iop3xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	return gpio_line_get(gpio);
+}
+
+static void iop3xx_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
+{
+	gpio_line_set(gpio, value);
+}
+
+static struct gpio_chip iop3xx_chip = {
+	.label			= "iop3xx",
+	.direction_input	= iop3xx_gpio_direction_input,
+	.get			= iop3xx_gpio_get_value,
+	.direction_output	= iop3xx_gpio_direction_output,
+	.set			= iop3xx_gpio_set_value,
+	.base			= 0,
+	.ngpio			= IOP3XX_N_GPIOS,
+};
+
+static int __init iop3xx_gpio_setup(void)
+{
+	return gpiochip_add(&iop3xx_chip);
+}
+arch_initcall(iop3xx_gpio_setup);
-- 
1.8.3.1
