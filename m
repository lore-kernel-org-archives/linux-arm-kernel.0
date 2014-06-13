From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 12:15:56 +0200
Subject: [PATCH] ARM: samsung: make SAMSUNG_DMADEV optional
Message-ID: <5267520.dQojiXcaqm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only remaining driver using the samsung dmadev code is the broken
samsung-ac97 sound driver. However, as found by Russell's autobuilder,
the elaborate dependency chains around it cause problems with
circular dependencies.

This is an attempt to simplify those dependencies by making the
SAMSUNG_DMADEV option user-selectable. I also try to keep the
default settings for all related options unchanged, so we don't
introduce any regressions against earlier testing on linux-next.

In particular, all s3c64xx and s5p* platforms keep selecting the
pl330 and pl08x drivers they require, but the select statement
is now moved towards the main platform option, and it remains
optional by unselecting CONFIG_DMADEVICES.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'd like to apply this into the fixes branch for 3.16. It should
help with the circular dependencies that Russell is seeing, and
also simplify the cleanups we have planned for 3.17.

Any feedback, testing, NAK?

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index d863722..eff95e9 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -18,9 +18,9 @@ config CPU_S3C6410
 	  Enable S3C6410 CPU support
 
 config S3C64XX_PL080
-	bool "S3C64XX DMA using generic PL08x driver"
+	def_bool DMADEVICES
+	select ARM_AMBA
 	select AMBA_PL08X
-	select SAMSUNG_DMADEV
 
 config S3C64XX_SETUP_SDHCI
 	bool
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 6480d5c..a564953 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -9,16 +9,18 @@ if ARCH_S5P64X0
 
 config CPU_S5P6440
 	bool
+	select ARM_AMBA
+	select PL330_DMA if DMADEVICES
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
 	select SAMSUNG_WAKEMASK if PM
 	help
 	  Enable S5P6440 CPU support
 
 config CPU_S5P6450
 	bool
+	select ARM_AMBA
+	select PL330_DMA if DMADEVICES
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
 	select SAMSUNG_WAKEMASK if PM
 	help
 	  Enable S5P6450 CPU support
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index c3d5360..769cb0c 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -9,8 +9,9 @@ if ARCH_S5PC100
 
 config CPU_S5PC100
 	bool
+	select ARM_AMBA
+	select PL330_DMA if DMADEVICES
 	select S5P_EXT_INT
-	select SAMSUNG_DMADEV
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index ede09e6..94fbf3b 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -11,10 +11,11 @@ if ARCH_S5PV210
 
 config CPU_S5PV210
 	bool
+	select ARM_AMBA
+	select PL330_DMA if DMADEVICES
 	select S5P_EXT_INT
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
 	help
 	  Enable S5PV210 CPU support
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f8c1bde..d27908c 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -408,17 +408,16 @@ config SAMSUNG_PM_GPIO
 	  Include legacy GPIO power management code for platforms not using
 	  pinctrl-samsung driver.
 
-endif
-
 config SAMSUNG_DMADEV
-	bool
-	select ARM_AMBA
+	bool "Use legacy Samsung DMA abstraction"
+	depends on CPU_S5PV210 || CPU_S5PC100 || ARCH_S5P64X0 || ARCH_S3C64XX
 	select DMADEVICES
-	select PL330_DMA if (ARCH_EXYNOS5 || ARCH_EXYNOS4 || CPU_S5PV210 || CPU_S5PC100 || \
-					CPU_S5P6450 || CPU_S5P6440)
+	default y
 	help
 	  Use DMA device engine for PL330 DMAC.
 
+endif
+
 config S5P_DEV_MFC
 	bool
 	help
