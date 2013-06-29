From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 29 Jun 2013 08:48:15 +0200
Subject: [PATCHv2 4/8] clocksource: sun4i: Fix the next event code
In-Reply-To: <alpine.DEB.2.02.1306282322480.4013@ionos.tec.linutronix.de>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372449386-1334-5-git-send-email-maxime.ripard@free-electrons.com>
 <alpine.DEB.2.02.1306282204220.4013@ionos.tec.linutronix.de>
 <20130628210853.GB2756@lukather>
 <alpine.DEB.2.02.1306282322480.4013@ionos.tec.linutronix.de>
Message-ID: <20130629064815.GA2593@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 11:27:25PM +0200, Thomas Gleixner wrote:
> On Fri, 28 Jun 2013, Maxime Ripard wrote:
> > On Fri, Jun 28, 2013 at 10:13:08PM +0200, Thomas Gleixner wrote:
> > > On Fri, 28 Jun 2013, Maxime Ripard wrote:
> > > > @@ -61,9 +62,14 @@ static void sun4i_clkevt_mode(enum clock_event_mode mode,
> > > >  static int sun4i_clkevt_next_event(unsigned long evt,
> > > >  				   struct clock_event_device *unused)
> > > >  {
> > > > -	u32 u = readl(timer_base + TIMER_CTL_REG(0));
> > > > -	writel(evt, timer_base + TIMER_CNTVAL_REG(0));
> > > > -	writel(u | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
> > > > +	u32 val = readl(timer_base + TIMER_CTL_REG(0));
> > > > +	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
> > > > +	udelay(1);
> > > 
> > > That udelay() is more than suspicious. Is there really no other way to
> > > deal with that hardware?
> > > 
> > > If no, you really need to put a proper explanation for that into the code.
> > 
> > The datasheet states that you have to wait for two ticks of the timer
> > clock source (in that case, 24MHz, which makes it around 80-85ns) before
> > you can actually enable it back.
> > 
> > I didn't came up with a better solution.
> 
> 80-85ns is definitely way less than 1us.
> 
> Why not reading the counter register and wait for 2 or 3 cycles to
> elapse instead of wasting a full microsecond evertime ?

Yes, but then we fall back to the discussion we had in the v1 about the
latch needed to read the counter, which would already take more time
than what we have to wait for.

Maybe we can use the second timer that we use for the clocksource
though: it's always running, already set up, work at the same rate and
we will only read it, so we won't change its monotonic nature.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130629/a74496cb/attachment.sig>
