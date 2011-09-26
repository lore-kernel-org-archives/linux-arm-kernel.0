From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Sep 2011 21:16:20 +0800
Subject: [PATCH] ARM i.MX gic: add handle_irq function
In-Reply-To: <20110926084141.GP31404@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
	<1316797284-21010-1-git-send-email-shawn.guo@linaro.org>
	<20110926084141.GP31404@pengutronix.de>
Message-ID: <20110926131618.GA17577@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 10:41:41AM +0200, Sascha Hauer wrote:
> On Sat, Sep 24, 2011 at 01:01:24AM +0800, Shawn Guo wrote:
> > This is a plain translation of assembly gic irq handler to C function
> > for CONFIG_MULTI_IRQ_HANDLER support on imx family.
> > 
> > As the speed of gic_handle_irq() is much more important than code
> > clean, the patch chooses to plug the ifdef in the function to compile
> > out the corresponding codes.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > Right, ideally the arch/arm/plat-mxc/gic.c should be merged into
> > arch/arm/common/gic.c.  But before rmk asks me to do that, I would
> > let it stay in imx platform.
> > 
> >  arch/arm/plat-mxc/Makefile                   |    2 +-
> >  arch/arm/plat-mxc/gic.c                      |   47 ++++++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h      |    2 +
> >  arch/arm/plat-mxc/include/mach/entry-macro.S |    6 +++
> >  4 files changed, 56 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/plat-mxc/gic.c
> > 
> > diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> > index d53c35f..b9f0f5f 100644
> > --- a/arch/arm/plat-mxc/Makefile
> > +++ b/arch/arm/plat-mxc/Makefile
> > @@ -5,7 +5,7 @@
> >  # Common support
> >  obj-y := clock.o time.o devices.o cpu.o system.o irq-common.o
> >  
> > -# MX51 uses the TZIC interrupt controller, older platforms use AVIC
> > +obj-$(CONFIG_ARM_GIC) += gic.o
> >  obj-$(CONFIG_MXC_TZIC) += tzic.o
> >  obj-$(CONFIG_MXC_AVIC) += avic.o
> >  
> > diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
> > new file mode 100644
> > index 0000000..487d12c
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/gic.c
> > @@ -0,0 +1,47 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <asm/localtimer.h>
> > +#include <asm/hardware/gic.h>
> > +#ifdef CONFIG_SMP
> > +#include <asm/smp.h>
> > +#endif
> > +
> > +asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> > +{
> > +	u32 irqstat, irqnr;
> > +
> > +	do {
> > +		irqstat = readl_relaxed(gic_cpu_base_addr + GIC_CPU_INTACK);
> > +		irqnr = irqstat & 0x3ff;
> > +		if (irqnr == 1023)
> > +			break;
> > +
> > +		if (irqnr > 29 && irqnr < 1021)
> > +			handle_IRQ(irqnr, regs);
> > +#ifdef CONFIG_SMP
> > +		else if (irqnr < 16) {
> > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > +						GIC_CPU_EOI);
> > +			do_IPI(irqnr, regs);
> > +		}
> > +#endif
> > +#ifdef CONFIG_LOCAL_TIMERS
> > +		else if (irqnr == 29) {
> > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > +						GIC_CPU_EOI);
> > +			do_local_timer(regs);
> > +		}
> > +#endif
> > +	} while (1);
> > +}
> 
> Shouldn't this code go to arch/arm/common/gic.c instead? The
> corresponding assembly code is generic so I see no reason to make
> this i.MX specific.
> 
Yes.  I put some notes below '---' about this.  Basically, this patch
is just a way around to have imx6q catch up with your global move on
i.mx CONFIG_MULTI_IRQ_HANDLER support.  In the long term, this GIC
support should definitely need to be handled by arch/arm/common/gic.c.

Actually, Marc Zyngier has just started posting CONFIG_MULTI_IRQ_HANDLER
for GIC.  But it depends on his own PPI series, which I'm unsure if it
will gets merged in the coming window.  I really want to get imx6q
merged in v3.2 window, so I would not have Marc's common GIC support
as a dependency.  We can switch to it once it gets merged.

-- 
Regards,
Shawn
