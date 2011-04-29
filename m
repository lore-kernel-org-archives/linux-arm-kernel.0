From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 14:28:32 +0200 (CEST)
Subject: [patch 07/16] arm: omap: Use clocksource based sched_clock
In-Reply-To: <20110429115744.GZ3755@atomide.com>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.221790438@linutronix.de>
	<20110429115744.GZ3755@atomide.com>
Message-ID: <alpine.LFD.2.02.1104291420240.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B1;2601;0cOn Fri, 29 Apr 2011, Tony Lindgren wrote:

> * Thomas Gleixner <tglx@linutronix.de> [110423 13:51]:
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/arm/mach-omap1/time.c               |   62 +--------------------------
> >  arch/arm/mach-omap2/timer-gp.c           |   17 -------
> >  arch/arm/plat-omap/counter_32k.c         |   71 ++-----------------------------
> >  arch/arm/plat-omap/dmtimer.c             |    4 -
> >  arch/arm/plat-omap/include/plat/common.h |    1 
> >  5 files changed, 13 insertions(+), 142 deletions(-)
> 
> This one needs the following patch to compile. Also, this
> fails with following, probably because the clocks are not
> set up at that point.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 80000005 [#1] SMP
> last sysfs file: 
> Modules linked in:
> CPU: 0    Not tainted  (2.6.39-rc5-00081-gc3dec8c #166)
> PC is at 0x0
> LR is at read_persistent_clock+0x24/0xb4

> The generic code should probably just return 0 until the clocks are
> initialized. Or do you have some other solution for that in mind?

The generic sched_clock implementation returns a jiffies based value
as long as there is no clocksource registered. But the above does not
fail in sched_clock() it fails in read_persistent_clock() which does

        last_cycles = cycles;
        cycles = clocksource_32k.read(&clocksource_32k);

So the following change causes this:

-     .read           = omap_32k_read_dummy,

Which leads to the question why you have a read_persistent_clock() at
all if it always reads 0 via omap_32k_read_dummy ? Or is this meant
just for the resume case? Then the above and the removal of
omap_32k_read_dummy() needs to be undone.

Thanks,

	tglx
