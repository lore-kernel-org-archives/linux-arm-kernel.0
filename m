From: wellsk40@gmail.com (Kevin Wells)
Date: Tue, 26 Jan 2010 16:19:34 -0800
Subject: [PATCH 01/10] ARM: LPC32XX: Changes to existing files to support
	the LPC32XX architecture
Message-ID: <1264551574.6528.4@usb10132>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes to existing files to support the new LPC32XX architecture


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
  arch/arm/Kconfig           |   16 ++++++++++++++++
  arch/arm/Makefile          |    1 +
  drivers/i2c/busses/Kconfig |    4 ++--
  drivers/watchdog/Kconfig   |    6 +++---
  include/linux/amba/clcd.h  |    3 ++-
  5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..cc2dbf9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -550,6 +550,20 @@ config ARCH_W90X900
  	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
  		 
ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>

+config ARCH_LPC32XX
+	bool "NXP LPC32XX"
+	select CPU_ARM926T
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
+	select HAVE_IDE
+	select ARM_AMBA
+	select USB_ARCH_HAS_OHCI
+	select COMMON_CLKDEV
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	help
+	  Support for the NXP LPC32XX family of processors
+
  config ARCH_PNX4008
  	bool "Philips Nexperia PNX4008 Mobile"
  	select CPU_ARM926T
@@ -771,6 +785,8 @@ source "arch/arm/mach-lh7a40x/Kconfig"

  source "arch/arm/mach-loki/Kconfig"

+source "arch/arm/mach-lpc32xx/Kconfig"
+
  source "arch/arm/mach-msm/Kconfig"

  source "arch/arm/mach-mv78xx0/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9e75825..b6ec4f7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -139,6 +139,7 @@ machine-$(CONFIG_ARCH_KS8695)		:=  
ks8695
  machine-$(CONFIG_ARCH_L7200)		:= l7200
  machine-$(CONFIG_ARCH_LH7A40X)		:= lh7a40x
  machine-$(CONFIG_ARCH_LOKI) 		:= loki
+machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
  machine-$(CONFIG_ARCH_MMP)		:= mmp
  machine-$(CONFIG_ARCH_MSM)		:= msm
  machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..590a441 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -467,8 +467,8 @@ config I2C_PASEMI
  	  Supports the PA Semi PWRficient on-chip SMBus interfaces.

  config I2C_PNX
-	tristate "I2C bus support for Philips PNX targets"
-	depends on ARCH_PNX4008
+	tristate "I2C bus support for Philips/NXP devices"
+	depends on ARCH_PNX4008 || ARCH_LPC32XX
  	help
  	  This driver supports the Philips IP3204 I2C IP block master  
and/or
  	  slave controller
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 050ee14..3019415 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -200,11 +200,11 @@ config OMAP_WATCHDOG
  	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430  
watchdog timer.

  config PNX4008_WATCHDOG
-	tristate "PNX4008 Watchdog"
-	depends on ARCH_PNX4008
+	tristate "PNX4008/LPC32XX Watchdog"
+	depends on ARCH_PNX4008 || ARCH_LPC32XX
  	help
  	  Say Y here if to include support for the watchdog timer
-	  in the PNX4008 processor.
+	  in the PNX4008 or LPC32XX processors.
  	  This driver can be built as a module by choosing M. The module
  	  will be called pnx4008_wdt.

diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index 29c0448..8d0d491 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -21,7 +21,8 @@
  #define CLCD_UBAS 		0x00000010
  #define CLCD_LBAS 		0x00000014

-#if !defined(CONFIG_ARCH_VERSATILE) && !defined(CONFIG_ARCH_REALVIEW)
+#if !defined(CONFIG_ARCH_VERSATILE) && !defined(CONFIG_ARCH_REALVIEW)\
+	&& !defined(CONFIG_ARCH_LPC32XX)
  #define CLCD_IENB 		0x00000018
  #define CLCD_CNTL 		0x0000001c
  #else
-- 
1.6.6
