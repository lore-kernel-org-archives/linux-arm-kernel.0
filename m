From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 23:08:53 +0200
Subject: [PATCHv2 4/8] clocksource: sun4i: Fix the next event code
In-Reply-To: <alpine.DEB.2.02.1306282204220.4013@ionos.tec.linutronix.de>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372449386-1334-5-git-send-email-maxime.ripard@free-electrons.com>
 <alpine.DEB.2.02.1306282204220.4013@ionos.tec.linutronix.de>
Message-ID: <20130628210853.GB2756@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jun 28, 2013 at 10:13:08PM +0200, Thomas Gleixner wrote:
> On Fri, 28 Jun 2013, Maxime Ripard wrote:
> 
> > The next_event logic was setting the next interval to fire in the
> > current timer value instead of the interval value register, which is
> > obviously wrong.
> 
> Ok.
> 
> > Plus the logic to set the actual value was wrong as well, so this
> > code has always been broken.
> 
> This lacks an explanation why the logic is wrong and what the actual
> fix is.

Right.

Actually, the interval register can only be modified when the timer is
disabled. So we first need, to disable it, change the interval, and then
enable it back.

> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clocksource/sun4i_timer.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> > index 84ace76..695c8c8 100644
> > --- a/drivers/clocksource/sun4i_timer.c
> > +++ b/drivers/clocksource/sun4i_timer.c
> > @@ -16,6 +16,7 @@
> >  
> >  #include <linux/clk.h>
> >  #include <linux/clockchips.h>
> > +#include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqreturn.h>
> > @@ -61,9 +62,14 @@ static void sun4i_clkevt_mode(enum clock_event_mode mode,
> >  static int sun4i_clkevt_next_event(unsigned long evt,
> >  				   struct clock_event_device *unused)
> >  {
> > -	u32 u = readl(timer_base + TIMER_CTL_REG(0));
> > -	writel(evt, timer_base + TIMER_CNTVAL_REG(0));
> > -	writel(u | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
> > +	u32 val = readl(timer_base + TIMER_CTL_REG(0));
> > +	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
> > +	udelay(1);
> 
> That udelay() is more than suspicious. Is there really no other way to
> deal with that hardware?
> 
> If no, you really need to put a proper explanation for that into the code.

The datasheet states that you have to wait for two ticks of the timer
clock source (in that case, 24MHz, which makes it around 80-85ns) before
you can actually enable it back.

I didn't came up with a better solution.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/0f311dd3/attachment.sig>
