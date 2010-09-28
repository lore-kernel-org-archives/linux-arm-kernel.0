From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 23:03:45 +0900
Subject: [PATCH 1/6] ARM: Samsung: Add common s5p gpio interrupt support
In-Reply-To: <1283764347-460-2-git-send-email-m.szyprowski@samsung.com>
References: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
	<1283764347-460-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <00c001cb5f15$f9e6de40$edb49ac0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds common code to enable support of gpio interrupts on s5p
> series.
> 
> The total number of gpio pins is quite large on s5p series. Registering
> irq support for all of them would be a resource waste. Because of that
> the interrupt support for standard gpio pins is registered dynamically
> by the s5p_register_gpio_interrupt() function.

Hi,

I checked only S5PV210/S5PC110 GPIO interrupt.

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/Kconfig                      |    5 +
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/include/plat/irqs.h          |    5 +
>  arch/arm/plat-s5p/irq-gpioint.c                |  243
> ++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h  |   18 ++
>  arch/arm/plat-samsung/include/plat/gpio-core.h |    4 +
>  6 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s5p/irq-gpioint.c
> 
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 407e323..d77d518 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -32,6 +32,11 @@ config S5P_EXT_INT
>  	  Use the external interrupts (other than GPIO interrupts.)
>  	  Note: Do not choose this for S5P6440.
> 
> +config S5P_GPIO_INT
> +	bool
> +	help
> +	  Common code for the GPIO interrupts (other than external
interrupts.)
> +
>  config S5P_DEV_FIMC0
>  	bool
>  	help
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index f3e917e..e0823be 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -18,6 +18,7 @@ obj-y				+= cpu.o
>  obj-y				+= clock.o
>  obj-y				+= irq.o
>  obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
> +obj-$(CONFIG_S5P_GPIO_INT)	+= irq-gpioint.o
> 
>  # devices
> 
> diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-
> s5p/include/plat/irqs.h
> index 3fb3a3a..50bcf1e 100644
> --- a/arch/arm/plat-s5p/include/plat/irqs.h
> +++ b/arch/arm/plat-s5p/include/plat/irqs.h
> @@ -94,4 +94,9 @@
>  						((irq) - S5P_EINT_BASE1) : \
>  						((irq) + 16 -
> S5P_EINT_BASE2))
> 
> +/* GPIO interrupt (registered by s5p_register_gpio_interrupt) */
> +#define S5P_GPIOINT_GROUP_COUNT 4
> +#define S5P_GPIOINT_GROUP_SIZE	8

Is it possible to support S5P SoCs GPIO interrupt with only 4-GROUPs?

