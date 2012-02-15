From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:40 +0900
Subject: [PATCH 06/12] ARM: S3C24XX: change the ARCH_S3C2410 to ARCH_S3C24XX
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the ARCH name to "ARCH_S3C24XX" for Samsung
S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443,
and S3C2450 SoCs so that we can merge the mach-xxx directories
and plat-s3c24xx dir. to just one mach-s3c24xx for them.

I think this should be sent to upstream via samsung tree because
this touches many samsung stuff.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Chris Ball <cjb@laptop.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                      |   23 +++++++++++------------
 arch/arm/Makefile                     |    2 +-
 arch/arm/boot/compressed/head.S       |    2 +-
 arch/arm/configs/mini2440_defconfig   |    2 +-
 arch/arm/configs/s3c2410_defconfig    |    2 +-
 arch/arm/configs/tct_hammer_defconfig |    2 +-
 arch/arm/mach-s3c2410/Kconfig         |    2 +-
 arch/arm/mach-s3c2412/Kconfig         |    4 ++--
 arch/arm/mach-s3c2416/Kconfig         |    2 +-
 arch/arm/mach-s3c2443/Kconfig         |    2 +-
 arch/arm/plat-s3c24xx/Kconfig         |    6 +++---
 arch/arm/plat-s3c24xx/Makefile        |    2 +-
 arch/arm/plat-samsung/Kconfig         |    4 ++--
 drivers/input/touchscreen/Kconfig     |    2 +-
 drivers/leds/Kconfig                  |    2 +-
 drivers/mmc/host/Kconfig              |    2 +-
 drivers/mtd/nand/Kconfig              |    2 +-
 drivers/rtc/Kconfig                   |    2 +-
 drivers/spi/Kconfig                   |    2 +-
 drivers/usb/Kconfig                   |    2 +-
 drivers/usb/gadget/Kconfig            |    4 ++--
 drivers/usb/host/ohci-hcd.c           |    2 +-
 drivers/video/Kconfig                 |    2 +-
 drivers/watchdog/Kconfig              |    2 +-
 sound/soc/samsung/Kconfig             |   12 ++++++------
 25 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..5f1a3ad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -763,22 +763,21 @@ config ARCH_SA1100
 	help
 	  Support for StrongARM 11x0 based boards.
 
-config ARCH_S3C2410
-	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443, S3C2450"
+config ARCH_S3C24XX
+	bool "Samsung S3C24XX SoCs"
 	select GENERIC_GPIO
 	select ARCH_HAS_CPUFREQ
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
-	  Samsung S3C2410X CPU based systems, such as the Simtec Electronics
-	  BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
-	  the Samsung SMDK2410 development board (and derivatives).
-
-	  Note, the S3C2416 and the S3C2450 are so close that they even share
-	  the same SoC ID code. This means that there is no separate machine
-	  directory (no arch/arm/mach-s3c2450) as the S3C2416 was first.
+	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
+	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
+	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
+	  Samsung SMDK2410 development board (and derivatives).
 
 config ARCH_S3C64XX
 	bool "Samsung S3C64XX"
@@ -1068,7 +1067,7 @@ source "arch/arm/plat-s5p/Kconfig"
 
 source "arch/arm/plat-spear/Kconfig"
 
-if ARCH_S3C2410
+if ARCH_S3C24XX
 source "arch/arm/mach-s3c2410/Kconfig"
 source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2416/Kconfig"
@@ -1590,7 +1589,7 @@ source kernel/Kconfig.preempt
 
 config HZ
 	int
-	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P64X0 || \
+	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
 		ARCH_S5PV210 || ARCH_EXYNOS4
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
@@ -2116,7 +2115,7 @@ config CPU_FREQ_S3C
 
 config CPU_FREQ_S3C24XX
 	bool "CPUfreq driver for Samsung S3C24XX series CPUs (EXPERIMENTAL)"
-	depends on ARCH_S3C2410 && CPU_FREQ && EXPERIMENTAL
+	depends on ARCH_S3C24XX && CPU_FREQ && EXPERIMENTAL
 	select CPU_FREQ_S3C
 	help
 	  This enables the CPUfreq driver for the Samsung S3C24XX family
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 40319d9..624f764 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -175,7 +175,7 @@ machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2412 s3c2416 s3c2440 s3c2443
+machine-$(CONFIG_ARCH_S3C24XX)		:= s3c2410 s3c2412 s3c2416 s3c2440 s3c2443
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c5d6025..5f6045f 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -58,7 +58,7 @@
 		add	\rb, \rb, #0x00010000	@ Ser1
 #endif
 		.endm
