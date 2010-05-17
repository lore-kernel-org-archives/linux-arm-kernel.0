From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 05:48:11 +0100
Subject: [PATCH v5] ARM: S5PV210: Add Ext interrupt support.
In-Reply-To: <AANLkTilijYxXm-vXTG3iL11Z_INXAebGQdh02EdmOboE@mail.gmail.com>
References: <1274059016-24700-1-git-send-email-kgene.kim@samsung.com>
	<20100517022209.GS26401@trinity.fluff.org>
	<AANLkTilijYxXm-vXTG3iL11Z_INXAebGQdh02EdmOboE@mail.gmail.com>
Message-ID: <20100517044811.GT26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 12:21:25PM +0900, Kyungmin Park wrote:
> On Mon, May 17, 2010 at 11:22 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Mon, May 17, 2010 at 10:16:56AM +0900, Kukjin Kim wrote:
> >> From: Jongpill Lee <boyko.lee@samsung.com>
> >>
> >> Add support for external interrupts on v210.
> >>
> >> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> >> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> ---
> >> ?arch/arm/mach-s5pv210/Kconfig ? ? ? ? ? ? ? ? ?| ? ?1 +
> >> ?arch/arm/mach-s5pv210/include/mach/irqs.h ? ? ?| ? 31 ++--
> >> ?arch/arm/mach-s5pv210/include/mach/regs-gpio.h | ? 46 +++++
> >> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? ?5 +
> >> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> >> ?arch/arm/plat-s5p/irq-eint.c ? ? ? ? ? ? ? ? ? | ?216 ++++++++++++++++++++++++
> >> ?6 files changed, 282 insertions(+), 18 deletions(-)
> >> ?create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> >> ?create mode 100644 arch/arm/plat-s5p/irq-eint.c
> >>
> >> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> >> index af33a1a..c4c2a7f 100644
> >> --- a/arch/arm/mach-s5pv210/Kconfig
> >> +++ b/arch/arm/mach-s5pv210/Kconfig
> >> @@ -12,6 +12,7 @@ if ARCH_S5PV210
> >> ?config CPU_S5PV210
> >> ? ? ? bool
> >> ? ? ? select PLAT_S5P
> >> + ? ? select S5P_EXT_INT
> >> ? ? ? help
> >> ? ? ? ? Enable S5PV210 CPU support
> >>
> >> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
> >> index 62c5175..42b9b28 100644
> >> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> >> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> >> @@ -17,22 +17,9 @@
> >>
> >> ?/* VIC0: System, DMA, Timer */
> >>
> >> -#define IRQ_EINT0 ? ? ? ? ? ?S5P_IRQ_VIC0(0)
> >> -#define IRQ_EINT1 ? ? ? ? ? ?S5P_IRQ_VIC0(1)
> >> -#define IRQ_EINT2 ? ? ? ? ? ?S5P_IRQ_VIC0(2)
> >> -#define IRQ_EINT3 ? ? ? ? ? ?S5P_IRQ_VIC0(3)
> >> -#define IRQ_EINT4 ? ? ? ? ? ?S5P_IRQ_VIC0(4)
> >> -#define IRQ_EINT5 ? ? ? ? ? ?S5P_IRQ_VIC0(5)
> >> -#define IRQ_EINT6 ? ? ? ? ? ?S5P_IRQ_VIC0(6)
> >> -#define IRQ_EINT7 ? ? ? ? ? ?S5P_IRQ_VIC0(7)
> >> -#define IRQ_EINT8 ? ? ? ? ? ?S5P_IRQ_VIC0(8)
> >> -#define IRQ_EINT9 ? ? ? ? ? ?S5P_IRQ_VIC0(9)
> >> -#define IRQ_EINT10 ? ? ? ? ? S5P_IRQ_VIC0(10)
> >> -#define IRQ_EINT11 ? ? ? ? ? S5P_IRQ_VIC0(11)
> >> -#define IRQ_EINT12 ? ? ? ? ? S5P_IRQ_VIC0(12)
> >> -#define IRQ_EINT13 ? ? ? ? ? S5P_IRQ_VIC0(13)
> >> -#define IRQ_EINT14 ? ? ? ? ? S5P_IRQ_VIC0(14)
> >> -#define IRQ_EINT15 ? ? ? ? ? S5P_IRQ_VIC0(15)
> >> +/* Can be used for EINTs 0 to 15 */
> >> +#define IRQ_EINT(x) ? ? ? ? ?((x) + S5P_IRQ_VIC0(0))
> >> +
> 
> It should be consider the higher interrupt number. As your comment
> user should use the
> IRQ_EINT(16) or IRQ_EINT(22). So IRQ_EINT should handle if EINT is
> grater than 15
> "This function demuxes the IRQ from the group0 external interrupts,
>  from IRQ_EINT(16) to IRQ_EINT(31). It is designed to be inlined into
>  * the specific handlers s5p_irq_demux_eintX_Y."
> 
> #define IRQ_EINT(x)             ((x) < 16 ? S5P_IRQ_VIC0(x) : \
>                                         (S5P_IRQ_EINT_BASE + (x)-16))

