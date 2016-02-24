From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 24 Feb 2016 09:20:22 -0700
Subject: [PATCH] drivers: perf: arm: implement CPU_PM notifier
In-Reply-To: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CANLsYkzvB0GbPeYHrcLtUz8DMHJh4FA5RVwVZ-UAm3BCznB_3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2016 at 11:22, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> When a CPU is suspended (either through suspend-to-RAM or CPUidle),
> its PMU registers content can be lost, which means that counters
> registers values that were initialized on power down entry have to be
> reprogrammed on power-up to make sure the counters set-up is preserved
> (ie on power-up registers take the reset values on Cold or Warm reset,
> which can be architecturally UNKNOWN).
>
> To guarantee seamless profiling conditions across a core power down
> this patch adds a CPU PM notifier to ARM pmus, that upon CPU PM
> entry/exit from low-power states saves/restores the pmu registers
> set-up (by using the ARM perf API), so that the power-down/up cycle does
> not affect the perf behaviour (apart from a black-out period between
> power-up/down CPU PM notifications that is unavoidable).
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 95 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h |  1 +
>  2 files changed, 96 insertions(+)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 166637f..12317a9 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -13,6 +13,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/of_device.h>
> @@ -710,6 +711,93 @@ static int cpu_pmu_notify(struct notifier_block *b, unsigned long action,
>         return NOTIFY_OK;
>  }
>
> +#ifdef CONFIG_CPU_PM
> +static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
> +{
> +       struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> +       struct perf_event *event;
> +       int idx;
> +
> +       for (idx = 0; idx < armpmu->num_events; idx++) {
> +               /*
> +                * If the counter is not used skip it, there is no
> +                * need of stopping/restarting it.
> +                */
> +               if (!test_bit(idx, hw_events->used_mask))
> +                       continue;
> +
> +               event = hw_events->events[idx];
> +
> +               switch (cmd) {
> +               case CPU_PM_ENTER:
> +                       /*
> +                        * Stop and update the counter
> +                        */
> +                       armpmu_stop(event, PERF_EF_UPDATE);
> +                       break;
> +               case CPU_PM_EXIT:
> +               case CPU_PM_ENTER_FAILED:
> +                        /* Restore and enable the counter */
> +                       armpmu_start(event, PERF_EF_RELOAD);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
> +                            void *v)
> +{
> +       struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
> +       struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
> +       int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
> +
> +       if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> +               return NOTIFY_DONE;
> +
> +       /*
> +        * Always reset the PMU registers on power-up even if
> +        * there are no events running.
> +        */
> +       if (cmd == CPU_PM_EXIT && armpmu->reset)
> +               armpmu->reset(armpmu);

I think this patch does the right thing but I can't get the above
reset.  Wouldn't it be better to do the reset as part of the
CPU_PM_EXIT case below?  At this point nothing tells us the CPU won't
go back down before the event is enabled, wasting the cycle needed to
reset the PMU.

Thanks,
Mathieu

> +
> +       if (!enabled)
> +               return NOTIFY_OK;
> +
> +       switch (cmd) {
> +       case CPU_PM_ENTER:
> +               armpmu->stop(armpmu);
> +               cpu_pm_pmu_setup(armpmu, cmd);
> +               break;
> +       case CPU_PM_EXIT:
> +               cpu_pm_pmu_setup(armpmu, cmd);
> +       case CPU_PM_ENTER_FAILED:
> +               armpmu->start(armpmu);
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static int cpu_pm_pmu_register(struct arm_pmu *cpu_pmu)
> +{
> +       cpu_pmu->cpu_pm_nb.notifier_call = cpu_pm_pmu_notify;
> +       return cpu_pm_register_notifier(&cpu_pmu->cpu_pm_nb);
> +}
> +
> +static void cpu_pm_pmu_unregister(struct arm_pmu *cpu_pmu)
> +{
> +       cpu_pm_unregister_notifier(&cpu_pmu->cpu_pm_nb);
> +}
> +#else
> +static inline int cpu_pm_pmu_register(struct arm_pmu *cpu_pmu) { return 0; }
> +static inline void cpu_pm_pmu_unregister(struct arm_pmu *cpu_pmu) { }
> +#endif
> +
>  static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>  {
>         int err;
> @@ -725,6 +813,10 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>         if (err)
>                 goto out_hw_events;
>
> +       err = cpu_pm_pmu_register(cpu_pmu);
> +       if (err)
> +               goto out_unregister;
> +
>         for_each_possible_cpu(cpu) {
>                 struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
>                 raw_spin_lock_init(&events->pmu_lock);
> @@ -746,6 +838,8 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>
>         return 0;
>
> +out_unregister:
> +       unregister_cpu_notifier(&cpu_pmu->hotplug_nb);
>  out_hw_events:
>         free_percpu(cpu_hw_events);
>         return err;
> @@ -753,6 +847,7 @@ out_hw_events:
>
>  static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  {
> +       cpu_pm_pmu_unregister(cpu_pmu);
>         unregister_cpu_notifier(&cpu_pmu->hotplug_nb);
>         free_percpu(cpu_pmu->hw_events);
>  }
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 83b5e34..9ffa316 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -107,6 +107,7 @@ struct arm_pmu {
>         struct platform_device  *plat_device;
>         struct pmu_hw_events    __percpu *hw_events;
>         struct notifier_block   hotplug_nb;
> +       struct notifier_block   cpu_pm_nb;
>  };
>
>  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> --
> 2.5.1
>
