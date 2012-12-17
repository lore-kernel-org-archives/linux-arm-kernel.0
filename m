From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 17 Dec 2012 09:02:18 +0100 (CET)
Subject: [PATCH 3/7] ARM: sh7372: support mixed DT and board code interrupt
 controller init
In-Reply-To: <20121215075156.GD9073@verge.net.au>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-4-git-send-email-g.liakhovetski@gmx.de>
 <20121215075156.GD9073@verge.net.au>
Message-ID: <Pine.LNX.4.64.1212170900260.24007@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Sat, 15 Dec 2012, Simon Horman wrote:

> On Fri, Dec 14, 2012 at 05:45:27PM +0100, Guennadi Liakhovetski wrote:
> > Extend DT interrupt controller initialisation to automatically fall back to
> > platform data based configuration, if booting without DT. This simplifies
> > implementing boards, capable of booting in either mode with a single kernel.
> 
> Hi Guennadi,
> 
> Do you have a case in mind where this will be used?
> My thinking until now has been that sh7372_init_irq_of() should only be called
> when a board is being initialised using DT.

As discussed in follow-ups to another patch from this series, the idea was 
to only have one sh7372_init_irq(_of)() function exported, but it's not 
too important, I'll drop this from v2.

Thanks
Guennadi

> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  arch/arm/mach-shmobile/intc-sh7372.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
> > index c923518..9c13ecc 100644
> > --- a/arch/arm/mach-shmobile/intc-sh7372.c
> > +++ b/arch/arm/mach-shmobile/intc-sh7372.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/io.h>
> >  #include <linux/sh_intc.h>
> > +#include <mach/common.h>
> >  #include <mach/intc.h>
> >  #include <mach/irqs.h>
> >  #include <asm/mach-types.h>
> > @@ -629,6 +630,11 @@ static const struct of_device_id irq_of_match[] __initconst = {
> >  
> >  void __init sh7372_init_irq_of(void)
> >  {
> > +	if (!of_have_populated_dt()) {
> > +		sh7372_init_irq();
> > +		return;
> > +	}
> > +
> >  	of_irq_init(irq_of_match);
> >  
> >  	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000,
> > -- 
> > 1.7.2.5
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
