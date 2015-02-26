From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Feb 2015 09:12:46 +0100
Subject: [RFC PATCH 3/3] rtc: at91sam9: properly act when IRQ handler is
 called in suspended state
In-Reply-To: <1611142.77NqGpG2im@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <1424771762-16343-4-git-send-email-boris.brezillon@free-electrons.com>
 <1611142.77NqGpG2im@vostro.rjw.lan>
Message-ID: <20150226091246.6bdae8db@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015 23:05:36 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Tuesday, February 24, 2015 10:56:02 AM Boris Brezillon wrote:
> > The IRQ line used by the RTC device is often shared with the system timer
> > (PIT) on at91 platforms.
> > Since timers are registering their handlers with IRQF_NO_SUSPEND, we should
> > expect being called in suspended state, and properly wake the system up
> > when this is the case.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/rtc/rtc-at91sam9.c | 62 ++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 51 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> > index 2183fd2..8cf9c1b 100644
> > --- a/drivers/rtc/rtc-at91sam9.c
> > +++ b/drivers/rtc/rtc-at91sam9.c
> > @@ -77,6 +77,8 @@ struct sam9_rtc {
> >  	unsigned int		gpbr_offset;
> >  	int 			irq;
> >  	struct clk		*sclk;
> > +	unsigned long		events;
> > +	spinlock_t		lock;
> >  };
> >  
> >  #define rtt_readl(rtc, field) \
> > @@ -271,14 +273,9 @@ static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
> >  	return 0;
> >  }
> >  
> > -/*
> > - * IRQ handler for the RTC
> > - */
> > -static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
> > +static irqreturn_t at91_rtc_cache_events(struct sam9_rtc *rtc)
> >  {
> > -	struct sam9_rtc *rtc = _rtc;
> >  	u32 sr, mr;
> > -	unsigned long events = 0;
> >  
> >  	/* Shared interrupt may be for another device.  Note: reading
> >  	 * SR clears it, so we must only read it in this irq handler!
> > @@ -290,18 +287,54 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
> >  
> >  	/* alarm status */
> >  	if (sr & AT91_RTT_ALMS)
> > -		events |= (RTC_AF | RTC_IRQF);
> > +		rtc->events |= (RTC_AF | RTC_IRQF);
> >  
> >  	/* timer update/increment */
> >  	if (sr & AT91_RTT_RTTINC)
> > -		events |= (RTC_UF | RTC_IRQF);
> > +		rtc->events |= (RTC_UF | RTC_IRQF);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void at91_rtc_flush_events(struct sam9_rtc *rtc)
> > +{
> > +	if (!rtc->events)
> > +		return;
> >  
> > -	rtc_update_irq(rtc->rtcdev, 1, events);
> > +	rtc_update_irq(rtc->rtcdev, 1, rtc->events);
> > +	rtc->events = 0;
> >  
> >  	pr_debug("%s: num=%ld, events=0x%02lx\n", __func__,
> > -		events >> 8, events & 0x000000FF);
> > +		rtc->events >> 8, rtc->events & 0x000000FF);
> > +}
> >  
> > -	return IRQ_HANDLED;
> > +/*
> > + * IRQ handler for the RTC
> > + */
> > +static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
> > +{
> > +	struct sam9_rtc *rtc = _rtc;
> > +	int ret;
> > +
> > +	spin_lock(&rtc->lock);
> > +
> > +	ret = at91_rtc_cache_events(rtc);
> > +
> > +	/* We're called in suspended state */
> > +	if (irq_is_wakeup_armed(irq)) {
> 
> Instead of doing this, I would set a flag in the driver's ->suspend
> callback (or in ->suspend_late, whichever is more convenient) and check
> that flag here.

Sure, if I can start acting as a suspended handler (in other words, if
I can safely call pm_system_wakeup) as soon as my suspend callback has
been called, then I'm fine adding a boolean to store the device state.

Thanks for your review.

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
