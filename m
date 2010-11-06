From: awg@embtoolkit.org (Abdoulaye Walsimou GAYE)
Date: Sat, 06 Nov 2010 17:09:37 +0100
Subject: [PATCH v2] ARM: s3c2442: Setup gpio {set,get}_pull callbacks
In-Reply-To: <1289030074-5233-1-git-send-email-anarsoul@gmail.com>
References: <1285020052-20020-1-git-send-email-lars@metafoo.de>
	<1289030074-5233-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4CD57DC1.4050403@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2010 08:54 AM, Vasily Khoruzhick wrote:
> Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default structure
> are initalized via s3c_gpio_{get,set}pull_1up. This results in a linker
> error:
>
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f4): undefined reference to
> `s3c_gpio_getpull_1up'
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f8): undefined reference to
> `s3c_gpio_setpull_1up'
>
> The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
> The method of controlling them is the same though.
> So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper functions
> to take an additional parameter deciding whether the pin has a pullup or pulldown.
> The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions passing
> either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.
>
> Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull fields
> in the s3c2442 cpu init function to the new pulldown helper functions.
>
> Based on patch from Lars-Peter Clausen<lars@metafoo.de>
>
> Signed-off-by: Vasily Khoruzhick<anarsoul@gmail.com>
> ---
>
>    

[...]
> diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
> index 24c6f5a..243b641 100644
> --- a/arch/arm/plat-s3c24xx/gpiolib.c
> +++ b/arch/arm/plat-s3c24xx/gpiolib.c
> @@ -82,8 +82,6 @@ static struct s3c_gpio_cfg s3c24xx_gpiocfg_banka = {
>   struct s3c_gpio_cfg s3c24xx_gpiocfg_default = {
>   	.set_config	= s3c_gpio_setcfg_s3c24xx,
>   	.get_config	= s3c_gpio_getcfg_s3c24xx,
> -	.set_pull	= s3c_gpio_setpull_1up,
> -	.get_pull	= s3c_gpio_getpull_1up,
>   };
>
>    

This part of your patch will prevent s3c2440 based boards to boot see [1]

[..]

[1] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bdf5005b738c1542a30b41a83069329313fc61f6

Best regards,
AWG
