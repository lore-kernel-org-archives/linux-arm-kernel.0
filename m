From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Nov 2010 18:01:13 +0100
Subject: [PATCH 11/11] ARM: imx: Add i.MX28 support into Kconfig and
	Makefile
In-Reply-To: <1289831795-4373-12-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
	<1289831795-4373-12-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101115170113.GQ8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:36:35PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig          |   20 ++++++++++++++++++++
>  arch/arm/mach-imx/Makefile         |    4 ++++
>  arch/arm/mach-imx/Makefile.boot    |    4 ++++
>  arch/arm/plat-mxc/Kconfig          |   12 ++++++++++++
>  arch/arm/plat-mxc/Makefile         |    4 +++-
>  arch/arm/plat-mxc/devices/Kconfig  |    3 +++
>  arch/arm/plat-mxc/devices/Makefile |    1 +
>  7 files changed, 47 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index d6e998f..8accd5c 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -199,3 +199,23 @@ config MACH_MXT_TD60
>  	  includes specific configurations for the module and its peripherals.
>  
>  endif
> +
> +if ARCH_MX28
> +
> +config SOC_IMX28
> +	select CPU_ARM926T
> +	select ARCH_MXC_IOMUX_PINCTRL
> +	select MXC_ICOLL
> +	bool
> +
> +comment "MX28 platforms:"
> +
> +config MACH_MX28EVK
> +	bool "MX28 EVK platform"
> +	select IMX_HAVE_PLATFORM_DUART
> +	help
> +	  Include support for MX28 EVK platform. This includes specific
> +	  configurations for the board and its peripherals.
> +
> +endif
> +
please remove the new line at EOF.

> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 5582692..3b12218 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -14,6 +14,8 @@ obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
>  obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
>  obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o
>  
> +obj-$(CONFIG_ARCH_MX28) += clock-imx28.o mm-imx28.o
> +
>  # Support for CMOS sensor interface
>  obj-$(CONFIG_MX1_VIDEO)	+= mx1-camera-fiq.o mx1-camera-fiq-ksym.o
>  
> @@ -32,3 +34,5 @@ obj-$(CONFIG_MACH_CPUIMX27) += mach-cpuimx27.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
>  obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
>  obj-$(CONFIG_MACH_MXT_TD60) += mach-mxt_td60.o
> +
> +obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
> index 7988a85..fd451d0 100644
> --- a/arch/arm/mach-imx/Makefile.boot
> +++ b/arch/arm/mach-imx/Makefile.boot
> @@ -9,3 +9,7 @@ initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
>  zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
>  params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
>  initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
> +
> +zreladdr-$(CONFIG_ARCH_MX28)	:= 0x40008000
> +params_phys-$(CONFIG_ARCH_MX28)	:= 0x40000100
> +initrd_phys-$(CONFIG_ARCH_MX28)	:= 0x40800000
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 680aeba..fd7ec19 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -25,6 +25,12 @@ config ARCH_MX25
>  	help
>  	  This enables support for systems based on the Freescale i.MX25 family
>  
> +config ARCH_MX28
> +	bool "MX28-based"
> +	select SOC_IMX28
Can you please let the machines select SOC_IMX28?

> +	help
> +	  This enables support for systems based on the Freescale i.MX28 family
> +
>  config ARCH_MX3
>  	bool "MX3-based"
>  	select CPU_V6
> @@ -68,6 +74,9 @@ config MXC_TZIC
>  config MXC_AVIC
>  	bool
>  
> +config MXC_ICOLL
> +	bool
> +
>  config MXC_PWM
>  	tristate "Enable PWM driver"
>  	select HAVE_PWM
> @@ -109,6 +118,9 @@ config IMX_HAVE_IOMUX_V1
>  config ARCH_MXC_IOMUX_V3
>  	bool
>  
> +config ARCH_MXC_IOMUX_PINCTRL
> +	bool
> +
>  config ARCH_MXC_AUDMUX_V1
>  	bool
>  
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 0e12591..e194468 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -5,12 +5,14 @@
>  # Common support
>  obj-y := clock.o gpio.o time.o devices.o cpu.o system.o
>  
> -# MX51 uses the TZIC interrupt controller, older platforms use AVIC (irq.o)
>  obj-$(CONFIG_MXC_TZIC) += tzic.o
>  obj-$(CONFIG_MXC_AVIC) += avic.o
> +obj-$(CONFIG_MXC_ICOLL) += icoll.o
>  
>  obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
>  obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
> +obj-$(CONFIG_ARCH_MXC_IOMUX_PINCTRL) += iomux-pinctrl.o
> +
>  obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
>  obj-$(CONFIG_MXC_PWM)  += pwm.o
>  obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index 9aa6f3e..e8860d9 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -1,3 +1,6 @@
> +config IMX_HAVE_PLATFORM_DUART
> +	bool
> +
>  config IMX_HAVE_PLATFORM_ESDHC
>  	bool
>  
> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
> index 45aefeb..11e2fcf 100644
> --- a/arch/arm/plat-mxc/devices/Makefile
> +++ b/arch/arm/plat-mxc/devices/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_DUART) += platform-duart.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_ESDHC) += platform-esdhc.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
