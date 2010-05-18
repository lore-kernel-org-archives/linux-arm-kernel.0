From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 May 2010 09:39:00 +0200
Subject: [PATCH v6] ARM: S5PV210: Add Ext interrupt support.
In-Reply-To: <1274082986-24250-1-git-send-email-kgene.kim@samsung.com>
References: <1274082986-24250-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <00dd01caf65d$316c8f30$9445ad90$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, May 17, 2010 9:56 AM Kukjin Kim wrote:

> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> Add support for external interrupts on S5PV210.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig                  |    1 +
>  arch/arm/mach-s5pv210/include/mach/irqs.h      |   31 ++---
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   44 +++++
>  arch/arm/plat-s5p/Kconfig                      |    5 +
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/irq-eint.c                   |  213
> ++++++++++++++++++++++++
>  6 files changed, 275 insertions(+), 20 deletions(-)
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
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
> s5pv210/include/mach/irqs.h
> index 62c5175..3a9e42e 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -17,22 +17,6 @@
> 
>  /* VIC0: System, DMA, Timer */
> 
> -#define IRQ_EINT0		S5P_IRQ_VIC0(0)
> -#define IRQ_EINT1		S5P_IRQ_VIC0(1)
> -#define IRQ_EINT2		S5P_IRQ_VIC0(2)
> -#define IRQ_EINT3		S5P_IRQ_VIC0(3)
> -#define IRQ_EINT4		S5P_IRQ_VIC0(4)
> -#define IRQ_EINT5		S5P_IRQ_VIC0(5)
> -#define IRQ_EINT6		S5P_IRQ_VIC0(6)
> -#define IRQ_EINT7		S5P_IRQ_VIC0(7)
> -#define IRQ_EINT8		S5P_IRQ_VIC0(8)
> -#define IRQ_EINT9		S5P_IRQ_VIC0(9)
> -#define IRQ_EINT10		S5P_IRQ_VIC0(10)
> -#define IRQ_EINT11		S5P_IRQ_VIC0(11)
> -#define IRQ_EINT12		S5P_IRQ_VIC0(12)
> -#define IRQ_EINT13		S5P_IRQ_VIC0(13)
> -#define IRQ_EINT14		S5P_IRQ_VIC0(14)
> -#define IRQ_EINT15		S5P_IRQ_VIC0(15)
>  #define IRQ_EINT16_31		S5P_IRQ_VIC0(16)
>  #define IRQ_BATF		S5P_IRQ_VIC0(17)
>  #define IRQ_MDMA		S5P_IRQ_VIC0(18)
> @@ -134,13 +118,20 @@
>  #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
>  #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
> 
> -#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
> +#define S5P_EINT_16_31_BASE	(IRQ_VIC_END + 1)
> 
> -#define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
> -#define IRQ_EINT(x)		S5P_EINT(x)
> +#define EINT_MODE		S3C_GPIO_SFN(0xf)
> +
> +#define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_IRQ_VIC0(0)) \
> +					: ((x) + S5P_EINT_16_31_BASE))

Is there any reason for loosing 16 irq numbers? In this macro
EINT(16-31) irqs are mapped to the range from S5P_EINT_16_31_BASE+16
to S5P_EINT_16_31_BASE+31, while the range from S5P_EINT_16_31_BASE
to S5P_EINT_16_31_BASE+15 is not used at all.

