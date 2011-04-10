From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Apr 2011 21:48:59 +0200
Subject: [PATCH 2/6] ARM: mxc: don't use the symbols in the CPU family choice
	to select others
In-Reply-To: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1302464943-20721-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbols in this choice should only be used to select between the
available machines that can be built into a single kernel. As these sets
(will) differ e.g. depending on ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR
letting them select other symbols makes the logic more complex and needs
to duplicate some things. So let the machines select the corresponding
symbols (indirectly via SOC_XYZ).

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |    3 +++
 arch/arm/mach-mx5/Kconfig |    6 ++++++
 arch/arm/plat-mxc/Kconfig |    4 ----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 13e6f81..7914283 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -43,6 +43,7 @@ config SOC_IMX27
 
 config SOC_IMX31
 	bool
+	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MX31
@@ -50,6 +51,7 @@ config SOC_IMX31
 
 config SOC_IMX35
 	bool
+	select CPU_V6
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select HAVE_EPIT
@@ -66,6 +68,7 @@ config MACH_MXLADS
 config ARCH_MX1ADS
 	bool "MX1ADS platform"
 	select MACH_MXLADS
+	select SOC_IMX1
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 49b5661..b3570e6 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -13,6 +13,8 @@ config ARCH_MX53
 
 config SOC_IMX50
 	bool
+	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
@@ -21,6 +23,8 @@ config SOC_IMX50
 
 config	SOC_IMX51
 	bool
+	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
@@ -29,6 +33,8 @@ config	SOC_IMX51
 
 config	SOC_IMX53
 	bool
+	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MX53
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 97f12a4..b9cf1c5 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -10,7 +10,6 @@ choice
 
 config ARCH_MX1
 	bool "MX1-based"
-	select SOC_IMX1
 	help
 	  This enables support for systems based on the Freescale i.MX1 family
 
@@ -26,14 +25,11 @@ config ARCH_MX25
 
 config ARCH_MX3
 	bool "MX3-based"
-	select CPU_V6
 	help
 	  This enables support for systems based on the Freescale i.MX3 family
 
 config ARCH_MX5
 	bool "MX5-based"
-	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
 	help
 	  This enables support for systems based on the Freescale i.MX51 family
 
-- 
1.7.2.3
