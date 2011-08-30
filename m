From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Aug 2011 21:27:23 +0900
Subject: [PATCH 1/7 (RE-SEND)] gpio/s3c24xx: move gpio driver into
	drivers/gpio/
In-Reply-To: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314707249-12241-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/Kconfig                      |    6 --
 arch/arm/mach-s3c2410/Makefile                     |    1 -
 arch/arm/mach-s3c2412/Kconfig                      |    1 -
 arch/arm/mach-s3c2412/Makefile                     |    1 -
 arch/arm/mach-s3c2440/Kconfig                      |    2 -
 arch/arm/plat-s3c24xx/Makefile                     |    2 -
 arch/arm/plat-s3c24xx/gpio.c                       |   96 --------------------
 drivers/gpio/Kconfig                               |    4 +
 drivers/gpio/Makefile                              |    1 +
 .../gpiolib.c => drivers/gpio/gpio-s3c24xx.c       |   70 +++++++++++++--
 10 files changed, 67 insertions(+), 117 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/gpio.c
 rename arch/arm/plat-s3c24xx/gpiolib.c => drivers/gpio/gpio-s3c24xx.c (78%)

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 7245a55..3700cf3 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -8,7 +8,6 @@ config CPU_S3C2410
 	select CPU_ARM920T
 	select S3C_GPIO_PULL_UP
 	select S3C2410_CLOCK
-	select S3C2410_GPIO
 	select CPU_LLSERIAL_S3C2410
 	select S3C2410_PM if PM
 	select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
@@ -28,11 +27,6 @@ config S3C2410_PM
 	help
 	  Power Management code common to S3C2410 and better
 
-config S3C2410_GPIO
-	bool
-	help
-	  GPIO code for S3C2410 and similar processors
-
 config SIMTEC_NOR
 	bool
 	help
diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
index 8169535..782fd81 100644
--- a/arch/arm/mach-s3c2410/Makefile
+++ b/arch/arm/mach-s3c2410/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_PM)	+= pm.o sleep.o
-obj-$(CONFIG_S3C2410_GPIO)	+= gpio.o
 obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpu-freq.o
 obj-$(CONFIG_S3C2410_PLLTABLE)	+= pll.o
 
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index c2cf4e5..b8b9029 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -9,7 +9,6 @@ config CPU_S3C2412
 	select CPU_LLSERIAL_S3C2440
 	select S3C2412_PM if PM
 	select S3C2412_DMA if S3C2410_DMA
-	select S3C2410_GPIO
 	help
 	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c2412/Makefile b/arch/arm/mach-s3c2412/Makefile
index 6c48a91..7e4d95f 100644
--- a/arch/arm/mach-s3c2412/Makefile
+++ b/arch/arm/mach-s3c2412/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 obj-$(CONFIG_CPU_S3C2412)	+= s3c2412.o
 obj-$(CONFIG_CPU_S3C2412)	+= irq.o
 obj-$(CONFIG_CPU_S3C2412)	+= clock.o
-obj-$(CONFIG_CPU_S3C2412)	+= gpio.o
 obj-$(CONFIG_S3C2412_DMA)	+= dma.o
 obj-$(CONFIG_S3C2412_PM)	+= pm.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep.o
diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 50825a3..c461fb8 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -8,7 +8,6 @@ config CPU_S3C2440
 	select S3C_GPIO_PULL_UP
 	select S3C2410_CLOCK
 	select S3C2410_PM if PM
-	select S3C2410_GPIO
 	select S3C2440_DMA if S3C2410_DMA
 	select CPU_S3C244X
 	select CPU_LLSERIAL_S3C2440
@@ -20,7 +19,6 @@ config CPU_S3C2442
 	select CPU_ARM920T
 	select S3C_GPIO_PULL_DOWN
 	select S3C2410_CLOCK
-	select S3C2410_GPIO
 	select S3C2410_PM if PM
 	select CPU_S3C244X
 	select CPU_LLSERIAL_S3C2440
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 0291bd6..e4f4649 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -15,8 +15,6 @@ obj-				:=
 obj-y				+= cpu.o
 obj-y				+= irq.o
 obj-y				+= devs.o
-obj-y				+= gpio.o
-obj-y				+= gpiolib.o
 obj-y				+= clock.o
 obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
 
