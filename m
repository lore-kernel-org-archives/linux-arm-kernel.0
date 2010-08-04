From: ben@simtec.co.uk (Ben Dooks)
Date: Wed, 04 Aug 2010 16:26:35 +0100
Subject: [PATCH RFC] h1940: use gpiolib for latch access
In-Reply-To: <1280076072-1049-1-git-send-email-anarsoul@gmail.com>
References: <1280076072-1049-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4C5986AB.40103@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/10 17:41, Vasily Khoruzhick wrote:
> This patch adds gpiolib support for h1940 latch.
> With this patch it's possible to use leds-gpio and uda1380
> drivers (they require gpiolib support for appropriate pins).
> And now it's possible to drop leds-h1940 driver.

I'm reasonably happy with this, any comments from Arnaud?

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2410/h1940-bluetooth.c          |   21 ++++--
>  arch/arm/mach-s3c2410/include/mach/h1940-latch.h |   57 ++++++------------
>  arch/arm/mach-s3c2410/mach-h1940.c               |   71 ++++++++++++++++++++--
>  arch/arm/plat-s3c24xx/Kconfig                    |    1 +
>  4 files changed, 99 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
> index 8cdeb14..6b86a72 100644
> --- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
> +++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
> @@ -30,7 +30,7 @@ static void h1940bt_enable(int on)
>  {
>  	if (on) {
>  		/* Power on the chip */
> -		h1940_latch_control(0, H1940_LATCH_BLUETOOTH_POWER);
> +		gpio_set_value(H1940_LATCH_BLUETOOTH_POWER, 1);
>  		/* Reset the chip */
>  		mdelay(10);
>  
> @@ -43,7 +43,7 @@ static void h1940bt_enable(int on)
>  		mdelay(10);
>  		gpio_set_value(S3C2410_GPH(1), 0);
>  		mdelay(10);
> -		h1940_latch_control(H1940_LATCH_BLUETOOTH_POWER, 0);
> +		gpio_set_value(H1940_LATCH_BLUETOOTH_POWER, 0);
>  	}
>  }
>  
> @@ -64,19 +64,26 @@ static int __devinit h1940bt_probe(struct platform_device *pdev)
>  
>  	ret = gpio_request(S3C2410_GPH(1), dev_name(&pdev->dev));
>  	if (ret) {
> -		dev_err(&pdev->dev, "could not get GPH1\n");\
> +		dev_err(&pdev->dev, "could not get GPH1\n");
> +		return ret;
> +	}
> +
> +	ret = gpio_request(H1940_LATCH_BLUETOOTH_POWER, dev_name(&pdev->dev));
> +	if (ret) {
> +		gpio_free(S3C2410_GPH(1));
> +		dev_err(&pdev->dev, "could not get BT_POWER\n");
>  		return ret;
>  	}
>  
>  	/* Configures BT serial port GPIOs */
>  	s3c_gpio_cfgpin(S3C2410_GPH(0), S3C2410_GPH0_nCTS0);
> -	s3c_gpio_cfgpull(S3C2410_GPH(0), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(0), S3C_GPIO_PULL_NONE);
>  	s3c_gpio_cfgpin(S3C2410_GPH(1), S3C2410_GPIO_OUTPUT);
> -	s3c_gpio_cfgpull(S3C2410_GPH(1), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(1), S3C_GPIO_PULL_NONE);
>  	s3c_gpio_cfgpin(S3C2410_GPH(2), S3C2410_GPH2_TXD0);
> -	s3c_gpio_cfgpull(S3C2410_GPH(2), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(2), S3C_GPIO_PULL_NONE);
>  	s3c_gpio_cfgpin(S3C2410_GPH(3), S3C2410_GPH3_RXD0);
> -	s3c_gpio_cfgpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);

Is this an error, or have you merged a part of a different patch
into this one?