>  /* Set the default NR_IRQS */
> 
> -#define NR_IRQS 		(IRQ_EINT(31) + 1)
> +#define NR_IRQS			(IRQ_EINT(31) + 1)
> +
> +#define EINT_GPIO_0(x)		S5PV210_GPH0(x)
> +#define EINT_GPIO_1(x)		S5PV210_GPH1(x)
> +#define EINT_GPIO_2(x)		S5PV210_GPH2(x)
> +#define EINT_GPIO_3(x)		S5PV210_GPH3(x)
> 
>  #endif /* ASM_ARCH_IRQS_H */
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> new file mode 100644
> index 0000000..5ff4b03
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> @@ -0,0 +1,44 @@
> +/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
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
> +#define S5P_EINT_CON(x)			(S5PV210_EINT30CON + ((x) *
0x4))
> +
> +#define S5PV210_EINT30FLTCON0		(S5P_VA_GPIO + 0xE80)
> +#define S5P_EINT_FLTCON(x)		(S5PV210_EINT30FLTCON0 + ((x) * 0x4))
> +
> +#define S5PV210_EINT30MASK		(S5P_VA_GPIO + 0xF00)
> +#define S5P_EINT_MASK(x)		(S5PV210_EINT30MASK + ((x) * 0x4))
> +
> +#define S5PV210_EINT30PEND		(S5P_VA_GPIO + 0xF40)
> +#define S5P_EINT_PEND(x)		(S5PV210_EINT30PEND + ((x) * 0x4))
> +
> +#define eint_offset(irq)	((irq) < IRQ_EINT16_31 ? ((irq) - IRQ_EINT(0))
> \
> +						: ((irq) - S5P_EINT_16_31_BASE))
> +
> +#define EINT_REG_NR(x)			(eint_offset(x) >> 3)
> +
> +#define eint_irq_to_bit(irq)		(1 << (eint_offset(irq) & 0x7))
> +
> +/* values for S5P_EXTINT0 */
> +#define S5P_EXTINT_LOWLEV		(0x00)
> +#define S5P_EXTINT_HILEV		(0x01)
> +#define S5P_EXTINT_FALLEDGE		(0x02)
> +#define S5P_EXTINT_RISEEDGE		(0x03)
> +#define S5P_EXTINT_BOTHEDGE		(0x04)
> +
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
> index 0000000..ec263d1
> --- /dev/null
> +++ b/arch/arm/plat-s5p/irq-eint.c
> @@ -0,0 +1,213 @@
> +/* linux/arch/arm/plat-s5p/irq-eint.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
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
> +	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
> +	mask |= eint_irq_to_bit(irq);
> +	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
> +}
> +
> +static void s5p_irq_eint_unmask(unsigned int irq)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
> +	mask &= ~(eint_irq_to_bit(irq));
> +	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
> +}
> +
> +static inline void s5p_irq_eint_ack(unsigned int irq)
> +{
> +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
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
> +		return -EINVAL;
> +	}
> +
> +	shift = (offs & 0x7) * 4;
> +	mask = 0x7 << shift;
> +
> +	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
> +	ctrl &= ~mask;
> +	ctrl |= newvalue << shift;
> +	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
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
> + * from EINTs 16 to 31. It is designed to be inlined into the specific
> + * handler s5p_irq_demux_eintX_Y.
> + *
> + * Each EINT pend/mask registers handle eight of them.
> + */
> +static inline void s5p_irq_demux_eint(unsigned int start)
> +{
> +	u32 status;
> +	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
> +	unsigned int irq;
> +
> +	status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
> +	status &= ~mask;
> +	status &= 0xff;
> +
> +	while (status) {
> +		irq = fls(status);
> +		generic_handle_irq(irq - 1 + start);
> +		status &= ~(1 << irq);
> +	}
> +}
> +
> +static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc
> *desc)
> +{
> +	s5p_irq_demux_eint(IRQ_EINT(16));
> +	s5p_irq_demux_eint(IRQ_EINT(24));
> +}
> +
> +static inline void s5p_irq_vic_eint_mask(unsigned int irq)
> +{
> +	s5p_irq_eint_mask(irq);
> +}
> +
> +static void s5p_irq_vic_eint_unmask(unsigned int irq)
> +{
> +	s5p_irq_eint_unmask(irq);
> +}

I've tested this code on SMDKC100 and it does not work without
masking/unmasking the irqs directly in VIC. The following code works
fine:

static inline void s5p_irq_vic_eint_mask(unsigned int irq)
{
        void __iomem *base = get_irq_chip_data(irq);
        s5p_irq_eint_mask(irq);
        writel(1<<eint_offset(irq), base + VIC_INT_ENABLE_CLEAR);
}

static void s5p_irq_vic_eint_unmask(unsigned int irq)
{
        void __iomem *base = get_irq_chip_data(irq);
        s5p_irq_eint_unmask(irq);
        writel(1<<eint_offset(irq), base + VIC_INT_ENABLE);
}

> +
> +static inline void s5p_irq_vic_eint_ack(unsigned int irq)
> +{
> +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
> +}
> +
> +static void s5p_irq_vic_eint_maskack(unsigned int irq)
> +{
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
> +};
> +
> +int __init s5p_init_irq_eint(void)
> +{
> +	int irq;
> +
> +	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++)
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
> --

I've also have problems with chained external interrupts from range 16-31.
Once the interrupt is raised it is raised constantly in endless loop. I
still didn't manage to figure what causes this problem. All register writes
seems to be the same as with my older version, which worked fine.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
