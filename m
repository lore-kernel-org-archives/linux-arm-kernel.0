From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:55 +0100
Subject: [PATCH 10/10] ARM: s3c64xx: allow building without board support
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the code for the s3c64xx platform is only used when booting
with ATAGS based board files, but not when using device-tree.

This tries to identify all the s3c64xx specific code that is
unneeded when CONFIG_ATAGS is not set, so we can build a smaller
DT-only kernel if configured that way.

All board support is still left intact but now depends on the
CONFIG_ATAGS symbol that users may intentionally disable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/Kconfig                     | 19 ++++++++++++++-----
 arch/arm/mach-s3c64xx/Makefile                    | 21 ++++++++++++---------
 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h |  3 +++
 arch/arm/plat-samsung/pm.c                        |  4 ----
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index caf71a99389e..7c0c420c3016 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -7,18 +7,17 @@ menuconfig ARCH_S3C64XX
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
-	select ATAGS
 	select CLKSRC_SAMSUNG_PWM
 	select COMMON_CLK_SAMSUNG
-	select GPIO_SAMSUNG
+	select GPIO_SAMSUNG if ATAGS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_TCM
 	select PLAT_SAMSUNG
 	select PM_GENERIC_DOMAINS if PM
-	select S3C_DEV_NAND
-	select S3C_GPIO_TRACK
-	select SAMSUNG_ATAGS
+	select S3C_DEV_NAND if ATAGS
+	select S3C_GPIO_TRACK if ATAGS
+	select SAMSUNG_ATAGS if ATAGS
 	select SAMSUNG_WAKEMASK if PM
 	select SAMSUNG_WDT_RESET
 	help
@@ -111,6 +110,7 @@ config S3C64XX_SETUP_USB_PHY
 
 config MACH_SMDK6400
        bool "SMDK6400"
+	depends on ATAGS
 	select CPU_S3C6400
 	select S3C64XX_SETUP_SDHCI
 	select S3C_DEV_HSMMC1
@@ -121,6 +121,7 @@ config MACH_SMDK6400
 
 config MACH_ANW6410
 	bool "A&W6410"
+	depends on ATAGS
 	select CPU_S3C6410
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C_DEV_FB
@@ -129,6 +130,7 @@ config MACH_ANW6410
 
 config MACH_MINI6410
 	bool "MINI6410"
+	depends on ATAGS
 	select CPU_S3C6410
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_SDHCI
@@ -144,6 +146,7 @@ config MACH_MINI6410
 
 config MACH_REAL6410
 	bool "REAL6410"
+	depends on ATAGS
 	select CPU_S3C6410
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_SDHCI
@@ -159,6 +162,7 @@ config MACH_REAL6410
 
 config MACH_SMDK6410
 	bool "SMDK6410"
+	depends on ATAGS
 	select CPU_S3C6410
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select S3C64XX_SETUP_FB_24BPP
@@ -246,6 +250,7 @@ config SMDK6410_WM1192_EV1
 
 config MACH_NCP
 	bool "NCP"
+	depends on ATAGS
 	select CPU_S3C6410
 	select S3C64XX_SETUP_I2C1
 	select S3C_DEV_HSMMC1
@@ -255,6 +260,7 @@ config MACH_NCP
 
 config MACH_HMT
 	bool "Airgoo HMT"
+	depends on ATAGS
 	select CPU_S3C6410
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C_DEV_FB
@@ -286,18 +292,21 @@ config MACH_SMARTQ
 
 config MACH_SMARTQ5
 	bool "SmartQ 5"
+	depends on ATAGS
 	select MACH_SMARTQ
 	help
 	    Machine support for the SmartQ 5
 
 config MACH_SMARTQ7
 	bool "SmartQ 7"
+	depends on ATAGS
 	select MACH_SMARTQ
 	help
 	    Machine support for the SmartQ 7
 
 config MACH_WLF_CRAGG_6410
 	bool "Wolfson Cragganmore 6410"
+	depends on ATAGS
 	depends on I2C=y
 	select CPU_S3C6410
 	select LEDS_GPIO_REGISTER
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 04cdcd40e23c..256cd5b40c60 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -8,20 +8,21 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
 asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
 
-# Core
+# PM
 
-obj-y				+= common.o
+obj-$(CONFIG_PM)		+= pm.o
+obj-$(CONFIG_PM_SLEEP)		+= sleep.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
-# Core support
+ifdef CONFIG_SAMSUNG_ATAGS
 
-obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
-obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
+obj-$(CONFIG_PM_SLEEP)          += irq-pm.o
 
-# PM
+# Core
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM_SLEEP)		+= irq-pm.o sleep.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+obj-y				+= common.o
+obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
+obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 
 # DMA support
 
@@ -58,4 +59,6 @@ obj-$(CONFIG_MACH_SMARTQ7)		+= mach-smartq7.o
 obj-$(CONFIG_MACH_SMDK6400)		+= mach-smdk6400.o
 obj-$(CONFIG_MACH_SMDK6410)		+= mach-smdk6410.o
 obj-$(CONFIG_MACH_WLF_CRAGG_6410)	+= mach-crag6410.o mach-crag6410-module.o
+endif
+
 obj-$(CONFIG_MACH_S3C64XX_DT)		+= mach-s3c64xx-dt.o
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
index 9c81fac3b2d5..1d3636512e33 100644
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
@@ -14,6 +14,8 @@
 #ifndef GPIO_SAMSUNG_S3C64XX_H
 #define GPIO_SAMSUNG_S3C64XX_H
 
+#ifdef CONFIG_GPIO_SAMSUNG
+
 /* GPIO bank sizes */
 #define S3C64XX_GPIO_A_NR	(8)
 #define S3C64XX_GPIO_B_NR	(7)
@@ -90,5 +92,6 @@ enum s3c_gpio_number {
 /* define the number of gpios we need to the one after the GPQ() range */
 #define GPIO_BOARD_START (S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
 
+#endif /* GPIO_SAMSUNG */
 #endif /* GPIO_SAMSUNG_S3C64XX_H */
 
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 82777c649774..d7803b434732 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -23,14 +23,10 @@
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
 
-#ifdef CONFIG_SAMSUNG_ATAGS
 #include <mach/map.h>
-#ifndef CONFIG_ARCH_EXYNOS
 #include <mach/regs-clock.h>
 #include <mach/regs-irq.h>
-#endif
 #include <mach/irqs.h>
-#endif
 
 #include <asm/irq.h>
 
-- 
2.1.0.rc2
