From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  3 Oct 2011 10:57:06 +0800
Subject: [PATCH v5 8/8] arm/imx: merge i.MX3 and i.MX6
In-Reply-To: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
References: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317610626-24357-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The patch merges the build of imx3 and imx6.  The Kconfig symbol
ARCH_IMX_V6_V7 is introduced to replace ARCH_MX3 and ARCH_MX6.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Makefile               |    3 +--
 arch/arm/mach-imx/Kconfig       |    7 +++----
 arch/arm/mach-imx/Makefile.boot |   10 +++++++---
 arch/arm/mm/Kconfig             |    4 ++--
 arch/arm/plat-mxc/Kconfig       |   18 +++++++-----------
 5 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 193439e..4e98937 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -158,9 +158,8 @@ machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
-machine-$(CONFIG_ARCH_MX3)		:= imx
+machine-$(CONFIG_ARCH_IMX_V6_V7)	:= imx
 machine-$(CONFIG_ARCH_MX5)		:= mx5
-machine-$(CONFIG_ARCH_MX6)		:= imx
 machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3852f45..27355cb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -74,6 +74,7 @@ config SOC_IMX31
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MX31
 	select MXC_AVIC
+	select SMP_ON_UP if SMP
 
 config SOC_IMX35
 	bool
@@ -83,6 +84,7 @@ config SOC_IMX35
 	select HAVE_EPIT
 	select ARCH_MX35
 	select MXC_AVIC
+	select SMP_ON_UP if SMP
 
 
 if ARCH_IMX_V4_V5
@@ -351,7 +353,7 @@ config MACH_IMX27IPCAM
 
 endif
 
-if ARCH_MX3
+if ARCH_IMX_V6_V7
 
 comment "MX31 platforms:"
 
@@ -601,9 +603,6 @@ config MACH_VPR200
 	  Include support for VPR200 platform. This includes specific
 	  configurations for the board and its peripherals.
 
-endif
-
-if ARCH_MX6
 comment "i.MX6 family:"
 
 config SOC_IMX6Q
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 22d8588..c349a96 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -14,9 +14,13 @@ zreladdr-$(CONFIG_MACH_MX27)	+= 0xA0008000
 params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
 initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
 
-zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
-params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
-initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
+zreladdr-$(CONFIG_SOC_IMX31)	+= 0x80008000
+params_phys-$(CONFIG_SOC_IMX31)	:= 0x80000100
+initrd_phys-$(CONFIG_SOC_IMX31)	:= 0x80800000
+
+zreladdr-$(CONFIG_SOC_IMX35)	+= 0x80008000
+params_phys-$(CONFIG_SOC_IMX35)	:= 0x80000100
+initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
 
 zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c3ce146..9ab5be0 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -819,10 +819,10 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
+		   REALVIEW_EB_A9MP || ARCH_IMX_V6_V7 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
 		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
-		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_MX6
+		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 058d1c5..2704951 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -6,7 +6,7 @@ menu "Freescale MXC Implementations"
 
 choice
 	prompt "Freescale CPU family:"
-	default ARCH_MX3
+	default ARCH_IMX_V6_V7
 
 config ARCH_IMX_V4_V5
 	bool "i.MX1, i.MX21, i.MX25, i.MX27"
@@ -16,10 +16,13 @@ config ARCH_IMX_V4_V5
 	  This enables support for systems based on the Freescale i.MX ARMv4
 	  and ARMv5 SoCs
 
-config ARCH_MX3
-	bool "MX3-based"
+config ARCH_IMX_V6_V7
+	bool "i.MX3, i.MX6"
+	select AUTO_ZRELADDR if !ZBOOT_ROM
+	select ARM_PATCH_PHYS_VIRT
 	help
-	  This enables support for systems based on the Freescale i.MX3 family
+	  This enables support for systems based on the Freescale i.MX3 and i.MX6
+	  family.
 
 config ARCH_MX5
 	bool "i.MX50, i.MX51, i.MX53"
@@ -29,13 +32,6 @@ config ARCH_MX5
 	  This enables support for machines using Freescale's i.MX50 and i.MX51
 	  processors.
 
-config ARCH_MX6
-	bool "i.MX6"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
-	select ARM_PATCH_PHYS_VIRT
-	help
-	  This enables support for systems based on the Freescale i.MX6 family
-
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
-- 
1.7.4.1
