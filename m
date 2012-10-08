From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 8 Oct 2012 17:35:04 +0100
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for secondary
 CPUs
In-Reply-To: <1349691981-31038-4-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
Message-ID: <20121008163504.GC5377@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 11:26:17AM +0100, Joseph Lo wrote:
> This supports power-gated (LP2) idle on secondary CPUs for Tegra30.
> The secondary CPUs can go into LP2 state independently. When CPU goes
> into LP2 state, it saves it's state and puts itself to flow controlled
> WFI state. After that, it will been power gated.
> 
> Based on the work by:
> Scott Williams <scwilliams@nvidia.com>
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm/mach-tegra/Makefile          |    1 +
>  arch/arm/mach-tegra/cpuidle-tegra30.c |   79 +++++++++++++++++++++++++++++-
>  arch/arm/mach-tegra/pm.c              |   88 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-tegra/pm.h              |   30 +++++++++++
>  arch/arm/mach-tegra/reset.h           |    9 +++
>  arch/arm/mach-tegra/sleep-tegra30.S   |   26 ++++++++++
>  arch/arm/mach-tegra/sleep.S           |   66 ++++++++++++++++++++++++
>  arch/arm/mach-tegra/sleep.h           |    2 +
>  8 files changed, 300 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/pm.c
>  create mode 100644 arch/arm/mach-tegra/pm.h
> 
> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index 9b80c1e..6f224f7 100644
> --- a/arch/arm/mach-tegra/Makefile
> +++ b/arch/arm/mach-tegra/Makefile
> @@ -8,6 +8,7 @@ obj-y                                   += pmc.o
>  obj-y                                  += flowctrl.o
>  obj-y                                  += powergate.o
>  obj-y                                  += apbio.o
> +obj-y                                  += pm.o
>  obj-$(CONFIG_CPU_IDLE)                 += cpuidle.o
>  obj-$(CONFIG_CPU_IDLE)                 += sleep.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
> index 0f85df8..842fef4 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra30.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
> @@ -19,21 +19,94 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/clockchips.h>
> 
>  #include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +
> +#include "pm.h"
> +#include "sleep.h"
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra30_idle_lp2(struct cpuidle_device *dev,
> +                           struct cpuidle_driver *drv,
> +                           int index);
> +#endif
> 
>  static struct cpuidle_driver tegra_idle_driver = {
>         .name = "tegra_idle",
>         .owner = THIS_MODULE,
>         .en_core_tk_irqen = 1,
> -       .state_count = 1,
> +       .state_count = 2,
>         .states = {
>                 [0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> +#ifdef CONFIG_PM_SLEEP
> +               [1] = {
> +                       .enter                  = tegra30_idle_lp2,
> +                       .exit_latency           = 2000,
> +                       .target_residency       = 2200,
> +                       .power_usage            = 0,
> +                       .flags                  = CPUIDLE_FLAG_TIME_VALID,
> +                       .name                   = "LP2",
> +                       .desc                   = "CPU power-gate",
> +               },
> +#endif
>         },
>  };
> 
>  static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
> 
> +#ifdef CONFIG_PM_SLEEP
> +static bool tegra30_idle_enter_lp2_cpu_n(struct cpuidle_device *dev,
> +                                        struct cpuidle_driver *drv,
> +                                        int index)
> +{
> +#ifdef CONFIG_SMP
> +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> +
> +       smp_wmb();
> +
> +       save_cpu_arch_register();
> +
> +       cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> +
> +       restore_cpu_arch_register();
> +
> +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +#endif

Can't you factor out this #ifdef out using an inline function ?

> +
> +       return true;
> +}
> +
> +static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
> +                                     struct cpuidle_driver *drv,
> +                                     int index)
> +{
> +       bool entered_lp2 = false;
> +
> +       local_fiq_disable();
> +
> +       tegra_set_cpu_in_lp2(dev->cpu);
> +       cpu_pm_enter();
> +
> +       if (dev->cpu == 0)

Logical cpu 0 ? Or you need a HW cpu 0 check here ? If you boot on a CPU
that is different from HW CPU 0 (do not know if that's possible) you
might have a problem.

[...]

> +bool __cpuinit tegra_set_cpu_in_lp2(int cpu)
> +{
> +       bool last_cpu = false;
> +
> +       spin_lock(&tegra_lp2_lock);
> +       BUG_ON(cpumask_test_cpu(cpu, &tegra_in_lp2));
> +       cpumask_set_cpu(cpu, &tegra_in_lp2);
> +
> +       /*
> +        * Update the IRAM copy used by the reset handler. The IRAM copy
> +        * can't use used directly by cpumask_set_cpu() because it uses
> +        * LDREX/STREX which requires the addressed location to be inner
> +        * cacheable and sharable which IRAM isn't.
> +        */
> +       writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> +       dsb();
> +
> +       if ((cpu == 0) && cpumask_equal(&tegra_in_lp2, cpu_online_mask))
> +               last_cpu = true;

For cpu == 0, see above.

[...]

> +ENTRY(tegra_flush_l1_cache)
> +       stmfd   sp!, {r4-r5, r7, r9-r11, lr}
> +       dmb                                     @ ensure ordering
> +
> +       /* Disable the data cache */
> +       mrc     p15, 0, r2, c1, c0, 0
> +       bic     r2, r2, #CR_C
> +       dsb
> +       mcr     p15, 0, r2, c1, c0, 0
> +
> +       /* Flush data cache */
> +       mov     r10, #0
> +#ifdef CONFIG_PREEMPT
> +       save_and_disable_irqs_notrace r9        @ make cssr&csidr read atomic
> +#endif
> +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr
> +       isb                                     @ isb to sych the new cssr&csidr
> +       mrc     p15, 1, r1, c0, c0, 0           @ read the new csidr
> +#ifdef CONFIG_PREEMPT
> +       restore_irqs_notrace r9
> +#endif
> +       and     r2, r1, #7                      @ extract the length of the cache lines
> +       add     r2, r2, #4                      @ add 4 (line length offset)
> +       ldr     r4, =0x3ff
> +       ands    r4, r4, r1, lsr #3              @ find maximum number on the way size
> +       clz     r5, r4                          @ find bit position of way size increment
> +       ldr     r7, =0x7fff
> +       ands    r7, r7, r1, lsr #13             @ extract max number of the index size
> +loop2:
> +       mov     r9, r4                          @ create working copy of max way size
> +loop3:
> +       orr     r11, r10, r9, lsl r5            @ factor way and cache number into r11
> +       orr     r11, r11, r7, lsl r2            @ factor index number into r11
> +       mcr     p15, 0, r11, c7, c14, 2         @ clean & invalidate by set/way
> +       subs    r9, r9, #1                      @ decrement the way
> +       bge     loop3
> +       subs    r7, r7, #1                      @ decrement the index
> +       bge     loop2
> +finished:
> +       mov     r10, #0                         @ swith back to cache level 0
> +       mcr     p15, 2, r10, c0, c0, 0          @ select current cache level in cssr
> +       dsb
> +       isb

This code is already in the kernel in cache-v7.S, please use that.
We are just adding the new LoUIS API that probably does what you
want, even though for Tegra, that is an A9 based platform I fail to
understand why Level of Coherency differs from L1.

Can you explain to me please why Level of Coherency (LoC) is != from L1
on Tegra ?

Thanks,
Lorenzo
