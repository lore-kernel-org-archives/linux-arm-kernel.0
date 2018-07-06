From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 6 Jul 2018 17:18:48 +0200
Subject: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <0ebef205-a6c8-0da2-86b4-6b1c982a1fdf@linaro.org>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <0ebef205-a6c8-0da2-86b4-6b1c982a1fdf@linaro.org>
Message-ID: <20180706151848.GB16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/2018 18:24:12+0200, Daniel Lezcano wrote:
> > +static void tc_clkevt2_clk_enable(struct clock_event_device *d)
> > +{
> > +	if (tce.clk_enabled)
> > +		return;
> 
> Why this test ?
> 
> > +	clk_enable(tce.clk);
> > +	tce.clk_enabled = true;
> > +}
> >
> > +static int tc_clkevt2_stop(struct clock_event_device *d)
> > +{
> > +	writel(0xff, tce.base + ATMEL_TC_IDR(tce.channel));
> > +	writel(ATMEL_TC_CCR_CLKDIS, tce.base + ATMEL_TC_CCR(tce.channel));
> > +
> > +	return 0;
> > +}
> > +
> > +static int tc_clkevt2_shutdown(struct clock_event_device *d)
> > +{
> > +	tc_clkevt2_stop(d);
> > +	if (!clockevent_state_detached(d))
> 
> Why this test ?
> 
> > +		tc_clkevt2_clk_disable(d);
> > +
> > +	return 0;
> > +}
> > +
> > +/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
> > + * because using one of the divided clocks would usually mean the
> > + * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
> > + *
> > + * A divided clock could be good for high resolution timers, since
> > + * 30.5 usec resolution can seem "low".
> > + */
> > +static int tc_clkevt2_set_oneshot(struct clock_event_device *d)
> > +{
> > +	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
> > +		tc_clkevt2_stop(d);
> 
> Why these tests ? :)
> 

All these test are to be nice with preempt-rt else we would be disabling
then reenabling the clock in an atomic context which fails with the
preempt-rt patch.

> > +	/* By not making the gentime core emulate periodic mode on top
> > +	 * of oneshot, we get lower overhead and improved accuracy.
> > +	 */
> > +	tc_clkevt2_clk_enable(d);
> > +
> > +	/* slow clock, count up to RC, then irq and restart */
> > +	writel(ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_WAVE |
> > +	       ATMEL_TC_CMR_WAVESEL_UPRC,
> > +	       tce.base + ATMEL_TC_CMR(tce.channel));
> > +	writel((32768 + HZ / 2) / HZ, tce.base + ATMEL_TC_RC(tce.channel));
> 
> Do this computation at init time.
> 

Does it really matter? All the members are constant so no code will be
generated for the computation. This ends up being an immediate value
computing it at init time would mean storing it in the structure which
would incur an extra load.

> > +	/* Enable clock and interrupts on RC compare */
> > +	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channel));
> > +	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
> > +	       tce.base + ATMEL_TC_CCR(tce.channel));
> > +
> > +	return 0;
> > +}
> > +
> > +static int tc_clkevt2_next_event(unsigned long delta,
> > +				 struct clock_event_device *d)
> > +{
> > +	writel(delta, tce.base + ATMEL_TC_RC(tce.channel));
> > +	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
> > +	       tce.base + ATMEL_TC_CCR(tce.channel));
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t tc_clkevt2_irq(int irq, void *handle)
> > +{
> > +	unsigned int sr;
> > +
> > +	sr = readl(tce.base + ATMEL_TC_SR(tce.channel));
> > +	if (sr & ATMEL_TC_CPCS) {
> > +		tce.clkevt.event_handler(&tce.clkevt);
> > +		return IRQ_HANDLED;
> 
> Isn't an clear irq missing ?
> 

It is cleared on read.

> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +static void tc_clkevt2_suspend(struct clock_event_device *d)
> > +{
> > +	tce.cache.cmr = readl(tce.base + ATMEL_TC_CMR(tce.channel));
> > +	tce.cache.imr = readl(tce.base + ATMEL_TC_IMR(tce.channel));
> > +	tce.cache.rc = readl(tce.base + ATMEL_TC_RC(tce.channel));
> > +	tce.cache.clken = !!(readl(tce.base + ATMEL_TC_SR(tce.channel)) &
> > +				ATMEL_TC_CLKSTA);
> 
> Who is in charge of powering down the timer ?
> 

The platform code stops all the clocks when going to suspend.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
