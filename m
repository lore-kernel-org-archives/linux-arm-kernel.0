From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 29 Oct 2015 16:44:10 -0400
Subject: [PATCH v2] clk: iproc: Make clocks visible options
Message-ID: <1446151450-23563-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the clocks visible options that can be selected by anyone.  This
avoids the problems of:
 1) Select is a reverse dependency and is hard for people to understand
    and can sometimes be a pain to track down
 2) Build coverage goes down because configs are hidden
 3) Code bloat

Patch suggested by Stephen Boyd

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |  1 -
 drivers/clk/bcm/Kconfig   | 30 +++++++++++++++++++++++++++++-
 drivers/clk/bcm/Makefile  |  7 +++----
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 679798b..cacaaec 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -14,7 +14,6 @@ config ARCH_BCM_IPROC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GLOBAL_TIMER
-	select COMMON_CLK_IPROC
 	select CLKSRC_MMIO
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index 46ee475..ad815a5 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -9,8 +9,36 @@ config CLK_BCM_KONA
 	  in the BCM281xx and BCM21664 families.
 
 config COMMON_CLK_IPROC
-	bool
+	bool "Broadcom iProc clock support"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on COMMON_CLK
+	default ARCH_BCM_IPROC
 	help
 	  Enable common clock framework support for Broadcom SoCs
 	  based on the iProc architecture
+
+if COMMON_CLK_IPROC
+
+config CLK_BCM_CYGNUS
+	bool "Broadcom Cygnus clock support"
+	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
+	default ARCH_BCM_CYGNUS
+	help
+	  Enable common clock framework support for the Broadcom Cygnus SoC
+
+config CLK_BCM_NSP
+	bool "Broadcom Northstar/Northstar Plus clock support"
+	depends on ARCH_BCM_5301X || ARCH_BCM_NSP || COMPILE_TEST
+	default ARCH_BCM_5301X || ARCH_BCM_NSP
+	help
+	  Enable common clock framework support for the Broadcom Northstar and
+	  Northstar Plus SoCs
+
+config CLK_BCM_NS2
+	bool "Broadcom Northstar 2 clock support"
+	depends on ARM64 || COMPILE_TEST
+	default ARCH_BCM_IPROC
+	help
+	  Enable common clock framework support for the Broadcom Northstar 2 SoC
+
+endif
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 2d1cbc5..05d5830 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
-obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-ns2.o
-obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
-obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
-obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
+obj-$(CONFIG_CLK_BCM_CYGNUS)	+= clk-cygnus.o
+obj-$(CONFIG_CLK_BCM_NSP)	+= clk-nsp.o
+obj-$(CONFIG_CLK_BCM_NS2)	+= clk-ns2.o
-- 
1.9.1
