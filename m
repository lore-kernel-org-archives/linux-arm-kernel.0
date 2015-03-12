From: stefan@agner.ch (Stefan Agner)
Date: Fri, 13 Mar 2015 00:36:18 +0100
Subject: [PATCH v3 10/12] ARM: vf610: enable Cortex-M4 on Vybrid SoC
In-Reply-To: <1426203380-7155-1-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
Message-ID: <1426203380-7155-11-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows to build the Kernel for Vybrid (VF6xx) SoC
when ARMv7-M CPU is selected. The resulting image runs on the
secondary Cortex-M4 core. This core has equally access to all
peripherals as the main Cortex-A5 core. However, there is no
resource control mechanism, hence when both cores are used
simultaneously, orthogonal device tree's are required.

The boot CPU is dependent on the SoC variant, however the
commonly available boards use variants where the Cortex-A5 is
the primary/boot CPU. Booting the secondary Cortex-M4 CPU
needs SoC specific register written. There is no in kernel
support for this right now, a external userspace utility
called "m4boot" can be used to boot the kernel:

m4boot xipImage initramfs.cpio.lzo vf610m4-colibri.dtb

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/arm/fsl.txt |  3 +++
 arch/arm/mach-imx/Kconfig                     | 36 +++++++++++++++++----------
 arch/arm/mach-imx/Makefile.boot               |  0
 arch/arm/mach-imx/mach-vf610.c                |  1 +
 4 files changed, 27 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-imx/Makefile.boot

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index a5462b6..2a3ba73 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -81,12 +81,15 @@ Freescale Vybrid Platform Device Tree Bindings
 For the Vybrid SoC familiy all variants with DDR controller are supported,
 which is the VF5xx and VF6xx series. Out of historical reasons, in most
 places the kernel uses vf610 to refer to the whole familiy.
+The compatible string "fsl,vf610m4" is used for the secondary Cortex-M4
+core support.
 
 Required root node compatible property (one of them):
     - compatible = "fsl,vf500";
     - compatible = "fsl,vf510";
     - compatible = "fsl,vf600";
     - compatible = "fsl,vf610";
+    - compatible = "fsl,vf610m4";
 
 Freescale LS1021A Platform Device Tree Bindings
 ------------------------------------------------
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d21cb9a..f719a53 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,5 @@
 menuconfig ARCH_MXC
-	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARCH_MULTI_V7M
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
 	select CLKSRC_MMIO
@@ -558,9 +558,11 @@ config MACH_VPR200
 
 endif
 
+comment "Device tree only"
+
 if ARCH_MULTI_V7
 
-comment "Device tree only"
+comment "Cortex-A platforms"
 
 config SOC_IMX5
 	bool
@@ -630,10 +632,28 @@ config SOC_IMX6SX
 	help
 	  This enables support for Freescale i.MX6 SoloX processor.
 
+
+config SOC_LS1021A
+	bool "Freescale LS1021A support"
+	select ARM_GIC
+	select HAVE_ARM_ARCH_TIMER
+	select PCI_DOMAINS if PCI
+	select ZONE_DMA if ARM_LPAE
+
+	help
+	  This enable support for Freescale LS1021A processor.
+
+endif
+
+comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
+
+if ARCH_MULTI_V7 || ARCH_MULTI_V7M
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select IRQ_DOMAIN_HIERARCHY
-	select ARM_GIC
+	select ARM_GIC if ARCH_MULTI_V7
+	select ARM_NVIC if ARCH_MULTI_V7M
 	select PINCTRL_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
 
@@ -660,16 +680,6 @@ choice
 
 endchoice
 
-config SOC_LS1021A
-	bool "Freescale LS1021A support"
-	select ARM_GIC
-	select HAVE_ARM_ARCH_TIMER
-	select PCI_DOMAINS if PCI
-	select ZONE_DMA if ARM_LPAE
-
-	help
-	  This enable support for Freescale LS1021A processor.
-
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 2e7c75b..b20f6c1 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -17,6 +17,7 @@ static const char * const vf610_dt_compat[] __initconst = {
 	"fsl,vf510",
 	"fsl,vf600",
 	"fsl,vf610",
+	"fsl,vf610m4",
 	NULL,
 };
 
-- 
2.3.1
