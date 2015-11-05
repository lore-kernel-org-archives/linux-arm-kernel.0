From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Nov 2015 15:49:01 +0100
Subject: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
In-Reply-To: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <3770393.BLNOaUSB5Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 November 2015 20:15:21 Masahiro Yamada wrote:
> When I was implementing a new reset controller for my SoCs,
> I struggled to make my sub-menu shown under the reset
> controller menu.
> I noticed the Kconfig in reset sub-system are screwed up due to two
> config options (ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER).
> 
> I think only the former should be select'ed by relevant SoCs,
> but in fact the latter is also select'ed here and there.
> Mixing "select" to a user-configurable option is a mess.
> 
> Finally, I started to wonder whether it could be more simpler?
> 
> The first patch drops ARCH_HAS_RESET_CONTROLLER.
> RESET_CONTROLLER should be directly selected by SoCs.
> 
> The rest of this series are minor clean ups in other
> sub-systems.
> I can postpone them if changes over cross sub-systems
> are not preferred.

Thanks a lot for picking up this topic! It has been annoying me
for a while and I have submitted an experimental patch some time
ago, but not finished it myself.

For some reason, I only see a subset of your patches here (patch 1, 4 and 6),
so I don't know exactly what you did. For reference, you can find
my original patch below. Please check if I did things that your
series doesn't do, and whether those are still needed.

	Arnd

commit 7983ffe5e07a5aac0c9bdd657858e3b2b9842b30
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Feb 24 15:30:30 2015 +0100

    rework RESET_CONTROLLER handling

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f5f6d0b09a6..ab137ae8dcc8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -319,6 +319,7 @@ choice
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 344434ca366c..2dc8f3df39e6 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -1,6 +1,5 @@
 menuconfig ARCH_BERLIN
 	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select DW_APB_ICTL
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8ceda2844c4f..1b1134adc188 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -58,7 +58,6 @@ config HAVE_IMX_MMDC
 
 config HAVE_IMX_SRC
 	def_bool y if SMP
-	select ARCH_HAS_RESET_CONTROLLER
 
 config IMX_HAVE_IOMUX_V1
 	bool
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 4773fe1d8b3f..116502d776ab 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -113,6 +113,7 @@ config MACH_MMP_DT
 	select PINCTRL_SINGLE
 	select COMMON_CLK
 	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select CPU_MOHAWK
 	help
 	  Include support for Marvell MMP2 based platforms using
@@ -125,6 +126,7 @@ config MACH_MMP2_DT
 	select PINCTRL
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select CPU_PJ4
 	help
 	  Include support for Marvell MMP2 based platforms using
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 9ab8932403e5..00adfc4a5cd6 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,12 +1,12 @@
 menuconfig ARCH_SIRF
 	bool "CSR SiRF" if ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
 	select REGMAP
 	select PINCTRL
 	select PINCTRL_SIRF
+	select RESET_CONTROLLER
 	help
 	  Support for CSR SiRFprimaII/Marco/Polo platforms
 
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ae4eb7cc4bcc..17d2df427c3c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -2,7 +2,6 @@ config ARCH_ROCKCHIP
 	bool "Rockchip RK2928 and RK3xxx SOCs" if ARCH_MULTI_V7
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
@@ -12,6 +11,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
 	select REGULATOR if PM
+	select RESET_CONTROLLER
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 125865daaf17..8092f4f84ee6 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -6,7 +6,6 @@ menuconfig ARCH_STI
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
-	select ARCH_HAS_RESET_CONTROLLER
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
@@ -14,7 +13,6 @@ menuconfig ARCH_STI
 	select ARM_ERRATA_775420
 	select PL310_ERRATA_753970 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
-	select RESET_CONTROLLER
 	help
 	  Include support for STiH41x SOCs like STiH415/416 using the device tree
 	  for discovery
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 4efe2d43a126..60b58ca02162 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,7 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index c2be98f38e73..b1c39eed19f1 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -45,7 +45,7 @@ extern void __init sun6i_reset_init(void);
 static void __init sun6i_timer_init(void)
 {
 	of_clk_init(NULL);
-	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
+	if (IS_ENABLED(CONFIG_RESET_SUNXI))
 		sun6i_reset_init();
 	clocksource_probe();
 }
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 0fa4c5f8b1be..269efaaa6843 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,7 +9,6 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select PM_OPP
-	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
 	select USB_ULPI if USB_PHY
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e6cd1a32025a..b93b75bf0a2d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -159,7 +159,6 @@ config DMA_SUN4I
 config DMA_SUN6I
 	tristate "Allwinner A31 SoCs DMA support"
 	depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
