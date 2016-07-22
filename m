From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 22 Jul 2016 17:02:24 -0400
Subject: [PATCH v2 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <4648059.qaGUNaKlSl@wuerfel>
References: <1469092768-17489-1-git-send-email-gabriel.fernandez@st.com>
 <34955897.5sjo821nJx@wuerfel>
 <20160721231602.GK21225@windriver.com> <4648059.qaGUNaKlSl@wuerfel>
Message-ID: <20160722210223.GG11410@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH v2 3/4] drivers: reset: Add STM32 reset driver] On 22/07/2016 (Fri 21:25) Arnd Bergmann wrote:

> On Thursday, July 21, 2016 7:16:02 PM CEST Paul Gortmaker wrote:
> 
> > > > ...we probably don't need module.h here or any of the other
> > > > MODULE_<blah> tags/macros either.  Use the builtin for the
> > > > register and all should be good.
> > > 
> > > I wonder if we should have separate symbols for each reset driver
> > > instead. Those could be allowed to be tristate, and could also
> > > be enabled for compile testing on other architectures.
> > 
> > I'm not quite clear on what you mean by the above.  Maybe if you have a
> > pointer to an example -- say like the work you mention below -- then
> > I'll understand what you have in mind.
> 
> I mean instead of having each driver compiled implicitly when the
> ARCH_* symbol is enabled, make the drivers user-selectable
> and just default to 'y' when the platform is enabled. This would
> let us actually use modular reset drivers where appropriate
> (which might be nowhere, but at least we wouldn't forbid it
> for no reason).

Aha, OK now I understand.  I suppose that would also allow them to be
exposed to allyesconfig and/or COMPILE_TEST too, although I still think
in the case of ARM one has to walk the defconfigs to get good compile
test coverage -- at least for the treewide stuff I tend to do.

Paul.
--

