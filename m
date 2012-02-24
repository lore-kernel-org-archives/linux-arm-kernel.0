From: robherring2@gmail.com (Rob Herring)
Date: Fri, 24 Feb 2012 08:14:09 -0600
Subject: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
In-Reply-To: <4F46C1AF.2040201@ti.com>
References: <4F46C1AF.2040201@ti.com>
Message-ID: <4F479B31.7090508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2012 04:46 PM, Cousson, Benoit wrote:
> The GPIO driver is still relying on internal OMAP IRQ defines that
> are not relevant anymore if OMAP is built with SPARSE_IRQ.
> 
> Replace the defines with the proper IRQ base number.
> Clean some comment style issue.
> Remove some hidden and ugly cpu_class_is_omap1() inside the
> gpio header.
> 
> XXX: That fix might be broken for OMAP1 MPUIO case.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> 
> Hi Tony,
> 
> Please note that this patch is still RFC, because I do not know how to fix properly the ugly cpu_class_is_omap1 and the dependency with IH_MPUIO_BASE to detect a MPUIO.
> 
> I'm still sending it, because it is needed to have SPARSE_IRQ working on OMAP4 with the previous series I've just sent.
> 
> Regards,
> Benoit
> 
>  arch/arm/plat-omap/include/plat/gpio.h |   22 ++------------------
>  drivers/gpio/gpio-omap.c               |   33 ++++++++++++++++---------------
>  2 files changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index cb75b65..b8a96c6 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -218,30 +218,14 @@ extern void omap_set_gpio_debounce(int gpio, int enable);
>  extern void omap_set_gpio_debounce_time(int gpio, int enable);
>  /*-------------------------------------------------------------------------*/
>  
> -/* Wrappers for "new style" GPIO calls, using the new infrastructure
> +/*
> + * Wrappers for "new style" GPIO calls, using the new infrastructure
>   * which lets us plug in FPGA, I2C, and other implementations.
> - * *
> + *
>   * The original OMAP-specific calls should eventually be removed.
>   */
>  
>  #include <linux/errno.h>
>  #include <asm-generic/gpio.h>
>  
> -static inline int irq_to_gpio(unsigned irq)
> -{
> -	int tmp;
> -
> -	/* omap1 SOC mpuio */
> -	if (cpu_class_is_omap1() && (irq < (IH_MPUIO_BASE + 16)))
> -		return (irq - IH_MPUIO_BASE) + OMAP_MAX_GPIO_LINES;
> -
> -	/* SOC gpio */
> -	tmp = irq - IH_GPIO_BASE;
> -	if (tmp < OMAP_MAX_GPIO_LINES)
> -		return tmp;
> -
> -	/* we don't supply reverse mappings for non-SOC gpios */
> -	return -EIO;
> -}
> -
>  #endif
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index bc2bd69..afef0f7 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -93,6 +93,11 @@ struct gpio_bank {
>  #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>  #define GPIO_MOD_CTRL_BIT	BIT(0)
>  
> +static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
> +{
> +	return gpio_irq - bank->irq_base + bank->chip.base;

Ideally, you could do something like this when you have a domain setup:

irq_get_irq_data(gpio_irq)->hw_irq + bank->chip.base

Also, with sparse irq you need to have a call to irq_alloc_desc. You can
avoid that by setting NR_IRQS or machine .nr_irqs, but that needs to go
away.

Otherwise, it certainly is a step in the right direction.

Rob
