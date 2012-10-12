From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 12 Oct 2012 15:07:56 +0800
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <5076F5CB.4020200@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
Message-ID: <1350025676.20241.82.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 00:37 +0800, Stephen Warren wrote:
> On 10/11/2012 05:24 AM, Joseph Lo wrote:
> > On Wed, 2012-10-10 at 06:49 +0800, Stephen Warren wrote:
> >> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> >>> The cpuidle LP2 is a power gating idle mode. It support power gating
> >>> vdd_cpu rail after all cpu cores in LP2. For Tegra30, the CPU0 must
> >>> be last one to go into LP2. We need to take care and make sure whole
> >>> secondary CPUs were in LP2 by checking CPU and power gate status.
> >>> After that, the CPU0 can go into LP2 safely. Then power gating the
> >>> CPU rail.
> >>
> >>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
> >>
> >>> +static bool tegra30_idle_enter_lp2_cpu_0(struct cpuidle_device *dev,
> >>> +					 struct cpuidle_driver *drv,
> >>> +					 int index)
> >>> +{
> >>> +	struct cpuidle_state *state = &drv->states[index];
> >>> +	u32 cpu_on_time = state->exit_latency;
> >>> +	u32 cpu_off_time = state->target_residency - state->exit_latency;
> >>> +
> >>> +	if (num_online_cpus() > 1 && !tegra_cpu_rail_off_ready()) {
> >>
> >> Should that be || not &&?
> >>
> >> Isn't the "num_online_cpus() > 1" condition effectively checked at the
> >> call site, i.e. in tegra30_idle_lp2() below via the if (last_cpu) check?
> >>
> > 
> > Should be "&&" here.
> > Because we need to check if there are still multi CPUs online, then we
> > need to make sure all the secondary CPUs be power gated first. After all
> > the secondary CPUs been power gated, the CPU0 could go into LP2 and the
> > CPU rail could be shut off.
> > If all the secondary CPUs been hot plugged, then the "num_online_cpus()
> >> 1" would be always false. Then the CPU0 can go into LP2 directly.
> > 
> > So it was used to check are there multi cpus online or not? It's
> > difference with the last_cpu check below. The last_cpu was used to check
> > all the CPUs were in LP2 process or not. If the CPU0 is the last one
> > went into LP2 process, then it would be true.
> > 
> > So the point here is. We can avoid to check the power status of the
> > secodarys CPUs if they be unplugged.
> 
> OK, so this condition is about ignoring the result of
> tegra_cpu_rail_off_ready() if there is only 1 CPU online. That makes
> sense, since we know in that case there cannot be any other CPUs to
> check if they're in LP2 or not.
> 
> But what about the case where 2 CPUs are online and 2 offline. In that
> case, num_online_cpus() > 1, so the call to tegra_cpu_rail_off_ready()
> is skipped. Yet, with 2 CPUs online, we do need to check whichever other
> CPU is online to see if it's in LP2 or not.
> 
> I think what we need to do is the following:
> 
> cpus_in_lp2_mask = generate_mask_from_pmc_registers();
> if (cpus_in_lp2_mask != cpus_online_mask) {
>     cpu_do_idle();
>     return;
> }
> enter lp2;
> 
> right?
> 

We are not only check the cpu_in_lp2_mask here. The most important thing
here was to check all the other secondary CPUs were already been power
gated. We need to check the physical power status of the CPUs not
logical status.

When there are only 2 CPU online, the "num_online_cpus() > 1" would be
true and the "tegra_cpu_rail_off_ready" still would be checked.

> >>> @@ -85,16 +108,22 @@ static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
> >>>  				      int index)
> >>>  {
> >>>  	bool entered_lp2 = false;
> >>> +	bool last_cpu;
> >>>  
> >>>  	local_fiq_disable();
> >>>  
> >>> +	last_cpu = tegra_set_cpu_in_lp2(dev->cpu);
> >>> +	if (dev->cpu == 0) {
> >>> +		if (last_cpu)
> >>> +			entered_lp2 = tegra30_idle_enter_lp2_cpu_0(dev, drv,
> >>> +								   index);
> >>> +		else
> >>> +			cpu_do_idle();
> >>> +	} else {
> >>>  		entered_lp2 = tegra30_idle_enter_lp2_cpu_n(dev, drv, index);
> >>> +	}
> >>
> >> Hmm. That means that if the last CPU to enter LP2 is e.g. CPU1, then
> >> even though all CPUs are now in LP2, the complex as a whole doesn't
> >> enter LP2. Is there a way to make the cluster as a whole enter LP2 in
> >> this case? Isn't that what coupled cpuidle is for?
> > 
> > It may look like the coupled cpuidle can satisfy the usage here. But it
> > didn't. Please check the criteria of coupled cpuidle. 
> 
> What about the first part of the question. What happens if:
> 
> CPU3 enters LP2
> CPU2 enters LP2
> CPU0 enters LP2
> CPU1 enters LP2
> 
> Since CPU1 is not CPU0, tegra30_idle_enter_lp2_cpu_n() is called, and
> hence I think the whole CPU complex is never rail-gated (just each CPU
> is power-gated) even though all CPUs are in LP2 and the complex could be
> rail-gated. Isn't this missing out on power-savings?

Yes, indeed.
> 
> So, we either need to:
> 
> a) Make tegra30_idle_enter_lp2_cpu_n() rail-gate if the last CPU is
> entering LP2, and then I'm not sure the implementation would be any
> different to tegra30_idle_enter_lp2_cpu_0, would it?
> 
No, we need to make sure the CPU0 is the last one go into LP2 state and
all other CPUs already be power gated. This is the only safe way to shut
off vdd_cpu rail (HW limitation).

> b) If CPUn can't trigger rail-gating, then when CPUn is the last to
> enter LP2 of the whole complex, it needs to IPI to CPU0 to tell it to
> rail-gate, and simply power-gate itself. I believe this IPI interaction
> is exactly what coupled cpuidle is about, isn't it?
> 

