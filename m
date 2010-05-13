From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 May 2010 02:05:01 +0100
Subject: [PATCH 07/16] ARM: S5PC100: Move gpio support from
	plat-s5pc1xx to mach-s5pc100
In-Reply-To: <1270190944-21644-8-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100513010501.GP6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 08:48:55AM +0200, Marek Szyprowski wrote:
> Move gpio-lib support from plat-s5pc1xx to mach-s5pc100. Only basic gpio
> functionality is now supported. Gpio interrupts are disabled temporarly
> and will be added later.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Makefile                     |    2 +-
>  .../gpiolib.c => mach-s5pc100/gpio.c}              |   48 +++++++++++---------
>  .../plat => mach-s5pc100/include/mach}/regs-gpio.h |    2 +-
>  3 files changed, 28 insertions(+), 24 deletions(-)
>  rename arch/arm/{plat-s5pc1xx/gpiolib.c => mach-s5pc100/gpio.c} (90%)
>  rename arch/arm/{plat-s5pc1xx/include/plat => mach-s5pc100/include/mach}/regs-gpio.h (98%)
> 
> diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
> index 8371cfb..187b06d 100644
> --- a/arch/arm/mach-s5pc100/Makefile
> +++ b/arch/arm/mach-s5pc100/Makefile
> @@ -11,7 +11,7 @@ obj-				:=
>  
>  # Core support for S5PC100 system
>  
> -obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o
> +obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o gpio.o
>  obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
>  
>  # machine support
> diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/mach-s5pc100/gpio.c
> similarity index 90%
> rename from arch/arm/plat-s5pc1xx/gpiolib.c
> rename to arch/arm/mach-s5pc100/gpio.c
> index 1ffc57a..9f6fbe1 100644
> --- a/arch/arm/plat-s5pc1xx/gpiolib.c
> +++ b/arch/arm/mach-s5pc100/gpio.c
> @@ -4,7 +4,7 @@
>   *  Copyright 2009 Samsung Electronics Co
>   *  Kyungmin Park <kyungmin.park@samsung.com>
>   *
> - * S5PC1XX - GPIOlib support
> + * S5PC100 - GPIOlib support
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -17,11 +17,11 @@
>  #include <linux/gpio.h>
>  
>  #include <mach/map.h>
> +#include <mach/regs-gpio.h>
>  
>  #include <plat/gpio-core.h>
>  #include <plat/gpio-cfg.h>
>  #include <plat/gpio-cfg-helpers.h>
> -#include <plat/regs-gpio.h>
>  
>  /* S5PC100 GPIO bank summary:
>   *
> @@ -72,7 +72,7 @@
>  #define gpio_dbg(x...) printk(KERN_DEBUG x)
>  #endif
>  
> -/* The s5pc1xx_gpiolib routines are to control the gpio banks where
> +/* The s5pc100_gpiolib routines are to control the gpio banks where
>   * the gpio configuration register (GPxCON) has 4 bits per GPIO, as the
>   * following example:
>   *
> @@ -87,7 +87,7 @@
>   * the output.
>   */
>  
> -static int s5pc1xx_gpiolib_input(struct gpio_chip *chip, unsigned offset)
> +static int s5pc100_gpiolib_input(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
>  	void __iomem *base = ourchip->base;
> @@ -102,7 +102,7 @@ static int s5pc1xx_gpiolib_input(struct gpio_chip *chip, unsigned offset)
>  	return 0;
>  }

to be honest i'd rather see the back of these and use the common support
for s5pc/s3c64xx which seems to be pretty much the same.
  
