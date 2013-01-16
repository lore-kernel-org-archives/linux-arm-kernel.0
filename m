From: ccross@android.com (Colin Cross)
Date: Wed, 16 Jan 2013 10:55:36 -0800
Subject: [PATCH V4 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <1358323873-30525-1-git-send-email-josephl@nvidia.com>
References: <1358323873-30525-1-git-send-email-josephl@nvidia.com>
Message-ID: <CAMbhsRTmGVrjnKa_z+zonGypU+U4r2iE=D-Zfvyoq8chY68QKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 12:11 AM, Joseph Lo <josephl@nvidia.com> wrote:
> The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
> core to go into this mode before other core. The coupled cpuidle framework
> can help to sync the MPCore to coupled state then go into "powered-down"
> idle mode together. The driver can just assume the MPCore come into
> "powered-down" mode at the same time. No need to take care if the CPU_0
> goes into this mode along and only can put it into safe idle mode (WFI).
>
> The powered-down state of Tegra20 requires power gating both CPU cores.
> When the secondary CPU requests to enter powered-down state, it saves
> its own contexts and then enters WFI for waiting CPU0 in the same state.
> When the CPU0 requests powered-down state, it attempts to put the secondary
> CPU into reset to prevent it from waking up. Then power down both CPUs
> together and power off the cpu rail.
>
> Be aware of that, you may see the legacy power state "LP2" in the code
> which is exactly the same meaning of "CPU power down".
>
> Based on the work by:
> Colin Cross <ccross@android.com>
> Gary King <gking@nvidia.com>
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> V4:
> * rename the function to "tegra20_wake_cpu1_from_reset"
> * make the coupled cpuidle can be disabled if SMP is disabled
> V3:
> * sqash last two patch in previous version to support coupled cpuidle
>   directly
> V2:
> * refine the cpu control function that dedicate for CPU_1
> * rename "tegra_cpu_pllp" to "tegra_switch_cpu_to_pllp"
> ---

<snip>

> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> index 50f984d..63ab9c2 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c

<snip>

> @@ -87,20 +176,31 @@ static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
>  }
>  #endif
>
> -static int tegra20_idle_lp2(struct cpuidle_device *dev,
> -                           struct cpuidle_driver *drv,
> -                           int index)
> +static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
> +                                   struct cpuidle_driver *drv,
> +                                   int index)
>  {
>         u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
>         bool entered_lp2 = false;
>
> +       if (tegra_pending_sgi())
> +               atomic_inc(&abort_flag);
Minor nit, this doesn't need to be atomic.  You could just use
abort_flag = true, or ACCESS_ONCE(abort_flag) = true.  Each cpu will
either not touch this variable or write 1 to it, so there is no
read/modify/write race.

> +
> +       cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
> +
> +       if (atomic_read(&abort_flag) > 0) {
> +               cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
> +               atomic_set(&abort_flag, 0);     /* clean flag for next coming */
> +               return -EINTR;
> +       }
> +
>         local_fiq_disable();
>
>         tegra_set_cpu_in_lp2(cpu);
>         cpu_pm_enter();
>
>         if (cpu == 0)
> -               cpu_do_idle();
> +               entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
>         else
>                 entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
>
> @@ -122,6 +222,10 @@ int __init tegra20_cpuidle_init(void)
>         struct cpuidle_device *dev;
>         struct cpuidle_driver *drv = &tegra_idle_driver;
>
> +#ifdef CONFIG_PM_SLEEP
> +       tegra_tear_down_cpu = tegra20_tear_down_cpu;
> +#endif
> +
>         drv->state_count = ARRAY_SIZE(tegra_idle_states);
>         memcpy(drv->states, tegra_idle_states,
>                         drv->state_count * sizeof(drv->states[0]));
> @@ -135,6 +239,9 @@ int __init tegra20_cpuidle_init(void)
>         for_each_possible_cpu(cpu) {
>                 dev = &per_cpu(tegra_idle_device, cpu);
>                 dev->cpu = cpu;
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +               dev->coupled_cpus = *cpu_online_mask;
I think this should be cpu_possible_mask instead of cpu_online_mask.
coupled.c already makes sure that only online cpus are considered by
the synchronization code.  If cpuidle were compiled as a module and
loaded after offlining a cpu, you would hit the WARN_ON in
cpuidle_coupled_register_device when onlining a cpu.

> +#endif
>
>                 dev->state_count = drv->state_count;
>                 ret = cpuidle_register_device(dev);
