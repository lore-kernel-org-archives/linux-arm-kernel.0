From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Nov 2010 15:18:20 +0900
Subject: [PATCH RESEND v3] ARM: s3c2442: Setup gpio {set,
	get}_pull callbacks
In-Reply-To: <1291026399-14873-1-git-send-email-anarsoul@gmail.com>
References: <000201cb8fae$4d61fd20$e825f760$%kim@samsung.com>
	<1291026399-14873-1-git-send-email-anarsoul@gmail.com>
Message-ID: <001801cb9056$65296530$2f7c2f90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default
> structure
> are initalized via s3c_gpio_{get,set}pull_1up. This results in a linker
> error when compiling kernel for s3c2442:
> 
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f4): undefined reference to
> `s3c_gpio_getpull_1up'
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f8): undefined reference to
> `s3c_gpio_setpull_1up'
> 
Yeah, happened build error when selected only S3C2442.

> The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
> The method of controlling them is the same though.
> So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper
> functions
> to take an additional parameter deciding whether the pin has a pullup or
> pulldown.
> The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions
> passing
> either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.
> 
> Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull
> fields
> in the s3c2442 cpu init function to the new pulldown helper functions.
> 
> Based on patch from "Lars-Peter Clausen" <lars@metafoo.de>
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: adapt patch for 2.6.37-rc1
> v3: restore default pull callbacks, add default pull callbacks for s3c2442
>  arch/arm/mach-s3c2440/Kconfig                      |    1 +
>  arch/arm/mach-s3c2440/s3c2442.c                    |    7 +++
>  arch/arm/plat-s3c24xx/gpiolib.c                    |    9 +++-
>  arch/arm/plat-samsung/gpio-config.c                |   44
++++++++++++++++--
> -
>  .../plat-samsung/include/plat/gpio-cfg-helpers.h   |   11 +++++
>  5 files changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
> index ff024a6..478fae0 100644
> --- a/arch/arm/mach-s3c2440/Kconfig
> +++ b/arch/arm/mach-s3c2440/Kconfig
> @@ -18,6 +18,7 @@ config CPU_S3C2440
>  config CPU_S3C2442
>  	bool
>  	select CPU_ARM920T
> +	select S3C_GPIO_PULL_DOWN
>  	select S3C2410_CLOCK
>  	select S3C2410_GPIO
>  	select S3C2410_PM if PM
> diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-
> s3c2440/s3c2442.c
> index 188ad1e..0dbc91c 100644
> --- a/arch/arm/mach-s3c2440/s3c2442.c
> +++ b/arch/arm/mach-s3c2440/s3c2442.c
> @@ -32,6 +32,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/mutex.h>
> +#include <linux/gpio.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> 
> @@ -44,6 +45,10 @@
>  #include <plat/clock.h>
>  #include <plat/cpu.h>
> 
> +#include <plat/gpio-core.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/gpio-cfg-helpers.h>
> +
>  /* S3C2442 extended clock support */
> 
>  static unsigned long s3c2442_camif_upll_round(struct clk *clk,
> @@ -160,6 +165,8 @@ static struct sys_device s3c2442_sysdev = {
>  int __init s3c2442_init(void)
>  {
>  	printk("S3C2442: Initialising architecture\n");

To add empty line would be helpful to read here.

> +	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1down;
> +	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1down;
> 
Right now, this is ok to me...but I think we need to sort this out with
other S3C SoCs.

>  	return sysdev_register(&s3c2442_sysdev);
>  }
> diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-
> s3c24xx/gpiolib.c
> index 24c6f5a..b805dab 100644
> --- a/arch/arm/plat-s3c24xx/gpiolib.c
> +++ b/arch/arm/plat-s3c24xx/gpiolib.c
> @@ -82,8 +82,13 @@ static struct s3c_gpio_cfg s3c24xx_gpiocfg_banka = {
>  struct s3c_gpio_cfg s3c24xx_gpiocfg_default = {
>  	.set_config	= s3c_gpio_setcfg_s3c24xx,
>  	.get_config	= s3c_gpio_getcfg_s3c24xx,
> -	.set_pull	= s3c_gpio_setpull_1up,
> -	.get_pull	= s3c_gpio_getpull_1up,
> +#if defined(CONFIG_S3C_GPIO_PULL_UP)
> +	.set_pull       = s3c_gpio_setpull_1up,
> +	.get_pull       = s3c_gpio_getpull_1up,
                 ^^^^^^
Why do you use white space instead of tab?
Original code used tab in there.

> +#elif defined(CONFIG_S3C_GPIO_PULL_DOWN)
> +	.set_pull	= s3c_gpio_setpull_1down,
> +	.get_pull	= s3c_gpio_getpull_1down,
> +#endif

Yeah, this is needed for avoiding build error with only S3C2442.
But please remember, now, its default is CONFIG_S3C_GPIO_PULL_UP when used
s3c2410_defconfig even though selected S3C_GPIO_PULL_DOWN together.

I will thinking about better method for single binary kernel of S3C24XX. As
you know, current your method can not support it.

>  };
> 
>  struct s3c_gpio_chip s3c24xx_gpios[] = {
> diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-
> samsung/gpio-config.c
> index b732b77..ac7f13f 100644
> --- a/arch/arm/plat-samsung/gpio-config.c
> +++ b/arch/arm/plat-samsung/gpio-config.c
> @@ -280,16 +280,17 @@ s3c_gpio_pull_t s3c_gpio_getpull_updown(struct
> s3c_gpio_chip *chip,
>  }
>  #endif
> 
> -#ifdef CONFIG_S3C_GPIO_PULL_UP
> -int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
> -			 unsigned int off, s3c_gpio_pull_t pull)
> +#if defined(CONFIG_S3C_GPIO_PULL_UP) ||
defined(CONFIG_S3C_GPIO_PULL_DOWN)
> +static int s3c_gpio_setpull_1(struct s3c_gpio_chip *chip,
> +			 unsigned int off, s3c_gpio_pull_t pull,
> +			 s3c_gpio_pull_t updown)

Hmm...how about s3c_gpio_setpull_1updown(...)?
And actually, not used 3rd argument, "pull" now.
I prefer follwoing.

+static int s3c_gpio_setpull_1(struct s3c_gpio_chip *chip,
+			      unsigned int off, s3c_gpio_pull_t pull)

>  {
>  	void __iomem *reg = chip->base + 0x08;
>  	u32 pup = __raw_readl(reg);
> 
>  	pup = __raw_readl(reg);

Hmm...need twice read?

> 
> -	if (pup == S3C_GPIO_PULL_UP)
> +	if (pup == updown)
>  		pup &= ~(1 << off);
>  	else if (pup == S3C_GPIO_PULL_NONE)
>  		pup |= (1 << off);

Is this right? I think, your code is wrong :-(
Of course, original code has bug too...

Should be like follwoing.
	
+	pup >>= off;
+
+	if ((pull == S3C_GPIO_PULL_UP) || (pull == S3C_GPIO_PULL_DOWN))
+		pup &= ~(1 << off);
+	else if (pull == S3C_GPIO_PULL_NONE)
+		pup |= (1 << off);
+	else
+		return -EINVAL;

	...
But, according to your patch, maybe not called "else if" and "else".
Because you only used "S3C_GPIO_PULL_UP" and "S3C_GPIO_PULL_DOWN" as
argument from caller function.

So should be separate it as Ben's original code.

> @@ -300,17 +301,46 @@ int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
>  	return 0;
>  }
> 
> -s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
> -				     unsigned int off)
> +static s3c_gpio_pull_t s3c_gpio_getpull_1(struct s3c_gpio_chip *chip,
> +				     unsigned int off, s3c_gpio_pull_t
updown)

s3c_gpio_getpull_1updown(...)?
And...why need 3rd argument, "updown"

+static s3c_gpio_pull_t s3c_gpio_getpull_1(struct s3c_gpio_chip *chip,
+					  unsigned int off)

>  {
>  	void __iomem *reg = chip->base + 0x08;
>  	u32 pup = __raw_readl(reg);
> 
>  	pup &= (1 << off);
> -	return pup ? S3C_GPIO_PULL_NONE : S3C_GPIO_PULL_UP;
> +	return pup ? S3C_GPIO_PULL_NONE : updown;

Is this right?
Hmm...No...

> +}
> +#endif /* CONFIG_S3C_GPIO_PULL_UP || CONFIG_S3C_GPIO_PULL_DOWN */
> +
> +#ifdef CONFIG_S3C_GPIO_PULL_UP
> +s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
> +				     unsigned int off)
> +{
> +	return s3c_gpio_getpull_1(chip, off, S3C_GPIO_PULL_UP);
> +}
> +
> +int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
> +			 unsigned int off, s3c_gpio_pull_t pull)
> +{
> +	return s3c_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_UP);
>  }
>  #endif /* CONFIG_S3C_GPIO_PULL_UP */
> 
> +#ifdef CONFIG_S3C_GPIO_PULL_DOWN
> +s3c_gpio_pull_t s3c_gpio_getpull_1down(struct s3c_gpio_chip *chip,
> +				     unsigned int off)
> +{
> +	return s3c_gpio_getpull_1(chip, off, S3C_GPIO_PULL_DOWN);
> +}
> +
> +int s3c_gpio_setpull_1down(struct s3c_gpio_chip *chip,
> +			 unsigned int off, s3c_gpio_pull_t pull)
> +{
> +	return s3c_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_DOWN);
> +}
> +#endif /* CONFIG_S3C_GPIO_PULL_DOWN */
> +
> +

No need 2 empty lines.

>  #ifdef CONFIG_S5P_GPIO_DRVSTR
>  s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin)
>  {
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> index 8fd65d8..0d2c570 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
> @@ -210,6 +210,17 @@ extern s3c_gpio_pull_t s3c_gpio_getpull_1up(struct
> s3c_gpio_chip *chip,
>  					    unsigned int off);
> 
>  /**
> + * s3c_gpio_getpull_1down() - Get configuration for choice of down or
none
> + * @chip: The gpio chip that the GPIO pin belongs to
> + * @off: The offset to the pin to get the configuration of.
> + *
> + * This helper function reads the state of the pull-down resistor for the
> + * given GPIO in the same case as s3c_gpio_setpull_1down.
> +*/
> +extern s3c_gpio_pull_t s3c_gpio_getpull_1down(struct s3c_gpio_chip *chip,
> +					    unsigned int off);
> +

Need to add "extern int s3c_gpio_setpull_1down(...);"

> +/**
>   * s3c_gpio_setpull_s3c2443() - Pull configuration for s3c2443.
>   * @chip: The gpio chip that is being configured.
>   * @off: The offset for the GPIO being configured.
> --

Please make sure your code has no problem again before submitting.
However, your pointing out is right. Should be fixed this...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
