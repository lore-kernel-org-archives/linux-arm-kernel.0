From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 07 Feb 2013 17:17:04 +0200
Subject: [PATCH v2 03/10] gpio: pxa: use platform data for gpio inverted
In-Reply-To: <1359886551-20950-4-git-send-email-haojian.zhuang@linaro.org>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <1359886551-20950-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5113C570.6060403@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/03/13 12:15, Haojian Zhuang wrote:
> Avoid to judge whether gpio is inverted by identifying cpu in gpio
> driver. Move this into platform data of gpio driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/mach-pxa/pxa25x.c |    3 +++
>  drivers/gpio/gpio-pxa.c    |   40 +++++++++++++++++++++++++---------------
>  include/linux/gpio-pxa.h   |    1 +
>  3 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index f4c293a..66dafb7 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -340,6 +340,9 @@ void __init pxa25x_map_io(void)
>  }
>  
>  static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
> +#ifdef CONFIG_CPU_PXA26x
> +	.inverted = true,
> +#endif
>  	.gpio_set_wake = gpio_set_wake,
>  };
>  
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index 2310665..1f8dfc8 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -71,6 +71,7 @@ struct pxa_gpio_chip {
>  	struct gpio_chip chip;
>  	void __iomem	*regbase;
>  	unsigned int	irq_base;
> +	bool		inverted;
>  	char label[10];
>  
>  	unsigned long	irq_mask;
> @@ -126,9 +127,9 @@ static inline int gpio_is_mmp_type(int type)
>  /* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
>   * as well as their Alternate Function value being '1' for GPIO in GAFRx.
>   */
> -static inline int __gpio_is_inverted(int gpio)
> +static inline int __gpio_is_inverted(struct pxa_gpio_chip *chip, int gpio)
>  {
> -	if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
> +	if ((chip->inverted) && (gpio > 85))
>  		return 1;
>  	return 0;
>  }
> @@ -139,15 +140,13 @@ static inline int __gpio_is_inverted(int gpio)
>   * is attributed as "occupied" here (I know this terminology isn't
>   * accurate, you are welcome to propose a better one :-)
>   */
> -static inline int __gpio_is_occupied(unsigned gpio)
> +static inline int __gpio_is_occupied(struct pxa_gpio_chip *chip, unsigned gpio)
>  {
> -	struct pxa_gpio_chip *pxachip;
>  	void __iomem *base;
>  	unsigned long gafr = 0, gpdr = 0;
>  	int ret, af = 0, dir = 0;
>  
> -	pxachip = gpio_to_pxachip(gpio);
> -	base = gpio_chip_base(&pxachip->chip);
> +	base = gpio_chip_base(&chip->chip);
>  	gpdr = readl_relaxed(base + GPDR_OFFSET);
>  
>  	switch (gpio_type) {
> @@ -158,7 +157,7 @@ static inline int __gpio_is_occupied(unsigned gpio)
>  		af = (gafr >> ((gpio & 0xf) * 2)) & 0x3;
>  		dir = gpdr & GPIO_bit(gpio);
>  
> -		if (__gpio_is_inverted(gpio))
> +		if (__gpio_is_inverted(chip, gpio))
>  			ret = (af != 1) || (dir == 0);
>  		else
>  			ret = (af != 0) || (dir != 0);
> @@ -188,16 +187,19 @@ int pxa_irq_to_gpio(struct irq_data *d)
>  	return gpio;
>  }
>  
> -static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> +static int pxa_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
>  {
> -	void __iomem *base = gpio_chip_base(chip);
> +	struct pxa_gpio_chip *chip = NULL;
> +	void __iomem *base = gpio_chip_base(gc);
>  	uint32_t value, mask = 1 << offset;
>  	unsigned long flags;
>  
> +	chip = container_of(gc, struct pxa_gpio_chip, chip);
> +
>  	spin_lock_irqsave(&gpio_lock, flags);
>  
>  	value = readl_relaxed(base + GPDR_OFFSET);
> -	if (__gpio_is_inverted(chip->base + offset))
> +	if (__gpio_is_inverted(chip, gc->base + offset))
>  		value |= mask;
>  	else
>  		value &= ~mask;
> @@ -207,19 +209,22 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  	return 0;
>  }
>  
> -static int pxa_gpio_direction_output(struct gpio_chip *chip,
> +static int pxa_gpio_direction_output(struct gpio_chip *gc,
>  				     unsigned offset, int value)
>  {
> -	void __iomem *base = gpio_chip_base(chip);
> +	struct pxa_gpio_chip *chip = NULL;
> +	void __iomem *base = gpio_chip_base(gc);
>  	uint32_t tmp, mask = 1 << offset;
>  	unsigned long flags;
>  
> +	chip = container_of(gc, struct pxa_gpio_chip, chip);
> +
>  	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
>  
>  	spin_lock_irqsave(&gpio_lock, flags);
>  
>  	tmp = readl_relaxed(base + GPDR_OFFSET);
> -	if (__gpio_is_inverted(chip->base + offset))
> +	if (__gpio_is_inverted(chip, gc->base + offset))
>  		tmp &= ~mask;
>  	else
>  		tmp |= mask;
> @@ -288,7 +293,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
>  		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
>  			return 0;
>  
> -		if (__gpio_is_occupied(gpio))
> +		if (__gpio_is_occupied(c, gpio))
>  			return 0;
>  
>  		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
> @@ -296,7 +301,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
>  
>  	gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
>  
> -	if (__gpio_is_inverted(gpio))
> +	if (__gpio_is_inverted(c, gpio))
>  		writel_relaxed(gpdr | mask,  c->regbase + GPDR_OFFSET);
>  	else
>  		writel_relaxed(gpdr & ~mask, c->regbase + GPDR_OFFSET);
> @@ -474,6 +479,9 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
>  		return -ENOMEM;
>  	if (of_find_property(np, "marvell,gpio-ed-mask", NULL))
>  		pdata->ed_mask = true;
> +	/* It's only valid for PXA26x */
> +	if (of_find_property(np, "marvell,gpio-inverted", NULL))
> +		pdata->inverted = true;
>  	/* set the platform data */
>  	pdev->dev.platform_data = pdata;
>  	gpio_type = (int)of_id->data;
> @@ -616,6 +624,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
>  		/* unmask GPIO edge detect for AP side */
>  		if (info->ed_mask)
>  			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
> +		/* update for gpio inverted */
> +		c->inverted = info->inverted;
>  	}
>  
>  	if (!use_of) {
> diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
> index 49120b8..0c212a1 100644
> --- a/include/linux/gpio-pxa.h
> +++ b/include/linux/gpio-pxa.h
> @@ -17,6 +17,7 @@ extern int pxa_irq_to_gpio(struct irq_data *d);
>  
>  struct pxa_gpio_platform_data {
>  	bool ed_mask;	/* true means that ed_mask reg is available */
> +	bool inverted;	/* only valid for PXA26x */
>  	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
>  };
>  
> 

-- 
Regards,
Igor.
