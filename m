From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 29 Apr 2014 01:59:20 +0200
Subject: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
In-Reply-To: <5523458.JVZJJObMjC@wuerfel>
References: <5523458.JVZJJObMjC@wuerfel>
Message-ID: <535EEB58.60809@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Thanks a lot for the patch.

On 04/28/2014 11:07 AM, Arnd Bergmann wrote:
> Commit 4df42de9d3e "gpio: omap: add a GPIO_OMAP option instead of using
> ARCH_OMAP" made it possible to build OMAP kernels without the GPIO driver,
> which at least on OMAP2 and OMAP3 causes build errors because of functions
> used by the platform power management code:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_prepare_for_idle'
> arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_resume_after_idle'
> 
> We presumably always want the GPIO driver on OMAP, so this adds a slightly
> broader dependency and only allows disabling the driver only when no
> OMAP2PLUS platform is selected.
>

This driver is also used by OMAP1. Even when disabling GPIO_OMAP on that
platform doesn't cause a build error since no function defined in the driver is
used directly by platform code, I think that we always want this driver on OMAP1
too.

> However, it seems entirely reasonable to include the driver in build tests
> on other platforms, so we should also allow building it for COMPILE_TEST
> builds and select the required GENERIC_IRQ_CHIP that may not already be
> enabled on other platforms.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index c58b828..c8c42be 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -244,9 +244,10 @@ config GPIO_OCTEON
>  	  family of SOCs.
>  
>  config GPIO_OMAP
> -	bool "TI OMAP GPIO support"
> +	bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS

So this should be:

+       bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS &&
!ARCH_OMAP1

>  	default y if ARCH_OMAP
> -	depends on ARM && ARCH_OMAP
> +	depends on ARM
> +	select GENERIC_IRQ_CHIP
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Say yes here to enable GPIO support for TI OMAP SoCs.
> 

With that change:

Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
