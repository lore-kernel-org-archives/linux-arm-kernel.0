From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:18:03 +0200
Subject: [PATCH 6/8] ARM: plat-iop: instantiate GPIO from platform device
Message-ID: <1379708284-8048-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the IOP32x and IOP33x platforms to pass their
base address offset by a resource attached to a platform device
instead of using static offset macros implicitly passed
through <linux/gpio.h> including <mach/gpio.h>. Delete the
local <mach/gpio.h> and <asm/hardware/iop3xx-gpio.h> headers
and remove the selection of NEED_MACH_GPIO_H.

Pass the virtual address as a resource in the platform device
at this point for bisectability, next patch will pass the
physical address as is custom.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3:
- Make sure to supply the GPIO device on all the iop32x
  variant and break it out into a convenience header file to
  share the same definition across all iop32x boards.
---
 arch/arm/Kconfig                            |  2 --
 arch/arm/include/asm/hardware/iop3xx-gpio.h | 32 -------------------------
 arch/arm/include/asm/hardware/iop3xx.h      |  9 --------
 arch/arm/mach-iop32x/em7210.c               |  2 ++
 arch/arm/mach-iop32x/glantank.c             |  2 ++
 arch/arm/mach-iop32x/gpio-iop32x.h          | 10 ++++++++
 arch/arm/mach-iop32x/include/mach/gpio.h    |  6 -----
 arch/arm/mach-iop32x/include/mach/iop32x.h  |  1 -
 arch/arm/mach-iop32x/iq31244.c              |  2 ++
 arch/arm/mach-iop32x/iq80321.c              |  2 ++
 arch/arm/mach-iop32x/n2100.c                |  2 ++
 arch/arm/mach-iop33x/include/mach/gpio.h    |  6 -----
 arch/arm/mach-iop33x/include/mach/iop33x.h  |  1 -
 arch/arm/mach-iop33x/iq80331.c              |  7 ++++++
 arch/arm/mach-iop33x/iq80332.c              |  7 ++++++
 drivers/gpio/gpio-iop.c                     | 36 +++++++++++++++++++++++++++--
 16 files changed, 68 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/iop3xx-gpio.h
 create mode 100644 arch/arm/mach-iop32x/gpio-iop32x.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc8c092..e83529b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -458,7 +458,6 @@ config ARCH_IOP32X
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
 	select GPIO_IOP
-	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
 	select PCI
 	select PLAT_IOP
@@ -472,7 +471,6 @@ config ARCH_IOP33X
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
 	select GPIO_IOP
-	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
 	select PCI
 	select PLAT_IOP
diff --git a/arch/arm/include/asm/hardware/iop3xx-gpio.h b/arch/arm/include/asm/hardware/iop3xx-gpio.h
deleted file mode 100644
index e2a0970..0000000
--- a/arch/arm/include/asm/hardware/iop3xx-gpio.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * arch/arm/include/asm/hardware/iop3xx-gpio.h
- *
- * IOP3xx GPIO wrappers
- *
- * Copyright (c) 2008 Arnaud Patard <arnaud.patard@rtp-net.org>
- * Based on IXP4XX gpio.h file
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#ifndef __ASM_ARM_HARDWARE_IOP3XX_GPIO_H
-#define __ASM_ARM_HARDWARE_IOP3XX_GPIO_H
-
-#include <mach/hardware.h>
-#include <asm-generic/gpio.h>
-
-#endif
-
diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 6af9c28..2594a95 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -18,10 +18,6 @@
 /*
  * IOP3XX GPIO handling
  */
-#define GPIO_IN			0
-#define GPIO_OUT		1
-#define GPIO_LOW		0
-#define GPIO_HIGH		1
 #define IOP3XX_GPIO_LINE(x)	(x)
 
 #ifndef __ASSEMBLY__
@@ -165,11 +161,6 @@ extern int iop3xx_get_init_atu(void);
 /* PERCR0 DOESN'T EXIST - index from 1! */
 #define IOP3XX_PERCR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0710)
 
