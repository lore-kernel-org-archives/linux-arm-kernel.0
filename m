From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Apr 2011 21:49:01 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
compile a single (working) kernel for these.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx51_defconfig |    2 +-
 arch/arm/mach-mx5/Kconfig       |   51 +++++++++++++++++++++++++-------------
 arch/arm/plat-mxc/Kconfig       |   19 +++++++++++++-
 3 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index d193e76..1260bc0 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -13,7 +13,7 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX5=y
+CONFIG_ARCH_MX51=y
 CONFIG_MACH_MX51_BABBAGE=y
 CONFIG_MACH_MX51_3DS=y
 CONFIG_MACH_EUKREA_CPUIMX51=y
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b3570e6..799fbc4 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -1,11 +1,11 @@
-if ARCH_MX5
-# ARCH_MX50/51/53 are left to mark places where prevent multi-soc in single
+if ARCH_MX503 || ARCH_MX51
+# ARCH_MX5/50/53 are left to mark places where prevent multi-soc in single
 # image. So for most time, SOC_IMX50/51/53 should be used.
 
-config ARCH_MX50
+config ARCH_MX5
 	bool
 
-config ARCH_MX51
+config ARCH_MX50
 	bool
 
 config ARCH_MX53
@@ -19,6 +19,7 @@ config SOC_IMX50
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
+	select ARCH_MX5
 	select ARCH_MX50
 
 config	SOC_IMX51
@@ -29,7 +30,7 @@ config	SOC_IMX51
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
-	select ARCH_MX51
+	select ARCH_MX5
 
 config	SOC_IMX53
 	bool
@@ -37,9 +38,29 @@ config	SOC_IMX53
 	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
+	select ARCH_MX5
 	select ARCH_MX53
 
-comment "MX5 platforms:"
+if ARCH_MX50_SUPPORTED
+#comment "i.MX50 machines:"
+
+config MACH_MX50_RDP
+	bool "Support MX50 reference design platform"
+	depends on BROKEN
+	select SOC_IMX50
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_FEC
+	help
+	  Include support for MX50 reference design platform (RDP) board. This
+	  includes specific configurations for the board and its peripherals.
+
+endif # ARCH_MX50_SUPPORTED
+
+if ARCH_MX51
+comment "i.MX51 machines:"
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
@@ -142,6 +163,11 @@ config MACH_MX51_EFIKASB
 	  Include support for Genesi Efika Smartbook. This includes specific
 	  configurations for the board and its peripherals.
 
+endif # ARCH_MX51
+
+if ARCH_MX53_SUPPORTED
+comment "i.MX53 machines:"
+
 config MACH_MX53_EVK
 	bool "Support MX53 EVK platforms"
 	select SOC_IMX53
@@ -177,17 +203,6 @@ config MACH_MX53_LOCO
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
 
-config MACH_MX50_RDP
-	bool "Support MX50 reference design platform"
-	depends on BROKEN
-	select SOC_IMX50
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select IMX_HAVE_PLATFORM_FEC
-	help
-	  Include support for MX50 reference design platform (RDP) board. This
-	  includes specific configurations for the board and its peripherals.
+endif # ARCH_MX53_SUPPORTED
 
 endif
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index ce6ed5e..aa4234b 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -4,6 +4,12 @@ source "arch/arm/plat-mxc/devices/Kconfig"
 
 menu "Freescale MXC Implementations"
 
+config ARCH_MX50_SUPPORTED
+	bool
+
+config ARCH_MX53_SUPPORTED
+	bool
+
 choice
 	prompt "Set of supported SoCs:"
 	default ARCH_MX3
@@ -36,8 +42,17 @@ config ARCH_MX3
 	  This enables support for machines using Freescale's i.MX31 and i.MX35
 	  processors.
 
-config ARCH_MX5
-	bool "MX5-based"
+config ARCH_MX503
+	bool "i.MX50 + i.MX53"
+	select ARCH_MX50_SUPPORTED
+	select ARCH_MX53_SUPPORTED
+	help
+	  This enables support for machines using Freescale's i.MX50 and i.MX51
+	  processors.
+
+config ARCH_MX51
+	bool "i.MX51"
+	select ARCH_MX51_SUPPORTED
 	help
 	  This enables support for systems based on the Freescale i.MX51 family
 
-- 
1.7.2.3
