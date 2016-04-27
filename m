From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Apr 2016 15:24:54 +0800
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
Message-ID: <20160427072454.GJ30692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 10:57:21AM +0800, Dong Aisheng wrote:
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
> Not all PLL has this issue.
> The issue happens on MX7D pll_audio_main_clk/pll_video_main_clk
> which requires more delay time and cause usleep.
> Because clk framework does not support MX7D clock types (operation requires
> parents on), we simply enable all clocks in imx7d_clocks_init().
> 
> If apply my this patch series:
> https://lkml.org/lkml/2016/4/20/199
> The issue can also be gone.

Thanks for the info.  It sounds like that we are fixing the problem in
the wrong place, i.e. clk_pllv3_prepare().  The function does nothing
wrong, since the .prepare hook is defined to be one that can sleep.  If
we see sleep warning in a context calling clk_prepare(), that probably
means we shouldn't make the function call from that context.

Shawn