Yes, indeed. Actually, I had tried the coupled cpuidle on Tegra20. I
knew it a lot. But I met issues when porting it. It looks like a race
condition and becomes a dead lock caused by IPI missing. Anyway, we can
talk about it more detail when I try to upstream the coupled cpuidle
support for Tegra later.

> > /*
> >  * To use coupled cpuidle states, a cpuidle driver must:
> >  *
> >  *    Set struct cpuidle_device.coupled_cpus to the mask of all
> >  *    coupled cpus, usually the same as cpu_possible_mask if all cpus
> >  *    are part of the same cluster.  The coupled_cpus mask must be
> >  *    set in the struct cpuidle_device for each cpu.
> >  *
> >  *    Set struct cpuidle_device.safe_state to a state that is not a
> >  *    coupled state.  This is usually WFI.
> >  *
> >  *    Set CPUIDLE_FLAG_COUPLED in struct cpuidle_state.flags for each
> >  *    state that affects multiple cpus.
> >  *
> >  *    Provide a struct cpuidle_state.enter function for each state
> >  *    that affects multiple cpus.  This function is guaranteed to be
> >  *    called on all cpus at approximately the same time.  The driver
> >  *    should ensure that the cpus all abort together if any cpu tries
> >  *    to abort once the function is called.  The function should return
> >  *    with interrupts still disabled.
> >  */
> > 
> > The Tegra30 can support the secondary CPUs go into LP2 (power-gate)
> > independently.
> 
> I think that just means that the safe state for CPUn (i.e. not CPU0) can
> do better than WFI on Tegra30, even though it can't on Tegra20.
> 
Yes, I understood.

> > The limitation of the CPU0 is the CPU0 must be the last
> > one to go into LP2 to shut off CPU rail.
> > 
> > It also no need for every CPU to leave LP2 at the same time. The CPU0
> > would be always the first one that woken up from LP2. But all the other
> > secondary CPUs can still keep in LP2. One of the secondary CPUs can also
> > be woken up alone, if the CPU0 already up.
> 
> That seems like an implementation detail. Perhaps coupled cpuidle needs
> to be enhanced to best support Tegra30?
> 
Yes. If the coupled cpuidle could support the CPUs can randomly leave
the coupled state, it would be perfect.

> >>> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> >>
> >>> +static void set_power_timers(unsigned long us_on, unsigned long us_off)
> >>
> >>> +	if (tegra_pclk == NULL) {
> >>> +		tegra_pclk = clk_get_sys(NULL, "pclk");
> >>> +		if (IS_ERR(tegra_pclk)) {
> >>> +			/*
> >>> +			 * pclk not been init or not exist.
> >>> +			 * Use sclk to take the place of it.
> >>> +			 * The default setting was pclk=sclk.
> >>> +			 */
> >>> +			tegra_pclk = clk_get_sys(NULL, "sclk");
> >>> +		}
> >>> +	}
> >>
> >> That's a little odd. Surely the HW has pclk or it doesn't? Why use
> >> different clocks at different times for what is apparently the same thing?
> > 
> > It just because the "pclk" is not available on the Tegra30's clock
> > framework but Tegra20 right now.
> 
> We should just fix that instead of working around it then. I assume it's
> a simple matter of adding the appropriate clock definition?

OK. I will add the "pclk" clock interface for Tegra30.

Thanks,
Joseph
