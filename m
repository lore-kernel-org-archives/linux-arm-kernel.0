From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 10:03:05 +0200
Subject: [PATCH 2/4] ARM i.MX: allow to compile together all i.MX5 based SoCs
In-Reply-To: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
References: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314172987-10349-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this we need CONFIG_AUTO_ZRELADDR and CONFIG_ARM_PATCH_PHYS_VIRT.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig               |   18 ++++--------------
 arch/arm/plat-mxc/Kconfig               |   20 ++++----------------
 arch/arm/plat-mxc/include/mach/memory.h |    6 ------
 3 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b4e7c58..6880691 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -1,8 +1,9 @@
-if ARCH_MX503 || ARCH_MX51
+if ARCH_MX5
+
 # ARCH_MX5/50/53 are left to mark places where prevent multi-soc in single
 # image. So for most time, SOC_IMX50/51/53 should be used.
 
-config ARCH_MX5
+config ARCH_MX51
 	bool
 
 config ARCH_MX50
@@ -19,7 +20,6 @@ config SOC_IMX50
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
-	select ARCH_MX5
 	select ARCH_MX50
 
 config	SOC_IMX51
@@ -30,7 +30,7 @@ config	SOC_IMX51
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
-	select ARCH_MX5
+	select ARCH_MX51
 
 config	SOC_IMX53
 	bool
@@ -38,10 +38,8 @@ config	SOC_IMX53
 	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
-	select ARCH_MX5
 	select ARCH_MX53
 
-if ARCH_MX50_SUPPORTED
 #comment "i.MX50 machines:"
 
 config MACH_MX50_RDP
@@ -57,9 +55,6 @@ config MACH_MX50_RDP
 	  Include support for MX50 reference design platform (RDP) board. This
 	  includes specific configurations for the board and its peripherals.
 
-endif # ARCH_MX50_SUPPORTED
-
-if ARCH_MX51
 comment "i.MX51 machines:"
 
 config MACH_MX51_BABBAGE
@@ -167,9 +162,6 @@ config MACH_MX51_EFIKASB
 	  Include support for Genesi Efika Smartbook. This includes specific
 	  configurations for the board and its peripherals.
 
-endif # ARCH_MX51
-
-if ARCH_MX53_SUPPORTED
 comment "i.MX53 machines:"
 
 config MACH_MX53_EVK
@@ -221,6 +213,4 @@ config MACH_MX53_ARD
 	  Include support for MX53 ARD platform. This includes specific
 	  configurations for the board and its peripherals.
 
-endif # ARCH_MX53_SUPPORTED
-
 endif
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 0665c1f..502e45f 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -4,12 +4,6 @@ source "arch/arm/plat-mxc/devices/Kconfig"
 
 menu "Freescale MXC Implementations"
 
-config ARCH_MX50_SUPPORTED
-	bool
-
-config ARCH_MX53_SUPPORTED
-	bool
-
 choice
 	prompt "Freescale CPU family:"
 	default ARCH_MX3
@@ -27,20 +21,14 @@ config ARCH_MX3
 	help
 	  This enables support for systems based on the Freescale i.MX3 family
 
-config ARCH_MX503
-	bool "i.MX50 + i.MX53"
-	select ARCH_MX50_SUPPORTED
-	select ARCH_MX53_SUPPORTED
+config ARCH_MX5
+	bool "i.MX50, i.MX51, i.MX53"
+	select AUTO_ZRELADDR
+	select ARM_PATCH_PHYS_VIRT
 	help
 	  This enables support for machines using Freescale's i.MX50 and i.MX51
 	  processors.
 
-config ARCH_MX51
-	bool "i.MX51"
-	select ARCH_MX51_SUPPORTED
-	help
-	  This enables support for systems based on the Freescale i.MX51 family
-
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index cbe2e3d..35e6c7f 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -23,12 +23,6 @@
 #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
 # if defined CONFIG_ARCH_MX3
 #  define PLAT_PHYS_OFFSET		MX3x_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MX50
-#  define PLAT_PHYS_OFFSET		MX50_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MX51
-#  define PLAT_PHYS_OFFSET		MX51_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MX53
-#  define PLAT_PHYS_OFFSET		MX53_PHYS_OFFSET
 # endif
 #endif
 
-- 
1.7.5.4
