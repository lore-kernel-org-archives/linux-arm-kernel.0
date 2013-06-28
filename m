From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 23:20:19 +0200
Subject: [PATCHv2 4/8] clocksource: sun4i: Fix the next event code
In-Reply-To: <7300725.devmrYGi4t@flatron>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372449386-1334-5-git-send-email-maxime.ripard@free-electrons.com>
 <alpine.DEB.2.02.1306282204220.4013@ionos.tec.linutronix.de>
 <7300725.devmrYGi4t@flatron>
Message-ID: <20130628212019.GC2756@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 10:35:29PM +0200, Tomasz Figa wrote:
> On Friday 28 of June 2013 22:13:08 Thomas Gleixner wrote:
> > On Fri, 28 Jun 2013, Maxime Ripard wrote:
> > > The next_event logic was setting the next interval to fire in the
> > > current timer value instead of the interval value register, which is
> > > obviously wrong.
> > 
> > Ok.
> > 
> > > Plus the logic to set the actual value was wrong as well, so this
> > > code has always been broken.
> > 
> > This lacks an explanation why the logic is wrong and what the actual
> > fix is.
> > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > > 
> > >  drivers/clocksource/sun4i_timer.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/clocksource/sun4i_timer.c
> > > b/drivers/clocksource/sun4i_timer.c index 84ace76..695c8c8 100644
> > > --- a/drivers/clocksource/sun4i_timer.c
> > > +++ b/drivers/clocksource/sun4i_timer.c
> > > @@ -16,6 +16,7 @@
> > > 
> > >  #include <linux/clk.h>
> > >  #include <linux/clockchips.h>
> > > 
> > > +#include <linux/delay.h>
> > > 
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/irqreturn.h>
> > > 
> > > @@ -61,9 +62,14 @@ static void sun4i_clkevt_mode(enum clock_event_mode
> > > mode,> 
> > >  static int sun4i_clkevt_next_event(unsigned long evt,
> > >  
> > >  				   struct clock_event_device *unused)
> > >  
> > >  {
> > > 
> > > -	u32 u = readl(timer_base + TIMER_CTL_REG(0));
> > > -	writel(evt, timer_base + TIMER_CNTVAL_REG(0));
> > > -	writel(u | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
> > > +	u32 val = readl(timer_base + TIMER_CTL_REG(0));
> > > +	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
> > > +	udelay(1);
> > 
> > That udelay() is more than suspicious.
> 
> Not only it is suspicious, but also delays the event by 1 microsecond. Not 
> much, given usual usage of clock events, but still.
> 
> From what I understand from this code, you keep this timer running and 
> just stop it to set new event. Can you simply disable autoreload and just 
> program this timer to start counting from evt down to 0 when it generates 
> interrupt and just stops itself?

Something like that, but not completely, because the timer actually
stops.

To reprogram a new interval to a running timer, you have to:
  - Disable it
  - Program the new interval
  - Propagates the new interval and start the timer by setting the bits
    ENABLE and (AUTO)RELOAD (AUTORELOAD is probably a bad name here
    actually). That is, wether or not it's a oneshot or periodic timer.

Now, between the time you disable the timer and enable it back, you have
to wait at least 2 timer clock source cycles (which is around 85ns).

It's the ONESHOT (BIT(7)) that actually controls wether or not the timer
is periodic.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/697eeeb2/attachment-0001.sig>
