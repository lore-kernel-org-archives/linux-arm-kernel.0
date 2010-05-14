From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 14 May 2010 02:20:52 +0100
Subject: [PATCH v3 2/2] ARM: S5PV210: Add Ext interrupt support
In-Reply-To: <1273749209-32461-1-git-send-email-kgene.kim@samsung.com>
References: <1273749209-32461-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100514012052.GN26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 08:13:29PM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> Add support for external interrupts on v210.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig                  |    1 +
>  arch/arm/mach-s5pv210/include/mach/irqs.h      |    5 +
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   84 +++++++++
>  arch/arm/plat-s5p/Kconfig                      |    5 +
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/irq-eint.c                   |  230 ++++++++++++++++++++++++
>  6 files changed, 326 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
>  create mode 100644 arch/arm/plat-s5p/irq-eint.c
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index af33a1a..c4c2a7f 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -12,6 +12,7 @@ if ARCH_S5PV210
>  config CPU_S5PV210
>  	bool
>  	select PLAT_S5P
> +	select S5P_EXT_INT
>  	help
>  	  Enable S5PV210 CPU support
>  
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
> index 62c5175..1714be2 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -139,6 +139,11 @@
>  #define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
>  #define IRQ_EINT(x)		S5P_EINT(x)
>  
> +#define S5P_EINT_SET0(x)	S5PV210_GPH0(x)
> +#define S5P_EINT_SET1(x)	S5PV210_GPH1(x)
> +#define S5P_EINT_SET2(x)	S5PV210_GPH2(x)
> +#define S5P_EINT_SET3(x)	S5PV210_GPH3(x)
> +
>  /* Set the default NR_IRQS */
>  
>  #define NR_IRQS 		(IRQ_EINT(31) + 1)
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> new file mode 100644
> index 0000000..86fb6a4
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> @@ -0,0 +1,84 @@
> +/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - GPIO (including EINT) register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_GPIO_H
> +#define __ASM_ARCH_REGS_GPIO_H __FILE__
> +
> +#include <mach/map.h>
> +
> +#define S5PV210_EINT30CON		(S5P_VA_GPIO + 0xE00)
> +#define S5PV210_EINT31CON		(S5P_VA_GPIO + 0xE04)
> +#define S5PV210_EINT32CON		(S5P_VA_GPIO + 0xE08)
> +#define S5PV210_EINT33CON		(S5P_VA_GPIO + 0xE0C)
> +
> +#define S5P_EINT_CON(x)			(S5PV210_EINT30CON + ((x) * 0x4))
> +
> +#define S5PV210_EINT30FLTCON0		(S5P_VA_GPIO + 0xE80)
> +#define S5PV210_EINT30FLTCON1		(S5P_VA_GPIO + 0xE84)
> +#define S5PV210_EINT31FLTCON0		(S5P_VA_GPIO + 0xE88)
> +#define S5PV210_EINT31FLTCON1		(S5P_VA_GPIO + 0xE8C)
> +#define S5PV210_EINT32FLTCON0		(S5P_VA_GPIO + 0xE90)
> +#define S5PV210_EINT32FLTCON1		(S5P_VA_GPIO + 0xE94)
> +#define S5PV210_EINT33FLTCON0		(S5P_VA_GPIO + 0xE98)
> +#define S5PV210_EINT33FLTCON1		(S5P_VA_GPIO + 0xE9C)

ok, do we really need all these defines? are they being used?

> +#define S5P_EINT_FLTCON(x)		(S5PV210_EINT30FLTCON0 + ((x) * 0x4))
> +
> +#define S5PV210_EINT30MASK		(S5P_VA_GPIO + 0xF00)
> +#define S5PV210_EINT31MASK		(S5P_VA_GPIO + 0xF04)
> +#define S5PV210_EINT32MASK		(S5P_VA_GPIO + 0xF08)
> +#define S5PV210_EINT33MASK		(S5P_VA_GPIO + 0xF0C)
> +
> +#define S5P_EINT_MASK(x)		(S5PV210_EINT30MASK + ((x) * 0x4))
> +
> +#define S5PV210_EINT30PEND		(S5P_VA_GPIO + 0xF40)
> +#define S5PV210_EINT31PEND		(S5P_VA_GPIO + 0xF44)
> +#define S5PV210_EINT32PEND		(S5P_VA_GPIO + 0xF48)
> +#define S5PV210_EINT33PEND		(S5P_VA_GPIO + 0xF4C)
> +
> +#define S5P_EINT_PEND(x)		(S5PV210_EINT30PEND + ((x) * 0x4))
> +
> +#define eint_offset(irq)	((irq) < IRQ_EINT16_31 ? ((irq)-IRQ_EINT0) \
> +						: (irq-S5P_IRQ_EINT_BASE))

I'm beginging to think it would be easier to have a seperate
handler for the EINT0..EINT15 ase and then have a seperate one
for the others in the EINT group.

