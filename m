From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:33 +0100
Subject: [PATCH 23/23] ARM: exynos: experimental multiplatform support
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-24-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the exynos platform to be selected as part
of a CONFIG_ARCH_MULTIPLATFORM kernel. This still
breaks a number of drivers, which we will have to
enable again one by one. Single-platform configurations
should not be impacted by this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig               | 11 ++---------
 arch/arm/mach-exynos/Kconfig   | 21 +++++++++++++++++----
 arch/arm/mach-exynos/Makefile  |  1 +
 arch/arm/plat-samsung/Kconfig  |  5 +++++
 arch/arm/plat-samsung/Makefile |  3 +++
 drivers/video/Kconfig          |  2 +-
 drivers/watchdog/Kconfig       |  1 +
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..56b62f5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -854,18 +854,11 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_EXYNOS
+config ARCH_EXYNOS_SINGLE
 	bool "Samsung EXYNOS"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SPARSEMEM_ENABLE
-	select CLKDEV_LOOKUP
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
@@ -1650,7 +1643,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
+	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 3291a72..1f2e7dc 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -7,6 +7,19 @@
 
 # Configuration options for the EXYNOS4
 
+config ARCH_EXYNOS
+	bool "Samsung EXYNOS" if ARCH_MULTI_V7
+	default ARCH_EXYNOS_SINGLE
+	select CLKDEV_LOOKUP
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
+	help
+	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
+
 if ARCH_EXYNOS
 
 menu "SAMSUNG EXYNOS SoCs Support"
@@ -35,7 +48,7 @@ config CPU_EXYNOS4210
 	select PM_GENERIC_DOMAINS
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS4210 CPU support
 
@@ -45,7 +58,7 @@ config SOC_EXYNOS4212
 	depends on ARCH_EXYNOS4
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS4212 SoC support
 
@@ -53,7 +66,7 @@ config SOC_EXYNOS4412
 	bool "SAMSUNG EXYNOS4412"
 	default y
 	depends on ARCH_EXYNOS4
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS4412 SoC support
 
@@ -64,7 +77,7 @@ config SOC_EXYNOS5250
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
 	select S5P_DEV_MFC
-	select SAMSUNG_DMADEV
+	select SAMSUNG_DMADEV if ARCH_EXYNOS_SINGLE
 	help
 	  Enable EXYNOS5250 SoC support
 
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index e2f1742..646b79e 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -4,6 +4,7 @@
 #		http://www.samsung.com/
 #
 # Licensed under GPLv2
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
 
 obj-y				:=
 obj-m				:=
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index a9d5216..b6669db 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -13,6 +13,10 @@ config PLAT_SAMSUNG
 	help
 	  Base platform code for all Samsung SoC based systems
 
+config PLAT_SAMSUNG_SINGLE
+	def_bool PLAT_SAMSUNG && !ARCH_MULTIPLATFORM
+	
+
 config PLAT_S5P
 	bool
 	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
@@ -178,6 +182,7 @@ config S5P_DEV_UART
 
 config S3C_ADC
 	bool "ADC common driver support"
+	depends on PLAT_SAMSUNG_SINGLE
 	help
 	  Core support for the ADC block found in the Samsung SoC systems
 	  for drivers such as the touchscreen and hwmon to use to share
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 3a7c64d..78f560e 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -4,6 +4,9 @@
 #
 # Licensed under GPLv2
 
+ccflags-$(CONFIG_ARCH_MULTI_V7) += -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARCH_EXYNOS)	+= -I$(srctree)/arch/arm/mach-exynos/include
+
 obj-y				:=
 obj-m				:=
 obj-n				:= dummy.o
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..05a4a59 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2048,7 +2048,7 @@ config FB_TMIO_ACCELL
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
 	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX || ARCH_S5P64X0 || \
-		ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
+		ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS_SINGLE)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9fcc70c..f39337b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -187,6 +187,7 @@ config HAVE_S3C2410_WATCHDOG
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
 	depends on HAVE_S3C2410_WATCHDOG
+	depends on PLAT_SAMSUNG_SINGLE
 	select WATCHDOG_CORE
 	help
 	  Watchdog timer block in the Samsung SoCs. This will reboot
-- 
1.8.1.2