-	depends on RESET_CONTROLLER
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 35215f6867d3..cb21e3821244 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -1,7 +1,6 @@
 config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
 	depends on DRM && ROCKCHIP_IOMMU
-	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
index e3aa5afc0244..8aeb4cdd76e5 100644
--- a/drivers/gpu/drm/sti/Kconfig
+++ b/drivers/gpu/drm/sti/Kconfig
@@ -1,7 +1,6 @@
 config DRM_STI
 	tristate "DRM Support for STMicroelectronics SoC stiH41x Series"
 	depends on DRM && (SOC_STIH415 || SOC_STIH416 || ARCH_MULTIPLATFORM) && HAVE_DMA_ATTRS
-	select RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 63ebb154b9b5..bbf5a4b7e0b6 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -3,7 +3,6 @@ config DRM_TEGRA
 	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
 	depends on COMMON_CLK
 	depends on DRM
-	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
index aefdff95356d..08766c6e7856 100644
--- a/drivers/gpu/ipu-v3/Kconfig
+++ b/drivers/gpu/ipu-v3/Kconfig
@@ -1,7 +1,6 @@
 config IMX_IPUV3_CORE
 	tristate "IPUv3 core support"
 	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM
-	depends on RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
 	help
 	  Choose this if you have a i.MX5/6 system and want to use the Image
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e24c2b680b47..775134dc7fc3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -886,7 +886,6 @@ config I2C_STU300
 
 config I2C_SUN6I_P2WI
 	tristate "Allwinner sun6i internal P2WI controller"
-	depends on RESET_CONTROLLER
 	depends on MACH_SUN6I || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 7eb5859dd035..53d92382030f 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -17,7 +17,8 @@ config GENERIC_PHY
 
 config PHY_BERLIN_USB
 	tristate "Marvell Berlin USB PHY Driver"
-	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
+	depends on ARCH_BERLIN || COMPILE_TEST
+	depends on HAS_IOMEM && OF
 	select GENERIC_PHY
 	help
 	  Enable this to support the USB PHY on Marvell Berlin SoCs.
@@ -218,7 +219,6 @@ config PHY_MT65XX_USB3
 config PHY_SUN4I_USB
 	tristate "Allwinner sunxi SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
-	depends on RESET_CONTROLLER
 	depends on EXTCON
 	depends on POWER_SUPPLY
 	select GENERIC_PHY
@@ -232,7 +232,6 @@ config PHY_SUN4I_USB
 config PHY_SUN9I_USB
 	tristate "Allwinner sun9i SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
-	depends on RESET_CONTROLLER
 	select GENERIC_PHY
 	help
 	  Enable this to support the transceiver that is part of Allwinner
@@ -342,7 +341,6 @@ config PHY_XGENE
 
 config PHY_STIH407_USB
 	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
-	depends on RESET_CONTROLLER
 	depends on ARCH_STI || COMPILE_TEST
 	select GENERIC_PHY
 	help
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index e68fd951129a..50bd2e37aaeb 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -27,7 +27,6 @@ config PINCTRL_SUN6I_A31S
 
 config PINCTRL_SUN6I_A31_R
 	def_bool MACH_SUN6I
-	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN7I_A20
@@ -48,7 +47,6 @@ config PINCTRL_SUN8I_A83T
 
 config PINCTRL_SUN8I_A23_R
 	def_bool MACH_SUN8I
-	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI_COMMON
 
 config PINCTRL_SUN9I_A80
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 0615f50a14cd..12026a1893b5 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -1,15 +1,24 @@
-config ARCH_HAS_RESET_CONTROLLER
+config RESET_CONTROLLER
 	bool
 
