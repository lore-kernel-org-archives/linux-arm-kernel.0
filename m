From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 12 Apr 2012 08:03:34 +1000
Subject: [PATCH v2] arm: ep93xx: use gpio_led_register_device
In-Reply-To: <201204111429.20038.hartleys@visionengravers.com>
References: <201204111429.20038.hartleys@visionengravers.com>
Message-ID: <4F85FFB6.8050406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/12 07:29, H Hartley Sweeten wrote:

> Use gpio_led_register_device to register the two leds
> connected to the ep93xx.
> 
> Since this is a common feature for all ep93xx based boards,
> create a new Kconfig option, ARCH_EP93XX_TYPICAL, to select
> the LEDS_GPIO_REGISTER feature.
> 
> The struct gpio_led and struct gpio_led_platform_data variables
> have been changed to const struct because of:
> 
> commit 9517f925f2eb9ffca78b3f0f9389fc675bcb572c
>     leds: make *struct gpio_led_platform_data.leds const
> 
> They have also been marked as __initconst because the helper
> function gpio_led_register_device makes a deep copy of the
> platform data to allow it to live in init memory:
> 
> commit 4440673a95e63ad888a41db596edaa0c55d3a332
>     leds: provide helper to register "leds-gpio" devices
> 
> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index 97a2493..19d8148 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -2,6 +2,11 @@ if ARCH_EP93XX
>  
>  menu "Cirrus EP93xx Implementation Options"
>  
> +config ARCH_EP93XX_TYPICAL


One minor change. Please use a different name for this. Since all
of the boards use this and it cannot be unselected, its a bit
misleading to call it typical. EP93XX_SOC or EP93XX_COMMON would
be a bit better.

~Ryan

> +	bool
> +	default y
> +	select LEDS_GPIO_REGISTER
> +
