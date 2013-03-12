From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:54 +0100
Subject: [PATCH v2 11/13] ARM: spear: use multiplatform configuration options.
In-Reply-To: <1363106816-9603-1-git-send-email-arnd@arndb.de>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
Message-ID: <1363106816-9603-12-git-send-email-arnd@arndb.de>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/Kconfig                    | 10 +-----
 arch/arm/configs/spear3xx_defconfig |  2 ++
 arch/arm/configs/spear6xx_defconfig |  1 +
 arch/arm/mach-spear/Kconfig         | 67 ++++++++++++++++++++++---------------
 arch/arm/mach-spear/Makefile        |  2 ++
 5 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4d2b1cf..4b82c7b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -933,16 +933,8 @@ config ARCH_NOMADIK
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
 
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 865980c..7ff23a0 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -6,7 +6,9 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
+CONFIG_ARCH_SPEAR3XX=y
 CONFIG_MACH_SPEAR300=y
 CONFIG_MACH_SPEAR310=y
 CONFIG_MACH_SPEAR320=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index a2a1265..7822980 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -6,6 +6,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR6XX=y
 CONFIG_BINFMT_MISC=y
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index e288df9..4c52ee2 100644
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
 	select ARCH_HAVE_CPUFREQ
 	select ARM_GIC
 	select CPU_V7
@@ -21,27 +29,8 @@ config ARCH_SPEAR13XX
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
@@ -53,12 +42,22 @@ config MACH_SPEAR1340
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
@@ -76,10 +75,18 @@ config MACH_SPEAR320
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
@@ -87,4 +94,10 @@ config MACH_SPEAR600
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
1.8.1.2