> 
> Another annoying thing is that all platforms today need to
> select two symbols
> 
>  	select ARCH_HAS_RESET_CONTROLLER
> 	select RESET_CONTROLLER
> 
> in order to actually build the driver, and the second one is
> user-selectable, meaning you can still disable all of them today,
> just not individual drivers.
> 
> The patch below is something I did a long time ago for my
> randconfig test branch and have kept forward-ported. It's
> probably bitrotten by now and wrong, but you should get the
> idea.
> 
> 	Arnd
> 
> commit ee86e4aad86ddce56a5858ddb5bb62d08b54e8f0
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Feb 24 15:30:30 2015 +0100
> 
>     rework RESET_CONTROLLER handling
> 
>  arch/arm/mach-berlin/Kconfig     |  1 -
>  arch/arm/mach-imx/Kconfig        |  1 -
>  arch/arm/mach-mmp/Kconfig        |  2 ++
>  arch/arm/mach-prima2/Kconfig     |  3 +--
>  arch/arm/mach-rockchip/Kconfig   |  2 +-
>  arch/arm/mach-sti/Kconfig        |  2 --
>  arch/arm/mach-sunxi/Kconfig      |  1 -
>  arch/arm/mach-sunxi/sunxi.c      |  2 +-
>  arch/arm/mach-tegra/Kconfig      |  1 -
>  drivers/dma/Kconfig              |  1 -
>  drivers/gpu/drm/rockchip/Kconfig |  1 -
>  drivers/gpu/drm/tegra/Kconfig    |  1 -
>  drivers/gpu/ipu-v3/Kconfig       |  1 -
>  drivers/i2c/busses/Kconfig       |  1 -
>  drivers/phy/Kconfig              |  6 ++----
>  drivers/pinctrl/sunxi/Kconfig    |  2 --
>  drivers/reset/Kconfig            | 27 ++++++++++++++++-----------
>  drivers/reset/Makefile           | 10 +++++-----
>  drivers/reset/sti/Kconfig        | 22 +++++++++++-----------
>  drivers/reset/sti/Makefile       |  8 ++++----
>  drivers/soc/mediatek/Kconfig     |  1 -
>  drivers/spi/Kconfig              |  7 ++-----
>  drivers/thermal/Kconfig          |  1 -
>  drivers/usb/phy/Kconfig          |  1 -
>  include/linux/reset.h            | 34 +++++++++++++++++++++++++---------
>  sound/soc/tegra/Kconfig          |  1 -
>  26 files changed, 70 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index 63ab1d368625..9ca262538e91 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -1,7 +1,6 @@
>  menuconfig ARCH_BERLIN
>  	bool "Marvell Berlin SoCs"
>  	depends on ARCH_MULTI_V7
> -	select ARCH_HAS_RESET_CONTROLLER
>  	select ARM_GIC
>  	select DW_APB_ICTL
>  	select DW_APB_TIMER_OF
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index ee9a318cab31..e72c5dcb2ea3 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -56,7 +56,6 @@ config HAVE_IMX_MMDC
>  
>  config HAVE_IMX_SRC
>  	def_bool y if SMP
> -	select ARCH_HAS_RESET_CONTROLLER
>  
>  config IMX_HAVE_IOMUX_V1
>  	bool
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 94500bed56ab..e2130e051d7f 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -111,6 +111,7 @@ config MACH_MMP_DT
>  	select PINCTRL_SINGLE
>  	select COMMON_CLK
>  	select ARCH_HAS_RESET_CONTROLLER
> +	select RESET_CONTROLLER
>  	select CPU_MOHAWK
>  	help
>  	  Include support for Marvell MMP2 based platforms using
> @@ -123,6 +124,7 @@ config MACH_MMP2_DT
>  	select PINCTRL
>  	select PINCTRL_SINGLE
>  	select ARCH_HAS_RESET_CONTROLLER
> +	select RESET_CONTROLLER
>  	select CPU_PJ4
>  	help
>  	  Include support for Marvell MMP2 based platforms using
> diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
> index 85e874a97337..6a28cfa89069 100644
> --- a/arch/arm/mach-prima2/Kconfig
> +++ b/arch/arm/mach-prima2/Kconfig
> @@ -1,14 +1,13 @@
>  menuconfig ARCH_SIRF
>  	bool "CSR SiRF"
>  	depends on ARCH_MULTI_V7
> -	select ARCH_HAS_RESET_CONTROLLER
> -	select RESET_CONTROLLER
>  	select GENERIC_IRQ_CHIP
>  	select GPIOLIB
>  	select NO_IOPORT_MAP
>  	select REGMAP
>  	select PINCTRL
>  	select PINCTRL_SIRF
> +	select RESET_CONTROLLER
>  	help
>  	  Support for CSR SiRFprimaII/Marco/Polo platforms
>  
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 9ad84cd01ba0..b67dfc23ddbb 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -3,7 +3,6 @@ config ARCH_ROCKCHIP
>  	depends on ARCH_MULTI_V7
>  	select PINCTRL
>  	select PINCTRL_ROCKCHIP
> -	select ARCH_HAS_RESET_CONTROLLER
>  	select ARM_AMBA
>  	select ARM_GIC
>  	select CACHE_L2X0
> @@ -13,6 +12,7 @@ config ARCH_ROCKCHIP
>  	select HAVE_ARM_TWD if SMP
>  	select DW_APB_TIMER_OF
>  	select REGULATOR if PM
> +	select RESET_CONTROLLER
>  	select ROCKCHIP_TIMER
>  	select ARM_GLOBAL_TIMER
>  	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> index 119e1108b1f8..7ceb3f9a0ca5 100644
> --- a/arch/arm/mach-sti/Kconfig
> +++ b/arch/arm/mach-sti/Kconfig
> @@ -8,7 +8,6 @@ menuconfig ARCH_STI
>  	select PINCTRL
>  	select PINCTRL_ST
>  	select MFD_SYSCON
> -	select ARCH_HAS_RESET_CONTROLLER
>  	select HAVE_ARM_SCU if SMP
>  	select GPIOLIB
>  	select ARM_ERRATA_754322
> @@ -16,7 +15,6 @@ menuconfig ARCH_STI
>  	select ARM_ERRATA_775420
>  	select PL310_ERRATA_753970 if CACHE_L2X0
>  	select PL310_ERRATA_769419 if CACHE_L2X0
> -	select RESET_CONTROLLER
>  	help
>  	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
>  	  STiH418 family SoCs using the Device Tree for discovery.  More
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 096ed216c6d5..b6427c08a7ff 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,7 +1,6 @@
>  menuconfig ARCH_SUNXI
>  	bool "Allwinner SoCs"
>  	depends on ARCH_MULTI_V7
> -	select ARCH_HAS_RESET_CONTROLLER
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
>  	select GPIOLIB
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 95dca8c2c9ed..1f7093166792 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -39,7 +39,7 @@ extern void __init sun6i_reset_init(void);
>  static void __init sun6i_timer_init(void)
>  {
>  	of_clk_init(NULL);
> -	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
> +	if (IS_ENABLED(CONFIG_RESET_SUNXI))
>  		sun6i_reset_init();
>  	clocksource_probe();
>  }
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 329f01c5b6f8..6986fee549cb 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,7 +10,6 @@ menuconfig ARCH_TEGRA
>  	select HAVE_ARM_TWD if SMP
>  	select PINCTRL
>  	select PM_OPP
> -	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
>  	select SOC_BUS
>  	help
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 739f797b40d9..675dcef0ac85 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -159,7 +159,6 @@ config DMA_SUN4I
>  config DMA_SUN6I
>  	tristate "Allwinner A31 SoCs DMA support"
>  	depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
> -	depends on RESET_CONTROLLER
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 3c58669a06ce..6f7f9c59f05b 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -1,7 +1,6 @@
>  config DRM_ROCKCHIP
>  	tristate "DRM Support for Rockchip"
>  	depends on DRM && ROCKCHIP_IOMMU
> -	depends on RESET_CONTROLLER
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 63ebb154b9b5..bbf5a4b7e0b6 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -3,7 +3,6 @@ config DRM_TEGRA
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>  	depends on COMMON_CLK
>  	depends on DRM
> -	depends on RESET_CONTROLLER
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL
> diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
> index aefdff95356d..08766c6e7856 100644
> --- a/drivers/gpu/ipu-v3/Kconfig
> +++ b/drivers/gpu/ipu-v3/Kconfig
> @@ -1,7 +1,6 @@
>  config IMX_IPUV3_CORE
>  	tristate "IPUv3 core support"
>  	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM
> -	depends on RESET_CONTROLLER
>  	select GENERIC_IRQ_CHIP
>  	help
>  	  Choose this if you have a i.MX5/6 system and want to use the Image
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 5c3993b26129..5913f7c7318a 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -891,7 +891,6 @@ config I2C_STU300
>  
>  config I2C_SUN6I_P2WI
>  	tristate "Allwinner sun6i internal P2WI controller"
> -	depends on RESET_CONTROLLER
>  	depends on MACH_SUN6I || COMPILE_TEST
>  	help
>  	  If you say yes to this option, support will be included for the
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 19bff3a10f69..f685397fd3ac 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -26,7 +26,8 @@ config PHY_BCM_NS_USB2
>  
>  config PHY_BERLIN_USB
>  	tristate "Marvell Berlin USB PHY Driver"
> -	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
> +	depends on ARCH_BERLIN || COMPILE_TEST
> +	depends on HAS_IOMEM && OF
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the USB PHY on Marvell Berlin SoCs.
> @@ -255,7 +256,6 @@ config PHY_HI6220_USB
>  config PHY_SUN4I_USB
>  	tristate "Allwinner sunxi SoC USB PHY driver"
>  	depends on ARCH_SUNXI && HAS_IOMEM && OF
> -	depends on RESET_CONTROLLER
>  	depends on EXTCON
>  	depends on POWER_SUPPLY
>  	select GENERIC_PHY
> @@ -269,7 +269,6 @@ config PHY_SUN4I_USB
>  config PHY_SUN9I_USB
>  	tristate "Allwinner sun9i SoC USB PHY driver"
>  	depends on ARCH_SUNXI && HAS_IOMEM && OF
> -	depends on RESET_CONTROLLER
>  	depends on USB_SUPPORT
>  	select USB_COMMON
>  	select GENERIC_PHY
> @@ -395,7 +394,6 @@ config PHY_XGENE
>  
>  config PHY_STIH407_USB
>  	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
> -	depends on RESET_CONTROLLER
>  	depends on ARCH_STI || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index aaf075b972f5..c55a6750f4b8 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -27,7 +27,6 @@ config PINCTRL_SUN6I_A31S
>  
>  config PINCTRL_SUN6I_A31_R
>  	def_bool MACH_SUN6I
> -	depends on RESET_CONTROLLER
>  	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN7I_A20
> @@ -48,7 +47,6 @@ config PINCTRL_SUN8I_A83T
>  
>  config PINCTRL_SUN8I_A23_R
>  	def_bool MACH_SUN8I
> -	depends on RESET_CONTROLLER
>  	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN8I_H3
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 4be1b8c21f6f..05d6afc8cff8 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -1,18 +1,23 @@
> -config ARCH_HAS_RESET_CONTROLLER
> +config RESET_CONTROLLER
>  	bool
>  
> -menuconfig RESET_CONTROLLER
> -	bool "Reset Controller Support"
> -	default y if ARCH_HAS_RESET_CONTROLLER
> -	help
> -	  Generic Reset Controller support.
> +menu "Reset Controller Support"
> +	depends on ARCH_HAS_RESET_CONTROLLER || COMPILE_TEST
>  
> -	  This framework is designed to abstract reset handling of devices
> -	  via GPIOs or SoC-internal reset controller modules.
> +config RESET_SOCFPGA
> +	bool "Altera SOCFPGA reset controller" if COMPILE_TEST
> +	default ARCH_SOCFPGA
> +	select RESET_CONTROLLER
>  
> -	  If unsure, say no.
> +config RESET_BERLIN
> +	bool "Marvell Berlin reset controller" if COMPILE_TEST
> +	default ARCH_BERLIN
> +	select RESET_CONTROLLER
>  
> -if RESET_CONTROLLER
> +config RESET_SUNXI
> +	bool "Allwinner reset controller" if COMPILE_TEST
> +	default ARCH_SUNXI
> +	select RESET_CONTROLLER
>  
>  config RESET_OXNAS
>  	bool
> @@ -30,4 +35,4 @@ config TI_SYSCON_RESET
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  
> -endif
> +endmenu
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 5d65a93d3c43..7e610e409dae 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,11 +1,11 @@
>  obj-y += core.o
> -obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
> -obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
> -obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
> +obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
> +obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_RESET_HISI) += hisilicon/
>  obj-$(CONFIG_ARCH_MESON) += reset-meson.o
> -obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
> -obj-$(CONFIG_ARCH_STI) += sti/
> +obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> +obj-$(CONFIG_RESET_STI_SYSCFG) += sti/
>  obj-$(CONFIG_ARCH_HISI) += hisilicon/
>  obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_ATH79) += reset-ath79.o
> diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
> index 613178553612..20ea1a147afb 100644
> --- a/drivers/reset/sti/Kconfig
> +++ b/drivers/reset/sti/Kconfig
> @@ -1,18 +1,18 @@
> -if ARCH_STI
> +if ARCH_STI || COMPILE_TEST
>  
> -config STI_RESET_SYSCFG
> +config RESET_STI_SYSCFG
>  	bool
>  
> -config STIH415_RESET
> -	bool
> -	select STI_RESET_SYSCFG
> +config RESET_STIH415
> +	bool "STmicroelectronics STiH415 reset controller" if COMPILE_TEST
> +	select RESET_STI_SYSCFG
>  
> -config STIH416_RESET
> -	bool
> -	select STI_RESET_SYSCFG
> +config RESET_STIH416
> +	bool "STmicroelectronics STiH416 reset controller" if COMPILE_TEST
> +	select RESET_STI_SYSCFG
>  
> -config STIH407_RESET
> -	bool
> -	select STI_RESET_SYSCFG
> +config RESET_STIH407
> +	bool "STmicroelectronics STiH407 reset controller" if COMPILE_TEST
> +	select RESET_STI_SYSCFG
>  
>  endif
> diff --git a/drivers/reset/sti/Makefile b/drivers/reset/sti/Makefile
> index dc85dfbe56a9..445bdddf45b9 100644
> --- a/drivers/reset/sti/Makefile
> +++ b/drivers/reset/sti/Makefile
> @@ -1,5 +1,5 @@
> -obj-$(CONFIG_STI_RESET_SYSCFG) += reset-syscfg.o
> +obj-$(CONFIG_RESET_STI_SYSCFG) += reset-syscfg.o
>  
> -obj-$(CONFIG_STIH415_RESET) += reset-stih415.o
> -obj-$(CONFIG_STIH416_RESET) += reset-stih416.o
> -obj-$(CONFIG_STIH407_RESET) += reset-stih407.o
> +obj-$(CONFIG_RESET_STIH415) += reset-stih415.o
> +obj-$(CONFIG_RESET_STIH416) += reset-stih416.o
> +obj-$(CONFIG_RESET_STIH407) += reset-stih407.o
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 0a4ea809a61b..8e47d52766b7 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -13,7 +13,6 @@ config MTK_INFRACFG
>  config MTK_PMIC_WRAP
>  	tristate "MediaTek PMIC Wrapper Support"
>  	depends on ARCH_MEDIATEK
> -	depends on RESET_CONTROLLER
>  	select REGMAP
>  	help
>  	  Say yes here to add support for MediaTek PMIC Wrapper found
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index c91493613238..c606e136f3c6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -575,7 +575,6 @@ config SPI_SH_HSPI
>  config SPI_SIRF
>  	tristate "CSR SiRFprimaII SPI controller"
>  	depends on SIRF_DMA
> -	depends on RESET_CONTROLLER
>  	select SPI_BITBANG
>  	help
>  	  SPI driver for CSR SiRFprimaII SoCs
> @@ -596,7 +595,6 @@ config SPI_SUN4I
>  config SPI_SUN6I
>  	tristate "Allwinner A31 SPI controller"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on RESET_CONTROLLER
>  	help
>  	  This enables using the SPI controller on the Allwinner A31 SoCs.
>  
> @@ -610,7 +608,7 @@ config SPI_MXS
>  config SPI_TEGRA114
>  	tristate "NVIDIA Tegra114 SPI Controller"
>  	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> -	depends on RESET_CONTROLLER && HAS_DMA
> +	depends on HAS_DMA
>  	help
>  	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
>  	  is different than the older SoCs SPI controller and also register interface
> @@ -619,7 +617,6 @@ config SPI_TEGRA114
>  config SPI_TEGRA20_SFLASH
>  	tristate "Nvidia Tegra20 Serial flash Controller"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> -	depends on RESET_CONTROLLER
>  	help
>  	  SPI driver for Nvidia Tegra20 Serial flash Controller interface.
>  	  The main usecase of this controller is to use spi flash as boot
> @@ -628,7 +625,7 @@ config SPI_TEGRA20_SFLASH
>  config SPI_TEGRA20_SLINK
>  	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
>  	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> -	depends on RESET_CONTROLLER && HAS_DMA
> +	depends on HAS_DMA
>  	help
>  	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
>  
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 8303823d7f07..e4e59701f7df 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -207,7 +207,6 @@ config SPEAR_THERMAL
>  config ROCKCHIP_THERMAL
>  	tristate "Rockchip thermal driver"
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on RESET_CONTROLLER
>  	depends on HAS_IOMEM
>  	help
>  	  Rockchip thermal driver provides support for Temperature sensor
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 4b5e5c8ecefd..5538e04c3356 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -146,7 +146,6 @@ config USB_MSM_OTG
>  	tristate "Qualcomm on-chip USB OTG controller support"
>  	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
>  	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
> -	depends on RESET_CONTROLLER
>  	depends on EXTCON
>  	select USB_PHY
>  	select QCOM_TCSR if ARCH_QCOM
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 5daff15722d3..4ec41b11e090 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -27,33 +27,41 @@ static inline int device_reset_optional(struct device *dev)
>  
>  #else
>  
> +#include <linux/device.h>
> +#include <linux/of.h>
> +
> +static inline int __must_check device_reset(struct device *dev)
> +{
> +	return -ENOSYS;
> +}
> +
>  static inline int reset_control_reset(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline int reset_control_assert(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline int reset_control_deassert(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline int reset_control_status(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline void reset_control_put(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  }
>  
>  static inline int __must_check device_reset(struct device *dev)
> @@ -64,21 +72,24 @@ static inline int __must_check device_reset(struct device *dev)
>  
>  static inline int device_reset_optional(struct device *dev)
>  {
> -	return -ENOTSUPP;
> +	if (of_property_read_bool(dev->of_node, "resets"))
> +		return -ENOSYS;
> +
> +	return 0;
>  }
>  
>  static inline struct reset_control *__of_reset_control_get(
>  					struct device_node *node,
>  					const char *id, int index, int shared)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(device_reset_optional(dev));
>  }
>  
>  static inline struct reset_control *__devm_reset_control_get(
>  					struct device *dev,
>  					const char *id, int index, int shared)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(device_reset_optional(dev));
>  }
>  
>  #endif /* CONFIG_RESET_CONTROLLER */
> @@ -330,10 +341,15 @@ static inline struct reset_control *reset_control_get(
>  	return reset_control_get_exclusive(dev, id);
>  }
>  
> +/*
> + * We intentionally return NULL here when no resets are specified
> + * or when building without DT, which is interpreted as 'success'
> + * if reset controller support is left out from the kernel.
> + */
>  static inline struct reset_control *reset_control_get_optional(
>  					struct device *dev, const char *id)
>  {
> -	return reset_control_get_optional_exclusive(dev, id);
> +	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
>  }
>  
>  static inline struct reset_control *of_reset_control_get(
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> index a6768f832c6f..70f58bd43a56 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -2,7 +2,6 @@ config SND_SOC_TEGRA
>  	tristate "SoC Audio for the Tegra System-on-Chip"
>  	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
>  	depends on COMMON_CLK
> -	depends on RESET_CONTROLLER
>  	select REGMAP_MMIO
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	help
> 