I think that this is the best way to go, and have EINT(x) deal with all
cases of 'x'. 

> Thank you,
> Kyungmin Park
> 
> >> ?#define IRQ_EINT16_31 ? ? ? ? ? ? ? ?S5P_IRQ_VIC0(16)
> >> ?#define IRQ_BATF ? ? ? ? ? ? S5P_IRQ_VIC0(17)
> >> ?#define IRQ_MDMA ? ? ? ? ? ? S5P_IRQ_VIC0(18)
> >> @@ -137,10 +124,18 @@
> >> ?#define S5P_IRQ_EINT_BASE ? ?(IRQ_VIC_END + 1)
> >>
> >> ?#define S5P_EINT(x) ? ? ? ? ?((x) + S5P_IRQ_EINT_BASE)
> >> -#define IRQ_EINT(x) ? ? ? ? ?S5P_EINT(x)
> >> +/* Can be used for EINTs 16 to 31 */
> >> +#define IRQ_EINT_GRP(x) ? ? ? ? ? ? ?S5P_EINT(x)
> >> +
> >> +#define EINT_MODE ? ? ? ? ? ?S3C_GPIO_SFN(0xf)
> >>
> >> ?/* Set the default NR_IRQS */
> >>
> >> -#define NR_IRQS ? ? ? ? ? ? ?(IRQ_EINT(31) + 1)
> >> +#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ?(IRQ_EINT_GRP(31) + 1)
> >> +
> >> +#define EINT_GPIO_REG0(x) ? ?S5PV210_GPH0(x)
> >> +#define EINT_GPIO_REG1(x) ? ?S5PV210_GPH1(x)
> >> +#define EINT_GPIO_REG2(x) ? ?S5PV210_GPH2(x)
> >> +#define EINT_GPIO_REG3(x) ? ?S5PV210_GPH3(x)

i think _REG shoiuld be removed from here, it isn't a register as such.

> >> ?#endif /* ASM_ARCH_IRQS_H */
> >> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> >> new file mode 100644
> >> index 0000000..fe16292
> >> --- /dev/null
> >> +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> >> @@ -0,0 +1,46 @@
> >> +/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * S5PV210 - GPIO (including EINT) register definitions
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +#ifndef __ASM_ARCH_REGS_GPIO_H
> >> +#define __ASM_ARCH_REGS_GPIO_H __FILE__
> >> +
> >> +#include <mach/map.h>
> >> +
> >> +#define S5PV210_EINT30CON ? ? ? ? ? ?(S5P_VA_GPIO + 0xE00)
> >> +#define S5P_EINT_CON(x) ? ? ? ? ? ? ? ? ? ? ?(S5PV210_EINT30CON + ((x) * 0x4))
> >> +
> >> +#define S5PV210_EINT30FLTCON0 ? ? ? ? ? ? ? ?(S5P_VA_GPIO + 0xE80)
> >> +#define S5P_EINT_FLTCON(x) ? ? ? ? ? (S5PV210_EINT30FLTCON0 + ((x) * 0x4))
> >> +
> >> +#define S5PV210_EINT30MASK ? ? ? ? ? (S5P_VA_GPIO + 0xF00)
> >> +#define S5P_EINT_MASK(x) ? ? ? ? ? ? (S5PV210_EINT30MASK + ((x) * 0x4))
> >> +
> >> +#define S5PV210_EINT30PEND ? ? ? ? ? (S5P_VA_GPIO + 0xF40)
> >> +#define S5P_EINT_PEND(x) ? ? ? ? ? ? (S5PV210_EINT30PEND + ((x) * 0x4))
> >> +
> >> +#define eint_offset(irq) ? ? ((irq) < IRQ_EINT16_31 ? ((irq) - IRQ_EINT(0)) \
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? : ((irq) - S5P_IRQ_EINT_BASE))
> >> +
> >
> > should we sepreate out the EINT 0..15 cases to make the higher EINT
> > code easier to process?
