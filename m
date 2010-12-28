From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 28 Dec 2010 00:57:01 +0000
Subject: [PATCH] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <003d01cba28b$a2388cc0$e6a9a640$%kim@samsung.com>
References: <1293017221-31037-1-git-send-email-kgene.kim@samsung.com>
	<20101222123502.GB2838@pulham.picochip.com>
	<003d01cba28b$a2388cc0$e6a9a640$%kim@samsung.com>
Message-ID: <20101228005701.GA2835@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 07:24:48PM +0900, Kukjin Kim wrote:
> Jamie Iles wrote:
> > > +irqreturn_t s5pv310_mct0_event_isr(int irq, void *dev_id)
> > > +{
> > > +	struct clock_event_device *evt;
> > > +
> > > +	/* Clear the MCT tick interrupt */
> > > +
> > > +	evt = &mct_tick0_device;
> > > +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> > > +		s5pv310_mct_tick_stop(MCT_TICK0);
> > 
> > I don't think you need to stop the timer here, the clockevents layer
> > will handle this for you.
> > 
> This is to support One-shot mode using MCT. Because basically MCT local
> timer only supports periodic mode.
> But will be added comment.

Actually I think you can simply remove the s5pv310_mct_tick_stop() 
altogether. The onestop event handlers should schedule the next expiry 
and will respect the min and max deltas so after the event the timer 
will be correctly programmed for the next event.

I had to try this on hardware to convince myself (the timers on my 
platform have the same behaviour) but it does work!

Jamie
