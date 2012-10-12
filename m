From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 12 Oct 2012 15:11:20 +0800
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <CAMbhsRScnEaEeyqGz6tfYQMHXaZva4UeHtFY4C9Vvu1MrKXPNg@mail.gmail.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
 <CAMbhsRScnEaEeyqGz6tfYQMHXaZva4UeHtFY4C9Vvu1MrKXPNg@mail.gmail.com>
Message-ID: <1350025880.20241.83.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 00:48 +0800, Colin Cross wrote:
> On Thu, Oct 11, 2012 at 9:37 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 10/11/2012 05:24 AM, Joseph Lo wrote:
> >> On Wed, 2012-10-10 at 06:49 +0800, Stephen Warren wrote:
> >>> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> >>>> The cpuidle LP2 is a power gating idle mode. It support power gating
> >>>> vdd_cpu rail after all cpu cores in LP2. For Tegra30, the CPU0 must
> >>>> be last one to go into LP2. We need to take care and make sure whole
> >>>> secondary CPUs were in LP2 by checking CPU and power gate status.
> >>>> After that, the CPU0 can go into LP2 safely. Then power gating the
> >>>> CPU rail.
> 
> <snip>
> 
> >>>> @@ -85,16 +108,22 @@ static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
> >>>>                                   int index)
> >>>>  {
> >>>>     bool entered_lp2 = false;
> >>>> +   bool last_cpu;
> >>>>
> >>>>     local_fiq_disable();
> >>>>
> >>>> +   last_cpu = tegra_set_cpu_in_lp2(dev->cpu);
> >>>> +   if (dev->cpu == 0) {
> >>>> +           if (last_cpu)
> >>>> +                   entered_lp2 = tegra30_idle_enter_lp2_cpu_0(dev, drv,
> >>>> +                                                              index);
> >>>> +           else
> >>>> +                   cpu_do_idle();
> >>>> +   } else {
> >>>>             entered_lp2 = tegra30_idle_enter_lp2_cpu_n(dev, drv, index);
> >>>> +   }
> >>>
> >>> Hmm. That means that if the last CPU to enter LP2 is e.g. CPU1, then
> >>> even though all CPUs are now in LP2, the complex as a whole doesn't
> >>> enter LP2. Is there a way to make the cluster as a whole enter LP2 in
> >>> this case? Isn't that what coupled cpuidle is for?
> >>
> >> It may look like the coupled cpuidle can satisfy the usage here. But it
> >> didn't. Please check the criteria of coupled cpuidle.
> >
> > What about the first part of the question. What happens if:
> >
> > CPU3 enters LP2
> > CPU2 enters LP2
> > CPU0 enters LP2
> > CPU1 enters LP2
> >
> > Since CPU1 is not CPU0, tegra30_idle_enter_lp2_cpu_n() is called, and
> > hence I think the whole CPU complex is never rail-gated (just each CPU
> > is power-gated) even though all CPUs are in LP2 and the complex could be
> > rail-gated. Isn't this missing out on power-savings?
> >
> > So, we either need to:
> >
> > a) Make tegra30_idle_enter_lp2_cpu_n() rail-gate if the last CPU is
> > entering LP2, and then I'm not sure the implementation would be any
> > different to tegra30_idle_enter_lp2_cpu_0, would it?
> >
> > b) If CPUn can't trigger rail-gating, then when CPUn is the last to
> > enter LP2 of the whole complex, it needs to IPI to CPU0 to tell it to
> > rail-gate, and simply power-gate itself. I believe this IPI interaction
> > is exactly what coupled cpuidle is about, isn't it?
> >
> >> /*
> >>  * To use coupled cpuidle states, a cpuidle driver must:
> >>  *
> >>  *    Set struct cpuidle_device.coupled_cpus to the mask of all
> >>  *    coupled cpus, usually the same as cpu_possible_mask if all cpus
> >>  *    are part of the same cluster.  The coupled_cpus mask must be
> >>  *    set in the struct cpuidle_device for each cpu.
> >>  *
> >>  *    Set struct cpuidle_device.safe_state to a state that is not a
> >>  *    coupled state.  This is usually WFI.
> >>  *
> >>  *    Set CPUIDLE_FLAG_COUPLED in struct cpuidle_state.flags for each
> >>  *    state that affects multiple cpus.
> >>  *
> >>  *    Provide a struct cpuidle_state.enter function for each state
> >>  *    that affects multiple cpus.  This function is guaranteed to be
> >>  *    called on all cpus at approximately the same time.  The driver
> >>  *    should ensure that the cpus all abort together if any cpu tries
> >>  *    to abort once the function is called.  The function should return
> >>  *    with interrupts still disabled.
> >>  */
> >>
> >> The Tegra30 can support the secondary CPUs go into LP2 (power-gate)
> >> independently.
> >
> > I think that just means that the safe state for CPUn (i.e. not CPU0) can
> > do better than WFI on Tegra30, even though it can't on Tegra20.
> 
> Exactly.
> 
> >> The limitation of the CPU0 is the CPU0 must be the last
> >> one to go into LP2 to shut off CPU rail.
> >>
> >> It also no need for every CPU to leave LP2 at the same time. The CPU0
> >> would be always the first one that woken up from LP2. But all the other
> >> secondary CPUs can still keep in LP2. One of the secondary CPUs can also
> >> be woken up alone, if the CPU0 already up.
> >
> > That seems like an implementation detail. Perhaps coupled cpuidle needs
> > to be enhanced to best support Tegra30?
> 
> As is, coupled cpuidle will work on Tegra30, but it will unnecessarily
> wake up the secondary cpus during the transitions to off and back on
> again.  Those cpus will immediately go back to single-cpu LP2, so it
> may not be a big deal, but there is a small optimization I've
> discussed with a few other people that could avoid waking them up.  I
> suggest adding an extra pre-idle hook to the Tegra30 that is called by
> coupled cpuidle on the last cpu to go down.  It would return a cpumask
> of cpus that have been prepared for idle by guaranteeing that they
> will not wake up from an interrupt, and therefore don't need to be
> woken up for the transitions.  I haven't worked with a cpu that needs
> this optimization yet, so I haven't done it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
