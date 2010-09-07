From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:13:18 +0100
Subject: [PATCH 1/5] h1940: use gpiolib for latch access
In-Reply-To: <1283871605-32068-2-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-1-git-send-email-anarsoul@gmail.com>
	<1283871605-32068-2-git-send-email-anarsoul@gmail.com>
Message-ID: <4C86C70E.7030009@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 16:00, Vasily Khoruzhick wrote:
> This patch adds gpiolib support for h1940 latch.
> With this patch it's possible to use leds-gpio and uda1380
> drivers (they require gpiolib support for appropriate pins).
> And now it's possible to drop leds-h1940 driver.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2410/h1940-bluetooth.c          |   13 +++-
>  arch/arm/mach-s3c2410/include/mach/h1940-latch.h |   57 ++++++------------
>  arch/arm/mach-s3c2410/mach-h1940.c               |   72 ++++++++++++++++++++--
>  arch/arm/plat-s3c24xx/Kconfig                    |    1 +
>  4 files changed, 95 insertions(+), 48 deletions(-)
> 

snip

>  #endif /* __ASM_ARCH_H1940_LATCH_H */
> diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
> index 3ba3bab..2af4afd 100644
> --- a/arch/arm/mach-s3c2410/mach-h1940.c
> +++ b/arch/arm/mach-s3c2410/mach-h1940.c

snip

> -EXPORT_SYMBOL_GPL(h1940_latch_control);
> +static int h1940_gpiolib_latch_input(struct gpio_chip *chip, unsigned offset)
> +{
> +	return -EINVAL;
> +}

does not setting the field have the same effect, if so, please remove.

> +
> +static inline int h1940_gpiolib_to_latch(int offset)
> +{
> +	return 1 << (offset + 16);
> +}
> +
> +static void h1940_gpiolib_latch_set(struct gpio_chip *chip,
> +					unsigned offset, int value)
> +{
> +	int latch_bit = h1940_gpiolib_to_latch(offset);
> +
> +	h1940_latch_control(value ? 0 : latch_bit,
> +		value ? latch_bit : 0);
> +}
> +
> +static int h1940_gpiolib_latch_output(struct gpio_chip *chip,
> +					unsigned offset, int value)
> +{
> +	h1940_gpiolib_latch_set(chip, offset, value);
> +
> +	return 0;
> +}

you could eliminate the blank line in the above.

> +
> +static int h1940_gpiolib_latch_get(struct gpio_chip *chip,
> +					unsigned offset)
> +{
> +	return (latch_state >> (offset + 16)) & 1;
> +}
> +
> +struct gpio_chip h1940_latch_gpiochip = {
> +	.base			= H1940_LATCH_GPIO(0),
> +	.owner			= THIS_MODULE,
> +	.label			= "H1940_LATCH",
> +	.ngpio			= 16,
> +	.direction_input	= h1940_gpiolib_latch_input,
> +	.direction_output	= h1940_gpiolib_latch_output,
> +	.set			= h1940_gpiolib_latch_set,
> +	.get			= h1940_gpiolib_latch_get,
> +};
>  
>  static void h1940_udc_pullup(enum s3c2410_udc_cmd_e cmd)
>  {
> @@ -125,10 +181,10 @@ static void h1940_udc_pullup(enum s3c2410_udc_cmd_e cmd)
>  	switch (cmd)
>  	{
>  		case S3C2410_UDC_P_ENABLE :
> -			h1940_latch_control(0, H1940_LATCH_USB_DP);
> +			gpio_set_value(H1940_LATCH_USB_DP, 1);
>  			break;
>  		case S3C2410_UDC_P_DISABLE :
> -			h1940_latch_control(H1940_LATCH_USB_DP, 0);
> +			gpio_set_value(H1940_LATCH_USB_DP, 0);
>  			break;
>  		case S3C2410_UDC_P_RESET :
>  			break;
> @@ -303,6 +359,8 @@ static void __init h1940_map_io(void)
>  	memcpy(phys_to_virt(H1940_SUSPEND_RESUMEAT), h1940_pm_return, 1024);
>  #endif
>  	s3c_pm_init();
> +
> +	WARN_ON(gpiochip_add(&h1940_latch_gpiochip));
>  }
>  
>  /* H1940 and RX3715 need to reserve this for suspend */
> @@ -342,9 +400,11 @@ static void __init h1940_init(void)
>  	gpio_request(S3C2410_GPC(0), "LCD power");
>  	gpio_request(S3C2410_GPC(5), "LCD power");
>  	gpio_request(S3C2410_GPC(6), "LCD power");
> -
>  	gpio_direction_input(S3C2410_GPC(6));
>  
> +	gpio_request(H1940_LATCH_USB_DP, "USB pullup");
> +	gpio_direction_output(H1940_LATCH_USB_DP, 0);
> +
>  	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
>  }
>  
> diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
> index 984bf66..5a27b1b 100644
> --- a/arch/arm/plat-s3c24xx/Kconfig
> +++ b/arch/arm/plat-s3c24xx/Kconfig
> @@ -69,6 +69,7 @@ config S3C24XX_GPIO_EXTRA
>  	int
>  	default 128 if S3C24XX_GPIO_EXTRA128
>  	default 64 if S3C24XX_GPIO_EXTRA64
> +	default 16 if ARCH_H1940
>  	default 0
>  
>  config S3C24XX_GPIO_EXTRA64

hmm, ok, we really need something in Kconfig to set a variable to
a min value.
