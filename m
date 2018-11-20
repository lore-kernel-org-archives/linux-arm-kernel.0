From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Nov 2018 08:16:57 +0000
Subject: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
In-Reply-To: <20181120050650.GC5885@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
 <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com>
 <20181120050650.GC5885@Mani-XPS-13-9360>
Message-ID: <86pnv0rwna.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Nov 2018 05:06:50 +0000,
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> Hi Marc,
> 
> On Mon, Nov 19, 2018 at 05:57:12PM +0000, Marc Zyngier wrote:
> > On 19/11/2018 17:09, Manivannan Sadhasivam wrote:
> > > Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> > > and HWTIMER.
> > > 
> > > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  arch/arm/mach-rda/Kconfig       |   1 +
> > >  drivers/clocksource/Kconfig     |   7 ++
> > >  drivers/clocksource/Makefile    |   1 +
> > >  drivers/clocksource/timer-rda.c | 187 ++++++++++++++++++++++++++++++++
> > >  4 files changed, 196 insertions(+)
> > >  create mode 100644 drivers/clocksource/timer-rda.c
> > > 
> > > diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> > > index 29012bc68ca4..1ea753f57b2d 100644
> > > --- a/arch/arm/mach-rda/Kconfig
> > > +++ b/arch/arm/mach-rda/Kconfig
> > > @@ -4,5 +4,6 @@ menuconfig ARCH_RDA
> > >  	select COMMON_CLK
> > >  	select GENERIC_IRQ_CHIP
> > >  	select RDA_INTC
> > > +	select RDA_TIMER
> > >  	help
> > >  	  This enables support for the RDA Micro 8810PL SoC family.
> > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > index 55c77e44bb2d..f51eee3a72ea 100644
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > > @@ -105,6 +105,13 @@ config OWL_TIMER
> > >  	help
> > >  	  Enables the support for the Actions Semi Owl timer driver.
> > >  
> > > +config RDA_TIMER
> > > +	bool "RDA timer driver" if COMPILE_TEST
> > > +	depends on GENERIC_CLOCKEVENTS
> > > +	select CLKSRC_MMIO
> > > +	help
> > > +	  Enables the support for the RDA Micro timer driver.
> > > +
> > >  config SUN4I_TIMER
> > >  	bool "Sun4i timer driver" if COMPILE_TEST
> > >  	depends on HAS_IOMEM
> > > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > > index dd9138104568..150020a90707 100644
> > > --- a/drivers/clocksource/Makefile
> > > +++ b/drivers/clocksource/Makefile
> > > @@ -57,6 +57,7 @@ obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
> > >  obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
> > >  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
> > >  obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
> > > +obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
> > >  
> > >  obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
> > >  obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
> > > diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
> > > new file mode 100644
> > > index 000000000000..3aa684d92c5d
> > > --- /dev/null
> > > +++ b/drivers/clocksource/timer-rda.c
> > > @@ -0,0 +1,187 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * RDA8810PL SoC timer driver
> > > + *
> > > + * Copyright RDA Microelectronics Company Limited
> > > + * Copyright (c) 2017 Andreas F?rber
> > > + * Copyright (c) 2018 Manivannan Sadhasivam
> > > + */
> > > +
> > > +#include <linux/clockchips.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/irqreturn.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_irq.h>
> > > +
> > > +#define RDA_OSTIMER_LOADVAL_L	0x000
> > > +#define RDA_OSTIMER_CTRL	0x004
> > > +#define RDA_HWTIMER_LOCKVAL_L	0x024
> > > +#define RDA_HWTIMER_LOCKVAL_H	0x028
> > > +#define RDA_TIMER_IRQ_MASK_SET	0x02c
> > > +#define RDA_TIMER_IRQ_CLR	0x034
> > > +
> > > +#define RDA_OSTIMER_CTRL_ENABLE		BIT(24)
> > > +#define RDA_OSTIMER_CTRL_REPEAT		BIT(28)
> > > +#define RDA_OSTIMER_CTRL_LOAD		BIT(30)
> > > +
> > > +#define RDA_TIMER_IRQ_MASK_SET_OSTIMER	BIT(0)
> > > +
> > > +#define RDA_TIMER_IRQ_CLR_OSTIMER	BIT(0)
> > > +
> > > +static void __iomem *rda_timer_base;
> > > +
> > > +static u64 rda_hwtimer_read(struct clocksource *cs)
> > > +{
> > > +	u32 lo, hi;
> > > +
> > > +	/* Always read low 32 bits first */
> > > +	lo = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_L);
> > > +	hi = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_H);
> > 
> > Please use the relaxed accessors throughout this driver. There is zero
> > reason to use the non-relaxed versions here.
> > 
> 
> Okay.
> 
> > Now, I'm pretty sure this thing isn't correct.
> > 
> > 	<timer = 0x00000000ffffffff>
> > 	lo = 0xffffffff;
> > 	<tick, timer = 0x0000000100000000>
> > 	hi = 0x00000001;
> > 
> > Bingo. You cannot read a 64bit counter with only two 32bit accesses.
> > 
> 
> I think the lack of description makes confusion here. In this SoC, there
> are two independent timers available: OSTIMER (56 bit) and HWTIMER (64 bit)
> with optional interrupt support. I have used OSTIMER for clockevents and
> HWTIMER for clocksource. Will add this information in driver.

How does this change anything with the fact that the above code is
broken? 56 or 64 bit, you cannot read this counter with a single
access, or two. The canonical way of reading such a counter is
something like this:

	do {
		lo = readl_relaxed(LO);
		hi = readl_relaxed(HI);
	} while (hi != read_relaxed(HI));

And yes, please add some documentation, as I have no idea which one is
which. Having structure and function names that match the IP blocks
used would also help.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
