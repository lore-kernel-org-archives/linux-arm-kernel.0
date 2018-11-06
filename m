From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 17:25:15 +0000
Subject: [PATCH] arm/twd: avoid waking deeply sleeping CPUs for rate
 change notifier
In-Reply-To: <1540812888.2582.4.camel@pengutronix.de>
References: <20180417104627.29643-1-l.stach@pengutronix.de>
 <1528733761.2842.8.camel@pengutronix.de>
 <1540812888.2582.4.camel@pengutronix.de>
Message-ID: <20181106172514.GM30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 12:34:48PM +0100, Lucas Stach wrote:
> Hi again,
> 
> Am Montag, den 11.06.2018, 18:16 +0200 schrieb Lucas Stach:
> > Hi all,
> > 
> > Am Dienstag, den 17.04.2018, 12:46 +0200 schrieb Lucas Stach:
> > > The current clock notifier sends an IPI to all CPUs, even if they are in
> > > deep sleep state with the local timer disabled and switched to tick
> > > broadcast. This needlessly cuts the CPU sleep times, as nothing is gained
> > > from updating a disabled TWDs rate.
> > > 
> > > Keep track of the enabled TWDs and only send an IPI to those CPUs with an
> > > active local timer. As disabled TWDs may now miss a CPU frequency update
> > > we need to make sure to refresh the rate on re-enabling of the timer.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > I would appreciate some feedback to this patch.
> > FWIW, I've been running some systems with this patch applied for quite
> > some time now with no issues spotted so far.
> 
> Can I persuade anyone to take a look at this?
> It's been some months since I've posted this and haven't got any
> feedback so far. I'm running this patch on a bunch of devices ever
> since posting it and could not spot any adverse effects.

This, quite simply, needs review by kernel/time people, especially
given the potential recursion setup by adding calls to
clockevents_update_freq() from within methods that this function
_may_ call.

For example, if the current state is shutdown, and
clockevents_switch_state() is called to set periodic mode,
__clockevents_switch_state() will be called to set periodic mode.
The current mode will be shutdown.  We'll call twd_set_periodic(),
which will then call into clockevents_update_freq().

If tick_broadcast_update_freq() returns -ENODEV (I don't know
under what situation that occurs), then we'll call
__clockevents_update_freq().  This currently will avoid calling
__clockevents_switch_state() but only because the current mode
is not marked as periodic yet.

If that changes (either by marking it periodic earlier, or
__clockevents_update_freq() changes), then we get a situation
where we'll call back into twd_set_periodic().

Then there's the ordering issues - what if we're switching to
one-shot mode, does this mean we could get something like:

	- set one-shot mode
		- clockevents_update_freq
		- set next event
	- set stale next event

So, I can't review this patch without spending a lot of time reading
and understanding the kernel/time code.  It would be way better if
someone who does understand that code (iow, a maintainer of that
code) looked at this patch.

> > > ---
> > > ?arch/arm/kernel/smp_twd.c | 31 +++++++++++++++++++++++++++++--
> > > ?1 file changed, 29 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> > > index b30eafeef096..a3be30d30cc2 100644
> > > --- a/arch/arm/kernel/smp_twd.c
> > > +++ b/arch/arm/kernel/smp_twd.c
> > > @@ -32,6 +32,8 @@ static struct clk *twd_clk;
> > > ?static unsigned long twd_timer_rate;
> > > ?static DEFINE_PER_CPU(bool, percpu_setup_called);
> > > ?
> > > +static cpumask_var_t active_twd_mask;
> > > +
> > > ?static struct clock_event_device __percpu *twd_evt;
> > > ?static unsigned int twd_features =
> > > > ?		CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> > > 
> > > @@ -39,12 +41,24 @@ static int twd_ppi;
> > > ?
> > > ?static int twd_shutdown(struct clock_event_device *clk)
> > > ?{
> > > > +	cpumask_clear_cpu(smp_processor_id(), active_twd_mask);
> > > 
> > > +
> > > > > > > ?	writel_relaxed(0, twd_base + TWD_TIMER_CONTROL);
> > > > ?	return 0;
> > > 
> > > ?}
> > > ?
> > > ?static int twd_set_oneshot(struct clock_event_device *clk)
> > > ?{
> > > > +	cpumask_set_cpu(smp_processor_id(), active_twd_mask);
> > > 
> > > +
> > > > > > > +	/*
> > > > > > > +	?* When going from shutdown to oneshot we might have missed some
> > > > > > > +	?* frequency updates if the CPU was sleeping. Make sure to update
> > > > > > > +	?* the timer frequency with the current rate.
> > > > > > > +	?*/
> > > > > > > +	if (clockevent_state_shutdown(clk))
> > > > +		clockevents_update_freq(clk, twd_timer_rate);
> > > 
> > > +
> > > > > > > ?	/* period set, and timer enabled in 'next_event' hook */
> > > > > > > ?	writel_relaxed(TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT,
> > > > ?		???????twd_base + TWD_TIMER_CONTROL);
> > > 
> > > @@ -57,6 +71,16 @@ static int twd_set_periodic(struct clock_event_device *clk)
> > > > > > > ?			?????TWD_TIMER_CONTROL_IT_ENABLE |
> > > > ?			?????TWD_TIMER_CONTROL_PERIODIC;
> > > 
> > > ?
> > > > +	cpumask_set_cpu(smp_processor_id(), active_twd_mask);
> > > 
> > > +
> > > > > > > +	/*
> > > > > > > +	?* When going from shutdown to periodic we might have missed some
> > > > > > > +	?* frequency updates if the CPU was sleeping. Make sure to update
> > > > > > > +	?* the timer frequency with the current rate.
> > > > > > > +	?*/
> > > > > > > +	if (clockevent_state_shutdown(clk))
> > > > +		clockevents_update_freq(clk, twd_timer_rate);
> > > 
> > > +
> > > > > > > ?	writel_relaxed(DIV_ROUND_CLOSEST(twd_timer_rate, HZ),
> > > > > > > ?		???????twd_base + TWD_TIMER_LOAD);
> > > > ?	writel_relaxed(ctrl, twd_base + TWD_TIMER_CONTROL);
> > > 
> > > @@ -124,8 +148,8 @@ static int twd_rate_change(struct notifier_block *nb,
> > > > > > > ?	?* changing cpu.
> > > > > > > ?	?*/
> > > > > > > ?	if (flags == POST_RATE_CHANGE)
> > > > > > > -		on_each_cpu(twd_update_frequency,
> > > > > > > -				??(void *)&cnd->new_rate, 1);
> > > > > > > +		on_each_cpu_mask(active_twd_mask, twd_update_frequency,
> > > > +				?(void *)&cnd->new_rate, 1);
> > > 
> > > ?
> > > > ?	return NOTIFY_OK;
> > > 
> > > ?}
> > > @@ -326,6 +350,9 @@ static int __init twd_local_timer_common_register(struct device_node *np)
> > > ?{
> > > > ?	int err;
> > > 
> > > ?
> > > > > > > +	if (!zalloc_cpumask_var(&active_twd_mask, GFP_KERNEL))
> > > > +		return -ENOMEM;
> > > 
> > > +
> > > > > > > ?	twd_evt = alloc_percpu(struct clock_event_device);
> > > > > > > ?	if (!twd_evt) {
> > > > ?		err = -ENOMEM;
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
