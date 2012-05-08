From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 08 May 2012 11:56:06 -0600
Subject: [PATCH v2 3/9] ARM: mmp: support DT in irq
In-Reply-To: <1336134626-12262-4-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <1336134626-12262-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20120508175606.B753A3E05D0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  4 May 2012 20:30:20 +0800, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> Merge irq-pxa168 and irq-mmp2. And support device tree also.
> 
> Since CONFIG_SPARSE_IRQ is enabled in arch-mmp, base irq starts from
> NR_IRQS_LEGACY.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

This is a really big change and difficult to review for regressions.
Is there any way you can break it down into incremental steps?  ie.
something like:
- first rename one of the drivers,
- factor out commit bits,
- pull in features from the other irq driver
- add DT support

> ---
>  arch/arm/Kconfig                             |    1 +
>  arch/arm/mach-mmp/Makefile                   |    8 +-
>  arch/arm/mach-mmp/include/mach/entry-macro.S |    4 +-
>  arch/arm/mach-mmp/include/mach/irqs.h        |   27 ++-
>  arch/arm/mach-mmp/irq-mmp2.c                 |  158 ---------
>  arch/arm/mach-mmp/irq-pxa168.c               |   54 ---
>  arch/arm/mach-mmp/irq.c                      |  445 ++++++++++++++++++++++++++
>  7 files changed, 472 insertions(+), 225 deletions(-)
>  delete mode 100644 arch/arm/mach-mmp/irq-mmp2.c
>  delete mode 100644 arch/arm/mach-mmp/irq-pxa168.c
>  create mode 100644 arch/arm/mach-mmp/irq.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cf006d4..4cf9d42 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -632,6 +632,7 @@ config ARCH_MMP
>  	select CLKDEV_LOOKUP
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_PXA
> +	select IRQ_DOMAIN
>  	select TICK_ONESHOT
>  	select PLAT_PXA
>  	select SPARSE_IRQ
> diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
> index 4fc0ff5..77f63c1 100644
> --- a/arch/arm/mach-mmp/Makefile
> +++ b/arch/arm/mach-mmp/Makefile
> @@ -2,12 +2,12 @@
>  # Makefile for Marvell's PXA168 processors line
>  #
>  
> -obj-y				+= common.o clock.o devices.o time.o
> +obj-y				+= common.o clock.o devices.o time.o irq.o
>  
>  # SoC support
> -obj-$(CONFIG_CPU_PXA168)	+= pxa168.o irq-pxa168.o
> -obj-$(CONFIG_CPU_PXA910)	+= pxa910.o irq-pxa168.o
> -obj-$(CONFIG_CPU_MMP2)		+= mmp2.o irq-mmp2.o sram.o
> +obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
> +obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
> +obj-$(CONFIG_CPU_MMP2)		+= mmp2.o sram.o
>  
>  # board support
>  obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
> diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
> index 9cff9e7..bd152e2 100644
> --- a/arch/arm/mach-mmp/include/mach/entry-macro.S
> +++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
> @@ -6,13 +6,15 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <asm/irq.h>
>  #include <mach/regs-icu.h>
>  
>  	.macro	get_irqnr_preamble, base, tmp
>  	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
>  	and	\tmp, \tmp, #0xff00
>  	cmp	\tmp, #0x5800
> -	ldr	\base, =ICU_VIRT_BASE
> +	ldr	\base, =mmp_icu_base
> +	ldr	\base, [\base, #0]
>  	addne	\base, \base, #0x10c		@ PJ1 AP INT SEL register
>  	addeq	\base, \base, #0x104		@ PJ4 IRQ SEL register
>  	.endm
> diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
> index d0e7466..fb492a5 100644
> --- a/arch/arm/mach-mmp/include/mach/irqs.h
> +++ b/arch/arm/mach-mmp/include/mach/irqs.h
> @@ -125,7 +125,7 @@
>  #define IRQ_MMP2_RTC_MUX		5
>  #define IRQ_MMP2_TWSI1			7
>  #define IRQ_MMP2_GPU			8
> -#define IRQ_MMP2_KEYPAD			9
> +#define IRQ_MMP2_KEYPAD_MUX		9
>  #define IRQ_MMP2_ROTARY			10
>  #define IRQ_MMP2_TRACKBALL		11
>  #define IRQ_MMP2_ONEWIRE		12
> @@ -163,11 +163,11 @@
>  #define IRQ_MMP2_DMA_FIQ		47
>  #define IRQ_MMP2_DMA_RIQ		48
>  #define IRQ_MMP2_GPIO			49
> -#define IRQ_MMP2_SSP_MUX		51
> +#define IRQ_MMP2_MIPI_HSI1_MUX		51
>  #define IRQ_MMP2_MMC2			52
>  #define IRQ_MMP2_MMC3			53
>  #define IRQ_MMP2_MMC4			54
> -#define IRQ_MMP2_MIPI_HSI		55
> +#define IRQ_MMP2_MIPI_HSI0_MUX		55
>  #define IRQ_MMP2_MSP			58
>  #define IRQ_MMP2_MIPI_SLIM_DMA		59
>  #define IRQ_MMP2_PJ4_FREQ_CHG		60
> @@ -186,8 +186,14 @@
>  #define IRQ_MMP2_RTC_ALARM		(IRQ_MMP2_RTC_BASE + 0)
>  #define IRQ_MMP2_RTC			(IRQ_MMP2_RTC_BASE + 1)
>  
> +/* secondary interrupt of INT #9 */
> +#define IRQ_MMP2_KEYPAD_BASE		(IRQ_MMP2_RTC_BASE + 2)
> +#define IRQ_MMP2_KPC			(IRQ_MMP2_KEYPAD_BASE + 0)
> +#define IRQ_MMP2_ROTORY			(IRQ_MMP2_KEYPAD_BASE + 1)
> +#define IRQ_MMP2_TBALL			(IRQ_MMP2_KEYPAD_BASE + 2)
> +
>  /* secondary interrupt of INT #17 */
> -#define IRQ_MMP2_TWSI_BASE		(IRQ_MMP2_RTC_BASE + 2)
> +#define IRQ_MMP2_TWSI_BASE		(IRQ_MMP2_KEYPAD_BASE + 3)
>  #define IRQ_MMP2_TWSI2			(IRQ_MMP2_TWSI_BASE + 0)
>  #define IRQ_MMP2_TWSI3			(IRQ_MMP2_TWSI_BASE + 1)
>  #define IRQ_MMP2_TWSI4			(IRQ_MMP2_TWSI_BASE + 2)
> @@ -212,11 +218,16 @@
>  #define IRQ_MMP2_COMMRX			(IRQ_MMP2_MISC_BASE + 14)
>  
>  /* secondary interrupt of INT #51 */
> -#define IRQ_MMP2_SSP_BASE		(IRQ_MMP2_MISC_BASE + 15)
> -#define IRQ_MMP2_SSP1_SRDY		(IRQ_MMP2_SSP_BASE + 0)
> -#define IRQ_MMP2_SSP3_SRDY		(IRQ_MMP2_SSP_BASE + 1)
> +#define IRQ_MMP2_MIPI_HSI1_BASE		(IRQ_MMP2_MISC_BASE + 15)
> +#define IRQ_MMP2_HSI1_CAWAKE		(IRQ_MMP2_MIPI_HSI1_BASE + 0)
> +#define IRQ_MMP2_MIPI_HSI_INT1		(IRQ_MMP2_MIPI_HSI1_BASE + 1)
> +
> +/* secondary interrupt of INT #55 */
> +#define IRQ_MMP2_MIPI_HSI0_BASE		(IRQ_MMP2_MIPI_HSI1_BASE + 2)
> +#define IRQ_MMP2_HSI0_CAWAKE		(IRQ_MMP2_MIPI_HSI0_BASE + 0)
> +#define IRQ_MMP2_MIPI_HSI_INT0		(IRQ_MMP2_MIPI_HSI0_BASE + 1)
>  
> -#define IRQ_MMP2_MUX_END		(IRQ_MMP2_SSP_BASE + 2)
> +#define IRQ_MMP2_MUX_END		(IRQ_MMP2_MIPI_HSI0_BASE + 2)
>  
>  #define IRQ_GPIO_START			128
>  #define MMP_NR_BUILTIN_GPIO		192
> diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
> deleted file mode 100644
> index 7895d27..0000000
> --- a/arch/arm/mach-mmp/irq-mmp2.c
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -/*
> - *  linux/arch/arm/mach-mmp/irq-mmp2.c
> - *
> - *  Generic IRQ handling, GPIO IRQ demultiplexing, etc.
> - *
> - *  Author:	Haojian Zhuang <haojian.zhuang@marvell.com>
> - *  Copyright:	Marvell International Ltd.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 as
> - *  published by the Free Software Foundation.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -
> -#include <mach/irqs.h>
> -#include <mach/regs-icu.h>
> -#include <mach/mmp2.h>
> -
> -#include "common.h"
> -
> -static void icu_mask_irq(struct irq_data *d)
> -{
> -	uint32_t r = __raw_readl(ICU_INT_CONF(d->irq));
> -
> -	r &= ~ICU_INT_ROUTE_PJ4_IRQ;
> -	__raw_writel(r, ICU_INT_CONF(d->irq));
> -}
> -
> -static void icu_unmask_irq(struct irq_data *d)
> -{
> -	uint32_t r = __raw_readl(ICU_INT_CONF(d->irq));
> -
> -	r |= ICU_INT_ROUTE_PJ4_IRQ;
> -	__raw_writel(r, ICU_INT_CONF(d->irq));
> -}
> -
> -static struct irq_chip icu_irq_chip = {
> -	.name		= "icu_irq",
> -	.irq_mask	= icu_mask_irq,
> -	.irq_mask_ack	= icu_mask_irq,
> -	.irq_unmask	= icu_unmask_irq,
> -};
> -
> -static void pmic_irq_ack(struct irq_data *d)
> -{
> -	if (d->irq == IRQ_MMP2_PMIC)
> -		mmp2_clear_pmic_int();
> -}
> -
> -#define SECOND_IRQ_MASK(_name_, irq_base, prefix)			\
> -static void _name_##_mask_irq(struct irq_data *d)			\
> -{									\
> -	uint32_t r;							\
> -	r = __raw_readl(prefix##_MASK) | (1 << (d->irq - irq_base));	\
> -	__raw_writel(r, prefix##_MASK);					\
> -}
> -
> -#define SECOND_IRQ_UNMASK(_name_, irq_base, prefix)			\
> -static void _name_##_unmask_irq(struct irq_data *d)			\
> -{									\
> -	uint32_t r;							\
> -	r = __raw_readl(prefix##_MASK) & ~(1 << (d->irq - irq_base));	\
> -	__raw_writel(r, prefix##_MASK);					\
> -}
> -
> -#define SECOND_IRQ_DEMUX(_name_, irq_base, prefix)			\
> -static void _name_##_irq_demux(unsigned int irq, struct irq_desc *desc)	\
> -{									\
> -	unsigned long status, mask, n;					\
> -	mask = __raw_readl(prefix##_MASK);				\
> -	while (1) {							\
> -		status = __raw_readl(prefix##_STATUS) & ~mask;		\
> -		if (status == 0)					\
> -			break;						\
> -		n = find_first_bit(&status, BITS_PER_LONG);		\
> -		while (n < BITS_PER_LONG) {				\
> -			generic_handle_irq(irq_base + n);		\
> -			n = find_next_bit(&status, BITS_PER_LONG, n+1);	\
> -		}							\
> -	}								\
> -}
> -
> -#define SECOND_IRQ_CHIP(_name_, irq_base, prefix)			\
> -SECOND_IRQ_MASK(_name_, irq_base, prefix)				\
> -SECOND_IRQ_UNMASK(_name_, irq_base, prefix)				\
> -SECOND_IRQ_DEMUX(_name_, irq_base, prefix)				\
> -static struct irq_chip _name_##_irq_chip = {				\
> -	.name		= #_name_,					\
> -	.irq_mask	= _name_##_mask_irq,				\
> -	.irq_unmask	= _name_##_unmask_irq,				\
> -}
> -
> -SECOND_IRQ_CHIP(pmic, IRQ_MMP2_PMIC_BASE, MMP2_ICU_INT4);
> -SECOND_IRQ_CHIP(rtc,  IRQ_MMP2_RTC_BASE,  MMP2_ICU_INT5);
> -SECOND_IRQ_CHIP(twsi, IRQ_MMP2_TWSI_BASE, MMP2_ICU_INT17);
> -SECOND_IRQ_CHIP(misc, IRQ_MMP2_MISC_BASE, MMP2_ICU_INT35);
> -SECOND_IRQ_CHIP(ssp,  IRQ_MMP2_SSP_BASE,  MMP2_ICU_INT51);
> -
> -static void init_mux_irq(struct irq_chip *chip, int start, int num)
> -{
> -	int irq;
> -
> -	for (irq = start; num > 0; irq++, num--) {
> -		struct irq_data *d = irq_get_irq_data(irq);
> -
> -		/* mask and clear the IRQ */
> -		chip->irq_mask(d);
> -		if (chip->irq_ack)
> -			chip->irq_ack(d);
> -
> -		irq_set_chip(irq, chip);
> -		set_irq_flags(irq, IRQF_VALID);
> -		irq_set_handler(irq, handle_level_irq);
> -	}
> -}
> -
> -void __init mmp2_init_icu(void)
> -{
> -	int irq;
> -
> -	for (irq = 0; irq < IRQ_MMP2_MUX_BASE; irq++) {
> -		icu_mask_irq(irq_get_irq_data(irq));
> -		irq_set_chip(irq, &icu_irq_chip);
> -		set_irq_flags(irq, IRQF_VALID);
> -
> -		switch (irq) {
> -		case IRQ_MMP2_PMIC_MUX:
> -		case IRQ_MMP2_RTC_MUX:
> -		case IRQ_MMP2_TWSI_MUX:
> -		case IRQ_MMP2_MISC_MUX:
> -		case IRQ_MMP2_SSP_MUX:
> -			break;
> -		default:
> -			irq_set_handler(irq, handle_level_irq);
> -			break;
> -		}
> -	}
> -
> -	/* NOTE: IRQ_MMP2_PMIC requires the PMIC MFPR register
> -	 * to be written to clear the interrupt
> -	 */
> -	pmic_irq_chip.irq_ack = pmic_irq_ack;
> -
> -	init_mux_irq(&pmic_irq_chip, IRQ_MMP2_PMIC_BASE, 2);
> -	init_mux_irq(&rtc_irq_chip, IRQ_MMP2_RTC_BASE, 2);
> -	init_mux_irq(&twsi_irq_chip, IRQ_MMP2_TWSI_BASE, 5);
> -	init_mux_irq(&misc_irq_chip, IRQ_MMP2_MISC_BASE, 15);
> -	init_mux_irq(&ssp_irq_chip, IRQ_MMP2_SSP_BASE, 2);
> -
> -	irq_set_chained_handler(IRQ_MMP2_PMIC_MUX, pmic_irq_demux);
> -	irq_set_chained_handler(IRQ_MMP2_RTC_MUX, rtc_irq_demux);
> -	irq_set_chained_handler(IRQ_MMP2_TWSI_MUX, twsi_irq_demux);
> -	irq_set_chained_handler(IRQ_MMP2_MISC_MUX, misc_irq_demux);
> -	irq_set_chained_handler(IRQ_MMP2_SSP_MUX, ssp_irq_demux);
> -}
> diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/irq-pxa168.c
> deleted file mode 100644
> index 89706a0..0000000
> --- a/arch/arm/mach-mmp/irq-pxa168.c
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - *  linux/arch/arm/mach-mmp/irq.c
> - *
> - *  Generic IRQ handling, GPIO IRQ demultiplexing, etc.
> - *
> - *  Author:	Bin Yang <bin.yang@marvell.com>
> - *  Created:	Sep 30, 2008
> - *  Copyright:	Marvell International Ltd.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 as
> - *  published by the Free Software Foundation.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -
> -#include <mach/regs-icu.h>
> -
> -#include "common.h"
> -
> -#define IRQ_ROUTE_TO_AP		(ICU_INT_CONF_AP_INT | ICU_INT_CONF_IRQ)
> -
> -#define PRIORITY_DEFAULT	0x1
> -#define PRIORITY_NONE		0x0	/* means IRQ disabled */
> -
> -static void icu_mask_irq(struct irq_data *d)
> -{
> -	__raw_writel(PRIORITY_NONE, ICU_INT_CONF(d->irq));
> -}
> -
> -static void icu_unmask_irq(struct irq_data *d)
> -{
> -	__raw_writel(IRQ_ROUTE_TO_AP | PRIORITY_DEFAULT, ICU_INT_CONF(d->irq));
> -}
> -
> -static struct irq_chip icu_irq_chip = {
> -	.name		= "icu_irq",
> -	.irq_ack	= icu_mask_irq,
> -	.irq_mask	= icu_mask_irq,
> -	.irq_unmask	= icu_unmask_irq,
> -};
> -
> -void __init icu_init_irq(void)
> -{
> -	int irq;
> -
> -	for (irq = 0; irq < 64; irq++) {
> -		icu_mask_irq(irq_get_irq_data(irq));
> -		irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
> -		set_irq_flags(irq, IRQF_VALID);
> -	}
> -}
> diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
> new file mode 100644
> index 0000000..3705470
> --- /dev/null
> +++ b/arch/arm/mach-mmp/irq.c
> @@ -0,0 +1,445 @@
> +/*
> + *  linux/arch/arm/mach-mmp/irq.c
> + *
> + *  Generic IRQ handling, GPIO IRQ demultiplexing, etc.
> + *  Copyright (C) 2008 - 2012 Marvell Technology Group Ltd.
> + *
> + *  Author:	Bin Yang <bin.yang@marvell.com>
> + *              Haojian Zhuang <haojian.zhuang@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#include <mach/irqs.h>
> +
> +#include "common.h"
> +
> +#define MAX_ICU_NR		16
> +
> +struct icu_chip_data {
> +	int			nr_irqs;
> +	unsigned int		virq_base;
> +	unsigned int		cascade_irq;
> +	void __iomem		*reg_status;
> +	void __iomem		*reg_mask;
> +	unsigned int		conf_enable;
> +	unsigned int		conf_disable;
> +	unsigned int		conf_mask;
> +	unsigned int		clr_mfp_irq_base;
> +	unsigned int		clr_mfp_hwirq;
> +	struct irq_domain	*domain;
> +};
> +
> +struct mmp_intc_conf {
> +	unsigned int	conf_enable;
> +	unsigned int	conf_disable;
> +	unsigned int	conf_mask;
> +};
> +
> +void __iomem *mmp_icu_base;
> +static struct icu_chip_data icu_data[MAX_ICU_NR];
> +static int max_icu_nr;
> +
> +extern void mmp2_clear_pmic_int(void);
> +
> +static void icu_mask_ack_irq(struct irq_data *d)
> +{
> +	struct irq_domain *domain = d->domain;
> +	struct icu_chip_data *data = (struct icu_chip_data *)domain->host_data;
> +	int hwirq;
> +	u32 r;
> +
> +	hwirq = d->irq - data->virq_base;
> +	if (data == &icu_data[0]) {
> +		r = readl_relaxed(mmp_icu_base + (hwirq << 2));
> +		r &= ~data->conf_mask;
> +		r |= data->conf_disable;
> +		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
> +	} else {
> +#ifdef CONFIG_CPU_MMP2
> +		if ((data->virq_base == data->clr_mfp_irq_base)
> +			&& (hwirq == data->clr_mfp_hwirq))
> +			mmp2_clear_pmic_int();
> +#endif
> +		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
> +		writel_relaxed(r, data->reg_mask);
> +	}
> +}
> +
> +static void icu_mask_irq(struct irq_data *d)
> +{
> +	struct irq_domain *domain = d->domain;
> +	struct icu_chip_data *data = (struct icu_chip_data *)domain->host_data;
> +	int hwirq;
> +	u32 r;
> +
> +	hwirq = d->irq - data->virq_base;
> +	if (data == &icu_data[0]) {
> +		r = readl_relaxed(mmp_icu_base + (hwirq << 2));
> +		r &= ~data->conf_mask;
> +		r |= data->conf_disable;
> +		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
> +	} else {
> +		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
> +		writel_relaxed(r, data->reg_mask);
> +	}
> +}
> +
> +static void icu_unmask_irq(struct irq_data *d)
> +{
> +	struct irq_domain *domain = d->domain;
> +	struct icu_chip_data *data = (struct icu_chip_data *)domain->host_data;
> +	int hwirq;
> +	u32 r;
> +
> +	hwirq = d->irq - data->virq_base;
> +	if (data == &icu_data[0]) {
> +		r = readl_relaxed(mmp_icu_base + (hwirq << 2));
> +		r &= ~data->conf_mask;
> +		r |= data->conf_enable;
> +		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
> +	} else {
> +		r = readl_relaxed(data->reg_mask) & ~(1 << hwirq);
> +		writel_relaxed(r, data->reg_mask);
> +	}
> +}
> +
> +static struct irq_chip icu_irq_chip = {
> +	.name		= "icu_irq",
> +	.irq_mask	= icu_mask_irq,
> +	.irq_mask_ack	= icu_mask_ack_irq,
> +	.irq_unmask	= icu_unmask_irq,
> +};
> +
> +static void icu_mux_irq_demux(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct irq_domain *domain;
> +	struct icu_chip_data *data;
> +	int i;
> +	unsigned long mask, status, n;
> +
> +	for (i = 1; i < max_icu_nr; i++) {
> +		if (irq == icu_data[i].cascade_irq) {
> +			domain = icu_data[i].domain;
> +			data = (struct icu_chip_data *)domain->host_data;
> +			break;
> +		}
> +	}
> +	if (i >= max_icu_nr) {
> +		pr_err("Spurious irq %d in MMP INTC\n", irq);
> +		return;
> +	}
> +
> +	mask = readl_relaxed(data->reg_mask);
> +	while (1) {
> +		status = readl_relaxed(data->reg_status) & ~mask;
> +		if (status == 0)
> +			break;
> +		n = find_first_bit(&status, BITS_PER_LONG);
> +		while (n < BITS_PER_LONG) {
> +			generic_handle_irq(icu_data[i].virq_base + n);
> +			n = find_next_bit(&status, BITS_PER_LONG, n + 1);
> +		}
> +	}
> +}
> +
> +static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +			      irq_hw_number_t hw)
> +{
> +	irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
> +	set_irq_flags(irq, IRQF_VALID);
> +	return 0;
> +}
> +
> +static int mmp_irq_domain_xlate(struct irq_domain *d, struct device_node *node,
> +				const u32 *intspec, unsigned int intsize,
> +				unsigned long *out_hwirq,
> +				unsigned int *out_type)
> +{
> +	*out_hwirq = intspec[0];
> +	return 0;
> +}
> +
> +const struct irq_domain_ops mmp_irq_domain_ops = {
> +	.map		= mmp_irq_domain_map,
> +	.xlate		= mmp_irq_domain_xlate,
> +};
> +
> +static struct mmp_intc_conf mmp_conf = {
> +	.conf_enable	= 0x51,
> +	.conf_disable	= 0x0,
> +	.conf_mask	= 0x7f,
> +};
> +
> +static struct mmp_intc_conf mmp2_conf = {
> +	.conf_enable	= 0x20,
> +	.conf_disable	= 0x0,
> +	.conf_mask	= 0x7f,
> +};
> +
> +/* MMP (ARMv5) */
> +void __init icu_init_irq(void)
> +{
> +	int irq;
> +
> +	max_icu_nr = 1;
> +	mmp_icu_base = ioremap(0xd4282000, 0x1000);
> +	icu_data[0].conf_enable = mmp_conf.conf_enable;
> +	icu_data[0].conf_disable = mmp_conf.conf_disable;
> +	icu_data[0].conf_mask = mmp_conf.conf_mask;
> +	icu_data[0].nr_irqs = 64;
> +	icu_data[0].virq_base = 0;
> +	icu_data[0].domain = irq_domain_add_legacy(NULL, 64, 0, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[0]);
> +	for (irq = 0; irq < 64; irq++) {
> +		icu_mask_irq(irq_get_irq_data(irq));
> +		irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +	irq_set_default_host(icu_data[0].domain);
> +}
> +
> +/* MMP2 (ARMv7) */
> +void __init mmp2_init_icu(void)
> +{
> +	int irq;
> +
> +	max_icu_nr = 8;
> +	mmp_icu_base = ioremap(0xd4282000, 0x1000);
> +	icu_data[0].conf_enable = mmp2_conf.conf_enable;
> +	icu_data[0].conf_disable = mmp2_conf.conf_disable;
> +	icu_data[0].conf_mask = mmp2_conf.conf_mask;
> +	icu_data[0].nr_irqs = 64;
> +	icu_data[0].virq_base = 0;
> +	icu_data[0].domain = irq_domain_add_legacy(NULL, 64, 0, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[0]);
> +	icu_data[1].reg_status = mmp_icu_base + 0x150;
> +	icu_data[1].reg_mask = mmp_icu_base + 0x168;
> +	icu_data[1].clr_mfp_irq_base = IRQ_MMP2_PMIC_BASE;
> +	icu_data[1].clr_mfp_hwirq = IRQ_MMP2_PMIC - IRQ_MMP2_PMIC_BASE;
> +	icu_data[1].nr_irqs = 2;
> +	icu_data[1].virq_base = IRQ_MMP2_PMIC_BASE;
> +	icu_data[1].domain = irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
> +						   icu_data[1].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[1]);
> +	icu_data[2].reg_status = mmp_icu_base + 0x154;
> +	icu_data[2].reg_mask = mmp_icu_base + 0x16c;
> +	icu_data[2].nr_irqs = 2;
> +	icu_data[2].virq_base = IRQ_MMP2_RTC_BASE;
> +	icu_data[2].domain = irq_domain_add_legacy(NULL, icu_data[2].nr_irqs,
> +						   icu_data[2].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[2]);
> +	icu_data[3].reg_status = mmp_icu_base + 0x180;
> +	icu_data[3].reg_mask = mmp_icu_base + 0x17c;
> +	icu_data[3].nr_irqs = 3;
> +	icu_data[3].virq_base = IRQ_MMP2_KEYPAD_BASE;
> +	icu_data[3].domain = irq_domain_add_legacy(NULL, icu_data[3].nr_irqs,
> +						   icu_data[3].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[3]);
> +	icu_data[4].reg_status = mmp_icu_base + 0x158;
> +	icu_data[4].reg_mask = mmp_icu_base + 0x170;
> +	icu_data[4].nr_irqs = 5;
> +	icu_data[4].virq_base = IRQ_MMP2_TWSI_BASE;
> +	icu_data[4].domain = irq_domain_add_legacy(NULL, icu_data[4].nr_irqs,
> +						   icu_data[4].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[4]);
> +	icu_data[5].reg_status = mmp_icu_base + 0x15c;
> +	icu_data[5].reg_mask = mmp_icu_base + 0x174;
> +	icu_data[5].nr_irqs = 15;
> +	icu_data[5].virq_base = IRQ_MMP2_MISC_BASE;
> +	icu_data[5].domain = irq_domain_add_legacy(NULL, icu_data[5].nr_irqs,
> +						   icu_data[5].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[5]);
> +	icu_data[6].reg_status = mmp_icu_base + 0x160;
> +	icu_data[6].reg_mask = mmp_icu_base + 0x178;
> +	icu_data[6].nr_irqs = 2;
> +	icu_data[6].virq_base = IRQ_MMP2_MIPI_HSI1_BASE;
> +	icu_data[6].domain = irq_domain_add_legacy(NULL, icu_data[6].nr_irqs,
> +						   icu_data[6].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[6]);
> +	icu_data[7].reg_status = mmp_icu_base + 0x188;
> +	icu_data[7].reg_mask = mmp_icu_base + 0x184;
> +	icu_data[7].nr_irqs = 2;
> +	icu_data[7].virq_base = IRQ_MMP2_MIPI_HSI0_BASE;
> +	icu_data[7].domain = irq_domain_add_legacy(NULL, icu_data[7].nr_irqs,
> +						   icu_data[7].virq_base, 0,
> +						   &irq_domain_simple_ops,
> +						   &icu_data[7]);
> +	for (irq = 0; irq < IRQ_MMP2_MUX_END; irq++) {
> +		icu_mask_irq(irq_get_irq_data(irq));
> +		switch (irq) {
> +		case IRQ_MMP2_PMIC_MUX:
> +		case IRQ_MMP2_RTC_MUX:
> +		case IRQ_MMP2_KEYPAD_MUX:
> +		case IRQ_MMP2_TWSI_MUX:
> +		case IRQ_MMP2_MISC_MUX:
> +		case IRQ_MMP2_MIPI_HSI1_MUX:
> +		case IRQ_MMP2_MIPI_HSI0_MUX:
> +			irq_set_chip(irq, &icu_irq_chip);
> +			irq_set_chained_handler(irq, icu_mux_irq_demux);
> +			break;
> +		default:
> +			irq_set_chip_and_handler(irq, &icu_irq_chip,
> +						 handle_level_irq);
> +			break;
> +		}
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +	irq_set_default_host(icu_data[0].domain);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id intc_ids[] __initconst = {
> +	{ .compatible = "mrvl,mmp-intc", .data = &mmp_conf },
> +	{ .compatible = "mrvl,mmp2-intc", .data = &mmp2_conf },
> +	{}
> +};
> +
> +static const struct of_device_id mmp_mux_irq_match[] __initconst = {
> +	{ .compatible = "mrvl,mmp2-mux-intc" },
> +	{}
> +};
> +
> +int __init mmp2_mux_init(struct device_node *parent)
> +{
> +	struct device_node *node;
> +	const struct of_device_id *of_id;
> +	struct resource res;
> +	int i, irq_base, ret, irq;
> +	u32 nr_irqs, mfp_irq;
> +
> +	node = parent;
> +	max_icu_nr = 1;
> +	for (i = 1; i < MAX_ICU_NR; i++) {
> +		node = of_find_matching_node(node, mmp_mux_irq_match);
> +		if (!node)
> +			break;
> +		of_id = of_match_node(&mmp_mux_irq_match[0], node);
> +		ret = of_property_read_u32(node, "mrvl,intc-nr-irqs",
> +					   &nr_irqs);
> +		if (ret) {
> +			pr_err("Not found mrvl,intc-nr-irqs property\n");
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		ret = of_address_to_resource(node, 0, &res);
> +		if (ret < 0) {
> +			pr_err("Not found reg property\n");
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		icu_data[i].reg_status = mmp_icu_base + res.start;
> +		ret = of_address_to_resource(node, 1, &res);
> +		if (ret < 0) {
> +			pr_err("Not found reg property\n");
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		icu_data[i].reg_mask = mmp_icu_base + res.start;
> +		icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
> +		if (!icu_data[i].cascade_irq) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
> +		if (irq_base < 0) {
> +			pr_err("Failed to allocate IRQ numbers for mux intc\n");
> +			ret = irq_base;
> +			goto err;
> +		}
> +		if (!of_property_read_u32(node, "mrvl,clr-mfp-irq",
> +					  &mfp_irq)) {
> +			icu_data[i].clr_mfp_irq_base = irq_base;
> +			icu_data[i].clr_mfp_hwirq = mfp_irq;
> +		}
> +		irq_set_chained_handler(icu_data[i].cascade_irq,
> +					icu_mux_irq_demux);
> +		icu_data[i].nr_irqs = nr_irqs;
> +		icu_data[i].virq_base = irq_base;
> +		icu_data[i].domain = irq_domain_add_legacy(node, nr_irqs,
> +							   irq_base, 0,
> +							   &mmp_irq_domain_ops,
> +							   &icu_data[i]);
> +		for (irq = irq_base; irq < irq_base + nr_irqs; irq++)
> +			icu_mask_irq(irq_get_irq_data(irq));
> +	}
> +	max_icu_nr = i;
> +	return 0;
> +err:
> +	of_node_put(node);
> +	max_icu_nr = i;
> +	return ret;
> +}
> +
> +void __init mmp_dt_irq_init(void)
> +{
> +	struct device_node *node;
> +	const struct of_device_id *of_id;
> +	struct mmp_intc_conf *conf;
> +	int nr_irqs, irq_base, ret, irq;
> +
> +	node = of_find_matching_node(NULL, intc_ids);
> +	if (!node) {
> +		pr_err("Failed to find interrupt controller in arch-mmp\n");
> +		return;
> +	}
> +	of_id = of_match_node(intc_ids, node);
> +	conf = of_id->data;
> +
> +	ret = of_property_read_u32(node, "mrvl,intc-nr-irqs", &nr_irqs);
> +	if (ret) {
> +		pr_err("Not found mrvl,intc-nr-irqs property\n");
> +		return;
> +	}
> +
> +	mmp_icu_base = of_iomap(node, 0);
> +	if (!mmp_icu_base) {
> +		pr_err("Failed to get interrupt controller register\n");
> +		return;
> +	}
> +
> +	irq_base = irq_alloc_descs(-1, 0, nr_irqs - NR_IRQS_LEGACY, 0);
> +	if (irq_base < 0) {
> +		pr_err("Failed to allocate IRQ numbers\n");
> +		goto err;
> +	} else if (irq_base != NR_IRQS_LEGACY) {
> +		pr_err("ICU's irqbase should be started from 0\n");
> +		goto err;
> +	}
> +	icu_data[0].conf_enable = conf->conf_enable;
> +	icu_data[0].conf_disable = conf->conf_disable;
> +	icu_data[0].conf_mask = conf->conf_mask;
> +	icu_data[0].nr_irqs = nr_irqs;
> +	icu_data[0].virq_base = 0;
> +	icu_data[0].domain = irq_domain_add_legacy(node, nr_irqs, 0, 0,
> +						   &mmp_irq_domain_ops,
> +						   &icu_data[0]);
> +	irq_set_default_host(icu_data[0].domain);
> +	for (irq = 0; irq < nr_irqs; irq++)
> +		icu_mask_irq(irq_get_irq_data(irq));
> +	mmp2_mux_init(node);
> +	return;
> +err:
> +	iounmap(mmp_icu_base);
> +}
> +#endif
> -- 
> 1.7.5.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
