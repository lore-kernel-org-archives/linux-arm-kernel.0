From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 15:53:58 +0000
Subject: [PATCH V2] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <1294107527-27915-1-git-send-email-kgene.kim@samsung.com>
References: <1294107527-27915-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110106155358.GH31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 11:18:47AM +0900, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> The Multi-Core Timer(MCT) of S5PV310 is designed for implementing
> clock source timer and clock event timers. This patch implements
> 1 clock source timer with 64 bit free running counter of MCT and
> 2 clock event timers with two of 31-bit tick counters.

I want to wait until after this merge window before commenting too much
on this; some of this patch will be impacted by changes in this merge
window.

> +static void s5pv310_frc_suspend(struct clocksource *cs)
> +{
> +	time_suspended = s5pv310_frc_read(cs);
> +};
> +
> +static void s5pv310_frc_resume(struct clocksource *cs)
> +{
> +	s5pv310_mct_frc_start((u32)(time_suspended >> 32), (u32)time_suspended);
> +};

Is this something which other clocksource drivers need to do, or does the
core automatically deal with the clocksource being irregular across a
suspend/resume event?

> +irqreturn_t s5pv310_mct_tick0_isr(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	/*
> +	 * This is for supporting oneshot mode.
> +	 * Mct would generate interrupt periodically
> +	 * without explicit stopping.
> +	 */
> +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> +		s5pv310_mct_tick_stop(MCT_TICK0);
> +
> +	/* Clear the MCT tick0 interrupt */
> +	s5pv310_mct_write(0x1, S5PV310_MCT_L0_INT_CSTAT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t s5pv310_mct_tick1_isr(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	/*
> +	 * This is for supporting oneshot mode.
> +	 * Mct would generate interrupt periodically
> +	 * without explicit stopping.
> +	 */
> +	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> +		s5pv310_mct_tick_stop(MCT_TICK1);
> +
> +	/* Clear the MCT tick1 interrupt */
> +	s5pv310_mct_write(0x1, S5PV310_MCT_L1_INT_CSTAT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}

Umm, why not wrap up the clock_event_device into your own structure,
which then carries the base address of the MCT to be used - rather than
duplicating the code just because the base address is different.  Eg,

struct mct_clock_event_device {
	struct clock_event_device evt;
	void __iomem *base;
};
