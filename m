From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 10:03:04 +0200
Subject: [PATCH 1/4] ARM i.MX: allow to compile together ARMv4 and ARMv5 based
	SoCs
In-Reply-To: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
References: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314172987-10349-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this we need CONFIG_AUTO_ZRELADDR and CONFIG_ARM_PATCH_PHYS_VIRT.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/Makefile                       |    4 +--
 arch/arm/mach-imx/Kconfig               |   50 ++++++++++--------------------
 arch/arm/plat-mxc/Kconfig               |   19 ++++--------
 arch/arm/plat-mxc/include/mach/memory.h |   10 +-----
 4 files changed, 25 insertions(+), 58 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 70c424e..9260c29 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -154,9 +154,7 @@ machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-machine-$(CONFIG_ARCH_MX1)		:= imx
-machine-$(CONFIG_ARCH_MX2)		:= imx
-machine-$(CONFIG_ARCH_MX25)		:= imx
+machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
 machine-$(CONFIG_ARCH_MX3)		:= imx
 machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_MXS)		:= mxs
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..bdc6345 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -5,6 +5,18 @@ config IMX_HAVE_DMA_V1
 # Some usages assume that having one of them implies not having (e.g.) ARCH_MX2.
 # To easily distinguish good and reviewed from unreviewed usages new (and IMHO
 # more sensible) names are used: SOC_IMX31 and SOC_IMX35
+config ARCH_MX1
+	bool
+
+config MACH_MX21
+	bool
+
+config ARCH_MX25
+	bool
+
+config MACH_MX27
+	bool
+
 config ARCH_MX31
 	bool
 
@@ -13,6 +25,7 @@ config ARCH_MX35
 
 config SOC_IMX1
 	bool
+	select ARCH_MX1
 	select CPU_ARM920T
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
@@ -20,6 +33,7 @@ config SOC_IMX1
 
 config SOC_IMX21
 	bool
+	select MACH_MX21
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -28,6 +42,7 @@ config SOC_IMX21
 
 config SOC_IMX25
 	bool
+	select ARCH_MX25
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MXC_IOMUX_V3
@@ -35,6 +50,7 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select MACH_MX27
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -59,7 +75,7 @@ config SOC_IMX35
 	select MXC_AVIC
 
 
-if ARCH_MX1
+if ARCH_IMX_V4_V5
 
 comment "MX1 platforms:"
 config MACH_MXLADS
@@ -87,30 +103,6 @@ config MACH_APF9328
 	help
 	  Say Yes here if you are using the Armadeus APF9328 development board
 
-endif
-
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
-
 comment "MX21 platforms:"
 
 config MACH_MX21ADS
@@ -124,10 +116,6 @@ config MACH_MX21ADS
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
-endif
-
-if ARCH_MX25
-
 comment "MX25 platforms:"
 
 config MACH_MX25_3DS
@@ -174,10 +162,6 @@ config MACH_EUKREA_MBIMXSD25_BASEBOARD
 
 endchoice
 
-endif
-
-if MACH_MX27
-
 comment "MX27 platforms:"
 
 config MACH_MX27ADS
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index a5353fc..0665c1f 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -14,20 +14,13 @@ choice
 	prompt "Freescale CPU family:"
 	default ARCH_MX3
 
-config ARCH_MX1
-	bool "MX1-based"
+config ARCH_IMX_V4_V5
+	bool "i.MX1, i.MX21, i.MX25, i.MX27"
+	select AUTO_ZRELADDR
+	select ARM_PATCH_PHYS_VIRT
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
+	  This enables support for systems based on the Freescale i.MX ARMv4
+	  and ARMv5 SoCs
 
 config ARCH_MX3
 	bool "MX3-based"
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 11be5cd..cbe2e3d 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -21,15 +21,7 @@
 #define MX53_PHYS_OFFSET	UL(0x70000000)
 
 #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
-# if defined CONFIG_ARCH_MX1
-#  define PLAT_PHYS_OFFSET		MX1_PHYS_OFFSET
-# elif defined CONFIG_MACH_MX21
-#  define PLAT_PHYS_OFFSET		MX21_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MX25
-#  define PLAT_PHYS_OFFSET		MX25_PHYS_OFFSET
-# elif defined CONFIG_MACH_MX27
-#  define PLAT_PHYS_OFFSET		MX27_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MX3
+# if defined CONFIG_ARCH_MX3
 #  define PLAT_PHYS_OFFSET		MX3x_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MX50
 #  define PLAT_PHYS_OFFSET		MX50_PHYS_OFFSET
-- 
1.7.5.4