-/* General Purpose I/O  */
-#define IOP3XX_GPOE		(volatile u32 *)IOP3XX_GPIO_REG(0x0000)
-#define IOP3XX_GPID		(volatile u32 *)IOP3XX_GPIO_REG(0x0004)
-#define IOP3XX_GPOD		(volatile u32 *)IOP3XX_GPIO_REG(0x0008)
-
 /* Timers  */
 #define IOP3XX_TU_TMR0		(volatile u32 *)IOP3XX_TIMER_REG(0x0000)
 #define IOP3XX_TU_TMR1		(volatile u32 *)IOP3XX_TIMER_REG(0x0004)
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 31fbb6c..177cd07 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -32,6 +32,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach-types.h>
 #include <mach/time.h>
+#include "gpio-iop32x.h"
 
 static void __init em7210_timer_init(void)
 {
@@ -183,6 +184,7 @@ void em7210_power_off(void)
 
 static void __init em7210_init_machine(void)
 {
+	register_iop32x_gpio();
 	platform_device_register(&em7210_serial_device);
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index ac30470..547b234 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -34,6 +34,7 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <mach/time.h>
+#include "gpio-iop32x.h"
 
 /*
  * GLAN Tank timer tick configuration.
@@ -187,6 +188,7 @@ static void glantank_power_off(void)
 
 static void __init glantank_init_machine(void)
 {
+	register_iop32x_gpio();
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
 	platform_device_register(&glantank_flash_device);
diff --git a/arch/arm/mach-iop32x/gpio-iop32x.h b/arch/arm/mach-iop32x/gpio-iop32x.h
new file mode 100644
index 0000000..b8710a6
--- /dev/null
+++ b/arch/arm/mach-iop32x/gpio-iop32x.h
@@ -0,0 +1,10 @@
+static struct resource iop32x_gpio_res[] = {
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x07c4), 0x10),
+};
+
+static inline void register_iop32x_gpio(void)
+{
+	platform_device_register_simple("gpio-iop", 0,
+					iop32x_gpio_res,
+					ARRAY_SIZE(iop32x_gpio_res));
+}
diff --git a/arch/arm/mach-iop32x/include/mach/gpio.h b/arch/arm/mach-iop32x/include/mach/gpio.h
deleted file mode 100644
index 708f4ec..0000000
--- a/arch/arm/mach-iop32x/include/mach/gpio.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_ARCH_IOP32X_GPIO_H
-#define __ASM_ARCH_IOP32X_GPIO_H
-
-#include <asm/hardware/iop3xx-gpio.h>
-
-#endif
diff --git a/arch/arm/mach-iop32x/include/mach/iop32x.h b/arch/arm/mach-iop32x/include/mach/iop32x.h
index 941f363..56ec864 100644
--- a/arch/arm/mach-iop32x/include/mach/iop32x.h
+++ b/arch/arm/mach-iop32x/include/mach/iop32x.h
@@ -19,7 +19,6 @@
  * Peripherals that are shared between the iop32x and iop33x but
  * located at different addresses.
  */
-#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07c4 + (reg))
 #define IOP3XX_TIMER_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07e0 + (reg))
 
 #include <asm/hardware/iop3xx.h>
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index f2cd296..0e1392b 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -37,6 +37,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <mach/time.h>
+#include "gpio-iop32x.h"
 
 /*
  * Until March of 2007 iq31244 platforms and ep80219 platforms shared the
@@ -283,6 +284,7 @@ void ep80219_power_off(void)
 
 static void __init iq31244_init_machine(void)
 {
+	register_iop32x_gpio();
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
 	platform_device_register(&iq31244_flash_device);
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index 015435d..66782ff 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -33,6 +33,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <mach/time.h>
+#include "gpio-iop32x.h"
 
 /*
  * IQ80321 timer tick configuration.
@@ -170,6 +171,7 @@ static struct platform_device iq80321_serial_device = {
 
 static void __init iq80321_init_machine(void)
 {
+	register_iop32x_gpio();
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
 	platform_device_register(&iq80321_flash_device);
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index bc40a97..c1cd80e 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -41,6 +41,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <mach/time.h>
+#include "gpio-iop32x.h"
 
 /*
  * N2100 timer tick configuration.
@@ -345,6 +346,7 @@ device_initcall(n2100_request_gpios);
 
 static void __init n2100_init_machine(void)
 {
+	register_iop32x_gpio();
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&n2100_flash_device);
 	platform_device_register(&n2100_serial_device);
diff --git a/arch/arm/mach-iop33x/include/mach/gpio.h b/arch/arm/mach-iop33x/include/mach/gpio.h
deleted file mode 100644
index ddd55bb..0000000
--- a/arch/arm/mach-iop33x/include/mach/gpio.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_ARCH_IOP33X_GPIO_H
-#define __ASM_ARCH_IOP33X_GPIO_H
-
-#include <asm/hardware/iop3xx-gpio.h>
-
-#endif
diff --git a/arch/arm/mach-iop33x/include/mach/iop33x.h b/arch/arm/mach-iop33x/include/mach/iop33x.h
index a89c0a2..c951226 100644
--- a/arch/arm/mach-iop33x/include/mach/iop33x.h
+++ b/arch/arm/mach-iop33x/include/mach/iop33x.h
@@ -18,7 +18,6 @@
  * Peripherals that are shared between the iop32x and iop33x but
  * located at different addresses.
  */
-#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780 + (reg))
 #define IOP3XX_TIMER_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07d0 + (reg))
 
 #include <asm/hardware/iop3xx.h>
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index c43304a..25741c4 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -122,8 +122,15 @@ static struct platform_device iq80331_flash_device = {
 	.resource	= &iq80331_flash_resource,
 };
 
+static struct resource iq80331_gpio_res[] = {
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780), 0x10),
+};
+
 static void __init iq80331_init_machine(void)
 {
+	platform_device_register_simple("gpio-iop", 0,
+					iq80331_gpio_res,
+					ARRAY_SIZE(iq80331_gpio_res));
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
 	platform_device_register(&iop33x_uart0_device);
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 8192987..a3b56e1 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -122,8 +122,15 @@ static struct platform_device iq80332_flash_device = {
 	.resource	= &iq80332_flash_resource,
 };
 
+static struct resource iq80332_gpio_res[] = {
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780), 0x10),
+};
+
 static void __init iq80332_init_machine(void)
 {
+	platform_device_register_simple("gpio-iop", 0,
+					iq80332_gpio_res,
+					ARRAY_SIZE(iq80332_gpio_res));
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
 	platform_device_register(&iop33x_uart0_device);
diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index 17cc701..24a86b0 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -16,9 +16,23 @@
 #include <linux/errno.h>
 #include <linux/gpio.h>
 #include <linux/export.h>
+#include <linux/platform_device.h>
 
 #define IOP3XX_N_GPIOS	8
 
+#define GPIO_IN			0
+#define GPIO_OUT		1
+#define GPIO_LOW		0
+#define GPIO_HIGH		1
+
+/* Memory base offset */
+static void __iomem *base;
+
+#define IOP3XX_GPIO_REG(reg)	(base + (reg))
+#define IOP3XX_GPOE		(volatile u32 *)IOP3XX_GPIO_REG(0x0000)
+#define IOP3XX_GPID		(volatile u32 *)IOP3XX_GPIO_REG(0x0004)
+#define IOP3XX_GPOD		(volatile u32 *)IOP3XX_GPIO_REG(0x0008)
+
 static void gpio_line_config(int line, int direction)
 {
 	unsigned long flags;
@@ -83,8 +97,26 @@ static struct gpio_chip iop3xx_chip = {
 	.ngpio			= IOP3XX_N_GPIOS,
 };
 
-static int __init iop3xx_gpio_setup(void)
+static int iop3xx_gpio_probe(struct platform_device *pdev)
 {
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = (void *) res->start;
+
 	return gpiochip_add(&iop3xx_chip);
 }
-arch_initcall(iop3xx_gpio_setup);
+
+static struct platform_driver iop3xx_gpio_driver = {
+	.driver = {
+		.name = "gpio-iop",
+		.owner = THIS_MODULE,
+	},
+	.probe = iop3xx_gpio_probe,
+};
+
+static int __init iop3xx_gpio_init(void)
+{
+	return platform_driver_register(&iop3xx_gpio_driver);
+}
+arch_initcall(iop3xx_gpio_init);
-- 
1.8.3.1
