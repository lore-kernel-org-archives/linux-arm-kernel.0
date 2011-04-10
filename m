From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Apr 2011 21:49:00 +0200
Subject: [PATCH 3/6] ARM: mxc: simplify platform selection for i.MX21 and
	i.MX27
In-Reply-To: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1302464943-20721-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the choice between i.MX21 and i.MX27 (that appeared when
choosing "MX2-based" in the mxc-global CPU family choice) to the global
choice.

Now this global choice isn't about "CPU families" anymore but this isn't
currently possible anyhow (e.g. because i.MX25 doesn't match many
expectations that are called MX2 and we cannot compile i.MX51 and i.MX53
into a single (runnable) kernel) and will change further in the future.

Note that reduced .config files for i.MX21 need some care not to switch
so a i.MX31/35 config which is the default in the global choice.
mx21_defconfig is adapted accordingly.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this is a more complete version of

	http://mid.gmane.org/1299086585-22707-1-git-send-email-u.kleine-koenig at pengutronix.de

. Back then Sascha suggested to do a more complete switch to a structure
that allows to take ARM_PATCH_PHYS_VIRT into account. But as we're not
yet there to support this on i.MX and because I think this justifies a
seperate patch I this up again.

Best regards
Uwe

 arch/arm/configs/mx21_defconfig |    2 +-
 arch/arm/configs/mx27_defconfig |    1 -
 arch/arm/mach-imx/Kconfig       |   30 ++++++++----------------------
 arch/arm/plat-mxc/Kconfig       |   26 +++++++++++++++++---------
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/arch/arm/configs/mx21_defconfig b/arch/arm/configs/mx21_defconfig
index 27261f6..4590a12 100644
--- a/arch/arm/configs/mx21_defconfig
+++ b/arch/arm/configs/mx21_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX2=y
+CONFIG_MACH_MX21=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MXC_PWM=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index 220e84f..11f1283 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -17,7 +17,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX2=y
 CONFIG_MACH_MX27=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_PCM038=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7914283..0382301 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,10 +1,14 @@
 config IMX_HAVE_DMA_V1
 	bool
 #
-# ARCH_MX31 and ARCH_MX35 are left for compatibility
+# ARCH_MX2, ARCH_MX31 and ARCH_MX35 are left for compatibility
 # Some usages assume that having one of them implies not having (e.g.) ARCH_MX2.
 # To easily distinguish good and reviewed from unreviewed usages new (and IMHO
-# more sensible) names are used: SOC_IMX31 and SOC_IMX35
+# more sensible) names are used: SOC_IMX21, SOC_IMX27, SOC_IMX31 and SOC_IMX35
+config ARCH_MX2
+	# note that i.MX25 doesn't select this
+	bool
+
 config ARCH_MX31
 	bool
 
@@ -20,6 +24,7 @@ config SOC_IMX1
 
 config SOC_IMX21
 	bool
+	select ARCH_MX2
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -35,6 +40,7 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
+	select ARCH_MX2
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
 	select IMX_HAVE_DMA_V1
@@ -82,26 +88,6 @@ config MACH_SCB9328
 
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
 if MACH_MX21
 
 comment "MX21 platforms:"
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index b9cf1c5..ce6ed5e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -5,28 +5,36 @@ source "arch/arm/plat-mxc/devices/Kconfig"
 menu "Freescale MXC Implementations"
 
 choice
-	prompt "Freescale CPU family:"
+	prompt "Set of supported SoCs:"
 	default ARCH_MX3
 
+# don't use the symbols available in this choice in code. They should only be
+# used to select the machines that can be compiled into a single kernel.
 config ARCH_MX1
-	bool "MX1-based"
+	bool "MX1"
 	help
 	  This enables support for systems based on the Freescale i.MX1 family
 
-config ARCH_MX2
-	bool "MX2-based"
+config MACH_MX21
+	bool "i.MX21"
 	help
-	  This enables support for systems based on the Freescale i.MX2 family
+	  This enables support for machines using Freescale's i.MX21 processor.
 
 config ARCH_MX25
-	bool "MX25-based"
+	bool "i.MX25"
 	help
-	  This enables support for systems based on the Freescale i.MX25 family
+	  This enables support for machines using Freescale's i.MX25 processor.
+
+config MACH_MX27
+	bool "i.MX27"
+	help
+	  This enables support for machines using Freescale's i.MX27 processor.
 
 config ARCH_MX3
-	bool "MX3-based"
+	bool "i.MX31 + i.MX35"
 	help
-	  This enables support for systems based on the Freescale i.MX3 family
+	  This enables support for machines using Freescale's i.MX31 and i.MX35
+	  processors.
 
 config ARCH_MX5
 	bool "MX5-based"
-- 
1.7.2.3
