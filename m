From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:25 +0200
Subject: [PATCH 5/8] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows for all armv4 and armv5 based i.MX systems to be compiled
together in one kernel. To accomplish this we need ARM_PATCH_PHYS_VIRT
and AUTO_ZRELADDR which is selected in Kconfig. This breaks execute
in place support. It would be possible to keep XIP support, but the
needed Kconfig magix is just too ugly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                    |   51 +++++++++-----------------
 arch/arm/mach-imx/Makefile                   |   10 +++---
 arch/arm/mach-imx/Makefile.boot              |   16 --------
 arch/arm/plat-mxc/Kconfig                    |   18 +++-------
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    2 +-
 5 files changed, 29 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 59c97a3..90550bc 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -11,8 +11,21 @@ config ARCH_MX31
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
 config SOC_IMX1
 	bool
+	select ARCH_MX1
 	select CPU_ARM920T
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
@@ -20,6 +33,7 @@ config SOC_IMX1
 
 config SOC_IMX21
 	bool
+	select ARCH_MX2
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
@@ -35,6 +50,8 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select MACH_MX27
+	select ARCH_MX2
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -59,7 +76,7 @@ config SOC_IMX35
 	select MXC_AVIC
 
 
-if ARCH_MX1
+if ARCH_IMX_V4_V5
 
 comment "MX1 platforms:"
 config MACH_MXLADS
@@ -87,30 +104,6 @@ config MACH_APF9328
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
@@ -124,10 +117,6 @@ config MACH_MX21ADS
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
-endif
-
-if ARCH_MX25
-
 comment "MX25 platforms:"
 
 config MACH_MX25_3DS
@@ -173,10 +162,6 @@ config MACH_EUKREA_MBIMXSD25_BASEBOARD
 
 endchoice
 
-endif
-
-if MACH_MX27
-
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
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index ebee18b..cdfe20f 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -1,19 +1,3 @@
-zreladdr-$(CONFIG_ARCH_MX1)	:= 0x08008000
-params_phys-$(CONFIG_ARCH_MX1)	:= 0x08000100
-initrd_phys-$(CONFIG_ARCH_MX1)	:= 0x08800000
-
-zreladdr-$(CONFIG_MACH_MX21)	:= 0xC0008000
-params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
-initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
-
-zreladdr-$(CONFIG_ARCH_MX25)	:= 0x80008000
-params_phys-$(CONFIG_ARCH_MX25)	:= 0x80000100
-initrd_phys-$(CONFIG_ARCH_MX25)	:= 0x80800000
-
-zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
-params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
-initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
-
 zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
 params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index a5353fc..0202ca0 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -14,20 +14,12 @@ choice
 	prompt "Freescale CPU family:"
 	default ARCH_MX3
 
-config ARCH_MX1
-	bool "MX1-based"
+config ARCH_IMX_V4_V5
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
+	bool "i.MX1, i.MX21, i.MX25, i.MX27"
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
+	  This enables support for armv4 and armv5 based i.MX systems
 
 config ARCH_MX3
 	bool "MX3-based"
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
1.7.4.1
