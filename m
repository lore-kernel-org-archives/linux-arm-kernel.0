From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 2 Jun 2016 22:59:15 +0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <alpine.DEB.2.11.1604271212290.3941@nanos>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
 <alpine.DEB.2.11.1604271212290.3941@nanos>
Message-ID: <20160602145915.GA31124@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Apr 27, 2016 at 12:15:00PM +0200, Thomas Gleixner wrote:
> On Wed, 27 Apr 2016, Dong Aisheng wrote:
> > On Wed, Apr 27, 2016 at 9:58 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > > On Tue, Apr 26, 2016 at 07:27:03PM +0800, Dong Aisheng wrote:
> > >> Shawn,
> > >> What's your suggestion?
> > >
> > > I think this needs more discussion, and I just dropped Stefan's patch
> > > from my tree.
> > >
> > > We need to firstly understand why this is happening.  The .prepare hook
> > > is defined to be non-atomic context, and so that we call sleep function
> > > in there.  We did everything right.  Why are we getting the warning?  If
> > > I'm correct, this warning only happens on i.MX7D.  Why is that?
> > >
> > 
> > Why Stefan's patch works (checking irqs_disabled()) is because during kernel
> > time init, the irq is still not enabled. It fixes the issue indirectly.
> > See:
> > asmlinkage __visible void __init start_kernel(void)
> > {
> >         /*
> >          * Set up the scheduler prior starting any interrupts (such as the
> >          * timer interrupt). Full topology setup happens at smp_init()
> >          * time - but meanwhile we still have a functioning scheduler.
> >          */
> >         sched_init();
> >         .............
> >         time_init();
> >         ..............
> >         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
> >         early_boot_irqs_disabled = false;
> >         local_irq_enable();
> > }
> > 
> > The issue can only happen when PLL enable causes a schedule during
> > imx_clock_init().
> 
> Calling a function which might sleep _BEFORE_ kernel_init() is wrong. Don't
> try to work around such an issue by doing magic irq_disabled() checks and busy
> loops. Fix the call site and be done with it.
> 

IRQ chip and clocksource are also initialised before kernel_init()
which may call clk APIs like clk_prepare_enable().
We may not be able to guarantee those clocks are unsleepable.

e.g.
For IRQ chip, the arm,gic documents the optional clocks property in
Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt.
Although there seems no user currently, not sure there might be
a exception in the future.

For clocksource driver, it's quite common to call clk APIs to
enable and get clock rate which may also cause sleep.
e.g. ARM twd clock in arch/arm/kernel/smp_twd.c.

If we have to avoid the possible sleep caused by these clocks,
we may need to manually check it and change the related clocks
(e.g PLLs) from sleepable to busy loops.
But that is not a good solution and may also not stable when
clock varies.

It looks like not easy to find a generic solution for them.
What's your suggestion?

And Stephen,

Besides above possible sleep, the clk framework itself may also
cause unexpected sleep before kernel_init().
1) clk framework now supports CLK_IS_CRITICAL flag which allows to
enable the clock during register in __clk_core_init(), it usually
can happen in time_init()->of_clk_init();

2) clk framework also support set default configuration like set_parent
and set_rate during register clk providers which also happens in
time_init()->of_clk_init().

Any ideas?
Do you think if we should move them onto a bit later stage after
kernel_init()?

Regards
Dong Aisheng

> Thanks,
> 
> 	tglx
> 
> 
