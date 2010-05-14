From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 14 May 2010 06:48:02 +0100
Subject: [PATCH v3 2/2] ARM: S5PV210: Add Ext interrupt support
In-Reply-To: <008601caf326$a1ba5310$e52ef930$%szyprowski@samsung.com>
References: <1273749209-32461-1-git-send-email-kgene.kim@samsung.com>
	<008601caf326$a1ba5310$e52ef930$%szyprowski@samsung.com>
Message-ID: <20100514054802.GB27571@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 07:30:53AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On Thursday, May 13, 2010 1:13 PM Kukjin Kim wrote:
> 
> > From: Jongpill Lee <boyko.lee@samsung.com>
> > 
> > Add support for external interrupts on v210.
> > 
> > Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> > Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-s5pv210/Kconfig                  |    1 +
> >  arch/arm/mach-s5pv210/include/mach/irqs.h      |    5 +
> >  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   84 +++++++++
> >  arch/arm/plat-s5p/Kconfig                      |    5 +
> >  arch/arm/plat-s5p/Makefile                     |    1 +
> >  arch/arm/plat-s5p/irq-eint.c                   |  230
> > ++++++++++++++++++++++++
> >  6 files changed, 326 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> >  create mode 100644 arch/arm/plat-s5p/irq-eint.c
> > 
> > diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> > index af33a1a..c4c2a7f 100644
> > --- a/arch/arm/mach-s5pv210/Kconfig
> > +++ b/arch/arm/mach-s5pv210/Kconfig
> > @@ -12,6 +12,7 @@ if ARCH_S5PV210
> >  config CPU_S5PV210
> >  	bool
> >  	select PLAT_S5P
> > +	select S5P_EXT_INT
> >  	help
> >  	  Enable S5PV210 CPU support
> > 
> > diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
> > s5pv210/include/mach/irqs.h
> > index 62c5175..1714be2 100644
> > --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> > +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> > @@ -139,6 +139,11 @@
> >  #define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
> >  #define IRQ_EINT(x)		S5P_EINT(x)
> > 
> > +#define S5P_EINT_SET0(x)	S5PV210_GPH0(x)
> > +#define S5P_EINT_SET1(x)	S5PV210_GPH1(x)
> > +#define S5P_EINT_SET2(x)	S5PV210_GPH2(x)
> > +#define S5P_EINT_SET3(x)	S5PV210_GPH3(x)
> > +
> >  /* Set the default NR_IRQS */
> > 
> >  #define NR_IRQS 		(IRQ_EINT(31) + 1)
> > diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> > b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> > new file mode 100644
> > index 0000000..86fb6a4
> > --- /dev/null
> > +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> > @@ -0,0 +1,84 @@
> > +/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> > + *
> > + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com/
> > + *
> > + * S5PV210 - GPIO (including EINT) register definitions
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#ifndef __ASM_ARCH_REGS_GPIO_H
> > +#define __ASM_ARCH_REGS_GPIO_H __FILE__
> > +
> > +#include <mach/map.h>
> > +
> > +#define S5PV210_EINT30CON		(S5P_VA_GPIO + 0xE00)
> > +#define S5PV210_EINT31CON		(S5P_VA_GPIO + 0xE04)
> > +#define S5PV210_EINT32CON		(S5P_VA_GPIO + 0xE08)
> > +#define S5PV210_EINT33CON		(S5P_VA_GPIO + 0xE0C)
> > +
> > +#define S5P_EINT_CON(x)			(S5PV210_EINT30CON + ((x) *
> 0x4))
> > +
> > +#define S5PV210_EINT30FLTCON0		(S5P_VA_GPIO + 0xE80)
> > +#define S5PV210_EINT30FLTCON1		(S5P_VA_GPIO + 0xE84)
> > +#define S5PV210_EINT31FLTCON0		(S5P_VA_GPIO + 0xE88)
> > +#define S5PV210_EINT31FLTCON1		(S5P_VA_GPIO + 0xE8C)
> > +#define S5PV210_EINT32FLTCON0		(S5P_VA_GPIO + 0xE90)
> > +#define S5PV210_EINT32FLTCON1		(S5P_VA_GPIO + 0xE94)
> > +#define S5PV210_EINT33FLTCON0		(S5P_VA_GPIO + 0xE98)
> > +#define S5PV210_EINT33FLTCON1		(S5P_VA_GPIO + 0xE9C)
> > +
> > +#define S5P_EINT_FLTCON(x)		(S5PV210_EINT30FLTCON0 + ((x) * 0x4))
> > +
> > +#define S5PV210_EINT30MASK		(S5P_VA_GPIO + 0xF00)
> > +#define S5PV210_EINT31MASK		(S5P_VA_GPIO + 0xF04)
> > +#define S5PV210_EINT32MASK		(S5P_VA_GPIO + 0xF08)
> > +#define S5PV210_EINT33MASK		(S5P_VA_GPIO + 0xF0C)
> > +
> > +#define S5P_EINT_MASK(x)		(S5PV210_EINT30MASK + ((x) * 0x4))
> > +
> > +#define S5PV210_EINT30PEND		(S5P_VA_GPIO + 0xF40)
> > +#define S5PV210_EINT31PEND		(S5P_VA_GPIO + 0xF44)
> > +#define S5PV210_EINT32PEND		(S5P_VA_GPIO + 0xF48)
> > +#define S5PV210_EINT33PEND		(S5P_VA_GPIO + 0xF4C)
> > +
> > +#define S5P_EINT_PEND(x)		(S5PV210_EINT30PEND + ((x) * 0x4))
> > +
> > +#define eint_offset(irq)	((irq) < IRQ_EINT16_31 ? ((irq)-IRQ_EINT0) \
> > +						: (irq-S5P_IRQ_EINT_BASE))
> > +
> > +#define eint_irq_to_bit(irq)		(1 << (eint_offset(irq) & 0x7))
> > +
> > +#define eint_conf_reg(irq)		((eint_offset(irq)) >> 3)
> > +#define eint_filt_reg(irq)		((eint_offset(irq)) >> 2)
> > +#define eint_mask_reg(irq)		((eint_offset(irq)) >> 3)
> > +#define eint_pend_reg(irq)		((eint_offset(irq)) >> 3)
> > +
> > +#define S5P_EINT30CON			S5PV210_EINT30CON
> > +#define S5P_EINT31CON			S5PV210_EINT31CON
> > +#define S5P_EINT32CON			S5PV210_EINT32CON
> > +#define S5P_EINT33CON			S5PV210_EINT33CON
> > +#define S5P_EINT30FLTCON0		S5PV210_EINT30FLTCON0
> > +#define S5P_EINT30FLTCON1		S5PV210_EINT30FLTCON1
> > +#define S5P_EINT31FLTCON0		S5PV210_EINT31FLTCON0
> > +#define S5P_EINT31FLTCON1		S5PV210_EINT31FLTCON1
> > +#define S5P_EINT32FLTCON0		S5PV210_EINT32FLTCON0
> > +#define S5P_EINT32FLTCON1		S5PV210_EINT32FLTCON1
> > +#define S5P_EINT33FLTCON0		S5PV210_EINT33FLTCON0
> > +#define S5P_EINT33FLTCON1		S5PV210_EINT33FLTCON1
> > +#define S5P_EINT30MASK			S5PV210_EINT30MASK
> > +#define S5P_EINT31MASK			S5PV210_EINT31MASK
> > +#define S5P_EINT32MASK			S5PV210_EINT32MASK
> > +#define S5P_EINT33MASK			S5PV210_EINT33MASK
> > +
> > +/* values for S5P_EXTINT0 */
> > +#define S5P_EXTINT_LOWLEV		(0x00)
> > +#define S5P_EXTINT_HILEV		(0x01)
> > +#define S5P_EXTINT_FALLEDGE		(0x02)
> > +#define S5P_EXTINT_RISEEDGE		(0x03)
> > +#define S5P_EXTINT_BOTHEDGE		(0x04)
> > +
> > +#endif /* __ASM_ARCH_REGS_GPIO_H */
> > diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> > index d400a6a..7d1fc40 100644
> > --- a/arch/arm/plat-s5p/Kconfig
> > +++ b/arch/arm/plat-s5p/Kconfig
> > @@ -23,3 +23,8 @@ config PLAT_S5P
> >  	select SAMSUNG_IRQ_UART
> >  	help
> >  	  Base platform code for Samsung's S5P series SoC.
> > +
> > +config S5P_EXT_INT
> > +	bool
> > +	help
> > +	  Use the external interrupts (other than GPIO interrupts.)
> > diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> > index a7c54b3..25941a5 100644
> > --- a/arch/arm/plat-s5p/Makefile
> > +++ b/arch/arm/plat-s5p/Makefile
> > @@ -16,4 +16,5 @@ obj-y				+= dev-uart.o
> >  obj-y				+= cpu.o
> >  obj-y				+= clock.o
> >  obj-y				+= irq.o
> > +obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
> >  obj-y				+= setup-i2c0.o
> > diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> > new file mode 100644
> > index 0000000..84f1016
> > --- /dev/null
> > +++ b/arch/arm/plat-s5p/irq-eint.c
> > @@ -0,0 +1,230 @@
> > +/* linux/arch/arm/plat-s5p/irq-eint.c
> > + *
> > + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com/
> > + *
> > + * S5P - IRQ EINT support
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/io.h>
> > +#include <linux/sysdev.h>
> > +#include <linux/gpio.h>
> > +
> > +#include <asm/bitops.h>
> > +#include <asm/hardware/vic.h>
> > +
> > +#include <plat/regs-irqtype.h>
> > +
> > +#include <mach/map.h>
> > +#include <plat/cpu.h>
> > +#include <plat/pm.h>
> > +
> > +#include <plat/gpio-cfg.h>
> > +#include <mach/regs-gpio.h>
> > +
> > +static inline void s5p_irq_eint_mask(unsigned int irq)
> > +{
> > +	u32 mask;
> > +
> > +	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> > +	mask |= eint_irq_to_bit(irq);
> > +	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> > +}
> > +
> > +static void s5p_irq_eint_unmask(unsigned int irq)
> > +{
> > +	u32 mask;
> > +
> > +	mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> > +	mask &= ~(eint_irq_to_bit(irq));
> > +	__raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> > +}
> > +
> > +static inline void s5p_irq_eint_ack(unsigned int irq)
> > +{
> > +	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> > +}
> > +
> > +static void s5p_irq_eint_maskack(unsigned int irq)
> > +{
> > +	/* compiler should in-line these */
> > +	s5p_irq_eint_mask(irq);
> > +	s5p_irq_eint_ack(irq);
> > +}
> > +
> > +static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
> > +{
> > +	int offs = eint_offset(irq);
> > +	int shift;
> > +	u32 ctrl, mask;
> > +	u32 newvalue = 0;
> > +
> > +	switch (type) {
> > +	case IRQ_TYPE_NONE:
> > +		printk(KERN_WARNING "No edge setting!\n");
> > +		break;
> > +
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		newvalue = S5P_EXTINT_RISEEDGE;
> > +		break;
> > +
> > +	case IRQ_TYPE_EDGE_FALLING:
> > +		newvalue = S5P_EXTINT_RISEEDGE;
> > +		break;
> > +
> > +	case IRQ_TYPE_EDGE_BOTH:
> > +		newvalue = S5P_EXTINT_BOTHEDGE;
> > +		break;
> > +
> > +	case IRQ_TYPE_LEVEL_LOW:
> > +		newvalue = S5P_EXTINT_LOWLEV;
> > +		break;
> > +
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		newvalue = S5P_EXTINT_HILEV;
> > +		break;
> > +
> > +	default:
> > +		printk(KERN_ERR "No such irq type %d", type);
> > +		return -1;
> > +	}
> > +
> > +	shift = (offs & 0x7) * 4;
> > +	mask = 0x7 << shift;
> > +
> > +	ctrl = __raw_readl(S5P_EINT_CON(eint_conf_reg(irq)));
> > +	ctrl &= ~mask;
> > +	ctrl |= newvalue << shift;
> > +	__raw_writel(ctrl, S5P_EINT_CON(eint_conf_reg(irq)));
> > +
> > +	if ((0 <= offs) && (offs < 8))
> > +		s3c_gpio_cfgpin(S5P_EINT_SET0(offs&0x7), 0xf<<((offs&0x7)*4));
> > +
> > +	else if ((8 <= offs) && (offs < 16))
> > +		s3c_gpio_cfgpin(S5P_EINT_SET1(offs&0x7), 0xf<<((offs&0x7)*4));
> > +
> > +	else if ((16 <= offs) && (offs < 24))
> > +		s3c_gpio_cfgpin(S5P_EINT_SET2(offs&0x7), 0xf<<((offs&0x7)*4));
> > +
> > +	else if ((24 <= offs) && (offs < 32))
> > +		s3c_gpio_cfgpin(S5P_EINT_SET3(offs&0x7), 0xf<<((offs&0x7)*4));
> > +
> > +	else
> > +		printk(KERN_ERR "No such irq number %d", offs);
> > +
> 
> This code will be reused for other s5p SoCs - at least s5pc100 should also
> use the common external interrupt code.
> 
> IMHO it would be better to use some common s5p defines to hide these magic
> numbers. What about the similar code from my "[PATCH 14/16] ARM: Samsung:
> Move external interrupts support from plat-s5pc1xx to plat-s5p" patch?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012618.html
> 
> I will be something like this:
> 
>         switch (offs) {
>         case 0 ... 7:
>                         gpio = S5P_GPH0(gpio);
>                 break;
>         case 8 ... 15:
>                         gpio = S5P_GPH1(gpio);
>                 break;
>         case 16 ... 23:
>                         gpio = S5P_GPH2(gpio);
>                 break;
>         case 24 ... 31:
>                         gpio = S5P_GPH3(gpio);
>                 break;
>         default:
>                 return -EINVAL;
>         }
> 
>         sfn = S3C_GPIO_SFN_EINT;
>         s3c_gpio_cfgpin(gpio, sfn);
> 
> Please note that the gpio special function value for EINT is different
> on s5pc100 and s5pv210 (0x2 vs. 0xf), so hiding this behind a define is
> much more convenient.

or even better, use the gpio chip to lookup the configuration structure
which provides the configuration setting, so we could do

      struct s3c_gpio_chip *chip = s3c_gpio_getchip(gpio);
      struct s3c_gpio_cfg *cfg = chip->cfg;

      s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(cfg->cfg_eint));

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
