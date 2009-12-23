From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Dec 2009 14:22:48 +0900
Subject: [PATCH 3/7] ARM: S5P6440: Add IRQ support
In-Reply-To: <20091218145347.4ad08b97@life-in-the-fast-lane>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-3-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-4-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-5-git-send-email-kgene.kim@samsung.com>
	<20091218145347.4ad08b97@life-in-the-fast-lane>
Message-ID: <000201ca838f$f7d25880$e7770980$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc Zyngier,

Thanks for your review.

Marc Zyngier wrote:
> On Fri, 18 Dec 2009 18:19:56 +0900
> Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> > This patch adds IRQ support for S5P6440 CPU.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
> > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> > ---
> >  arch/arm/mach-s5p6440/include/mach/irqs.h     |  111 +++++++++++
> >  arch/arm/mach-s5p6440/include/mach/regs-irq.h |   23 +++
> >  arch/arm/plat-s5p/include/plat/irqs.h         |   80 ++++++++
> >  arch/arm/plat-s5p/irq.c                       |  251
> +++++++++++++++++++++++++
> >  4 files changed, 465 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-s5p6440/include/mach/irqs.h
> >  create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-irq.h
> >  create mode 100644 arch/arm/plat-s5p/include/plat/irqs.h
> >  create mode 100644 arch/arm/plat-s5p/irq.c
> >
> > diff --git a/arch/arm/mach-s5p6440/include/mach/irqs.h b/arch/arm/mach-
> s5p6440/include/mach/irqs.h
> > new file mode 100644
> > index 0000000..dd1b50b
> > --- /dev/null
> > +++ b/arch/arm/mach-s5p6440/include/mach/irqs.h
> > @@ -0,0 +1,111 @@
> > +/* linux/arch/arm/mach-s5p6440/include/mach/irqs.h
> > + *
> > + * Copyright 2009 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com/
> > + *
> > + * S5P6440 - IRQ definitions
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#ifndef __ASM_ARCH_S5P_IRQS_H
> > +#define __ASM_ARCH_S5P_IRQS_H __FILE__
> > +
> > +#include <plat/irqs.h>
> > +
> > +/* VIC0 */
> > +
> > +#define IRQ_EINT0_3		S5P_IRQ_VIC0(0)
> > +#define IRQ_EINT4_11		S5P_IRQ_VIC0(1)
> > +#define IRQ_RTC_TIC		S5P_IRQ_VIC0(2)
> > +#define IRQ_IIC1		S5P_IRQ_VIC0(5)
> > +#define IRQ_I2SV40		S5P_IRQ_VIC0(6)
> > +#define IRQ_GPS			S5P_IRQ_VIC0(7)
> > +#define IRQ_POST0		S5P_IRQ_VIC0(9)
> > +#define IRQ_2D			S5P_IRQ_VIC0(11)
> > +#define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(23)
> > +#define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(24)
> > +#define IRQ_TIMER2_VIC		S5P_IRQ_VIC0(25)
> > +#define IRQ_WDT			S5P_IRQ_VIC0(26)
> > +#define IRQ_TIMER3_VIC		S5P_IRQ_VIC0(27)
> > +#define IRQ_TIMER4_VIC		S5P_IRQ_VIC0(28)
> > +#define IRQ_DISPCON0		S5P_IRQ_VIC0(29)
> > +#define IRQ_DISPCON1		S5P_IRQ_VIC0(30)
> > +#define IRQ_DISPCON2		S5P_IRQ_VIC0(31)
> > +
> > +/* VIC1 */
> > +
> > +#define IRQ_EINT12_15		S5P_IRQ_VIC1(0)
> > +#define IRQ_PCM0		S5P_IRQ_VIC1(2)
> > +#define IRQ_UART0		S5P_IRQ_VIC1(5)
> > +#define IRQ_UART1		S5P_IRQ_VIC1(6)
> > +#define IRQ_UART2		S5P_IRQ_VIC1(7)
> > +#define IRQ_UART3		S5P_IRQ_VIC1(8)
> > +#define IRQ_DMA0		S5P_IRQ_VIC1(9)
> > +#define IRQ_NFC			S5P_IRQ_VIC1(13)
> > +#define IRQ_SPI0		S5P_IRQ_VIC1(16)
> > +#define IRQ_SPI1		S5P_IRQ_VIC1(17)
> > +#define IRQ_IIC			S5P_IRQ_VIC1(18)
> > +#define IRQ_DISPCON3		S5P_IRQ_VIC1(19)
> > +#define IRQ_FIMGVG		S5P_IRQ_VIC1(20)
> > +#define IRQ_EINTG1_G9		S5P_IRQ_VIC1(21)
> 
> The name of this entry is badly chosen, as 6440 only has groups 1, 2,
> 5, 6, and 8. What about IRQ_EINT_GROUPS? Or anything that would
> represent the actual function...
Yeah, your suggestion is some reason. Let me check about that. Thanks.


