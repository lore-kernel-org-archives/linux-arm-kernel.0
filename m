From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Feb 2016 17:35:11 +0000
Subject: [PATCH] drivers: perf: arm: implement CPU_PM notifier
In-Reply-To: <CANLsYkzvB0GbPeYHrcLtUz8DMHJh4FA5RVwVZ-UAm3BCznB_3w@mail.gmail.com>
References: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CANLsYkzvB0GbPeYHrcLtUz8DMHJh4FA5RVwVZ-UAm3BCznB_3w@mail.gmail.com>
Message-ID: <20160224173511.GF25385@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 09:20:22AM -0700, Mathieu Poirier wrote:
> On 23 February 2016 at 11:22, Lorenzo Pieralisi

[...]

> > +static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
> > +                            void *v)
> > +{
> > +       struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
> > +       struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> > +       int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> > +
> > +       if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> > +               return NOTIFY_DONE;
> > +
> > +       /*
> > +        * Always reset the PMU registers on power-up even if
> > +        * there are no events running.
> > +        */
> > +       if (cmd == CPU_PM_EXIT && armpmu->reset)
> > +               armpmu->reset(armpmu);
> 
> I think this patch does the right thing but I can't get the above
> reset.  Wouldn't it be better to do the reset as part of the
> CPU_PM_EXIT case below?  At this point nothing tells us the CPU won't
> go back down before the event is enabled, wasting the cycle needed to
> reset the PMU.

The logic goes, if the cpu is woken up and it has no events enabled,
if we do not reset it (mind, ->reset here sets the PMU register values
to a sane default, some of them are architecturally UNKNOWN on reset, it
does NOT reset the PMU) _and_ we subsequently install an event on it we
do have a problem, that's why whenever a core gets out of low-power we
have to reset its pmu.

Does it make sense ?

Thanks,
Lorenzo

> 
> Thanks,
> Mathieu
> 
> > +
> > +       if (!enabled)
> > +               return NOTIFY_OK;
> > +
> > +       switch (cmd) {
> > +       case CPU_PM_ENTER:
> > +               armpmu->stop(armpmu);
> > +               cpu_pm_pmu_setup(armpmu, cmd);
> > +               break;
> > +       case CPU_PM_EXIT:
> > +               cpu_pm_pmu_setup(armpmu, cmd);
> > +       case CPU_PM_ENTER_FAILED:
> > +               armpmu->start(armpmu);
> > +               break;
> > +       default:
> > +               return NOTIFY_DONE;
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> > +static int cpu_pm_pmu_register(struct arm_pmu *cpu_pmu)
> > +{
> > +       cpu_pmu->cpu_pm_nb.notifier_call = cpu_pm_pmu_notify;
> > +       return cpu_pm_register_notifier(&cpu_pmu->cpu_pm_nb);
> > +}
> > +
> > +static void cpu_pm_pmu_unregister(struct arm_pmu *cpu_pmu)
> > +{
> > +       cpu_pm_unregister_notifier(&cpu_pmu->cpu_pm_nb);
> > +}
> > +#else
> > +static inline int cpu_pm_pmu_register(struct arm_pmu *cpu_pmu) { return 0; }
> > +static inline void cpu_pm_pmu_unregister(struct arm_pmu *cpu_pmu) { }
> > +#endif
> > +
> >  static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
> >  {
> >         int err;
> > @@ -725,6 +813,10 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
> >         if (err)
> >                 goto out_hw_events;
> >
> > +       err = cpu_pm_pmu_register(cpu_pmu);
> > +       if (err)
> > +               goto out_unregister;
> > +
> >         for_each_possible_cpu(cpu) {
> >                 struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
> >                 raw_spin_lock_init(&events->pmu_lock);
> > @@ -746,6 +838,8 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
> >
> >         return 0;
> >
> > +out_unregister:
> > +       unregister_cpu_notifier(&cpu_pmu->hotplug_nb);
> >  out_hw_events:
> >         free_percpu(cpu_hw_events);
> >         return err;
> > @@ -753,6 +847,7 @@ out_hw_events:
> >
> >  static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
> >  {
> > +       cpu_pm_pmu_unregister(cpu_pmu);
> >         unregister_cpu_notifier(&cpu_pmu->hotplug_nb);
> >         free_percpu(cpu_pmu->hw_events);
> >  }
> > diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> > index 83b5e34..9ffa316 100644
> > --- a/include/linux/perf/arm_pmu.h
> > +++ b/include/linux/perf/arm_pmu.h
> > @@ -107,6 +107,7 @@ struct arm_pmu {
> >         struct platform_device  *plat_device;
> >         struct pmu_hw_events    __percpu *hw_events;
> >         struct notifier_block   hotplug_nb;
> > +       struct notifier_block   cpu_pm_nb;
> >  };
> >
> >  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> > --
> > 2.5.1
> >
> 
