From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 13:11:53 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110303121153.GJ29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 06:23:05PM +0100, Uwe Kleine-K?nig wrote:
> The only use of selecting MX2-based before was to get the choice to select
> between i.MX21 and i.MX27. So better provide this choice directly.
> 
> Note that this has an influence on reduced i.MX21 configs because the
> former default "MACH_MX21" for the "CPUs" choice makes MACH_MX21 not
> appear in the reduced config and so the default for "Freescale CPU family:"
> (i.e. ARCH_MX3) is used now.  mx21_defconfig is adapted not to be affected
> by this problem.

Do we really want to do this? Now that we are likely to get phys/virt
runtime patching in the next merge window I'd rather do something like
this:

8<--------------------------------------
[PATCH] ARM i.MX: Allow to compile SoCs contained in arch-imx in a single kernel

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |  112 ++++++++++++++++++++++++++++++--------------
 arch/arm/plat-mxc/Kconfig |   17 +------
 2 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5eec099..1c6d8d5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,8 +1,28 @@
+if ARCH_IMX
+
 config IMX_HAVE_DMA_V1
 	bool
 
+# obsolete: The MACH_MX/ARCH_MX should go away once the users
+# are moved to the corresponding SOC_IMX_* in the tree
+config MACH_MX21
+	bool
+
+config MACH_MX27
+	bool
+
+config ARCH_MX25
+	bool
+
+config ARCH_MX2
+	bool
+
+config ARCH_MX1
+	bool
+
 config SOC_IMX1
 	bool
+	select ARCH_MX1
 	select CPU_ARM920T
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
@@ -10,6 +30,8 @@ config SOC_IMX1
 
 config SOC_IMX21
 	bool
+	select MACH_MX21
+	select ARCH_MX2
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -18,6 +40,7 @@ config SOC_IMX21
 
 config SOC_IMX25
 	bool
+	select ARCH_MX25
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MXC_IOMUX_V3
@@ -25,13 +48,61 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select ARCH_MX2
+	select MACH_MX27
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
 
-if ARCH_MX1
+config IMX_MULTI_ARCHITECTURE
+	bool "i.MX multi architecture support"
+	depends on ARM_PATCH_PHYS_VIRT
+	depends on AUTO_ZRELADDR
+
+if IMX_MULTI_ARCHITECTURE
+config ARCH_IMX_MULTI_MX1
+	select SOC_IMX1
+	bool "i.MX1 support"
+
+config ARCH_IMX_MULTI_MX21
+	select SOC_IMX21
+	bool "i.MX21 support"
+
+config ARCH_IMX_MULTI_MX25
+	select SOC_IMX25
+	bool "i.MX25 support"
+
+config ARCH_IMX_MULTI_MX27
+	select SOC_IMX27
+	bool "i.MX27 support"
+endif
+
+if !IMX_MULTI_ARCHITECTURE
+comment "enable ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR to get"
+comment "support for multiple i.MX Families"
+choice
+	prompt "Select i.MX CPU"
+config ARCH_IMX_HAS_MX1
+	select SOC_IMX1
+	bool "i.MX1 support"
+
+config ARCH_IMX_HAS_MX21
+	select SOC_IMX21
+	bool "i.MX21 support"
+
+config ARCH_IMX_HAS_MX25
+	select SOC_IMX25
+	bool "i.MX25 support"
+
+config ARCH_IMX_HAS_MX27
+	select SOC_IMX27
+	bool "i.MX27 support"
+endchoice
+endif
+
+if SOC_IMX1
 
 comment "MX1 platforms:"
 config MACH_MXLADS
@@ -53,33 +124,12 @@ config MACH_SCB9328
 
 endif
 
-if ARCH_MX2
-
-choice
-	prompt "CPUs:"
-	default MACH_MX21
-
-config MACH_MX21
-	bool "i.MX21 support"
-	help
-	  This enables support for Freescale's MX2 based i.MX21 processor.
-
-config MACH_MX27
-	bool "i.MX27 support"
-	help
-	  This enables support for Freescale's MX2 based i.MX27 processor.
-
-endchoice
-
-endif
-
-if MACH_MX21
+if SOC_IMX21
 
 comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
-	select SOC_IMX21
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -90,13 +140,12 @@ config MACH_MX21ADS
 
 endif
 
-if ARCH_MX25
+if SOC_IMX25
 
 comment "MX25 platforms:"
 
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
-	select SOC_IMX25
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
@@ -110,7 +159,6 @@ config MACH_MX25_3DS
 
 config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
-	select SOC_IMX25
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
@@ -138,13 +186,12 @@ endchoice
 
 endif
 
-if MACH_MX27
+if SOC_IMX27
 
 comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -157,7 +204,6 @@ config MACH_MX27ADS
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -187,7 +233,6 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -236,7 +281,6 @@ endchoice
 
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -253,7 +297,6 @@ config MACH_MX27_3DS
 
 config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -265,7 +308,6 @@ config MACH_IMX27_VISSTRIM_M10
 
 config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
@@ -274,7 +316,6 @@ config MACH_IMX27LITE
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
@@ -293,7 +334,6 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -305,7 +345,6 @@ config MACH_MXT_TD60
 
 config MACH_IMX27IPCAM
 	bool "IMX27 IPCAM platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
@@ -313,3 +352,4 @@ config MACH_IMX27IPCAM
 	  configurations for the board and its peripherals.
 
 endif
+endif
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 389f217..646fee6 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -8,21 +8,10 @@ choice
 	prompt "Freescale CPU family:"
 	default ARCH_MX3
 
-config ARCH_MX1
-	bool "MX1-based"
-	select SOC_IMX1
+config ARCH_IMX
+	bool "i.MX1, i.MX21, i.MX25, i.MX27 based"
 	help
-	  This enables support for systems based on the Freescale i.MX1 family
-
-config ARCH_MX2
-	bool "MX2-based"
-	help
-	  This enables support for systems based on the Freescale i.MX2 family
-
-config ARCH_MX25
-	bool "MX25-based"
-	help
-	  This enables support for systems based on the Freescale i.MX25 family
+	  This enables support for systems based on the Freescale i.MX1/2 family
 
 config ARCH_MX3
 	bool "MX3-based"
-- 
1.7.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