>  	rfk = rfkill_alloc(DRV_NAME, &pdev->dev, RFKILL_TYPE_BLUETOOTH,
> diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> index d8a8327..4607d5c 100644
> --- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> +++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> @@ -14,51 +14,30 @@
>  #ifndef __ASM_ARCH_H1940_LATCH_H
>  #define __ASM_ARCH_H1940_LATCH_H
>  
> +#include <mach/gpio.h>
>  
> -#ifndef __ASSEMBLY__
> -#define H1940_LATCH		((void __force __iomem *)0xF8000000)
> -#else
> -#define H1940_LATCH		0xF8000000
> -#endif
> -
> -#define H1940_PA_LATCH		(S3C2410_CS2)
> +#define H1940_LATCH_GPIO(x)		(S3C_GPIO_END + x)
>  
>  /* SD layer latch */
>  
> -#define H1940_LATCH_SDQ1		(1<<16)
> -#define H1940_LATCH_LCD_P1		(1<<17)
> -#define H1940_LATCH_LCD_P2		(1<<18)
> -#define H1940_LATCH_LCD_P3		(1<<19)
> -#define H1940_LATCH_MAX1698_nSHUTDOWN	(1<<20)		/* LCD backlight */
> -#define H1940_LATCH_LED_RED		(1<<21)
> -#define H1940_LATCH_SDQ7		(1<<22)
> -#define H1940_LATCH_USB_DP		(1<<23)
> +#define H1940_LATCH_SDQ1		H1940_LATCH_GPIO(0)
> +#define H1940_LATCH_LCD_P1		H1940_LATCH_GPIO(1)
> +#define H1940_LATCH_LCD_P2		H1940_LATCH_GPIO(2)
> +#define H1940_LATCH_LCD_P3		H1940_LATCH_GPIO(3)
> +#define H1940_LATCH_MAX1698_nSHUTDOWN	H1940_LATCH_GPIO(4)
> +#define H1940_LATCH_LED_RED		H1940_LATCH_GPIO(5)
> +#define H1940_LATCH_SDQ7		H1940_LATCH_GPIO(6)
> +#define H1940_LATCH_USB_DP		H1940_LATCH_GPIO(7)
>  
>  /* CPU layer latch */
>  
> -#define H1940_LATCH_UDA_POWER		(1<<24)
> -#define H1940_LATCH_AUDIO_POWER		(1<<25)
> -#define H1940_LATCH_SM803_ENABLE	(1<<26)
> -#define H1940_LATCH_LCD_P4		(1<<27)
> -#define H1940_LATCH_CPUQ5		(1<<28)		/* untraced */
> -#define H1940_LATCH_BLUETOOTH_POWER	(1<<29)		/* active high */
> -#define H1940_LATCH_LED_GREEN		(1<<30)
> -#define H1940_LATCH_LED_FLASH		(1<<31)
> -
> -/* default settings */
> -
> -#define H1940_LATCH_DEFAULT		\
> -	H1940_LATCH_LCD_P4		| \
> -	H1940_LATCH_SM803_ENABLE	| \
> -	H1940_LATCH_SDQ1		| \
> -	H1940_LATCH_LCD_P1		| \
> -	H1940_LATCH_LCD_P2		| \
> -	H1940_LATCH_LCD_P3		| \
> -	H1940_LATCH_MAX1698_nSHUTDOWN   | \
> -	H1940_LATCH_CPUQ5
> -
> -/* control functions */
> -
> -extern void h1940_latch_control(unsigned int clear, unsigned int set);
> +#define H1940_LATCH_UDA_POWER		H1940_LATCH_GPIO(8)
> +#define H1940_LATCH_AUDIO_POWER		H1940_LATCH_GPIO(9)
> +#define H1940_LATCH_SM803_ENABLE	H1940_LATCH_GPIO(10)
> +#define H1940_LATCH_LCD_P4		H1940_LATCH_GPIO(11)
> +#define H1940_LATCH_CPUQ5		H1940_LATCH_GPIO(12)
> +#define H1940_LATCH_BLUETOOTH_POWER	H1940_LATCH_GPIO(13)
> +#define H1940_LATCH_LED_GREEN		H1940_LATCH_GPIO(14)
> +#define H1940_LATCH_LED_FLASH		H1940_LATCH_GPIO(15)
>  
>  #endif /* __ASM_ARCH_H1940_LATCH_H */
> diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
> index 779b45b..693f467 100644
> --- a/arch/arm/mach-s3c2410/mach-h1940.c
> +++ b/arch/arm/mach-s3c2410/mach-h1940.c
> @@ -42,6 +42,7 @@
>  #include <mach/regs-gpio.h>
>  #include <mach/gpio-fns.h>
>  #include <mach/gpio-nrs.h>
> +#include <mach/gpio.h>
>  
>  #include <mach/h1940.h>
>  #include <mach/h1940-latch.h>
> @@ -58,6 +59,18 @@
>  #include <plat/mci.h>
>  #include <plat/ts.h>
>  
> +#ifndef __ASSEMBLY__
> +#define H1940_LATCH		((void __force __iomem *)0xF8000000)
> +#else
> +#define H1940_LATCH		0xF8000000
> +#endif
> +
> +#define H1940_PA_LATCH		(S3C2410_CS2)
> +
> +#define H1940_LATCH_GPIO(x)		(S3C_GPIO_END + x)
> +
> +#define H1940_LATCH_BIT(x)		(1 << (x + 16 - S3C_GPIO_END))

you probably want an () around the 'x's in the above defines.

> +
>  static struct map_desc h1940_iodesc[] __initdata = {
>  	[0] = {
>  		.virtual	= (unsigned long)H1940_LATCH,
> @@ -99,9 +112,16 @@ static struct s3c2410_uartcfg h1940_uartcfgs[] __initdata = {
>  
>  /* Board control latch control */
>  
> -static unsigned int latch_state = H1940_LATCH_DEFAULT;
> +static unsigned int latch_state = H1940_LATCH_BIT(H1940_LATCH_LCD_P4) |
> +	H1940_LATCH_BIT(H1940_LATCH_SM803_ENABLE)	|
> +	H1940_LATCH_BIT(H1940_LATCH_SDQ1)			|
> +	H1940_LATCH_BIT(H1940_LATCH_LCD_P1)			|
> +	H1940_LATCH_BIT(H1940_LATCH_LCD_P2)			|
> +	H1940_LATCH_BIT(H1940_LATCH_LCD_P3)			|
> +	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN)   |
> +	H1940_LATCH_BIT(H1940_LATCH_CPUQ5);
>  
> -void h1940_latch_control(unsigned int clear, unsigned int set)
> +static void h1940_latch_control(unsigned int clear, unsigned int set)
>  {
>  	unsigned long flags;
>  
> @@ -115,7 +135,43 @@ void h1940_latch_control(unsigned int clear, unsigned int set)
>  	local_irq_restore(flags);
>  }
>  
> -EXPORT_SYMBOL_GPL(h1940_latch_control);
> +static int h1940_gpiolib_latch_input(struct gpio_chip *chip, unsigned offset)
> +{
> +	return -EINVAL;
> +}
> +
> +
> +static void h1940_gpiolib_latch_set(struct gpio_chip *chip,
> +					unsigned offset, int value)
> +{

computing the bit seperately to the call to h1940_latch_control
would have made the code easier to read.

> +	h1940_latch_control(value ? 0 : (1 << (offset + 16)),
> +		value ? (1 << (offset + 16)) : 0);
> +}
> +
> +static int h1940_gpiolib_latch_output(struct gpio_chip *chip,
> +					unsigned offset, int value)
> +{
> +	h1940_gpiolib_latch_set(chip, offset, value);
> +
> +	return 0;
> +}
> +
> +static int h1940_gpiolib_latch_get(struct gpio_chip *chip,
> +					unsigned offset)
> +{
> +	return (latch_state >> (offset + 16)) & 1;
> +}
> +
> +struct gpio_chip h1940_latch_gpiochip = {
> +	.base				= H1940_LATCH_GPIO(0),
> +	.owner				= THIS_MODULE,
> +	.label				= "H1940_LATCH",
> +	.ngpio				= 16,
> +	.direction_input	= h1940_gpiolib_latch_input,
> +	.direction_output	= h1940_gpiolib_latch_output,
> +	.set				= h1940_gpiolib_latch_set,
> +	.get				= h1940_gpiolib_latch_get,
> +};
>  
>  static void h1940_udc_pullup(enum s3c2410_udc_cmd_e cmd)
>  {
> @@ -124,10 +180,10 @@ static void h1940_udc_pullup(enum s3c2410_udc_cmd_e cmd)
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
> @@ -302,6 +358,8 @@ static void __init h1940_map_io(void)
>  	memcpy(phys_to_virt(H1940_SUSPEND_RESUMEAT), h1940_pm_return, 1024);
>  #endif
>  	s3c_pm_init();
> +
> +	WARN_ON(gpiochip_add(&h1940_latch_gpiochip));
>  }
>  
>  static void __init h1940_init_irq(void)
> @@ -335,6 +393,9 @@ static void __init h1940_init(void)
>  	gpio_request(S3C2410_GPC(5), "LCD power");
>  	gpio_request(S3C2410_GPC(6), "LCD power");
>  
> +	gpio_request(H1940_LATCH_USB_DP, "USB pullup");
> +	gpio_direction_output(H1940_LATCH_USB_DP, 0);
> +
>  	gpio_direction_input(S3C2410_GPC(6));
>  
>  	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
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
