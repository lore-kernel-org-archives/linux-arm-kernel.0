From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 27 Sep 2012 13:50:05 +0900
Subject: [PATCH 1/2] ARM: SAMSUNG: Insert bitmap_gpio_int member in
 samsung_gpio_chip
In-Reply-To: <000001cd9c63$e95c7b60$bc157220$@com>
References: <000001cd9c63$e95c7b60$bc157220$@com>
Message-ID: <5063DAFD.1040903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2012 12:55 PM, Eunki Kim wrote:
> When a device uses GPIO interrupt, its driver assumes that GPIO
> should be INPUT mode. However, GPIO of SAMSUNG SoC is sepated to
> INPUT mode and INTERRUPT mode. They are set by 0x0 and 0xF in GPIO
> control register. If the register is set to INPUT mode, the
> interrupt never occur. Therefore, it's necessary to set INTERRUPT
> mode instead of INPUT mode when the pin is used for GPIO interrupt.

If for this, already the patch was posted.

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074387.html

Thanks.

> This patch inserts the bitmap_gpio_int member in struct samsung_
> gpio_chip in order to represent use of GPIO interrupt for each pin
> and sets the related bit when s5p_register_gpio_interrupt function
> is called.
>
> Signed-off-by: Eunki Kim <eunki_kim@samsung.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/plat-samsung/include/plat/gpio-core.h |    2 ++
>   arch/arm/plat-samsung/s5p-irq-gpioint.c        |    8 ++++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h
> b/arch/arm/plat-samsung/include/plat/gpio-core.h
> index 1fe6917..dfd8b7a 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-core.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
> @@ -48,6 +48,7 @@ struct samsung_gpio_cfg;
>    * @config: special function and pull-resistor control information.
>    * @lock: Lock for exclusive access to this gpio bank.
>    * @pm_save: Save information for suspend/resume support.
> + * @bitmap_gpio_int: Bitmap for representing GPIO interrupt or not.
>    *
>    * This wrapper provides the necessary information for the Samsung
>    * specific gpios being registered with gpiolib.
> @@ -71,6 +72,7 @@ struct samsung_gpio_chip {
>   #ifdef CONFIG_PM
>   	u32			pm_save[4];
>   #endif
> +	u32			bitmap_gpio_int;
>   };
>   
>   static inline struct samsung_gpio_chip *to_samsung_gpio(struct gpio_chip *gpc)
> diff --git a/arch/arm/plat-samsung/s5p-irq-gpioint.c b/arch/arm/plat-samsung/s5p-irq-gpioint.c
> index f9431fe..d981c61 100644
> --- a/arch/arm/plat-samsung/s5p-irq-gpioint.c
> +++ b/arch/arm/plat-samsung/s5p-irq-gpioint.c
> @@ -185,7 +185,7 @@ int __init s5p_register_gpio_interrupt(int pin)
>   
>   	/* check if the group has been already registered */
>   	if (my_chip->irq_base)
> -		return my_chip->irq_base + offset;
> +		goto success;
>   
>   	/* register gpio group */
>   	ret = s5p_gpioint_add(my_chip);
> @@ -193,9 +193,13 @@ int __init s5p_register_gpio_interrupt(int pin)
>   		my_chip->chip.to_irq = samsung_gpiolib_to_irq;
>   		printk(KERN_INFO "Registered interrupt support for gpio group %d.\n",
>   		       group);
> -		return my_chip->irq_base + offset;
> +		goto success;
>   	}
>   	return ret;
> +success:
> +	my_chip->bitmap_gpio_int |= BIT(offset);
> +
> +	return my_chip->irq_base + offset;
>   }
>   
>   int __init s5p_register_gpioint_bank(int chain_irq, int start, int nr_groups)
