From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:54 +0000
Subject: [PATCH 11/13] ARM: spear: use multiplatform configuration options.
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spear platform is now multiplatform capable in principle,
and everything still builds when enabled. This slightly rearranges
the Kconfig options for spear to enable both single- and multiplatform
support. As a side-effect, even building the single spear kernel
can now enable spear3xx and spear6xx simultaneously, although
not together with spear13xx, because they are a different archicture
version (v7 instead of v5).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig             | 10 +------
 arch/arm/mach-spear/Kconfig  | 67 ++++++++++++++++++++++++++------------------
 arch/arm/mach-spear/Makefile |  2 ++
 3 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b5ad03..8a108bc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -909,16 +909,8 @@ config ARCH_NOMADIK
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
-config PLAT_SPEAR
+config PLAT_SPEAR_SINGLE
 	bool "ST SPEAr"
-	select ARCH_HAS_CPUFREQ
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 60987a3..2a3de5e 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -2,14 +2,22 @@
 # SPEAr Platform configuration file
 #
 
-if PLAT_SPEAR
+menuconfig PLAT_SPEAR
+	bool "ST SPEAr Family" if ARCH_MULTI_V7 || ARCH_MULTI_V5
+	default PLAT_SPEAR_SINGLE
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
 
-choice
-	prompt "ST SPEAr Family"
-	default ARCH_SPEAR3XX
+if PLAT_SPEAR
 
 config ARCH_SPEAR13XX
-	bool "ST SPEAr13xx with Device Tree"
+	bool "ST SPEAr13xx"
+	depends on ARCH_MULTI_V7 || PLAT_SPEAR_SINGLE
 	select ARM_GIC
 	select CPU_V7
 	select GPIO_SPEAR_SPICS
@@ -20,27 +28,8 @@ config ARCH_SPEAR13XX
 	help
 	  Supports for ARM's SPEAR13XX family
 
-config ARCH_SPEAR3XX
-	bool "ST SPEAr3xx with Device Tree"
-	select ARM_VIC
-	select CPU_ARM926T
-	select PINCTRL
-	select USE_OF
-	help
-	  Supports for ARM's SPEAR3XX family
-
-config ARCH_SPEAR6XX
-	bool "SPEAr6XX"
-	select ARM_VIC
-	select CPU_ARM926T
-	help
-	  Supports for ARM's SPEAR6XX family
-
-endchoice
-
 if ARCH_SPEAR13XX
 
-menu "SPEAr13xx Implementations"
 config MACH_SPEAR1310
 	bool "SPEAr1310 Machine support with Device Tree"
 	select PINCTRL_SPEAR1310
@@ -52,12 +41,22 @@ config MACH_SPEAR1340
 	select PINCTRL_SPEAR1340
 	help
 	  Supports ST SPEAr1340 machine configured via the device-tree
-endmenu
+
 endif #ARCH_SPEAR13XX
 
+config ARCH_SPEAR3XX
+	bool "ST SPEAr3xx"
+	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
+	depends on !ARCH_SPEAR13XX
+	select ARM_VIC
+	select CPU_ARM926T
+	select PINCTRL
+	select USE_OF
+	help
+	  Supports for ARM's SPEAR3XX family
+
 if ARCH_SPEAR3XX
 
-menu "SPEAr3xx Implementations"
 config MACH_SPEAR300
 	bool "SPEAr300 Machine support with Device Tree"
 	select PINCTRL_SPEAR300
@@ -75,10 +74,18 @@ config MACH_SPEAR320
 	select PINCTRL_SPEAR320
 	help
 	  Supports ST SPEAr320 machine configured via the device-tree
-endmenu
 
 endif
 
+config ARCH_SPEAR6XX
+	bool "ST SPEAr6XX"
+	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
+	depends on !ARCH_SPEAR13XX
+	select ARM_VIC
+	select CPU_ARM926T
+	help
+	  Supports for ARM's SPEAR6XX family
+
 config MACH_SPEAR600
 	def_bool y
 	depends on ARCH_SPEAR6XX
@@ -86,4 +93,10 @@ config MACH_SPEAR600
 	help
 	  Supports ST SPEAr600 boards configured via the device-treesource "arch/arm/mach-spear6xx/Kconfig"
 
+config ARCH_SPEAR_AUTO
+	def_bool PLAT_SPEAR_SINGLE
+	depends on !ARCH_SPEAR13XX && !ARCH_SPEAR6XX
+	select ARCH_SPEAR3XX
+
 endif
+
diff --git a/arch/arm/mach-spear/Makefile b/arch/arm/mach-spear/Makefile
index 8a937bf..dc9ce80 100644
--- a/arch/arm/mach-spear/Makefile
+++ b/arch/arm/mach-spear/Makefile
@@ -2,6 +2,8 @@
 # SPEAr Platform specific Makefile
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 # Common support
 obj-y	:= restart.o time.o
 
-- 
1.8.0