> > +#define IRQ_PMUIRQ		S5P_IRQ_VIC1(23)
> > +#define IRQ_HSMMC0		S5P_IRQ_VIC1(24)
> > +#define IRQ_HSMMC1		S5P_IRQ_VIC1(25)
> > +#define IRQ_HSMMC2		IRQ_SPI1	/* shared with SPI1 */
> > +#define IRQ_OTG			S5P_IRQ_VIC1(26)
> > +#define IRQ_DSI			S5P_IRQ_VIC1(27)
> > +#define IRQ_RTC_ALARM		S5P_IRQ_VIC1(28)
> > +#define IRQ_TSI			S5P_IRQ_VIC1(29)
> > +#define IRQ_PENDN		S5P_IRQ_VIC1(30)
> > +#define IRQ_TC			IRQ_PENDN
> > +#define IRQ_ADC			S5P_IRQ_VIC1(31)
> > +
> > +/*
> > + * Since the IRQ_EINT(x) are a linear mapping on s5p6440 we just defined
> > + * them as an IRQ_EINT(x) macro from S5P_IRQ_EINT_BASE which we place
> > + * after the pair of VICs.
> > + */
> > +
> > +#define S5P_IRQ_EINT_BASE	(S5P_IRQ_VIC1(31) + 6)
> > +
> > +#define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
> > +#define IRQ_EINT(x)		S5P_EINT(x)
> > +
> > +/*
> > + * Next the external interrupt groups. These are similar to the
IRQ_EINT(x)
> > + * that they are sourced from the GPIO pins but with a different scheme
for
> > + * priority and source indication.
> > + *
> > + * The IRQ_EINT(x) can be thought of as 'group 0' of the available GPIO
> > + * interrupts, but for historical reasons they are kept apart from these
> > + * next interrupts.
> > + *
> > + * Use IRQ_EINT_GROUP(group, offset) to get the number for use in the
> > + * machine specific support files.
> > + */
> > +
> > +/* Actually, #6 and #7 are missing in the EINT_GROUP1 */
> > +#define IRQ_EINT_GROUP1_NR	(15)
> > +#define IRQ_EINT_GROUP2_NR	(8)
> > +#define IRQ_EINT_GROUP5_NR	(7)
> > +#define IRQ_EINT_GROUP6_NR	(10)
> > +/* Actually, #0, #1 and #2 are missing in the EINT_GROUP8 */
> > +#define IRQ_EINT_GROUP8_NR	(11)
> 
> Group 8 has interrupts numbered from 3 to 11, so this should read 12.
According to the UM's '5.10 PORT P Control Registers', it has 11 interrupts
numbered from 3 to 10. So I think it's right.


> > +
> > +#define IRQ_EINT_GROUP_BASE	S5P_EINT(16)
> > +#define IRQ_EINT_GROUP1_BASE	(IRQ_EINT_GROUP_BASE + 0)
> > +#define IRQ_EINT_GROUP2_BASE	(IRQ_EINT_GROUP1_BASE +
> IRQ_EINT_GROUP1_NR)
> > +#define IRQ_EINT_GROUP5_BASE	(IRQ_EINT_GROUP2_BASE +
> IRQ_EINT_GROUP2_NR)
> > +#define IRQ_EINT_GROUP6_BASE	(IRQ_EINT_GROUP5_BASE +
> IRQ_EINT_GROUP5_NR)
> > +#define IRQ_EINT_GROUP8_BASE	(IRQ_EINT_GROUP6_BASE +
> IRQ_EINT_GROUP6_NR)
> > +
> > +#define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##__BASE +
> (x))
>                                                              ^^^^^
> One _ too many.
Oh, you're right. I'm sorry for my mistake. Only one under bar is right, not
two. I'll change it.


> > +
> > +/* Set the default NR_IRQS */
> > +
> > +#define NR_IRQS			(IRQ_EINT_GROUP8_BASE +
> IRQ_EINT_GROUP8_NR + 1)
> > +
> > +#endif /* __ASM_ARCH_S5P_IRQS_H */

(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
