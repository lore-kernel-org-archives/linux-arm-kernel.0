From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 07 Oct 2010 14:30:42 +0200
Subject: [PATCH 3/3] ARM: S5PV310: Add external interrupt support
In-Reply-To: <1286450698-12029-4-git-send-email-jongsun.han@samsung.com>
References: <1286450698-12029-1-git-send-email-jongsun.han@samsung.com>
	<1286450698-12029-4-git-send-email-jongsun.han@samsung.com>
Message-ID: <019101cb661b$77eef410$67ccdc30$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, October 07, 2010 1:25 PM Jongsun Han wrote:

> This patch adds the external interrupt support.
> All external interrupts are transferred to GIC through interrupt combiner.
> 
> Signed-off-by: Jongsun Han <jongsun.han@samsung.com>
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Makefile   |    2 +-
>  arch/arm/mach-s5pv310/irq-eint.c |  257 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 258 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/irq-eint.c
> 
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index d17c8c7..7b91a9b 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -13,7 +13,7 @@ obj-				:=
>  # Core support for S5PV310 system
> 
>  obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
> -obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o
> +obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o irq-eint.o
>  obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
> 
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-s5pv310/irq-eint.c
> new file mode 100644
> index 0000000..5eb464b
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/irq-eint.c
> @@ -0,0 +1,257 @@
> +/* linux/arch/arm/mach-s5pv310/irq-eint.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * S5PV310 - IRQ EINT support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/sysdev.h>
> +#include <linux/gpio.h>
> +
> +#include <plat/regs-irqtype.h>
> +#include <plat/pm.h>
> +#include <plat/cpu.h>
> +#include <plat/gpio-cfg.h>
> +
> +#include <mach/map.h>
> +#include <mach/regs-gpio.h>
> +
> +static DEFINE_SPINLOCK(eint_lock);
> +
> +static unsigned int s5pv310_get_irq_nr(unsigned int number)
> +{
> +	u32 ret = 0;
> +
> +	switch (number) {
> +	case 0 ... 3:
> +		ret = (number + IRQ_EINT0);
> +		break;
> +	case 4 ... 7:
> +		ret = (number + (IRQ_EINT4 - 4));
> +		break;
> +	case 8 ... 15:
> +		ret = (number + (IRQ_EINT8 - 8));
> +		break;
> +	default:
> +		printk(KERN_ERR "number available : %d\n", number);
> +	}
> +
> +	return ret;
> +}
> +
> +static unsigned int s5pv310_irq_split(unsigned int number)
> +{
> +	u32 ret;
> +	u32 test = number;
> +
> +	ret = do_div(test, IRQ_EINT_BASE);
> +
> +	do_div(ret, 8);
> +
> +	return ret;
> +}
> +
> +static unsigned int s5pv310_irq_to_bit(unsigned int irq)
> +{
> +	u32 ret;
> +	u32 tmp;
> +
> +	tmp = do_div(irq, IRQ_EINT_BASE);
> +
> +	ret = do_div(tmp, 8);
> +
> +	return 1 << ret;
> +}
> +
> +static inline void s5pv310_irq_eint_mask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	spin_lock(&eint_lock);
> +	mask = __raw_readl(S5P_EINT_MASK(s5pv310_irq_split(irq)));
> +	mask |= s5pv310_irq_to_bit(irq);
> +	__raw_writel(mask, S5P_EINT_MASK(s5pv310_irq_split(irq)));
> +	spin_unlock(&eint_lock);
> +}
> +
> +static void s5pv310_irq_eint_unmask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	spin_lock(&eint_lock);
> +	mask = __raw_readl(S5P_EINT_MASK(s5pv310_irq_split(irq)));
> +	mask &= ~(s5pv310_irq_to_bit(irq));
> +	__raw_writel(mask, S5P_EINT_MASK(s5pv310_irq_split(irq)));
> +	spin_unlock(&eint_lock);
> +}
> +
> +static inline void s5pv310_irq_eint_ack(unsigned int irq)
> +{
> +	spin_lock(&eint_lock);
> +	__raw_writel(s5pv310_irq_to_bit(irq),
> +		     S5P_EINT_PEND(s5pv310_irq_split(irq)));
> +	spin_unlock(&eint_lock);
> +}
> +
> +static void s5pv310_irq_eint_maskack(unsigned int irq)
> +{
> +	s5pv310_irq_eint_mask(irq);
> +	s5pv310_irq_eint_ack(irq);
> +}
> +
> +static int s5pv310_irq_eint_set_type(unsigned int irq, unsigned int type)
> +{
> +	int offs = EINT_OFFSET(irq);
> +	int shift;
> +	u32 ctrl, mask;
> +	u32 newvalue = 0;
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		newvalue = S5P_IRQ_TYPE_EDGE_RISING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		newvalue = S5P_IRQ_TYPE_EDGE_FALLING;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		newvalue = S5P_IRQ_TYPE_EDGE_BOTH;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:

> +		if (irq == IRQ_EINT(5))
> +			newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
> +		else
> +			newvalue = S5P_IRQ_TYPE_LEVEL_LOW;

This one looks like an ugle hack. What is it for?

> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -EINVAL;
> +	}
> +
> +	shift = (offs & 0x7) * 4;
> +	mask = 0x7 << shift;
> +
> +	spin_lock(&eint_lock);
> +	ctrl = __raw_readl(S5P_EINT_CON(s5pv310_irq_split(irq)));
> +	ctrl &= ~mask;
> +	ctrl |= newvalue << shift;
> +	__raw_writel(ctrl, S5P_EINT_CON(s5pv310_irq_split(irq)));
> +	spin_unlock(&eint_lock);
> +
> +	if ((0 <= offs) && (offs < 8))
> +		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
> +
> +	else if ((8 <= offs) && (offs < 16))
> +		s3c_gpio_cfgpin(EINT_GPIO_1(offs & 0x7), EINT_MODE);
> +
> +	else if ((16 <= offs) && (offs < 24))
> +		s3c_gpio_cfgpin(EINT_GPIO_2(offs & 0x7), EINT_MODE);
> +
> +	else if ((24 <= offs) && (offs < 32))
> +		s3c_gpio_cfgpin(EINT_GPIO_3(offs & 0x7), EINT_MODE);
> +
> +	else
> +		printk(KERN_ERR "No such irq number %d", offs);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip s5pv310_irq_eint = {
> +	.name		= "s5pv310-eint",
> +	.mask		= s5pv310_irq_eint_mask,
> +	.unmask		= s5pv310_irq_eint_unmask,
> +	.mask_ack	= s5pv310_irq_eint_maskack,
> +	.ack		= s5pv310_irq_eint_ack,
> +	.set_type	= s5pv310_irq_eint_set_type,
> +#ifdef CONFIG_PM
> +	.set_wake	= s3c_irqext_wake,
> +#endif
> +};
> +
> +/* s5pv310_irq_demux_eint
> + *
> + * This function demuxes the IRQ from from EINTs 16 to 31.
> + * It is designed to be inlined into the specific handler
> + * s5p_irq_demux_eintX_Y.
> + *
> + * Each EINT pend/mask registers handle eight of them.
> + */
> +static inline void s5pv310_irq_demux_eint(unsigned int start)
> +{
> +	unsigned int irq;
> +
> +	u32 status = __raw_readl(S5P_EINT_PEND(s5pv310_irq_split(start)));
> +	u32 mask = __raw_readl(S5P_EINT_MASK(s5pv310_irq_split(start)));
> +
> +	status &= ~mask;
> +	status &= 0xff;
> +
> +	while (status) {
> +		irq = fls(status) - 1;
> +		generic_handle_irq(irq + start);
> +		status &= ~(1 << irq);
> +	}
> +}
> +
> +static void s5pv310_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5pv310_irq_demux_eint(IRQ_EINT(16));
> +	s5pv310_irq_demux_eint(IRQ_EINT(24));
> +}
> +
> +static void s5pv310_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
> +{
> +	u32 i;
> +	struct irq_chip *chip = get_irq_chip(irq);
> +
> +	chip->mask(irq);
> +
> +	if (chip->ack)
> +		chip->ack(irq);
> +
> +	for (i = 0 ; i <= 15 ; i++) {
> +		if (irq == s5pv310_get_irq_nr(i)) {
> +			generic_handle_irq(IRQ_EINT(i));
> +			break;
> +		}
> +	}
> +
> +	chip->unmask(irq);
> +}

Am I right that this chained handler is just a simple proxy? If so is it really
needed?

> +
> +int __init s5pv310_init_irq_eint(void)
> +{
> +	int irq;
> +
> +	for (irq = 0 ; irq <= 31 ; irq++) {
> +		set_irq_chip(IRQ_EINT(irq), &s5pv310_irq_eint);
> +		set_irq_handler(IRQ_EINT(irq), handle_level_irq);
> +		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(IRQ_EINT16_31, s5pv310_irq_demux_eint16_31);
> +
> +	for (irq = 0 ; irq <= 15 ; irq++)
> +		set_irq_chained_handler(s5pv310_get_irq_nr(irq),
> +					s5pv310_irq_eint0_15);
> +
> +	return 0;
> +}
> +
> +arch_initcall(s5pv310_init_irq_eint);

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