-#elif defined(CONFIG_ARCH_S3C2410)
+#elif defined(CONFIG_ARCH_S3C24XX)
 		.macro loadsp, rb, tmp
 		mov	\rb, #0x50000000
 		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 2472a95..42da918 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -13,7 +13,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_BLK_DEV_INTEGRITY=y
-CONFIG_ARCH_S3C2410=y
+CONFIG_ARCH_S3C24XX=y
 CONFIG_S3C_ADC=y
 CONFIG_S3C24XX_PWM=y
 CONFIG_MACH_MINI2440=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index f9096c1..8746c00 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -9,7 +9,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S3C2410=y
+CONFIG_ARCH_S3C24XX=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_S3C_ADC=y
 CONFIG_S3C24XX_PWM=y
diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 95c0f0d..1d24f84 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -14,7 +14,7 @@ CONFIG_SLOB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S3C2410=y
+CONFIG_ARCH_S3C24XX=y
 CONFIG_MACH_TCT_HAMMER=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 5261a7e..ce62099 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -4,7 +4,7 @@
 
 config CPU_S3C2410
 	bool
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	select CPU_ARM920T
 	select S3C2410_CLOCK
 	select CPU_LLSERIAL_S3C2410
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index b8b9029..41f3327 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -4,7 +4,7 @@
 
 config CPU_S3C2412
 	bool
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2412_PM if PM
@@ -14,7 +14,7 @@ config CPU_S3C2412
 
 config CPU_S3C2412_ONLY
 	bool
-	depends on ARCH_S3C2410 && !CPU_S3C2410 && \
+	depends on ARCH_S3C24XX && !CPU_S3C2410 && \
 		   !CPU_S3C2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
 		   !CPU_S3C2443 && CPU_S3C2412
 	default y if CPU_S3C2412
diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 84c7b03..53d5c2b 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -9,7 +9,7 @@
 
 config CPU_S3C2416
 	bool
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	select CPU_ARM926T
 	select S3C2416_DMA if S3C2410_DMA
 	select CPU_LLSERIAL_S3C2440
diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
index 8814031..793a0fe 100644
--- a/arch/arm/mach-s3c2443/Kconfig
+++ b/arch/arm/mach-s3c2443/Kconfig
@@ -4,7 +4,7 @@
 
 config CPU_S3C2443
 	bool
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	select CPU_ARM920T
 	select S3C2443_DMA if S3C2410_DMA
 	select CPU_LLSERIAL_S3C2440
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 6b1d918..5a67eda 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -4,7 +4,7 @@
 
 config PLAT_S3C24XX
 	bool
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	default y
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
@@ -84,7 +84,7 @@ config PM_SIMTEC
 
 config S3C2410_DMA
 	bool "S3C2410 DMA support"
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	select S3C_DMA
 	help
 	  S3C2410 DMA support. This is needed for drivers like sound which
@@ -93,7 +93,7 @@ config S3C2410_DMA
 
 config S3C2410_DMA_DEBUG
 	bool "S3C2410 DMA support debug"
-	depends on ARCH_S3C2410 && S3C2410_DMA
+	depends on ARCH_S3C24XX && S3C2410_DMA
 	help
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 7cefd7f..32bd295 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
 obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
 
 # device specific setup and/or initialisation
-obj-$(CONFIG_ARCH_S3C2410)	+= setup-i2c.o
+obj-$(CONFIG_ARCH_S3C24XX)	+= setup-i2c.o
 obj-$(CONFIG_S3C2410_SETUP_TS)	+= setup-ts.o
 
 # machine common support
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 6a2abe6..71553f4 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -205,7 +205,7 @@ config S3C_DEV_USB_HSOTG
 
 config S3C_DEV_WDT
 	bool
-	default y if ARCH_S3C2410
+	default y if ARCH_S3C24XX
 	help
 	  Complie in platform device definition for Watchdog Timer
 
@@ -264,7 +264,7 @@ config SAMSUNG_DEV_KEYPAD
 
 config SAMSUNG_DEV_PWM
 	bool
-	default y if ARCH_S3C2410
+	default y if ARCH_S3C24XX
 	help
 	  Compile in platform device definition for PWM Timer
 
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4af2a18..b306168 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -215,7 +215,7 @@ config TOUCHSCREEN_FUJITSU
 
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410/generic touchscreen input driver"
-	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
+	depends on ARCH_S3C24XX || SAMSUNG_DEV_TS
 	select S3C_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index c957c34..2ba64ca 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -69,7 +69,7 @@ config LEDS_MIKROTIK_RB532
 config LEDS_S3C24XX
 	tristate "LED Support for Samsung S3C24XX GPIO LEDs"
 	depends on LEDS_CLASS
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	help
 	  This option enables support for LEDs connected to GPIO lines
 	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index cf444b0..f31f7cb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -395,7 +395,7 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	help
 	  This selects a driver for the MCI interface found in
           Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 31b034b..92e8559 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -187,7 +187,7 @@ config MTD_NAND_PPCHAMELEONEVB
 
 config MTD_NAND_S3C2410
 	tristate "NAND Flash support for Samsung S3C SoCs"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX
