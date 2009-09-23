From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:17:22 +0530
Subject: [PATCH 1/8] [ARM]: enable SMP support for U8500 architecture
Message-ID: <1253735242.21542.160.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This enables SMP, binds to the existing modules like
Local timers, TWD, SCU and other generic SMP helpers.
This also enables machine ux500.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/Kconfig  |   20 ++++++++++++++++----
 arch/arm/Makefile |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..9331cce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -637,6 +637,16 @@ config ARCH_OMAP
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
+config ARCH_U8500
+	bool "ST-Ericsson U8500 Series"
+	select ARM_AMBA
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select COMMON_CLKDEV
+	help
+	  Include support for ST-Ericsson's Cortex-A9 based
+	  U8500 architecture.
+
 endchoice
 
 source "arch/arm/mach-clps711x/Kconfig"
@@ -728,6 +738,8 @@ source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
 
+source "arch/arm/mach-ux500/Kconfig"
+
 source "arch/arm/mach-w90x900/Kconfig"
 
 # Definitions to make life easier
@@ -881,10 +893,10 @@ source "kernel/time/Kconfig"
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
+		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4)
+	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -953,9 +965,9 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
+		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4)
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c877d6d..948a8d9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -155,6 +155,7 @@ machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
 machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
 machine-$(CONFIG_ARCH_U300)		:= u300
+machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
-- 
1.6.3.GIT
