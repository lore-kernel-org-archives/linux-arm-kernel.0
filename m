From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 23 Dec 2010 19:24:48 +0900
Subject: [PATCH] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <20101222123502.GB2838@pulham.picochip.com>
References: <1293017221-31037-1-git-send-email-kgene.kim@samsung.com>
	<20101222123502.GB2838@pulham.picochip.com>
Message-ID: <003d01cba28b$a2388cc0$e6a9a640$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote:
> 
> Hi Kukjin,
> 
Hi Jamie :-)

> Just trying to learn what other people are doing in their platforms, so
> apologies if my comments aren't applicable! Looks good to me though.
> 
No problem, thanks for your comments and always welcome to review ;-)

(snip)

> > +
> > +static struct clock_event_device mct_tick1_device = {
> > +	.name		= "mct-tick1",
> > +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> > +	.rating		= 450,
> > +	.shift		= 20,
> > +	.set_next_event	= s5pv310_tick1_set_next_event,
> > +	.set_mode	= s5pv310_tick1_set_mode,
> > +};
> 
> Do you need to specify .shift here? Could you use
> clockevents_calc_mult_shift() to calculate mult and shift for you?
> 
Oh, yeah...Mr. Youn and I didn't notice the existence of it...will fix.

> > +irqreturn_t s5pv310_mct0_event_isr(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt;
> > +
> > +	/* Clear the MCT tick interrupt */
> > +
> > +	evt = &mct_tick0_device;
> > +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> > +		s5pv310_mct_tick_stop(MCT_TICK0);
> 
> I don't think you need to stop the timer here, the clockevents layer
> will handle this for you.
> 
This is to support One-shot mode using MCT. Because basically MCT local
timer only supports periodic mode.
But will be added comment.

> [...]
> > +static void s5pv310_mct_clockevent_init(struct clock_event_device *dev)
> > +{
> > +	dev->mult = div_sc(clk_rate / 2, NSEC_PER_SEC, dev->shift);
> > +
> > +	dev->max_delta_ns = clockevent_delta2ns(0xfffffff, dev);
> 
> Is there a reason that the delta is only using 28 bits here?
> 
Oh, your pointing out is right...Its max delta should be 31 bits.
Will fix it...and correct value is 0x7fffffff.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