> +#define S5P_GPIOINT_COUNT	(S5P_GPIOINT_GROUP_COUNT *
> S5P_GPIOINT_GROUP_SIZE)
> +
>  #endif /* __ASM_PLAT_S5P_IRQS_H */
> diff --git a/arch/arm/plat-s5p/irq-gpioint.c
b/arch/arm/plat-s5p/irq-gpioint.c
> new file mode 100644
> index 0000000..7409ae0
> --- /dev/null
> +++ b/arch/arm/plat-s5p/irq-gpioint.c
> @@ -0,0 +1,243 @@
> +/* linux/arch/arm/plat-s5p/irq-gpioint.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * Author: Kyungmin Park <kyungmin.park@samsung.com>
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify
it
> + *  under  the terms of  the GNU General  Public License as published by
the
> + *  Free Software Foundation;  either version 2 of the  License, or (at
your
> + *  option) any later version.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +
> +#include <mach/map.h>
> +#include <plat/gpio-core.h>
> +#include <plat/gpio-cfg.h>
> +
> +#define S5P_GPIOREG(x)			(S5P_VA_GPIO + (x))
> +
> +#define GPIOINT_CON_OFFSET		0x700
> +#define GPIOINT_MASK_OFFSET		0x900
> +#define GPIOINT_PEND_OFFSET		0xA00
> +
> +#define GPIOINT_LEVEL_LOW		0x0
> +#define GPIOINT_LEVEL_HIGH		0x1
> +#define GPIOINT_EDGE_FALLING		0x2
> +#define GPIOINT_EDGE_RISING		0x3
> +#define GPIOINT_EDGE_BOTH		0x4

I remember Kyungmin's patch about interrupt polarity of GPIO Interrupt and
GPIO External Interrupt.
How about merging them into plat-s5p/include

Hmm...let's think the proper name...

> +
> +static struct s3c_gpio_chip *irq_chips[S5P_GPIOINT_GROUP_MAXNR];

Where is the definition of S5P_GPIOINT_GROUP_MAXNR?

> +
> +static int s5p_gpioint_get_group(unsigned int irq)
> +{
> +	struct gpio_chip *chip = get_irq_data(irq);
> +	struct s3c_gpio_chip *s3c_chip = container_of(chip,
> +			struct s3c_gpio_chip, chip);
> +	int group;
> +
> +	for (group = 0; group < S5P_GPIOINT_GROUP_MAXNR; group++)
> +		if (s3c_chip == irq_chips[group])
> +			break;
> +
> +	return group;
> +}
> +
> +static int s5p_gpioint_get_offset(unsigned int irq)
> +{
> +	struct gpio_chip *chip = get_irq_data(irq);
> +	struct s3c_gpio_chip *s3c_chip = container_of(chip,
> +			struct s3c_gpio_chip, chip);
> +
> +	return irq - s3c_chip->irq_base;
> +}
> +
> +static void s5p_gpioint_ack(unsigned int irq)
> +{
> +	int group, offset, pend_offset;
> +	unsigned int value;
> +
> +	group = s5p_gpioint_get_group(irq);
> +	offset = s5p_gpioint_get_offset(irq);
> +	pend_offset = group << 2;
> +
> +	value = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) +
> pend_offset);
> +	value |= 1 << offset;
> +	__raw_writel(value, S5P_GPIOREG(GPIOINT_PEND_OFFSET) +
> pend_offset);
> +}
> +
> +static void s5p_gpioint_mask(unsigned int irq)
> +{
> +	int group, offset, mask_offset;
> +	unsigned int value;
> +
> +	group = s5p_gpioint_get_group(irq);
> +	offset = s5p_gpioint_get_offset(irq);
> +	mask_offset = group << 2;
> +
> +	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> mask_offset);
> +	value |= 1 << offset;
> +	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> mask_offset);
> +}
> +
> +static void s5p_gpioint_unmask(unsigned int irq)
> +{
> +	int group, offset, mask_offset;
> +	unsigned int value;
> +
> +	group = s5p_gpioint_get_group(irq);
> +	offset = s5p_gpioint_get_offset(irq);
> +	mask_offset = group << 2;
> +
> +	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> mask_offset);
> +	value &= ~(1 << offset);
> +	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> mask_offset);
> +}
> +
> +static void s5p_gpioint_mask_ack(unsigned int irq)
> +{
> +	s5p_gpioint_mask(irq);
> +	s5p_gpioint_ack(irq);
> +}
> +
> +static int s5p_gpioint_set_type(unsigned int irq, unsigned int type)
> +{
> +	int group, offset, con_offset;
> +	unsigned int value;
> +
> +	group = s5p_gpioint_get_group(irq);
> +	offset = s5p_gpioint_get_offset(irq);
> +	con_offset = group << 2;
> +
> +	switch (type) {
> +	case IRQ_TYPE_NONE:
> +		printk(KERN_WARNING "No irq type\n");
> +		return -EINVAL;
> +	case IRQ_TYPE_EDGE_RISING:
> +		type = GPIOINT_EDGE_RISING;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		type = GPIOINT_EDGE_FALLING;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		type = GPIOINT_EDGE_BOTH;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		type = GPIOINT_LEVEL_HIGH;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		type = GPIOINT_LEVEL_LOW;
> +		break;
> +	default:
> +		BUG();

how about merging IRQ_TYPE_NONE and 'default'?
And basically, rerely happened exception case, so it's better move
IRQ_TYPE_NONE to later in switch case.

> +	}
> +
> +	value = __raw_readl(S5P_GPIOREG(GPIOINT_CON_OFFSET) +
> con_offset);
> +	value &= ~(0xf << (offset * 0x4));

0x7 is enough on S5PV210...but need to check another S5P SoCs.

> +	value |= (type << (offset * 0x4));
> +	__raw_writel(value, S5P_GPIOREG(GPIOINT_CON_OFFSET) +
> con_offset);
> +
> +	return 0;
> +}
> +
> +struct irq_chip s5p_gpioint = {
> +	.name		= "GPIO",

how about s5p-gpioint?

> +	.ack		= s5p_gpioint_ack,
> +	.mask		= s5p_gpioint_mask,
> +	.mask_ack	= s5p_gpioint_mask_ack,
> +	.unmask		= s5p_gpioint_unmask,
> +	.set_type	= s5p_gpioint_set_type,
> +};
> +
> +static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	int group, offset, pend_offset, mask_offset;
> +	int real_irq;
> +	unsigned int pend, mask;
> +
> +	for (group = 0; group < S5P_GPIOINT_GROUP_MAXNR; group++) {
> +		pend_offset = group << 2;
> +		pend = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) +
> +				pend_offset);
> +		if (!pend)
> +			continue;
> +
> +		mask_offset = group << 2;
> +		mask = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
> +				mask_offset);
> +		pend &= ~mask;
> +
> +		for (offset = 0; offset < 8; offset++) {
> +			if (pend & (1 << offset)) {
> +				struct s3c_gpio_chip *chip =
irq_chips[group];
> +				if (chip) {
> +					real_irq = chip->irq_base + offset;
> +					generic_handle_irq(real_irq);
> +				}
> +			}
> +		}
> +	}
> +}
> +
> +static __init int s5p_gpioint_add(struct s3c_gpio_chip *chip)
> +{
> +	static int used_gpioint_groups = 0;
> +	static bool handler_registered = 0;
> +	int irq, group = chip->group;
> +	int i;
> +
> +	if (used_gpioint_groups >= S5P_GPIOINT_GROUP_COUNT)
> +		return -ENOMEM;
> +
> +	chip->irq_base = S5P_GPIOINT_BASE +
> +			 used_gpioint_groups * S5P_GPIOINT_GROUP_SIZE;

Where is S5P_GPIOINT_BASE?

> +	used_gpioint_groups++;
> +
> +	if (!handler_registered) {
> +		set_irq_chained_handler(IRQ_GPIOINT, s5p_gpioint_handler);

As you know, IRQ_GPIOINT defined only in the mach-s5p6442, mach-s5pc100 and
mach-s5pv210.
It means can be happend build error with mach-s5p64x0 or mach-s5pv310.

> +		handler_registered = 1;
> +	}
> +
> +	irq_chips[group] = chip;
> +	for (i = 0; i < chip->chip.ngpio; i++) {
> +		irq = chip->irq_base + i;
> +		set_irq_chip(irq, &s5p_gpioint);
> +		set_irq_data(irq, &chip->chip);

Do we really need set_irq_data?

> +		set_irq_handler(irq, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +	return 0;
> +}
> +
> +int __init s5p_register_gpio_interrupt(int pin)
> +{
> +	struct s3c_gpio_chip *my_chip = s3c_gpiolib_getchip(pin);
> +	int offset, group;
> +	int ret;
> +
> +	if (!my_chip)
> +		return -EINVAL;
> +
> +	offset = pin - my_chip->chip.base;
> +	group = my_chip->group;
> +
> +	/* check if the group has been already registered */
> +	if (my_chip->irq_base)
> +		return my_chip->irq_base + offset;
> +
> +	/* register gpio group */
> +	ret = s5p_gpioint_add(my_chip);
> +	if (ret == 0) {
> +		printk(KERN_INFO "Registered interrupt support for gpio
> group %d.\n",
> +		       group);
> +		return my_chip->irq_base + offset;
> +	}
> +	return ret;
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
b/arch/arm/plat-
> samsung/include/plat/gpio-cfg.h
> index db4112c..41479a0 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
> @@ -169,4 +169,22 @@ extern s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned
> int pin);
>  */
>  extern int s5p_gpio_set_drvstr(unsigned int pin, s5p_gpio_drvstr_t
drvstr);
> 
> +/**
> + * s5p_register_gpio_interrupt() - register interrupt support for a gpio
group
> + * @pin: The pin number from the group to be registered
> + *
> + * This function registers gpio interrupt support for the group that the
> + * specified pin belongs to.
> + *
> + * The total number of gpio pins is quite large ob s5p series.
Registering
> + * irq support for all of them would be a resource waste. Because of that
the
> + * interrupt support for standard gpio pins is registered dynamically.
> + *
> + * It will return the irq number of the interrupt that has been
registered
> + * or -ENOMEM if no more gpio interrupts can be registered. It is allowed
> + * to call this function more than once for the same gpio group (the
group
> + * will be registered only once).
> + */
> +extern int s5p_register_gpio_interrupt(int pin);
> +
>  #endif /* __PLAT_GPIO_CFG_H */
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h
b/arch/arm/plat-
> samsung/include/plat/gpio-core.h
> index e358c7d..c22c27c 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-core.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
> @@ -43,6 +43,8 @@ struct s3c_gpio_cfg;
>   * struct s3c_gpio_chip - wrapper for specific implementation of gpio
>   * @chip: The chip structure to be exported via gpiolib.
>   * @base: The base pointer to the gpio configuration registers.
> + * @group: The group register number for gpio interrupt support.
> + * @irq_base: The base irq number.
>   * @config: special function and pull-resistor control information.
>   * @lock: Lock for exclusive access to this gpio bank.
>   * @pm_save: Save information for suspend/resume support.
> @@ -63,6 +65,8 @@ struct s3c_gpio_chip {
>  	struct s3c_gpio_cfg	*config;
>  	struct s3c_gpio_pm	*pm;
>  	void __iomem		*base;
> +	int			irq_base;
> +	int			group;
>  	spinlock_t		 lock;
>  #ifdef CONFIG_PM
>  	u32			pm_save[4];
> --

I need sleeping :-)
Will continue tomorrow.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
