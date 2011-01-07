From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 07 Jan 2011 21:05:11 +0900
Subject: [PATCH V2] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <20110106155358.GH31708@n2100.arm.linux.org.uk>
References: <1294107527-27915-1-git-send-email-kgene.kim@samsung.com>
	<20110106155358.GH31708@n2100.arm.linux.org.uk>
Message-ID: <019e01cbae63$2511a5e0$6f34f1a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Tue, Jan 04, 2011 at 11:18:47AM +0900, Kukjin Kim wrote:
> > From: Changhwan Youn <chaos.youn@samsung.com>
> >
> > The Multi-Core Timer(MCT) of S5PV310 is designed for implementing
> > clock source timer and clock event timers. This patch implements
> > 1 clock source timer with 64 bit free running counter of MCT and
> > 2 clock event timers with two of 31-bit tick counters.
> 
> I want to wait until after this merge window before commenting too much
> on this; some of this patch will be impacted by changes in this merge
> window.
> 
Hmmm...Ok, I understood.

> > +static void s5pv310_frc_suspend(struct clocksource *cs)
> > +{
> > +	time_suspended = s5pv310_frc_read(cs);
> > +};
> > +
> > +static void s5pv310_frc_resume(struct clocksource *cs)
> > +{
> > +	s5pv310_mct_frc_start((u32)(time_suspended >> 32),
> (u32)time_suspended);
> > +};
> 
> Is this something which other clocksource drivers need to do, or does the
> core automatically deal with the clocksource being irregular across a
> suspend/resume event?
> 
Normally this is not necessary because core deals with the irregularity of
clocksource, but for sched_clock() implementation, clocksource had better be
regular across a suspend/resume event. One example is "Show timing
information on printks" kernel configuration. Without this code, timing
information resets after suspend/resume event.

Following is not submitted but will be submitted :-)

unsigned long long sched_clock(void)
{
	struct clocksource *cs = &mct_frc;

	return clocksource_cyc2ns(cs->read(NULL), sched_mult, sched_shift);
}

> > +irqreturn_t s5pv310_mct_tick0_isr(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = dev_id;
> > +
> > +	/*
> > +	 * This is for supporting oneshot mode.
> > +	 * Mct would generate interrupt periodically
> > +	 * without explicit stopping.
> > +	 */
> > +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> > +		s5pv310_mct_tick_stop(MCT_TICK0);
> > +
> > +	/* Clear the MCT tick0 interrupt */
> > +	s5pv310_mct_write(0x1, S5PV310_MCT_L0_INT_CSTAT);
> > +
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +irqreturn_t s5pv310_mct_tick1_isr(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt = dev_id;
> > +
> > +	/*
> > +	 * This is for supporting oneshot mode.
> > +	 * Mct would generate interrupt periodically
> > +	 * without explicit stopping.
> > +	 */
> > +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> > +		s5pv310_mct_tick_stop(MCT_TICK1);
> > +
> > +	/* Clear the MCT tick1 interrupt */
> > +	s5pv310_mct_write(0x1, S5PV310_MCT_L1_INT_CSTAT);
> > +
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> Umm, why not wrap up the clock_event_device into your own structure,
> which then carries the base address of the MCT to be used - rather than
> duplicating the code just because the base address is different.  Eg,
> 
> struct mct_clock_event_device {
> 	struct clock_event_device evt;
> 	void __iomem *base;
> };

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