> +#define eint_irq_to_bit(irq)		(1 << (eint_offset(irq) & 0x7))
> +
> +#define eint_conf_reg(irq)		((eint_offset(irq)) >> 3)
> +#define eint_filt_reg(irq)		((eint_offset(irq)) >> 2)
> +#define eint_mask_reg(irq)		((eint_offset(irq)) >> 3)
> +#define eint_pend_reg(irq)		((eint_offset(irq)) >> 3)
> +
> +#define S5P_EINT30CON			S5PV210_EINT30CON
> +#define S5P_EINT31CON			S5PV210_EINT31CON
> +#define S5P_EINT32CON			S5PV210_EINT32CON
> +#define S5P_EINT33CON			S5PV210_EINT33CON
> +#define S5P_EINT30FLTCON0		S5PV210_EINT30FLTCON0
> +#define S5P_EINT30FLTCON1		S5PV210_EINT30FLTCON1
> +#define S5P_EINT31FLTCON0		S5PV210_EINT31FLTCON0
> +#define S5P_EINT31FLTCON1		S5PV210_EINT31FLTCON1
> +#define S5P_EINT32FLTCON0		S5PV210_EINT32FLTCON0
> +#define S5P_EINT32FLTCON1		S5PV210_EINT32FLTCON1
> +#define S5P_EINT33FLTCON0		S5PV210_EINT33FLTCON0
> +#define S5P_EINT33FLTCON1		S5PV210_EINT33FLTCON1
> +#define S5P_EINT30MASK			S5PV210_EINT30MASK
> +#define S5P_EINT31MASK			S5PV210_EINT31MASK
> +#define S5P_EINT32MASK			S5PV210_EINT32MASK
> +#define S5P_EINT33MASK			S5PV210_EINT33MASK
> +
> +/* values for S5P_EXTINT0 */
> +#define S5P_EXTINT_LOWLEV		(0x00)
> +#define S5P_EXTINT_HILEV		(0x01)
> +#define S5P_EXTINT_FALLEDGE		(0x02)
> +#define S5P_EXTINT_RISEEDGE		(0x03)
> +#define S5P_EXTINT_BOTHEDGE		(0x04)
> +#endif /* __ASM_ARCH_REGS_GPIO_H */
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index d400a6a..7d1fc40 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -23,3 +23,8 @@ config PLAT_S5P
>  	select SAMSUNG_IRQ_UART
>  	help
>  	  Base platform code for Samsung's S5P series SoC.
> +
> +config S5P_EXT_INT
> +	bool
> +	help
> +	  Use the external interrupts (other than GPIO interrupts.)
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index a7c54b3..25941a5 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -16,4 +16,5 @@ obj-y				+= dev-uart.o
>  obj-y				+= cpu.o
>  obj-y				+= clock.o
>  obj-y				+= irq.o
> +obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
>  obj-y				+= setup-i2c0.o
> diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> new file mode 100644
> index 0000000..84f1016
> --- /dev/null
> +++ b/arch/arm/plat-s5p/irq-eint.c
> @@ -0,0 +1,230 @@
> +/* linux/arch/arm/plat-s5p/irq-eint.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P - IRQ EINT support
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
> +#include <asm/bitops.h>
> +#include <asm/hardware/vic.h>
> +
> +#include <plat/regs-irqtype.h>
> +
> +#include <mach/map.h>
> +#include <plat/cpu.h>
> +#include <plat/pm.h>
> +
> +#include <plat/gpio-cfg.h>
> +#include <mach/regs-gpio.h>
> +
> +static inline void s5p_irq_eint_mask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> +	mask |= eint_irq_to_bit(irq);
> +	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> +}
> +
> +static void s5p_irq_eint_unmask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> +	mask &= ~(eint_irq_to_bit(irq));
> +	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> +}
> +
> +static inline void s5p_irq_eint_ack(unsigned int irq)
> +{
> +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> +}
> +
> +static void s5p_irq_eint_maskack(unsigned int irq)
> +{
> +	/* compiler should in-line these */
> +	s5p_irq_eint_mask(irq);
> +	s5p_irq_eint_ack(irq);
> +}
> +
> +static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
> +{
> +	int offs = eint_offset(irq);
> +	int shift;
> +	u32 ctrl, mask;
> +	u32 newvalue = 0;
> +
> +	switch (type) {
> +	case IRQ_TYPE_NONE:
> +		printk(KERN_WARNING "No edge setting!\n");
> +		break;
> +
> +	case IRQ_TYPE_EDGE_RISING:
> +		newvalue = S5P_EXTINT_RISEEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		newvalue = S5P_EXTINT_RISEEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		newvalue = S5P_EXTINT_BOTHEDGE;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		newvalue = S5P_EXTINT_LOWLEV;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		newvalue = S5P_EXTINT_HILEV;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -1;
> +	}
> +
> +	shift = (offs & 0x7) * 4;
> +	mask = 0x7 << shift;
> +
> +	ctrl = __raw_readl(S5P_EINT_CON(eint_conf_reg(irq)));
> +	ctrl &= ~mask;
> +	ctrl |= newvalue << shift;
> +	__raw_writel(ctrl, S5P_EINT_CON(eint_conf_reg(irq)));
> +
> +	if ((0 <= offs) && (offs < 8))
> +		s3c_gpio_cfgpin(S5P_EINT_SET0(offs&0x7), 0xf<<((offs&0x7)*4));

S3C_GPIO_SFN(0xf) would avoid the shifting of the second argument.
how about an array for the first, and do the following:

    s3c_gpio_cfgpin(set[offs >> 3] + (offs & 0x7));

also, please rember coding style and use 'offs & 0x7'

> +	else if ((8 <= offs) && (offs < 16))
> +		s3c_gpio_cfgpin(S5P_EINT_SET1(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else if ((16 <= offs) && (offs < 24))
> +		s3c_gpio_cfgpin(S5P_EINT_SET2(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else if ((24 <= offs) && (offs < 32))
> +		s3c_gpio_cfgpin(S5P_EINT_SET3(offs&0x7), 0xf<<((offs&0x7)*4));
> +
> +	else
> +		printk(KERN_ERR "No such irq number %d", offs);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip s5p_irq_eint = {
> +	.name		= "s5p-eint",
> +	.mask		= s5p_irq_eint_mask,
> +	.unmask		= s5p_irq_eint_unmask,
> +	.mask_ack	= s5p_irq_eint_maskack,
> +	.ack		= s5p_irq_eint_ack,
> +	.set_type	= s5p_irq_eint_set_type,
> +#ifdef CONFIG_PM
> +	.set_wake	= s3c_irqext_wake,
> +#endif
> +};
> +
> +/* s5p_irq_demux_eint
> + *
> + * This function demuxes the IRQ from the group0 external interrupts,
> + * from IRQ_EINT(16) to IRQ_EINT(31). It is designed to be inlined into
> + * the specific handlers s5p_irq_demux_eintX_Y.
> + */
> +static inline void s5p_irq_demux_eint(unsigned int start, unsigned int end)
> +{
> +	u32 status;
> +	u32 mask = __raw_readl(S5P_EINT_MASK((start >> 3)));
> +	unsigned int irq;
> +
> +	status = __raw_readl(S5P_EINT_PEND((start >> 3)));

thought you'd defined mcros for this function in the header....

> +	status &= ~mask;
> +	status &= (1 << (end - start + 1)) - 1;
> +
> +	while (status) {
> +		irq = fls(status);
> +		generic_handle_irq(irq - 1 + IRQ_EINT(start));
> +		clear_bit(irq, (long unsigned int *)&status);

is it any more/less efficient than 'status &= ~(1 << irq)' ?
I'll put a 100WON wager on not using clear_bit being the best.

> +	}
> +}
> +
> +static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_eint(16, 23);
> +	s5p_irq_demux_eint(24, 31);
> +}
> +
> +/* EINT0 ~ EINT15 */
> +
> +static void s5p_irq_vic_eint_mask(unsigned int irq)
> +{
> +	void __iomem *base = get_irq_chip_data(irq);
> +
> +	s5p_irq_eint_mask(irq);
> +
> +	irq &= 31;
> +	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
> +}

Do we need to be disaling both the EINT mask and the VIC one?

Would leaving the VIC unmasked and simply using the EINT mask be better?

> +static void s5p_irq_vic_eint_unmask(unsigned int irq)
> +{
> +	void __iomem *base = get_irq_chip_data(irq);
> +
> +	s5p_irq_eint_unmask(irq);
> +
> +	irq &= 31;
> +	writel(1 << irq, base + VIC_INT_ENABLE);
> +}
> +
> +static inline void s5p_irq_vic_eint_ack(unsigned int irq)
> +{
> +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> +}
> +
> +static void s5p_irq_vic_eint_maskack(unsigned int irq)
> +{
> +	/* compiler should in-line these */
> +	s5p_irq_vic_eint_mask(irq);
> +	s5p_irq_vic_eint_ack(irq);
> +}
> +
> +static struct irq_chip s5p_irq_vic_eint = {
> +	.name		= "s5p_vic_eint",
> +	.mask		= s5p_irq_vic_eint_mask,
> +	.unmask		= s5p_irq_vic_eint_unmask,
> +	.mask_ack	= s5p_irq_vic_eint_maskack,
> +	.ack		= s5p_irq_vic_eint_ack,
> +	.set_type	= s5p_irq_eint_set_type,
> +#ifdef CONFIG_PM
> +	.set_wake	= s3c_irqext_wake,
> +#endif
> +
> +};
> +
> +int __init s5p_init_irq_eint(void)
> +{
> +	int irq;
> +
> +	for (irq = IRQ_EINT0; irq <= IRQ_EINT15; irq++)
> +		set_irq_chip(irq, &s5p_irq_vic_eint);
> +
> +	for (irq = IRQ_EINT(16); irq <= IRQ_EINT(31); irq++) {
> +		set_irq_chip(irq, &s5p_irq_eint);
> +		set_irq_handler(irq, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(IRQ_EINT16_31, s5p_irq_demux_eint16_31);
> +	return 0;
> +}
> +
> +arch_initcall(s5p_init_irq_eint);

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