diff --git a/arch/arm/plat-s3c24xx/gpio.c b/arch/arm/plat-s3c24xx/gpio.c
deleted file mode 100644
index 2f3d7c0..0000000
--- a/arch/arm/plat-s3c24xx/gpio.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/gpio.c
- *
- * Copyright (c) 2004-2010 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX GPIO support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/gpio-fns.h>
-#include <asm/irq.h>
-
-#include <mach/regs-gpio.h>
-
-#include <plat/gpio-core.h>
-
-/* gpiolib wrappers until these are totally eliminated */
-
-void s3c2410_gpio_pullup(unsigned int pin, unsigned int to)
-{
-	int ret;
-
-	WARN_ON(to);	/* should be none of these left */
-
-	if (!to) {
-		/* if pull is enabled, try first with up, and if that
-		 * fails, try using down */
-
-		ret = s3c_gpio_setpull(pin, S3C_GPIO_PULL_UP);
-		if (ret)
-			s3c_gpio_setpull(pin, S3C_GPIO_PULL_DOWN);
-	} else {
-		s3c_gpio_setpull(pin, S3C_GPIO_PULL_NONE);
-	}
-}
-EXPORT_SYMBOL(s3c2410_gpio_pullup);
-
-void s3c2410_gpio_setpin(unsigned int pin, unsigned int to)
-{
-	/* do this via gpiolib until all users removed */
-
-	gpio_request(pin, "temporary");
-	gpio_set_value(pin, to);
-	gpio_free(pin);
-}
-
-EXPORT_SYMBOL(s3c2410_gpio_setpin);
-
-unsigned int s3c2410_gpio_getpin(unsigned int pin)
-{
-	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
-	unsigned long offs = pin - chip->chip.base;
-
-	return __raw_readl(chip->base + 0x04) & (1<< offs);
-}
-
-EXPORT_SYMBOL(s3c2410_gpio_getpin);
-
-unsigned int s3c2410_modify_misccr(unsigned int clear, unsigned int change)
-{
-	unsigned long flags;
-	unsigned long misccr;
-
-	local_irq_save(flags);
-	misccr = __raw_readl(S3C24XX_MISCCR);
-	misccr &= ~clear;
-	misccr ^= change;
-	__raw_writel(misccr, S3C24XX_MISCCR);
-	local_irq_restore(flags);
-
-	return misccr;
-}
-
-EXPORT_SYMBOL(s3c2410_modify_misccr);
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d539efd..5654e1b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -135,6 +135,10 @@ config GPIO_PLAT_SAMSUNG
 	def_bool y
 	depends on SAMSUNG_GPIOLIB_4BIT
 
+config GPIO_S3C24XX
+	def_bool y
+	depends on PLAT_S3C24XX
+
 config GPIO_S5PC100
 	def_bool y
 	depends on CPU_S5PC100
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9588948..c7f1c00 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 
 obj-$(CONFIG_GPIO_PLAT_SAMSUNG)	+= gpio-plat-samsung.o
+obj-$(CONFIG_GPIO_S3C24XX)	+= gpio-s3c24xx.o
 obj-$(CONFIG_GPIO_S5PC100)	+= gpio-s5pc100.o
 obj-$(CONFIG_GPIO_S5PV210)	+= gpio-s5pv210.o
 
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/drivers/gpio/gpio-s3c24xx.c
similarity index 78%
rename from arch/arm/plat-s3c24xx/gpiolib.c
rename to drivers/gpio/gpio-s3c24xx.c
index 243b641..ff61031 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/drivers/gpio/gpio-s3c24xx.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/gpiolib.c
- *
+/*
  * Copyright (c) 2008-2010 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -19,16 +18,17 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <asm/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio-fns.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <mach/hardware.h>
-#include <asm/irq.h>
 #include <plat/pm.h>
 
-#include <mach/regs-gpio.h>
-
 static int s3c24xx_gpiolib_banka_input(struct gpio_chip *chip, unsigned offset)
 {
 	return -EINVAL;
@@ -210,7 +210,6 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 	},
 };
 
-
 static __init int s3c24xx_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip = s3c24xx_gpios;
@@ -225,5 +224,60 @@ static __init int s3c24xx_gpiolib_init(void)
 
 	return 0;
 }
-
 core_initcall(s3c24xx_gpiolib_init);
+
+/* gpiolib wrappers until these are totally eliminated */
+
+void s3c2410_gpio_pullup(unsigned int pin, unsigned int to)
+{
+	int ret;
+
+	WARN_ON(to);	/* should be none of these left */
+
+	if (!to) {
+		/* if pull is enabled, try first with up, and if that
+		 * fails, try using down */
+
+		ret = s3c_gpio_setpull(pin, S3C_GPIO_PULL_UP);
+		if (ret)
+			s3c_gpio_setpull(pin, S3C_GPIO_PULL_DOWN);
+	} else {
+		s3c_gpio_setpull(pin, S3C_GPIO_PULL_NONE);
+	}
+}
+EXPORT_SYMBOL(s3c2410_gpio_pullup);
+
+void s3c2410_gpio_setpin(unsigned int pin, unsigned int to)
+{
+	/* do this via gpiolib until all users removed */
+
+	gpio_request(pin, "temporary");
+	gpio_set_value(pin, to);
+	gpio_free(pin);
+}
+EXPORT_SYMBOL(s3c2410_gpio_setpin);
+
+unsigned int s3c2410_gpio_getpin(unsigned int pin)
+{
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	unsigned long offs = pin - chip->chip.base;
+
+	return __raw_readl(chip->base + 0x04) & (1<< offs);
+}
+EXPORT_SYMBOL(s3c2410_gpio_getpin);
+
+unsigned int s3c2410_modify_misccr(unsigned int clear, unsigned int change)
+{
+	unsigned long flags;
+	unsigned long misccr;
+
+	local_irq_save(flags);
+	misccr = __raw_readl(S3C24XX_MISCCR);
+	misccr &= ~clear;
+	misccr ^= change;
+	__raw_writel(misccr, S3C24XX_MISCCR);
+	local_irq_restore(flags);
+
+	return misccr;
+}
+EXPORT_SYMBOL(s3c2410_modify_misccr);
-- 
1.7.1
