From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Oct 2013 10:21:50 +0100
Subject: [PATCH] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <CAPrCYkc-ocBi6B6MP23gHqsovgQovvEWSv=khstS4wbD2dXzjw@mail.gmail.com>
References: <1381733189-2745-1-git-send-email-vkale@apm.com>
 <20131014123436.GA10491@mudshark.cambridge.arm.com>
 <CAPrCYkc-ocBi6B6MP23gHqsovgQovvEWSv=khstS4wbD2dXzjw@mail.gmail.com>
Message-ID: <20131015092149.GA30046@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 07:33:25AM +0100, Vinayak Kale wrote:
> On Mon, Oct 14, 2013 at 6:04 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Oct 14, 2013 at 07:46:29AM +0100, Vinayak Kale wrote:
> >>               if (err) {
> >>                       pr_err("unable to request IRQ%d for ARM PMU counters\n",
> >> -                             irq);
> >> +                                     irq);
> >>                       armpmu_release_hardware(armpmu);
> >>                       return err;
> >>               }
> >>
> >> -             cpumask_set_cpu(i, &armpmu->active_irqs);
> >> +             on_each_cpu(armpmu_enable_percpu_irq, (void *)armpmu, 1);
> >> +     } else {
> >> +             for (i = 0; i < irqs; ++i) {
> >> +                     err = 0;
> >> +                     irq = platform_get_irq(pmu_device, i);
> >> +                     if (irq < 0)
> >> +                             continue;
> >> +
> >> +                     /*
> >> +                      * If we have a single PMU interrupt that we can't shift,
> >> +                      * assume that we're running on a uniprocessor machine and
> >> +                      * continue. Otherwise, continue without this interrupt.
> >> +                      */
> >> +                     if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
> >> +                             pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
> >> +                                             irq, i);
> >> +                             continue;
> >> +                     }
> >> +
> >> +                     err = request_irq(irq, armpmu->handle_irq,
> >> +                                     IRQF_NOBALANCING,
> >> +                                     "arm-pmu", armpmu);
> >
> > A better way to do this is to try request_percpu_irq first. If that fails,
> > then try request_irq. However, the error reporting out of request_percpu_irq
> > could do with some cleanup (rather than just return -EINVAL) so we can
> > detect the difference between `this interrupt isn't per-cpu' and `this
> > per-cpu interrupt is invalid'. This can help us avoid the WARN_ON in
> > request_irq when it is passed a per-cpu interrupt.
> >
> 
> Trying request_percpu_irq first seems better. But if it fails then we
> would straight away
> assume it's not per-cpu interrupt and try request_irq. In this case we
> may not be able to
> detect 'this per-cpu interrupt is invalid' case.

Right, but you could have a patch to fix the core code as part of this
series, as I hinted at above.

> >> @@ -784,8 +832,8 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
> >>  /*
> >>   * PMXEVTYPER: Event selection reg
> >>   */
> >> -#define      ARMV8_EVTYPE_MASK       0xc80000ff      /* Mask for writable bits */
> >> -#define      ARMV8_EVTYPE_EVENT      0xff            /* Mask for EVENT bits */
> >> +#define      ARMV8_EVTYPE_MASK       0xc80003ff      /* Mask for writable bits */
> >> +#define      ARMV8_EVTYPE_EVENT      0x3ff           /* Mask for EVENT bits */
> >>
> >>  /*
> >>   * Event filters for PMUv3
> >> @@ -1175,7 +1223,7 @@ static void armv8pmu_reset(void *info)
> >>  static int armv8_pmuv3_map_event(struct perf_event *event)
> >>  {
> >>       return map_cpu_event(event, &armv8_pmuv3_perf_map,
> >> -                             &armv8_pmuv3_perf_cache_map, 0xFF);
> >> +                             &armv8_pmuv3_perf_cache_map, 0x3FF);
> >>  }
> >
> > What's all this?
> >
> 
> The evtCount (event number) field width is 10bits in event selection register.
> So need to fix ARMV8_EVTYPE_* macros and related mask value.
> 
> From the subject of patch, one may think that the patch is specific
> only to percpu irq changes (which is not true).
> 
> I had mentioned about fixing ARMV8_EVTYPE_* macros in patch description.

Ok, please put this change in a separate patch.

Will