+	depends on ARCH_S3C24XX || ARCH_S3C64XX
 	help
 	  This enables the NAND flash controller on the S3C24xx and S3C64xx
 	  SoCs
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e19a403..cb7df33 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -748,7 +748,7 @@ config HAVE_S3C_RTC
 
 config RTC_DRV_S3C
 	tristate "Samsung S3C series SoC RTC"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || HAVE_S3C_RTC
+	depends on ARCH_S3C64XX || HAVE_S3C_RTC
 	help
 	  RTC (Realtime Clock) driver for the clock inbuilt into the
 	  Samsung S3C24XX series of SoCs. This can provide periodic
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3f9a47e..e980700 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -281,7 +281,7 @@ config SPI_PXA2XX_PCI
 
 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
-	depends on ARCH_S3C2410 && EXPERIMENTAL
+	depends on ARCH_S3C24XX && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  SPI driver for Samsung S3C24XX series ARM SoCs
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 75823a1..5bf2913 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -37,7 +37,7 @@ config USB_ARCH_HAS_OHCI
 	# ARM:
 	default y if SA1111
 	default y if ARCH_OMAP
-	default y if ARCH_S3C2410
+	default y if ARCH_S3C24XX
 	default y if PXA27x
 	default y if PXA3xx
 	default y if ARCH_EP93XX
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7ecb68a..43a11c1 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -284,7 +284,7 @@ config USB_IMX
 
 config USB_S3C2410
 	tristate "S3C2410 USB Device Controller"
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	help
 	  Samsung's S3C2410 is an ARM-4 processor with an integrated
 	  full speed USB 1.1 device controller.  It has 4 configurable
@@ -299,7 +299,7 @@ config USB_S3C2410_DEBUG
 
 config USB_S3C_HSUDC
 	tristate "S3C2416, S3C2443 and S3C2450 USB Device Controller"
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C24XX
 	select USB_GADGET_DUALSPEED
 	help
 	  Samsung's S3C2416, S3C2443 and S3C2450 is an ARM9 based SoC
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 34b9edd..f15e08f 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1000,7 +1000,7 @@ MODULE_LICENSE ("GPL");
 #define SA1111_DRIVER		ohci_hcd_sa1111_driver
 #endif
 
-#if defined(CONFIG_ARCH_S3C2410) || defined(CONFIG_ARCH_S3C64XX)
+#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S3C64XX)
 #include "ohci-s3c2410.c"
 #define PLATFORM_DRIVER		ohci_hcd_s3c2410_driver
 #endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6ca0c40..64ad8cc 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2061,7 +2061,7 @@ config FB_S3C_DEBUG_REGWRITE
 
 config FB_S3C2410
 	tristate "S3C2410 LCD framebuffer support"
-	depends on FB && ARCH_S3C2410
+	depends on FB && ARCH_S3C24XX
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 877b107..3aa52ba 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -170,7 +170,7 @@ config HAVE_S3C2410_WATCHDOG
 
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
-	depends on ARCH_S3C2410 || HAVE_S3C2410_WATCHDOG
+	depends on HAVE_S3C2410_WATCHDOG
 	select WATCHDOG_CORE
 	help
 	  Watchdog timer block in the Samsung SoCs. This will reboot
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index f3417f2..fe3995c 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,8 +1,8 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_EXYNOS4
+	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_EXYNOS4
 	select S3C64XX_DMA if ARCH_S3C64XX
-	select S3C2410_DMA if ARCH_S3C2410
+	select S3C2410_DMA if ARCH_S3C24XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Samsung SoCs' Audio interfaces. You will also need to
@@ -84,7 +84,7 @@ config SND_SOC_SAMSUNG_SMDK2443_WM9710
 
 config SND_SOC_SAMSUNG_LN2440SBC_ALC650
 	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C2410
+	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
 	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
@@ -95,7 +95,7 @@ config SND_SOC_SAMSUNG_LN2440SBC_ALC650
 
 config SND_SOC_SAMSUNG_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C2410
+	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
 	select SND_S3C24XX_I2S
 	select SND_SOC_L3
 	select SND_SOC_UDA134X
@@ -107,14 +107,14 @@ config SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C2410
+	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC23
 	select SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_HERMES
 	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C2410
+	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_SAMSUNG_SIMTEC
-- 
1.7.4.4
