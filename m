From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 21:08:48 +0100
Subject: [PATCH 15/15] ARM: mxs: Add build configuration for mxs
In-Reply-To: <1290754154-9428-16-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-16-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101130200848.GB20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 02:49:14PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/Kconfig                   |   10 ++++++++++
>  arch/arm/Makefile                  |    1 +
>  arch/arm/mach-mxs/Kconfig          |   34 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/Makefile         |   14 ++++++++++++++
>  arch/arm/mach-mxs/Makefile.boot    |    3 +++
>  arch/arm/mach-mxs/devices/Kconfig  |    5 +++++
>  arch/arm/mach-mxs/devices/Makefile |    2 ++
>  7 files changed, 69 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/Kconfig
>  create mode 100644 arch/arm/mach-mxs/Makefile
>  create mode 100644 arch/arm/mach-mxs/Makefile.boot
>  create mode 100644 arch/arm/mach-mxs/devices/Kconfig
>  create mode 100644 arch/arm/mach-mxs/devices/Makefile
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db524e7..b0a5130 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -351,6 +351,14 @@ config ARCH_MXC
>  	help
>  	  Support for Freescale MXC/iMX-based family of processors
>  
> +config ARCH_MXS
> +	bool "Freescale MXS-based"
> +	select GENERIC_CLOCKEVENTS
> +	select ARCH_REQUIRE_GPIOLIB
> +	select COMMON_CLKDEV
> +	help
> +	  Support for Freescale MXS-based family of processors
> +
>  config ARCH_STMP3XXX
>  	bool "Freescale STMP3xxx"
>  	select CPU_ARM926T
> @@ -924,6 +932,8 @@ source "arch/arm/plat-pxa/Kconfig"
>  
>  source "arch/arm/mach-mmp/Kconfig"
>  
> +source "arch/arm/mach-mxs/Kconfig"
> +
>  source "arch/arm/mach-realview/Kconfig"
>  
>  source "arch/arm/mach-sa1100/Kconfig"
optimally you should put the source line between mxc and stmp3xxx to
have the same order as in the symbol definition above.

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 057beb8..c22c1ad 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -158,6 +158,7 @@ machine-$(CONFIG_ARCH_MX25)		:= imx
>  machine-$(CONFIG_ARCH_MX3)		:= mx3
>  machine-$(CONFIG_ARCH_MX5)		:= mx5
>  machine-$(CONFIG_ARCH_MXC91231)		:= mxc91231
> +machine-$(CONFIG_ARCH_MXS)		:= mxs
>  machine-$(CONFIG_ARCH_NETX)		:= netx
>  machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
>  machine-$(CONFIG_ARCH_NS9XXX)		:= ns9xxx
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> new file mode 100644
> index 0000000..c4ac7b4
> --- /dev/null
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -0,0 +1,34 @@
> +if ARCH_MXS
> +
> +source "arch/arm/mach-mxs/devices/Kconfig"
> +
> +config SOC_IMX23
> +	bool
> +	select CPU_ARM926T
> +
> +config SOC_IMX28
> +	bool
> +	select CPU_ARM926T
> +
> +comment "MXS platforms:"
> +
> +config MACH_MX23EVK
> +	bool "Support MX23EVK Platform"
> +	select SOC_IMX23
> +	select MXS_HAVE_PLATFORM_DUART
> +	default y
> +	help
> +	  Include support for MX23EVK platform. This includes specific
> +	  configurations for the board and its peripherals.
> +
> +config MACH_MX28EVK
> +	bool "Support MX28EVK Platform"
> +	select SOC_IMX28
> +	select MXS_HAVE_PLATFORM_DUART
> +	select MXS_HAVE_PLATFORM_FEC
> +	default y
> +	help
> +	  Include support for MX28EVK platform. This includes specific
> +	  configurations for the board and its peripherals.
> +
> +endif
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> new file mode 100644
> index 0000000..0b24b0d
> --- /dev/null
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -0,0 +1,14 @@
> +#
> +# Makefile for the linux kernel.
not very helpful
> +#
> +
> +# Common support
> +obj-y := clock.o cpu.o devices.o gpio.o icoll.o iomux.o system.o timer.o
> +
> +obj-$(CONFIG_SOC_IMX23) += clock-mx23.o mm-mx23.o
> +obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
> +
> +obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
> +obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> +
> +obj-y += devices/
> diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
> new file mode 100644
> index 0000000..1568ad4
> --- /dev/null
> +++ b/arch/arm/mach-mxs/Makefile.boot
> @@ -0,0 +1,3 @@
> +   zreladdr-y	:= 0x40008000
> +params_phys-y	:= 0x40000100
> +initrd_phys-y	:= 0x40800000
do you need params_phys and initrd_phys?

> diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> new file mode 100644
> index 0000000..a35a2dc
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -0,0 +1,5 @@
> +config MXS_HAVE_PLATFORM_DUART
> +	bool
> +
> +config MXS_HAVE_PLATFORM_FEC
> +	bool
> diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> new file mode 100644
> index 0000000..4b5266a
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_DUART) += platform-duart.o
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
