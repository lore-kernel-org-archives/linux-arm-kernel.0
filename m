From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Apr 2016 12:15:00 +0200 (CEST)
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1604271212290.3941@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2016, Dong Aisheng wrote:
> On Wed, Apr 27, 2016 at 9:58 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Tue, Apr 26, 2016 at 07:27:03PM +0800, Dong Aisheng wrote:
> >> Shawn,
> >> What's your suggestion?
> >
> > I think this needs more discussion, and I just dropped Stefan's patch
> > from my tree.
> >
> > We need to firstly understand why this is happening.  The .prepare hook
> > is defined to be non-atomic context, and so that we call sleep function
> > in there.  We did everything right.  Why are we getting the warning?  If
> > I'm correct, this warning only happens on i.MX7D.  Why is that?
> >
> 
> Why Stefan's patch works (checking irqs_disabled()) is because during kernel
> time init, the irq is still not enabled. It fixes the issue indirectly.
> See:
> asmlinkage __visible void __init start_kernel(void)
> {
>         /*
>          * Set up the scheduler prior starting any interrupts (such as the
>          * timer interrupt). Full topology setup happens at smp_init()
>          * time - but meanwhile we still have a functioning scheduler.
>          */
>         sched_init();
>         .............
>         time_init();
>         ..............
>         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
>         early_boot_irqs_disabled = false;
>         local_irq_enable();
> }
> 
> The issue can only happen when PLL enable causes a schedule during
> imx_clock_init().

Calling a function which might sleep _BEFORE_ kernel_init() is wrong. Don't
try to work around such an issue by doing magic irq_disabled() checks and busy
loops. Fix the call site and be done with it.

Thanks,

	tglx
