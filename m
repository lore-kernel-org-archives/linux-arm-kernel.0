From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Jun 2011 15:22:06 +0200
Subject: [PATCH 5/8 v2] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110601132206.GF23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This allows for all armv4 and armv5 based i.MX systems to be compiled
together in one kernel. To accomplish this we need ARM_PATCH_PHYS_VIRT
and AUTO_ZRELADDR which is selected in Kconfig.
As compiling with ARM_PATCH_PHYS_VIRT breaks XIP support and different
PHYS_OFFSETs break uImage support the old way to integrate only one
of these SoCs is kept in place.

Also, As the ARM_PATCH_PHYS_VIRT now has a user this removes the
dependency to EXPERIMENTAL.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-imx/Kconfig                    |   58 +++++++++++++++-----------
 arch/arm/mach-imx/Makefile                   |   10 ++--
 arch/arm/plat-mxc/Kconfig                    |   34 ++++++++++++---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    2 +-
 5 files changed, 66 insertions(+), 39 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..89c3f16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -193,7 +193,6 @@ config VECTORS_BASE
 
 config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
 	depends on !XIP_KERNEL && MMU
 	depends on !ARCH_REALVIEW || !SPARSEMEM
 	help
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 59c97a3..501cf9b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -11,8 +11,33 @@ config ARCH_MX31
 config ARCH_MX35
 	bool
 
+config ARCH_MX1
+	bool
+
+config ARCH_MX2
+	bool
+
+config ARCH_MX25
+	bool
+
+config MACH_MX27
+	bool
+
+config HAVE_SOC_IMX1
+	bool
+
+config HAVE_SOC_IMX21
+	bool
+
+config HAVE_SOC_IMX25
+	bool
+
+config HAVE_SOC_IMX27
+	bool
+
 config SOC_IMX1
 	bool
+	select ARCH_MX1
 	select CPU_ARM920T
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
@@ -20,6 +45,7 @@ config SOC_IMX1
 
 config SOC_IMX21
 	bool
+	select ARCH_MX2
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -28,6 +54,7 @@ config SOC_IMX21
 
 config SOC_IMX25
 	bool
+	select ARCH_MX25
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MXC_IOMUX_V3
@@ -35,6 +62,8 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select MACH_MX27
+	select ARCH_MX2
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -59,7 +88,7 @@ config SOC_IMX35
 	select MXC_AVIC
 
 
-if ARCH_MX1
+if HAVE_SOC_IMX1
 
 comment "MX1 platforms:"
 config MACH_MXLADS
@@ -89,27 +118,7 @@ config MACH_APF9328
 
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
+if HAVE_SOC_IMX21
 
 comment "MX21 platforms:"
 
@@ -126,7 +135,7 @@ config MACH_MX21ADS
 
 endif
 
-if ARCH_MX25
+if HAVE_SOC_IMX25
 
 comment "MX25 platforms:"
 
@@ -175,8 +184,7 @@ endchoice
 
 endif
 
-if MACH_MX27
-
+if HAVE_SOC_IMX27
 comment "MX27 platforms:"
 
 config MACH_MX27ADS
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e9eb36d..db6394a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,12 +1,12 @@
 obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 
-obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
-obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
+obj-$(CONFIG_SOC_IMX1) += clock-imx1.o mm-imx1.o
+obj-$(CONFIG_SOC_IMX21) += clock-imx21.o mm-imx21.o
 
-obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
+obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
 
-obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
-obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
+obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
+obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
 obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx35.o cpu-imx35.o clock-imx35.o ehci-imx35.o
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index a5353fc..44ebde3 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -14,21 +14,41 @@ choice
 	prompt "Freescale CPU family:"
 	default ARCH_MX3
 
-config ARCH_MX1
-	bool "MX1-based"
+config SOC_SELECT_IMX1
+	bool "i.MX1 based"
+	select HAVE_SOC_IMX1
 	help
 	  This enables support for systems based on the Freescale i.MX1 family
 
-config ARCH_MX2
-	bool "MX2-based"
+config SOC_SELECT_IMX21
+	bool "i.MX21 based"
+	select HAVE_SOC_IMX21
 	help
-	  This enables support for systems based on the Freescale i.MX2 family
+	  This enables support for systems based on the Freescale i.MX21 family
 
-config ARCH_MX25
-	bool "MX25-based"
+config SOC_SELECT_IMX25
+	bool "i.MX25 based"
+	select HAVE_SOC_IMX25
 	help
 	  This enables support for systems based on the Freescale i.MX25 family
 
+config SOC_SELECT_IMX27
+	bool "i.MX27 based"
+	select HAVE_SOC_IMX27
+	help
+	  This enables support for systems based on the Freescale i.MX27 family
+
+config ARCH_IMX_V4_V5
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
+	select HAVE_SOC_IMX1
+	select HAVE_SOC_IMX21
+	select HAVE_SOC_IMX25
+	select HAVE_SOC_IMX27
+	bool "i.MX1, i.MX21, i.MX25 and i.MX27 based"
+	help
+	  This enables support for all armv4 and armv5 based i.MX systems
+
 config ARCH_MX3
 	bool "MX3-based"
 	help
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 3538b85..735b81d 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -76,7 +76,7 @@ static struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
 	return imx_add_platform_device("imx-dma", -1, NULL, 0, NULL, 0);
 }
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 static struct sdma_script_start_addrs addr_imx25_to1 = {
 	.ap_2_ap_addr = 729,
 	.uart_2_mcu_addr = 904,
-- 
1.7.5.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
