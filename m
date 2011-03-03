From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 3 Mar 2011 13:26:54 +0800
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110303052653.GA19961@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
On Wed, Mar 02, 2011 at 06:23:05PM +0100, Uwe Kleine-K?nig wrote:
> The only use of selecting MX2-based before was to get the choice to select
> between i.MX21 and i.MX27. So better provide this choice directly.
> 
> Note that this has an influence on reduced i.MX21 configs because the
> former default "MACH_MX21" for the "CPUs" choice makes MACH_MX21 not
> appear in the reduced config and so the default for "Freescale CPU family:"
> (i.e. ARCH_MX3) is used now.  mx21_defconfig is adapted not to be affected
> by this problem.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/configs/mx21_defconfig |    2 +-
>  arch/arm/configs/mx27_defconfig |    1 -
>  arch/arm/mach-imx/Kconfig       |   20 --------------------
>  arch/arm/plat-mxc/Kconfig       |   19 ++++++++++++++++---
>  4 files changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/configs/mx21_defconfig b/arch/arm/configs/mx21_defconfig
> index a5a71c2..761fea6 100644
> --- a/arch/arm/configs/mx21_defconfig
> +++ b/arch/arm/configs/mx21_defconfig
> @@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_ARCH_MXC=y
> -CONFIG_ARCH_MX2=y
> +CONFIG_MACH_MX21=y
>  CONFIG_MACH_MX21ADS=y
>  CONFIG_MXC_PWM=y
>  CONFIG_NO_HZ=y
> diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
> index 3817c60..098d77d 100644
> --- a/arch/arm/configs/mx27_defconfig
> +++ b/arch/arm/configs/mx27_defconfig
> @@ -17,7 +17,6 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_ARCH_MXC=y
> -CONFIG_ARCH_MX2=y
>  CONFIG_MACH_MX27=y
>  CONFIG_MACH_MX27ADS=y
>  CONFIG_MACH_PCM038=y
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c172418..c94cbad 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -53,26 +53,6 @@ config MACH_SCB9328
>  
>  endif
>  
> -if ARCH_MX2
> -
> -choice
> -	prompt "CPUs:"
> -	default MACH_MX21
> -
> -config MACH_MX21
> -	bool "i.MX21 support"
> -	help
> -	  This enables support for Freescale's MX2 based i.MX21 processor.
> -
> -config MACH_MX27
> -	bool "i.MX27 support"
> -	help
> -	  This enables support for Freescale's MX2 based i.MX27 processor.
> -
> -endchoice
> -
> -endif
> -
>  if MACH_MX21
>  
>  comment "MX21 platforms:"
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 389f217..03a9a9e 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -2,6 +2,10 @@ if ARCH_MXC
>  
>  source "arch/arm/plat-mxc/devices/Kconfig"
>  
> +config ARCH_MX2
> +	# don't use this in new code
> +	bool
> +
>  menu "Freescale MXC Implementations"
>  
>  choice
> @@ -14,16 +18,25 @@ config ARCH_MX1
>  	help
>  	  This enables support for systems based on the Freescale i.MX1 family
>  
> -config ARCH_MX2
> -	bool "MX2-based"
> +config MACH_MX21
> +	bool "MX21-based"
> +	select ARCH_MX2
>  	help
> -	  This enables support for systems based on the Freescale i.MX2 family
> +	  This enables support for systems based on the Freescale i.MX21 family
Is it ToDo marker like ARCH_51? Why is it MACH_xx while others are ARCH_XX?
It might be little strange that mx2x is a excetion while others are grouped.

Thanks
Richard
>  
>  config ARCH_MX25
>  	bool "MX25-based"
> +	# note that i.MX25 doesn't match the expectations that are currently
> +	# called ARCH_MX2
>  	help
>  	  This enables support for systems based on the Freescale i.MX25 family
>  
> +config MACH_MX27
> +	bool "MX27-based"
> +	select ARCH_MX2
> +	help
> +	  This enables support for Freescale's MX2 based i.MX27 processor.
> +
>  config ARCH_MX3
>  	bool "MX3-based"
>  	select CPU_V6
> -- 
> 1.7.2.3
> 
> 
