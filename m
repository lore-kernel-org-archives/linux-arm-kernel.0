From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:35 +0900
Subject: [PATCH 01/12] ARM: S3C24XX: remove unused spi gpio setup functions
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

A grep through the kernel source revealed that neither the
config-options nor the defined functions are used anywhere
in the kernel.

There was also no activity in this regard through the last kernel
releases, so it seems this situation will not change in the future.

Therefore this patch removes this seemingly dead code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/spi.h     |   11 -------
 arch/arm/plat-s3c24xx/Kconfig                |   20 -------------
 arch/arm/plat-s3c24xx/Makefile               |    6 ----
 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c |   36 ------------------------
 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c   |   38 --------------------------
 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c    |   36 ------------------------
 6 files changed, 0 insertions(+), 147 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
 delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c
 delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c

diff --git a/arch/arm/mach-s3c2410/include/mach/spi.h b/arch/arm/mach-s3c2410/include/mach/spi.h
index 4d95883..2a686c0 100644
--- a/arch/arm/mach-s3c2410/include/mach/spi.h
+++ b/arch/arm/mach-s3c2410/include/mach/spi.h
@@ -24,15 +24,4 @@ struct s3c2410_spi_info {
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
-/* Standard setup / suspend routines for SPI GPIO pins. */
-
-extern void s3c24xx_spi_gpiocfg_bus0_gpe11_12_13(struct s3c2410_spi_info *spi,
-						 int enable);
-
-extern void s3c24xx_spi_gpiocfg_bus1_gpg5_6_7(struct s3c2410_spi_info *spi,
-					      int enable);
-
-extern void s3c24xx_spi_gpiocfg_bus1_gpd8_9_10(struct s3c2410_spi_info *spi,
-					       int enable);
-
 #endif /* __ASM_ARCH_SPI_H */
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index d8973ac..6b1d918 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -98,26 +98,6 @@ config S3C2410_DMA_DEBUG
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.
 
-# SPI default pin configuration code
-
-config S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13
-	bool
-	help
-	  SPI GPIO configuration code for BUS0 when connected to
-	  GPE11, GPE12 and GPE13.
-
-config S3C24XX_SPI_BUS1_GPG5_GPG6_GPG7
-	bool
-	help
-	  SPI GPIO configuration code for BUS 1 when connected to
-	  GPG5, GPG6 and GPG7.
-
-config S3C24XX_SPI_BUS1_GPD8_GPD9_GPD10
-	bool
-	help
-	  SPI GPIO configuration code for BUS 1 when connected to
-	  GPD8, GPD9 and GPD10.
-
 # common code for s3c24xx based machines, such as the SMDKs.
 
 # cpu frequency items common between s3c2410 and s3c2440/s3c2442
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index b2b0112..7cefd7f 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -38,12 +38,6 @@ obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
 obj-$(CONFIG_ARCH_S3C2410)	+= setup-i2c.o
 obj-$(CONFIG_S3C2410_SETUP_TS)	+= setup-ts.o
 
-# SPI gpio central GPIO functions
-
-obj-$(CONFIG_S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13) += spi-bus0-gpe11_12_13.o
-obj-$(CONFIG_S3C24XX_SPI_BUS1_GPG5_GPG6_GPG7)    += spi-bus1-gpg5_6_7.o
-obj-$(CONFIG_S3C24XX_SPI_BUS1_GPD8_GPD9_GPD10)	 += spi-bus1-gpd8_9_10.o
-
 # machine common support
 
 obj-$(CONFIG_MACH_SMDK)		+= common-smdk.o
diff --git a/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c b/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
deleted file mode 100644
index 704175b..0000000
--- a/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX SPI - gpio configuration for bus 0 on gpe11,12,13
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
-*/
-
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-
-#include <mach/spi.h>
-#include <mach/regs-gpio.h>
-
-void s3c24xx_spi_gpiocfg_bus0_gpe11_12_13(struct s3c2410_spi_info *spi,
-					  int enable)
-{
-	if (enable) {
-		s3c_gpio_cfgpin(S3C2410_GPE(13), S3C2410_GPE13_SPICLK0);
-		s3c_gpio_cfgpin(S3C2410_GPE(12), S3C2410_GPE12_SPIMOSI0);
-		s3c_gpio_cfgpin(S3C2410_GPE(11), S3C2410_GPE11_SPIMISO0);
-		s3c2410_gpio_pullup(S3C2410_GPE(11), 0);
-		s3c2410_gpio_pullup(S3C2410_GPE(13), 0);
-	} else {
-		s3c_gpio_cfgpin(S3C2410_GPE(13), S3C2410_GPIO_INPUT);
-		s3c_gpio_cfgpin(S3C2410_GPE(11), S3C2410_GPIO_INPUT);
-		s3c_gpio_setpull(S3C2410_GPE(11), S3C_GPIO_PULL_NONE);
-		s3c_gpio_setpull(S3C2410_GPE(12), S3C_GPIO_PULL_NONE);
-		s3c_gpio_setpull(S3C2410_GPE(13), S3C_GPIO_PULL_NONE);
-	}
-}
diff --git a/arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c b/arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c
deleted file mode 100644
index 72457af..0000000
--- a/arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/spi-bus0-gpd8_9_10.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX SPI - gpio configuration for bus 1 on gpd8,9,10
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
-*/
-
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-
-#include <mach/spi.h>
-#include <mach/regs-gpio.h>
-
-void s3c24xx_spi_gpiocfg_bus1_gpd8_9_10(struct s3c2410_spi_info *spi,
-					int enable)
-{
-
-	printk(KERN_INFO "%s(%d)\n", __func__, enable);
-	if (enable) {
-		s3c_gpio_cfgpin(S3C2410_GPD(10), S3C2440_GPD10_SPICLK1);
-		s3c_gpio_cfgpin(S3C2410_GPD(9), S3C2440_GPD9_SPIMOSI1);
-		s3c_gpio_cfgpin(S3C2410_GPD(8), S3C2440_GPD8_SPIMISO1);
-		s3c2410_gpio_pullup(S3C2410_GPD(10), 0);
-		s3c2410_gpio_pullup(S3C2410_GPD(9), 0);
-	} else {
-		s3c_gpio_cfgpin(S3C2410_GPD(8), S3C2410_GPIO_INPUT);
-		s3c_gpio_cfgpin(S3C2410_GPD(9), S3C2410_GPIO_INPUT);
-		s3c_gpio_setpull(S3C2410_GPD(10), S3C_GPIO_PULL_NONE);
-		s3c_gpio_setpull(S3C2410_GPD(9), S3C_GPIO_PULL_NONE);
-		s3c_gpio_setpull(S3C2410_GPD(8), S3C_GPIO_PULL_NONE);
-	}
-}
diff --git a/arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c b/arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c
deleted file mode 100644
index c3972b6..0000000
--- a/arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/spi-bus0-gpg5_6_7.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C24XX SPI - gpio configuration for bus 1 on gpg5,6,7
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
-*/
-
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-
-#include <mach/spi.h>
-#include <mach/regs-gpio.h>
-
-void s3c24xx_spi_gpiocfg_bus1_gpg5_6_7(struct s3c2410_spi_info *spi,
-				       int enable)
-{
-	if (enable) {
-		s3c_gpio_cfgpin(S3C2410_GPG(7), S3C2410_GPG7_SPICLK1);
-		s3c_gpio_cfgpin(S3C2410_GPG(6), S3C2410_GPG6_SPIMOSI1);
-		s3c_gpio_cfgpin(S3C2410_GPG(5), S3C2410_GPG5_SPIMISO1);
-		s3c2410_gpio_pullup(S3C2410_GPG(5), 0);
-		s3c2410_gpio_pullup(S3C2410_GPG(6), 0);
-	} else {
-		s3c_gpio_cfgpin(S3C2410_GPG(7), S3C2410_GPIO_INPUT);
-		s3c_gpio_cfgpin(S3C2410_GPG(5), S3C2410_GPIO_INPUT);
-		s3c_gpio_setpull(S3C2410_GPG(5), S3C_GPIO_PULL_NONE);
-		s3c_gpio_setpull(S3C2410_GPG(6), S3C_GPIO_PULL_NONE);
-		s3c_gpio_setpull(S3C2410_GPG(7), S3C_GPIO_PULL_NONE);
-	}
-}
-- 
1.7.4.4