-menuconfig RESET_CONTROLLER
-	bool "Reset Controller Support"
-	default y if ARCH_HAS_RESET_CONTROLLER
-	help
-	  Generic Reset Controller support.
+menu "Reset Controller Support"
+	depends on ARCH_HAS_RESET_CONTROLLER || COMPILE_TEST
 
-	  This framework is designed to abstract reset handling of devices
-	  via GPIOs or SoC-internal reset controller modules.
+config RESET_SOCFPGA
+	bool "Altera SOCFPGA reset controller" if COMPILE_TEST
+	default ARCH_SOCFPGA
+	select RESET_CONTROLLER
 
-	  If unsure, say no.
+config RESET_BERLIN
+	bool "Marvell Berlin reset controller" if COMPILE_TEST
+	default ARCH_BERLIN
+	select RESET_CONTROLLER
+
+config RESET_SUNXI
+	bool "Allwinner reset controller" if COMPILE_TEST
+	default ARCH_SUNXI
+	select RESET_CONTROLLER
 
 source "drivers/reset/sti/Kconfig"
+
+endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 85d5904e5480..e05aeffb692f 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,8 +1,8 @@
 obj-$(CONFIG_RESET_CONTROLLER) += core.o
 obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
-obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
-obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
-obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
-obj-$(CONFIG_ARCH_STI) += sti/
+obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
+obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_RESET_STI_SYSCFG) += sti/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
index f8c15a37fb35..ef9bb8675577 100644
--- a/drivers/reset/sti/Kconfig
+++ b/drivers/reset/sti/Kconfig
@@ -1,19 +1,19 @@
-if ARCH_STI
+if ARCH_STI || COMPILE_TEST
 
-config STI_RESET_SYSCFG
+config RESET_STI_SYSCFG
 	bool
 	select RESET_CONTROLLER
 
-config STIH415_RESET
-	bool
-	select STI_RESET_SYSCFG
+config RESET_STIH415
+	bool "STmicroelectronics STiH415 reset controller" if COMPILE_TEST
+	select RESET_STI_SYSCFG
 
-config STIH416_RESET
-	bool
-	select STI_RESET_SYSCFG
+config RESET_STIH416
+	bool "STmicroelectronics STiH416 reset controller" if COMPILE_TEST
+	select RESET_STI_SYSCFG
 
-config STIH407_RESET
-	bool
-	select STI_RESET_SYSCFG
+config RESET_STIH407
+	bool "STmicroelectronics STiH407 reset controller" if COMPILE_TEST
+	select RESET_STI_SYSCFG
 
 endif
diff --git a/drivers/reset/sti/Makefile b/drivers/reset/sti/Makefile
index dc85dfbe56a9..445bdddf45b9 100644
--- a/drivers/reset/sti/Makefile
+++ b/drivers/reset/sti/Makefile
@@ -1,5 +1,5 @@
-obj-$(CONFIG_STI_RESET_SYSCFG) += reset-syscfg.o
+obj-$(CONFIG_RESET_STI_SYSCFG) += reset-syscfg.o
 
-obj-$(CONFIG_STIH415_RESET) += reset-stih415.o
-obj-$(CONFIG_STIH416_RESET) += reset-stih416.o
-obj-$(CONFIG_STIH407_RESET) += reset-stih407.o
+obj-$(CONFIG_RESET_STIH415) += reset-stih415.o
+obj-$(CONFIG_RESET_STIH416) += reset-stih416.o
+obj-$(CONFIG_RESET_STIH407) += reset-stih407.o
diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 9d5068248aa0..511c40e08780 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -13,7 +13,6 @@ config MTK_INFRACFG
 config MTK_PMIC_WRAP
 	tristate "MediaTek PMIC Wrapper Support"
 	depends on ARCH_MEDIATEK
-	depends on RESET_CONTROLLER
 	select REGMAP
 	help
 	  Say yes here to add support for MediaTek PMIC Wrapper found
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b046fd94346a..4a62428836f3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -527,7 +527,6 @@ config SPI_SH_HSPI
 config SPI_SIRF
 	tristate "CSR SiRFprimaII SPI controller"
 	depends on SIRF_DMA
