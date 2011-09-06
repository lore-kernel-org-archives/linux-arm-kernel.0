From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 09:30:04 +0200
Subject: [RFC/PATCH] ARM: ixp4xx gpiolib support
In-Reply-To: <1315226991-3835-1-git-send-email-kaloz@openwrt.org>
References: <20110905104133.GH6619@n2100.arm.linux.org.uk>
	<1315226991-3835-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20110906073004.GA28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Sep 05, 2011 at 02:49:51PM +0200, Imre Kaloz wrote:
> This patch adds gpiolib support for the IXP4xx platform
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/arm/Kconfig                         |    2 +-
>  arch/arm/mach-ixp4xx/common.c            |   39 +++++++++++++++++++++++++
>  arch/arm/mach-ixp4xx/include/mach/gpio.h |   46 ++++++++++--------------------
>  3 files changed, 55 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3269576..e793a75 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -481,7 +481,7 @@ config ARCH_IXP4XX
>  	depends on MMU
>  	select CLKSRC_MMIO
>  	select CPU_XSCALE
> -	select GENERIC_GPIO
> +	select ARCH_REQUIRE_GPIOLIB
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_SCHED_CLOCK
>  	select MIGHT_HAVE_PCI
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index 0777257..7603456 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -36,6 +36,7 @@
>  #include <asm/page.h>
>  #include <asm/irq.h>
>  #include <asm/sched_clock.h>
> +#include <asm/gpio.h>
>  
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
> @@ -375,12 +376,50 @@ static struct platform_device *ixp46x_devices[] __initdata = {
>  unsigned long ixp4xx_exp_bus_size;
>  EXPORT_SYMBOL(ixp4xx_exp_bus_size);
>  
> +static int ixp4xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
> +{
> +	gpio_line_config(gpio, IXP4XX_GPIO_IN);
> +	return 0;
> +}
> +
> +static int ixp4xx_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int level)
> +{
> +	gpio_line_set(gpio, level);
> +	gpio_line_config(gpio, IXP4XX_GPIO_OUT);
> +	return 0;
> +}
> +
> +static int ixp4xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
> +{
> +	int value;
> +
> +	gpio_line_get(gpio, &value);
> +	return value;
> +}
> +
> +static void ixp4xx_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
> +{
> +	gpio_line_set(gpio, value);
> +}
> +
> +static struct gpio_chip ixp4xx_gpio_chip = {
> +	.label			= "IXP4XX_GPIO_CHIP",
> +	.direction_input	= ixp4xx_gpio_direction_input,
> +	.direction_output	= ixp4xx_gpio_direction_output,
> +	.get			= ixp4xx_gpio_get_value,
> +	.set			= ixp4xx_gpio_set_value,
> +	.base			= 0,
> +	.ngpio			= 16,
> +};
> +
>  void __init ixp4xx_sys_init(void)
>  {
>  	ixp4xx_exp_bus_size = SZ_16M;
>  
>  	platform_add_devices(ixp4xx_devices, ARRAY_SIZE(ixp4xx_devices));
>  
> +	gpiochip_add(&ixp4xx_gpio_chip);
> +
>  	if (cpu_is_ixp46x()) {
>  		int region;
>  
> diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
> index a5f87de..86f3596 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/gpio.h
> @@ -27,47 +27,31 @@
>  
>  #include <linux/kernel.h>
>  #include <mach/hardware.h>
> +#include <asm-generic/gpio.h>			/* cansleep wrappers */
>  
> -static inline int gpio_request(unsigned gpio, const char *label)
> -{
> -	return 0;
> -}
> -
> -static inline void gpio_free(unsigned gpio)
> -{
> -	might_sleep();
> -
> -	return;
> -}
> -
> -static inline int gpio_direction_input(unsigned gpio)
> -{
> -	gpio_line_config(gpio, IXP4XX_GPIO_IN);
> -	return 0;
> -}
> -
> -static inline int gpio_direction_output(unsigned gpio, int level)
> -{
> -	gpio_line_set(gpio, level);
> -	gpio_line_config(gpio, IXP4XX_GPIO_OUT);
> -	return 0;
> -}
> +#define NR_BUILTIN_GPIO 16
>  
>  static inline int gpio_get_value(unsigned gpio)
>  {
> -	int value;
> -
> -	gpio_line_get(gpio, &value);
> -
> -	return value;
> +	if (gpio < NR_BUILTIN_GPIO)
you might want to test the impact of using 

	if (__builtin_constant_p(gpio) && gpio < NR_BUILTIN_GPIO)

here. I don't know what to expect from it, but this is the idiom I saw
when I implemented gpio stuff some years ago.

> +	{
> +		int value;
> +		gpio_line_get(gpio, &value);
> +		return value;
I wonder about the return value of gpio_line_get. If it's void why not
change it to return the value instead of using an output parameter.

> +	}
> +	else
> +		return __gpio_get_value(gpio);
>  }
>  
>  static inline void gpio_set_value(unsigned gpio, int value)
>  {
> -	gpio_line_set(gpio, value);
> +	if (gpio < NR_BUILTIN_GPIO)
> +		gpio_line_set(gpio, value);
> +	else
> +		__gpio_set_value(gpio, value);
>  }
>  
> -#include <asm-generic/gpio.h>			/* cansleep wrappers */
> +#define gpio_cansleep __gpio_cansleep
>  
>  extern int gpio_to_irq(int gpio);
>  extern int irq_to_gpio(unsigned int irq);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
