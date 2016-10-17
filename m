From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 10:43:03 +0200
Subject: [PATCH 2/2] ARM: oxnas: Add OX820 config and makefile entry
In-Reply-To: <20161017084303.20078-1-narmstrong@baylibre.com>
References: <20161017084303.20078-1-narmstrong@baylibre.com>
Message-ID: <20161017084303.20078-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor the oxnas Kconfig entries among the OX810SE and OX820 configs,
and add the files to support the OX820 SMP feature.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/Makefile           |  1 +
 arch/arm/mach-oxnas/Kconfig | 30 +++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6be9ee1..68312a9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -191,6 +191,7 @@ machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
 machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
+machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
index 29100be..8fa4557 100644
--- a/arch/arm/mach-oxnas/Kconfig
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -1,9 +1,16 @@
 menuconfig ARCH_OXNAS
 	bool "Oxford Semiconductor OXNAS Family SoCs"
 	select ARCH_HAS_RESET_CONTROLLER
+	select COMMON_CLK_OXNAS
 	select GPIOLIB
+	select MFD_SYSCON
+	select OXNAS_RPS_TIMER
+	select PINCTRL_OXNAS
+	select RESET_CONTROLLER
+	select RESET_OXNAS
+	select VERSATILE_FPGA_IRQ
 	select PINCTRL
-	depends on ARCH_MULTI_V5
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6
 	help
 	  Support for OxNas SoC family developed by Oxford Semiconductor.
 
@@ -11,16 +18,21 @@ if ARCH_OXNAS
 
 config MACH_OX810SE
 	bool "Support OX810SE Based Products"
-	select ARCH_HAS_RESET_CONTROLLER
-	select COMMON_CLK_OXNAS
+	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
-	select MFD_SYSCON
-	select OXNAS_RPS_TIMER
-	select PINCTRL_OXNAS
-	select RESET_CONTROLLER
-	select RESET_OXNAS
-	select VERSATILE_FPGA_IRQ
 	help
 	  Include Support for the Oxford Semiconductor OX810SE SoC Based Products.
 
+config MACH_OX820
+	bool "Support OX820 Based Products"
+	depends on ARCH_MULTI_V6
+	select ARM_GIC
+	select DMA_CACHE_RWFO if SMP
+	select CPU_V6K
+	select HAVE_SMP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	help
+	  Include Support for the Oxford Semiconductor OX820 SoC Based Products.
+
 endif
-- 
2.7.0
