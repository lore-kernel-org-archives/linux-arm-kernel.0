From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:53 -0700
Subject: [PATCH 6/9] ARM: Make a Kconfig option for shared BCM2835/BCM2836
 code.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-7-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2836 in the Raspberry Pi 2 is the same as the 2835 in terms of
peripherals, it's just the CPU implementation that has changed.  We
need a new ARCH_BCM2836 to handle the CPU change, so make a hidden
ARCH_BCM283X Kconfig option for the peripherals to depend on.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/mach-bcm/Kconfig      | 7 +++++++
 arch/arm/mach-bcm/Makefile     | 4 ++--
 drivers/char/hw_random/Kconfig | 6 +++---
 drivers/clk/Makefile           | 2 +-
 drivers/clocksource/Makefile   | 2 +-
 drivers/dma/Kconfig            | 4 ++--
 drivers/i2c/busses/Kconfig     | 6 +++---
 drivers/irqchip/Makefile       | 2 +-
 drivers/mmc/host/Kconfig       | 6 +++---
 drivers/pwm/Kconfig            | 6 +++---
 drivers/spi/Kconfig            | 6 +++---
 drivers/watchdog/Kconfig       | 4 ++--
 sound/soc/bcm/Kconfig          | 6 +++---
 13 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..7c438b2 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -107,8 +107,15 @@ config ARCH_BCM_MOBILE_SMP
 
 comment "Other Architectures"
 
+config ARCH_BCM283X
+	bool
+	help
+	  This option should be selected by the 2835 and 2836 chips to
+	  enable common platform features.
+
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
+	select ARCH_BCM283X
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_411920
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 4c38674..40f9dc1 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -31,8 +31,8 @@ ifeq ($(call as-instr,.arch_extension sec,as_has_sec),as_has_sec)
 CFLAGS_bcm_kona_smc.o		+= -Wa,-march=armv7-a+sec -DREQUIRES_SEC
 endif
 
-# BCM2835
-obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
+# BCM283x
+obj-$(CONFIG_ARCH_BCM283X)	+= board_bcm2835.o
 
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index de57b38..bfde6cf 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -89,12 +89,12 @@ config HW_RANDOM_BCM63XX
 	  If unusure, say Y.
 
 config HW_RANDOM_BCM2835
-	tristate "Broadcom BCM2835 Random Number Generator support"
-	depends on ARCH_BCM2835
+	tristate "Broadcom BCM283x Random Number Generator support"
+	depends on ARCH_BCM283X
 	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on the Broadcom BCM2835 SoCs.
+	  Generator hardware found on the Broadcom BCM283x SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm2835-rng
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d478ceb..8b8bd41 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -19,7 +19,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
-obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
+obj-$(CONFIG_ARCH_BCM283X)		+= clk-bcm2835.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 752d5c7..e38a82d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
-obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_ARCH_BCM283X)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index a874b6e..07d07db 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -332,8 +332,8 @@ config DMA_OMAP
 	select DMA_VIRTUAL_CHANNELS
 
 config DMA_BCM2835
-	tristate "BCM2835 DMA engine support"
-	depends on ARCH_BCM2835
+	tristate "BCM283x DMA engine support"
+	depends on ARCH_BCM283X
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 22da9c2..215fe36 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -361,11 +361,11 @@ config I2C_AXXIA
 	  an error.
 
 config I2C_BCM2835
-	tristate "Broadcom BCM2835 I2C controller"
-	depends on ARCH_BCM2835
+	tristate "Broadcom BCM283x I2C controller"
+	depends on ARCH_BCM283X
 	help
 	  If you say yes to this option, support will be included for the
-	  BCM2835 I2C controller.
+	  BCM283x I2C controller.
 
 	  If you don't know what to do here, say N.
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 42965d2..b067923 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
-obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
+obj-$(CONFIG_ARCH_BCM283X)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 61ac63a..fe7f879 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -286,12 +286,12 @@ config MMC_SDHCI_BCM_KONA
 	  If you have a controller with this interface, say Y or M here.
 
 config MMC_SDHCI_BCM2835
-	tristate "SDHCI platform support for the BCM2835 SD/MMC Controller"
-	depends on ARCH_BCM2835
+	tristate "SDHCI platform support for the BCM283x SD/MMC Controller"
+	depends on ARCH_BCM283X
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-	  This selects the BCM2835 SD/MMC controller. If you have a BCM2835
+	  This selects the BCM283x SD/MMC controller. If you have a BCM283x
 	  platform with SD or MMC devices, say Y or M here.
 
 	  If unsure, say N.
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b1541f4..4989430 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -84,10 +84,10 @@ config PWM_BCM_KONA
 	  will be called pwm-bcm-kona.
 
 config PWM_BCM2835
-	tristate "BCM2835 PWM support"
-	depends on ARCH_BCM2835
+	tristate "BCM283x PWM support"
+	depends on ARCH_BCM283X
 	help
-	  PWM framework driver for BCM2835 controller (Raspberry Pi)
+	  PWM framework driver for BCM283x controller (Raspberry Pi)
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bcm2835.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbe..3c26c6a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -76,12 +76,12 @@ config SPI_ATMEL
 	  many AT32 (AVR32) and AT91 (ARM) chips.
 
 config SPI_BCM2835
-	tristate "BCM2835 SPI controller"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	tristate "BCM283x SPI controller"
+	depends on ARCH_BCM283X || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI master.
 
-	  The BCM2835 contains two types of SPI master controller; the
+	  The BCM283x contains two types of SPI master controller; the
 	  "universal SPI master", and the regular SPI controller. This driver
 	  is for the regular SPI controller. Slave mode operation is not also
 	  not supported.
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 16f2023..5811dd6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1216,11 +1216,11 @@ config BCM63XX_WDT
 
 config BCM2835_WDT
 	tristate "Broadcom BCM2835 hardware watchdog"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM283X
 	select WATCHDOG_CORE
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
-	  BCM2835 SoC.
+	  BCM283x SoC.
 
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called bcm2835_wdt.
diff --git a/sound/soc/bcm/Kconfig b/sound/soc/bcm/Kconfig
index 6a834e1..1d5d3c6 100644
--- a/sound/soc/bcm/Kconfig
+++ b/sound/soc/bcm/Kconfig
@@ -1,9 +1,9 @@
 config SND_BCM2835_SOC_I2S
-	tristate "SoC Audio support for the Broadcom BCM2835 I2S module"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	tristate "SoC Audio support for the Broadcom BCM283x I2S module"
+	depends on ARCH_BCM283X || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
 	  Say Y or M if you want to add support for codecs attached to
-	  the BCM2835 I2S interface. You will also need
+	  the BCM283x I2S interface. You will also need
 	  to select the audio interfaces to support below.
-- 
2.1.4
