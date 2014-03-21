From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:28:04 +0100
Subject: [PATCH 28/62] ARM: pxa: FB_W100 must be built-in
In-Reply-To: <1395257399-359545-29-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-29-git-send-email-arnd@arndb.de>
Message-ID: <201403211728.04429.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Arnd Bergmann wrote:
> The pxa platform code directly calls into the W100 framebuffer
> driver for eseries. This means it cannot be a loadable module
> and we also have to ensure that the core framebuffer code
> is built-in.
> 

Ignore this once, I'll drop it from the series and do a proper
fix, like we did for some of the other patches. It's better 
to change the code not to call into the fb driver if that is
disabled.

	Arnd

> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 96100db..562b17f 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -556,6 +556,7 @@ config MACH_ICONTROL
>  config ARCH_PXA_ESERIES
>  	bool "PXA based Toshiba e-series PDAs"
>  	select FB_W100
> +	select FB
>  	select PXA25x
>  
>  config MACH_E330
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index dade5b7..86873ff 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1996,8 +1996,8 @@ config FB_FSL_DIU
>  	  Framebuffer driver for the Freescale SoC DIU
>  
>  config FB_W100
> -	tristate "W100 frame buffer support"
> -	depends on FB && ARCH_PXA
> +	bool "W100 frame buffer support"
> +	depends on FB=y && ARCH_PXA
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
>   	select FB_CFB_IMAGEBLIT
> -- 
> 1.8.3.2
> 
> 
