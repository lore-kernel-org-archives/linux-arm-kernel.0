From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 1 Jul 2013 10:15:51 +0200 (CEST)
Subject: [PATCHv2 4/8] clocksource: sun4i: Fix the next event code
In-Reply-To: <20130629064815.GA2593@lukather>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372449386-1334-5-git-send-email-maxime.ripard@free-electrons.com>
 <alpine.DEB.2.02.1306282204220.4013@ionos.tec.linutronix.de>
 <20130628210853.GB2756@lukather>
 <alpine.DEB.2.02.1306282322480.4013@ionos.tec.linutronix.de>
 <20130629064815.GA2593@lukather>
Message-ID: <alpine.DEB.2.02.1307011014430.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 29 Jun 2013, Maxime Ripard wrote:
> On Fri, Jun 28, 2013 at 11:27:25PM +0200, Thomas Gleixner wrote:
> > On Fri, 28 Jun 2013, Maxime Ripard wrote:
> > > On Fri, Jun 28, 2013 at 10:13:08PM +0200, Thomas Gleixner wrote:
> > > > On Fri, 28 Jun 2013, Maxime Ripard wrote:
> > > > > @@ -61,9 +62,14 @@ static void sun4i_clkevt_mode(enum clock_event_mode mode,
> > > > >  static int sun4i_clkevt_next_event(unsigned long evt,
> > > > >  				   struct clock_event_device *unused)
> > > > >  {
> > > > > -	u32 u = readl(timer_base + TIMER_CTL_REG(0));
> > > > > -	writel(evt, timer_base + TIMER_CNTVAL_REG(0));
> > > > > -	writel(u | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
> > > > > +	u32 val = readl(timer_base + TIMER_CTL_REG(0));
> > > > > +	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
> > > > > +	udelay(1);
> > > > 
> > > > That udelay() is more than suspicious. Is there really no other way to
> > > > deal with that hardware?
> > > > 
> > > > If no, you really need to put a proper explanation for that into the code.
> > > 
> > > The datasheet states that you have to wait for two ticks of the timer
> > > clock source (in that case, 24MHz, which makes it around 80-85ns) before
> > > you can actually enable it back.
> > > 
> > > I didn't came up with a better solution.
> > 
> > 80-85ns is definitely way less than 1us.
> > 
> > Why not reading the counter register and wait for 2 or 3 cycles to
> > elapse instead of wasting a full microsecond evertime ?
> 
> Yes, but then we fall back to the discussion we had in the v1 about the
> latch needed to read the counter, which would already take more time
> than what we have to wait for.
> 
> Maybe we can use the second timer that we use for the clocksource
> though: it's always running, already set up, work at the same rate and
> we will only read it, so we won't change its monotonic nature.

Right. That will give you exact the information you need and make for
the shortest waiting time.

Thanks,

	tglx
