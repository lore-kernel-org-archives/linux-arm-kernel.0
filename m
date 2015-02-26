From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 26 Feb 2015 09:30:02 +0100
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <CADhT+wcyim0Yeq6Wcy6UFAmv+GPjWtVO3hQQ_7uX1bMskADSJQ@mail.gmail.com>
References: <54D8E3BB.3060505@opensource.altera.com>
 <20150209185820.GB7994@pengutronix.de>
 <20150209213017.GC7994@pengutronix.de>
 <54DD2BB3.3090507@opensource.altera.com>
 <20150213080106.GD7994@pengutronix.de>
 <CADhT+wfbZb+u7a-aCi71rh9xFMuphOvqiyEgEYpmmTQtujLcVg@mail.gmail.com>
 <20150217222817.GS8656@n2100.arm.linux.org.uk>
 <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
 <20150225092657.GU8656@n2100.arm.linux.org.uk>
 <CADhT+wcyim0Yeq6Wcy6UFAmv+GPjWtVO3hQQ_7uX1bMskADSJQ@mail.gmail.com>
Message-ID: <20150226083002.GS7994@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:30:32AM -0600, Dinh Nguyen wrote:
> On Wed, Feb 25, 2015 at 3:26 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 24, 2015 at 05:55:05PM -0600, Dinh Nguyen wrote:
> >> Do you have a recommendation on what should be done?
> >
> > Please try this:
> >
> >  arch/arm/mach-socfpga/socfpga.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> > index 383d61e138af..f5e597c207b9 100644
> > --- a/arch/arm/mach-socfpga/socfpga.c
> > +++ b/arch/arm/mach-socfpga/socfpga.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/hardware/cache-l2x0.h>
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/map.h>
> > +#include <asm/cacheflush.h>
> >
> >  #include "core.h"
> >
> > @@ -73,6 +74,10 @@ void __init socfpga_sysmgr_init(void)
> >                         (u32 *) &socfpga_cpu1start_addr))
> >                 pr_err("SMP: Need cpu1-start-addr in device tree.\n");
> >
> > +       /* Ensure that socfpga_cpu1start_addr is visible to other CPUs */
> > +       smp_wmb();
> > +       sync_cache_w(&socfpga_cpu1start_addr);
> > +
> >         sys_manager_base_addr = of_iomap(np, 0);
> >
> >         np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
> >
> > --
> 
> 
> Thanks Russell! I have been able to run the test for > 30 minutes now
> with both cores coming up just fine.
> 

\o/ That sounds very good.

> Do you mind taking this patch for 4.0-rc? If so,
> 
> Tested-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Steffen, if you don't mind, do you want to test on your setup as well?
> 

Yes, of course. Let's see how fast I can get my test running again,
my Sockit is at the Embedded World ATM :-(

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
