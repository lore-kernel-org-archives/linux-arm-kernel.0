From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:21 +0200
Subject: [PATCH 25/61] ARM: imx: prepare deprecating ARCH_MX1, MACH_MX2,
	MACH_MX21 and MACH_MX27
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-26-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_... is reserved for machine support, so use SOC as prefix, not MACH.

This introduces new symbols SOC_IMX1, SOC_IMX21 and SOC_IMX27.  They are
selected by the old symbols for now.  There is no substitute for MACH_MX2
as most usages of MX2 only means MX21 + MX27 but not MX25.

Later the choice about CPU and CPU family should go away and the individual
machines should select the right SOC symbol.  This is a precondition to
support more than one SOC in a single kernel image.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |   24 ++++++++++++++++++++++--
 arch/arm/plat-mxc/Kconfig |    5 +----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3ca8fa7..08002df 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,11 @@
 if ARCH_MX1
 
+config SOC_IMX1
+	select CPU_ARM920T
+	select IMX_HAVE_DMA_V1
+	select IMX_HAVE_IOMUX_V1
+	bool
+
 comment "MX1 platforms:"
 config MACH_MXLADS
 	bool
@@ -19,19 +25,33 @@ endif
 
 if ARCH_MX2
 
+config SOC_IMX21
+	select CPU_ARM926T
+	select ARCH_MXC_AUDMUX_V1
+	select IMX_HAVE_DMA_V1
+	select IMX_HAVE_IOMUX_V1
+	bool
+
+config SOC_IMX27
+	select CPU_ARM926T
+	select ARCH_MXC_AUDMUX_V1
+	select IMX_HAVE_DMA_V1
+	select IMX_HAVE_IOMUX_V1
+	bool
+
 choice
 	prompt "CPUs:"
 	default MACH_MX21
 
 config MACH_MX21
 	bool "i.MX21 support"
-	select ARCH_MXC_AUDMUX_V1
+	select SOC_IMX21
 	help
 	  This enables support for Freescale's MX2 based i.MX21 processor.
 
 config MACH_MX27
 	bool "i.MX27 support"
-	select ARCH_MXC_AUDMUX_V1
+	select SOC_IMX27
 	help
 	  This enables support for Freescale's MX2 based i.MX27 processor.
 
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 3adad38..d80de4e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -8,15 +8,12 @@ choice
 
 config ARCH_MX1
 	bool "MX1-based"
-	select CPU_ARM920T
-	select IMX_HAVE_IOMUX_V1
+	select SOC_IMX1
 	help
 	  This enables support for systems based on the Freescale i.MX1 family
 
 config ARCH_MX2
 	bool "MX2-based"
-	select CPU_ARM926T
-	select IMX_HAVE_IOMUX_V1
 	help
 	  This enables support for systems based on the Freescale i.MX2 family
 
-- 
1.7.1
