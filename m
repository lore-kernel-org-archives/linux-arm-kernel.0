From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 7 Jun 2010 23:54:10 +0100
Subject: mini2440 (likely more boards) boot failure because of recent
	changes in s3c gpio
In-Reply-To: <4C0BF34A.1060805@walsimou.com>
References: <4C0BF34A.1060805@walsimou.com>
Message-ID: <20100607225410.GT7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 06, 2010 at 09:13:14PM +0200, Abdoulaye Walsimou Gaye wrote:
> Hello list,
> Recent changes in s3c gpio break mini2440 board.
> The problem is that mach-mini2440.c: mini2440_init() (where we call  
> s3c_gpio_setpull())
> is called before s3c2440.c: s3c2440_init() (where we initialize  
> s3c24xx_gpiocfg_default.set_pull function pointer).
> This causes dereferencing of NULL pointer at boot time and a kernel panic.
> The following change (probably not what needs to be done) lets the board  
> boot again:

ok, thankyou for reporting this. will look into it as soon as possible.

> diff --git a/arch/arm/plat-s3c24xx/gpiolib.c  
> b/arch/arm/plat-s3c24xx/gpiolib.c
> index 4c0896f..ae9d3c2 100644
> --- a/arch/arm/plat-s3c24xx/gpiolib.c
> +++ b/arch/arm/plat-s3c24xx/gpiolib.c
> @@ -87,6 +87,8 @@ static struct s3c_gpio_cfg s3c24xx_gpiocfg_banka = {
>  struct s3c_gpio_cfg s3c24xx_gpiocfg_default = {
>         .set_config     = s3c_gpio_setcfg_s3c24xx,
>         .get_config     = s3c_gpio_getcfg_s3c24xx,
> +       .set_pull       = s3c_gpio_setpull_1up,
> +       .get_pull       = s3c_gpio_getpull_1up,
>  };
>
> Best regards,
> AWG
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