> -static int s5pc1xx_gpiolib_output(struct gpio_chip *chip,
> +static int s5pc100_gpiolib_output(struct gpio_chip *chip,
>  				       unsigned offset, int value)
>  {
>  	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
> @@ -129,12 +129,14 @@ static int s5pc1xx_gpiolib_output(struct gpio_chip *chip,
>  	return 0;
>  }
>  
> -static int s5pc1xx_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
> +#if 0
> +static int s5pc100_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
>  {
>  	return S3C_IRQ_GPIO(chip->base + offset);
>  }
> +#endif
>  
> -static int s5pc1xx_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
> +static int s5pc100_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
>  {
>  	int base;
>  
> @@ -449,33 +451,34 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
>  };
>  
>  /* FIXME move from irq-gpio.c */
> -extern struct irq_chip s5pc1xx_gpioint;
> -extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
> +extern struct irq_chip s5pc100_gpioint;
> +extern void s5pc100_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
>  
> -static __init void s5pc1xx_gpiolib_link(struct s3c_gpio_chip *chip)
> +static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
>  {
> -	chip->chip.direction_input = s5pc1xx_gpiolib_input;
> -	chip->chip.direction_output = s5pc1xx_gpiolib_output;
> +	chip->chip.direction_input = s5pc100_gpiolib_input;
> +	chip->chip.direction_output = s5pc100_gpiolib_output;
>  	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
> -
> +#if 0
>  	/* Interrupt */
>  	if (chip->config == &gpio_cfg) {
>  		int i, irq;
>  
> -		chip->chip.to_irq = s5pc1xx_gpiolib_to_irq;
> +		chip->chip.to_irq = s5pc100_gpiolib_to_irq;
>  
>  		for (i = 0;  i < chip->chip.ngpio; i++) {
>  			irq = S3C_IRQ_GPIO_BASE + chip->chip.base + i;
> -			set_irq_chip(irq, &s5pc1xx_gpioint);
> +			set_irq_chip(irq, &s5pc100_gpioint);
>  			set_irq_data(irq, &chip->chip);
>  			set_irq_handler(irq, handle_level_irq);
>  			set_irq_flags(irq, IRQF_VALID);
>  		}
>  	} else if (chip->config == &gpio_cfg_eint)
> -		chip->chip.to_irq = s5pc1xx_gpiolib_to_eint;
> +		chip->chip.to_irq = s5pc100_gpiolib_to_eint;
> +#endif
>  }
>  
> -static __init void s5pc1xx_gpiolib_add(struct s3c_gpio_chip *chips,
> +static __init void s5pc100_gpiolib_add(struct s3c_gpio_chip *chips,
>  				       int nr_chips,
>  				       void (*fn)(struct s3c_gpio_chip *))
>  {
> @@ -486,7 +489,7 @@ static __init void s5pc1xx_gpiolib_add(struct s3c_gpio_chip *chips,
>  	}
>  }
>  
> -static __init int s5pc1xx_gpiolib_init(void)
> +static __init int s5pc100_gpiolib_init(void)
>  {
>  	struct s3c_gpio_chip *chips;
>  	int nr_chips;
> @@ -494,10 +497,11 @@ static __init int s5pc1xx_gpiolib_init(void)
>  		chips = s5pc100_gpio_chips;
>  		nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
>  
> -	s5pc1xx_gpiolib_add(chips, nr_chips, s5pc1xx_gpiolib_link);
> +	s5pc100_gpiolib_add(chips, nr_chips, s5pc100_gpiolib_link);
>  	/* Interrupt */
> -	set_irq_chained_handler(IRQ_GPIOINT, s5pc1xx_irq_gpioint_handler);
> -
> +#if 0
> +	set_irq_chained_handler(IRQ_GPIOINT, s5pc100_irq_gpioint_handler);
> +#endif
>  	return 0;
>  }
> -core_initcall(s5pc1xx_gpiolib_init);
> +core_initcall(s5pc100_gpiolib_init);
> diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
> similarity index 98%
> rename from arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
> rename to arch/arm/mach-s5pc100/include/mach/regs-gpio.h
> index 43c7bc8..b523d84 100644
> --- a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
> +++ b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
> @@ -12,7 +12,7 @@
>  #include <mach/map.h>
>  
>  /* S5PC100 */
> -#define S5PC100_GPIO_BASE	S5PC1XX_VA_GPIO
> +#define S5PC100_GPIO_BASE	S5P_VA_GPIO
>  #define S5PC100_GPA0_BASE	(S5PC100_GPIO_BASE + 0x0000)
>  #define S5PC100_GPA1_BASE	(S5PC100_GPIO_BASE + 0x0020)
>  #define S5PC100_GPB_BASE	(S5PC100_GPIO_BASE + 0x0040)
> -- 
> 1.6.4
> 
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
