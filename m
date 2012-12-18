From: ccross@android.com (Colin Cross)
Date: Mon, 17 Dec 2012 18:46:26 -0800
Subject: [PATCH V3 2/5] ARM: tegra20: cpuidle: add powered-down state for
 secondary CPU
In-Reply-To: <1355797861-12759-3-git-send-email-josephl@nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-3-git-send-email-josephl@nvidia.com>
Message-ID: <CAMbhsRTLo6jS_7hqVVtgaa8_ZweAwicrgghaaFWfnzHpc6f1Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 6:30 PM, Joseph Lo <josephl@nvidia.com> wrote:
> The powered-down state of Tegra20 requires power gating both CPU cores.
> When the secondary CPU requests to enter powered-down state, it saves
> its own contexts and then enters WFI. The Tegra20 had a limition to
> power down both CPU cores. The secondary CPU must waits for CPU0 in
> powered-down state too. If the secondary CPU be woken up before CPU0
> entering powered-down state, then it needs to restore its CPU states
> and waits for next chance.
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
> V3:
> * dynamic checking of the number of the state counts
> * fix the code sequence for aborting cpu_suspend in
>   tegra20_sleep_cpu_secondary_finish
> V2:
> * no change
> ---
>  arch/arm/mach-tegra/cpuidle-tegra20.c |   94 ++++++++++++++++++++-
>  arch/arm/mach-tegra/pm.c              |    2 +
>  arch/arm/mach-tegra/sleep-tegra20.S   |  147 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-tegra/sleep.h           |   23 +++++
>  4 files changed, 261 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> index d32e8b0..716aef3 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> @@ -22,28 +22,112 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/clockchips.h>
>
>  #include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +#include <asm/smp_plat.h>
> +
> +#include "pm.h"
> +#include "sleep.h"
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra20_idle_lp2(struct cpuidle_device *dev,
> +                           struct cpuidle_driver *drv,
> +                           int index);
> +#endif
> +
> +static struct cpuidle_state tegra_idle_states[] = {
> +       [0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> +#ifdef CONFIG_PM_SLEEP
> +       [1] = {
> +               .enter                  = tegra20_idle_lp2,
> +               .exit_latency           = 5000,
> +               .target_residency       = 10000,
> +               .power_usage            = 0,
> +               .flags                  = CPUIDLE_FLAG_TIME_VALID,
> +               .name                   = "powered-down",
> +               .desc                   = "CPU power gated",
> +       },
> +#endif
> +};
>
>  static struct cpuidle_driver tegra_idle_driver = {
>         .name = "tegra_idle",
>         .owner = THIS_MODULE,
>         .en_core_tk_irqen = 1,
> -       .state_count = 1,
> -       .states = {
> -               [0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> -       },
>  };
>
>  static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
>
> +#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_SMP
> +static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
> +                                        struct cpuidle_driver *drv,
> +                                        int index)
> +{
> +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> +
> +       cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
> +
> +       tegra20_cpu_clear_resettable();
> +
> +       clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +
> +       return true;
> +}
> +#else
> +static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
> +                                               struct cpuidle_driver *drv,
> +                                               int index)
> +{
> +       return true;
> +}
> +#endif
> +
> +static int __cpuinit tegra20_idle_lp2(struct cpuidle_device *dev,
> +                                     struct cpuidle_driver *drv,
> +                                     int index)
> +{
> +       u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
> +       bool entered_lp2 = false;
> +
> +       local_fiq_disable();
> +
> +       tegra_set_cpu_in_lp2(cpu);
> +       cpu_pm_enter();

You must check the return value from cpu_pm_enter and synchronize and
abort both cpus.

> +
> +       if (cpu == 0)
> +               cpu_do_idle();
> +       else
> +               entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
> +
> +       cpu_pm_exit();
> +       tegra_clear_cpu_in_lp2(cpu);
> +
> +       local_fiq_enable();
> +
> +       smp_rmb();
> +
> +       return entered_lp2 ? index : 0;
> +}
> +#endif
> +
>  int __init tegra20_cpuidle_init(void)
>  {
> -       int ret;
> +       int ret, i;
>         unsigned int cpu;
>         struct cpuidle_device *dev;
>         struct cpuidle_driver *drv = &tegra_idle_driver;
>
> +       drv->state_count = sizeof(tegra_idle_states) /
> +                          sizeof(struct cpuidle_state);
> +       for (i = 0; i < drv->state_count; i++)
> +               memcpy(&drv->states[i], &tegra_idle_states[i],
> +                      sizeof(struct cpuidle_state));
> +
>         ret = cpuidle_register_driver(&tegra_idle_driver);
>         if (ret) {
>                 pr_err("CPUidle driver registration failed\n");

Is there a call to cpu_cluster_pm_enter/exit somewhere else?
