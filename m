From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Dec 2012 11:09:41 +0000
Subject: [PATCH 06/10] arm: arch_timer: divorce from local_timer api
In-Reply-To: <50C26ACA.4050509@codeaurora.org>
References: <1354297568-26366-1-git-send-email-mark.rutland@arm.com>
 <1354297568-26366-7-git-send-email-mark.rutland@arm.com>
 <50C26ACA.4050509@codeaurora.org>
Message-ID: <20121210110754.GA18328@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 10:16:42PM +0000, Stephen Boyd wrote:
> On 11/30/12 09:46, Mark Rutland wrote:
> > Currently, the arch_timer driver is tied to the arm port, as it relies
> > on code in arch/arm/smp.c to setup and teardown timers as cores are
> > hotplugged on and off. The timer is registered through an arm-specific
> > registration mechanism, preventing sharing the driver with the arm64
> > port.
> >
> > This patch moves the driver to using a cpu notifier instead, making it
> > easier to port.
> 
> How does ipi_timer() work after this change? Don't we need it because of
> FEAT_C3_STOP?

The unfortunate answer is it doesn't, and we'll need broadcast for any systems
where the timers turn off in low power states.

I'll take a look at decoupling the broadcast mechanism from the drivers, it's
not really a property of the clock hardware and it would be nice to split it.

> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> [snip]
> > @@ -245,12 +244,28 @@ static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
> >  	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
> >  }
> >  
> > -static struct local_timer_ops arch_timer_ops __cpuinitdata = {
> > -	.setup	= arch_timer_setup,
> > -	.stop	= arch_timer_stop,
> > -};
> > +static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
> > +					   unsigned long action, void *hcpu)
> > +{
> > +	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
> > +
> > +	switch (action) {
> > +	case CPU_STARTING:
> > +	case CPU_STARTING_FROZEN:
> > +		arch_timer_setup(evt);
> > +		break;
> > +	case CPU_DYING:
> > +	case CPU_DYING_FROZEN:
> > +		arch_timer_stop(evt);
> > +		break;
> > +	}
> 
> You can save 2 lines with a switch (action & ~CPU_TASKS_FROZEN) here.

Sure. I'll fold that in.

> > +
> > +	return NOTIFY_OK;
> > +}
> >  
> > -static struct clock_event_device arch_timer_global_evt;
> > +static struct notifier_block __cpuinitdata arch_timer_cpu_nb = {
> 
> __cpuinitdata goes last before the equals sign.

I'll fix that up.

> > +	.notifier_call = arch_timer_cpu_notify,
> > +};
> >  
> >  static int __init arch_timer_register(void)
> >  {
> >
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 

Thanks,
Mark.