-	depends on RESET_CONTROLLER
 	select SPI_BITBANG
 	help
 	  SPI driver for CSR SiRFprimaII SoCs
@@ -548,7 +547,6 @@ config SPI_SUN4I
 config SPI_SUN6I
 	tristate "Allwinner A31 SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on RESET_CONTROLLER
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
@@ -562,7 +560,7 @@ config SPI_MXS
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
-	depends on RESET_CONTROLLER && HAS_DMA
+	depends on HAS_DMA
 	help
 	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
 	  is different than the older SoCs SPI controller and also register interface
@@ -571,7 +569,6 @@ config SPI_TEGRA114
 config SPI_TEGRA20_SFLASH
 	tristate "Nvidia Tegra20 Serial flash Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on RESET_CONTROLLER
 	help
 	  SPI driver for Nvidia Tegra20 Serial flash Controller interface.
 	  The main usecase of this controller is to use spi flash as boot
@@ -580,7 +577,7 @@ config SPI_TEGRA20_SFLASH
 config SPI_TEGRA20_SLINK
 	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
-	depends on RESET_CONTROLLER && HAS_DMA
+	depends on HAS_DMA
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c463c89b90ef..2e7524f0f3f7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -205,7 +205,6 @@ config SPEAR_THERMAL
 config ROCKCHIP_THERMAL
 	tristate "Rockchip thermal driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on RESET_CONTROLLER
 	help
 	  Rockchip thermal driver provides support for Temperature sensor
 	  ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 173132416170..7acb038fd26a 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -140,7 +140,6 @@ config USB_ISP1301
 config USB_MSM_OTG
 	tristate "Qualcomm on-chip USB OTG controller support"
 	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
-	depends on RESET_CONTROLLER
 	depends on EXTCON
 	select USB_PHY
 	help
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 7f65f9cff951..56c389347096 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -40,38 +40,49 @@ struct reset_control *of_reset_control_get(struct device_node *node,
 
 #else
 
+#include <linux/device.h>
+#include <linux/of.h>
+
+static inline int __must_check device_reset(struct device *dev)
+{
+	return -ENOSYS;
+}
+
 static inline int reset_control_reset(struct reset_control *rstc)
 {
-	WARN_ON(1);
+	WARN_ON(rstc != NULL);
 	return 0;
 }
 
 static inline int reset_control_assert(struct reset_control *rstc)
 {
-	WARN_ON(1);
+	WARN_ON(rstc != NULL);
 	return 0;
 }
 
 static inline int reset_control_deassert(struct reset_control *rstc)
 {
-	WARN_ON(1);
+	WARN_ON(rstc != NULL);
 	return 0;
 }
 
 static inline int reset_control_status(struct reset_control *rstc)
 {
-	WARN_ON(1);
+	WARN_ON(rstc != NULL);
 	return 0;
 }
 
 static inline void reset_control_put(struct reset_control *rstc)
 {
-	WARN_ON(1);
+	WARN_ON(rstc != NULL);
 }
 
 static inline int device_reset_optional(struct device *dev)
 {
-	return -ENOSYS;
+	if (of_property_read_bool(dev->of_node, "resets"))
+		return -ENOSYS;
+
+	return 0;
 }
 
 static inline struct reset_control *__must_check reset_control_get(
@@ -88,16 +99,21 @@ static inline struct reset_control *__must_check devm_reset_control_get(
 	return ERR_PTR(-EINVAL);
 }
 
+/*
+ * We intentionally return NULL here when no resets are specified
+ * or when building without DT, which is interpreted as 'success'
+ * if reset controller support is left out from the kernel.
+ */
 static inline struct reset_control *reset_control_get_optional(
 					struct device *dev, const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(device_reset_optional(dev));
 }
 
 static inline struct reset_control *devm_reset_control_get_optional(
 					struct device *dev, const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return reset_control_get_optional(dev, id);
 }
 
 static inline struct reset_control *of_reset_control_get(
diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index a6768f832c6f..70f58bd43a56 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -2,7 +2,6 @@ config SND_SOC_TEGRA
 	tristate "SoC Audio for the Tegra System-on-Chip"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
 	depends on COMMON_CLK
-	depends on RESET_CONTROLLER
 	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
