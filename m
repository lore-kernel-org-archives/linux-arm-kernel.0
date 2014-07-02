From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 02 Jul 2014 08:29:42 -0700
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
 <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
Message-ID: <20140702152942.12768.85270@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Estevam (2014-07-01 10:44:40)
> On Tue, Jul 1, 2014 at 8:52 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> >> --- a/arch/arm/mach-imx/clk-gate2.c
> >> +++ b/arch/arm/mach-imx/clk-gate2.c
> >> @@ -67,7 +67,7 @@ static void clk_gate2_disable(struct clk_hw *hw)
> >>
> >>       spin_lock_irqsave(gate->lock, flags);
> >>
> >> -     if (gate->share_count && --(*gate->share_count) > 0)
> >> +     if (gate->share_count && (*gate->share_count)-- > 0)
> >
> > The change makes no sense.  Let's say that clk_gate2_disable() gets
> > called with share_count being 1.  In this case, we should access
> > register to gate the clock, right?
> 
> If share_count is 1 it means that someone else is using the clock and
> we can't disable it.

Why do you keep track of share_count at all? Is the enable_count
bookkeeping within the clock framework insufficient for your needs?

Regards,
Mike

> 
> Please try running the series without this patch. When the extern
> audio clock is enabled, share_count is 1. Later the the spdif clock
> (the one that is shared with extern audio clock) is disabled by the
> CCF as it is not used, which makes the extern audio clock to be also
> disabled, which is not what we want.
> 
> What would you suggest?
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
