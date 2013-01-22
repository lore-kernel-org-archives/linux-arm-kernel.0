From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Tue, 22 Jan 2013 11:29:17 +0530
Subject: [PATCH 4/4] ARM: apply the l2x0 Errata 769419 at run time
In-Reply-To: <20130121161202.GR23505@n2100.arm.linux.org.uk>
References: <20130121131709.GA29927@bnru10>
 <20130121161202.GR23505@n2100.arm.linux.org.uk>
Message-ID: <20130122055916.GA22429@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 17:12:02 +0100, Russell King - ARM Linux wrote:
> On Mon, Jan 21, 2013 at 06:47:12PM +0530, srinidhi kasagar wrote:
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > ---
> >  arch/arm/kernel/process.c |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index c6dec5f..c94d84f 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -39,6 +39,7 @@
> >  #include <asm/thread_notify.h>
> >  #include <asm/stacktrace.h>
> >  #include <asm/mach/time.h>
> > +#include <asm/hardware/cache-l2x0.h>
> >  
> >  #ifdef CONFIG_CC_STACKPROTECTOR
> >  #include <linux/stackprotector.h>
> > @@ -201,9 +202,11 @@ void cpu_idle(void)
> >  			 * to ensure we don't miss a wakeup call.
> >  			 */
> >  			local_irq_disable();
> > -#ifdef CONFIG_PL310_ERRATA_769419
> > -			wmb();
> > -#endif
> > +
> > +			/* Check for PL310 ERRATA 769419 */
> > +			if (l2x0_get_rtl_release() == L2X0_CACHE_ID_RTL_R3P0)
> > +				wmb();
> 
> You have to be joking if you think that is suitable... two reasons:
> 
> 1. It's a horrid layering violation.
> 2. l2x0_get_rtl_release() unconditionally reads from a register in the L2
>    controller.  What if you don't have a L2 controller?

my bad, this can be fixed. Thank you.

> 
> Is it really worth this hastle, or would it just be better to keep the
> ifdef there, using the configuration symbol as a way to indicate whether
> we want this work-around included in the kernel, and always have the
> wmb() there if the symbol is enabled?
We can keep the ifdef there, my idea was to completely eliminate these
CONFIG_PL310_ERRATA_*. The problem comes when you have a single defconfig
for two platforms (ex, ST-E's 8500 and 8540) where one platform needs
this and the other don't.

regards/srinidhi
