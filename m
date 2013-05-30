From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 30 May 2013 16:35:41 +0200
Subject: [PATCH 3/3] ARM: tegra114: cpuidle: add powered-down state
In-Reply-To: <1369912782-30663-4-git-send-email-josephl@nvidia.com>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com>
 <1369912782-30663-4-git-send-email-josephl@nvidia.com>
Message-ID: <51A763BD.6070001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2013 01:19 PM, Joseph Lo wrote:
> This supports CPU core power down on each CPU when CPU idle. When CPU go
> into this state, it saves it's context and needs a proper configuration
> in flow controller to power gate the CPU when CPU runs into WFI
> instruction. And the CPU also needs to set the IRQ as CPU power down idle
> wake up event in flow controller.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---

Hi Joseph,

a new flag has been added in the cpuidle framework to let this one to
handle the timer broadcast : CPUIDLE_FLAG_TIMER_STOP

It is the commit b60e6a0eb0273132cbb60a9806abf5f47a4aee1c

You can get rid of the clockevent notify stuff by adding this flag to
the state.

Also, can you clarify why tegra3 code is used in tegra114 ?


>  arch/arm/mach-tegra/cpuidle-tegra114.c | 62 +++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
> index 1d1c602..e7d21f5 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
> @@ -17,19 +17,79 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/clockchips.h>
>  
>  #include <asm/cpuidle.h>
> +#include <asm/suspend.h>
> +#include <asm/smp_plat.h>
> +
> +#include "pm.h"
> +#include "sleep.h"
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra114_idle_power_down(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv,
> +				    int index);

Isn't possible to move the driver declaration after the
tegra114_idle_power_down function, before the init function, so we
prevent a forward declaration ?

> +#define TEGRA114_MAX_STATES 2
> +#else
> +#define TEGRA114_MAX_STATES 1
> +#endif
>  
>  static struct cpuidle_driver tegra_idle_driver = {
>  	.name = "tegra_idle",
>  	.owner = THIS_MODULE,
> -	.state_count = 1,
> +	.state_count = TEGRA114_MAX_STATES,
>  	.states = {
>  		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> +#ifdef CONFIG_PM_SLEEP
> +		[1] = {
> +			.enter			= tegra114_idle_power_down,
> +			.exit_latency		= 500,
> +			.target_residency	= 1000,
> +			.power_usage		= 0,
> +			.flags			= CPUIDLE_FLAG_TIME_VALID,
> +			.name			= "powered-down",
> +			.desc			= "CPU power gated",
> +		},
> +#endif
>  	},
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int tegra114_idle_power_down(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv,
> +				    int index)
> +{
> +	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;

IMO, it is up to the tegra_set_cpu_in_lp2 / tegra_clear_cpu_in_lp2
functions to do the cpu map conversion instead of adding this into a
routine working with logical cpu.

> +	local_fiq_disable();
> +
> +	tegra_set_cpu_in_lp2(cpu);
> +	cpu_pm_enter();
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> +	smp_wmb();

Why do you need a memory barrier here ?

> +	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +
> +	cpu_pm_exit();
> +	tegra_clear_cpu_in_lp2(cpu);
> +
> +	local_fiq_enable();
> +
> +	smp_rmb();

Why do you need a memory barrier here ?

> +	return index;
> +}
> +#endif
> +
>  int __init tegra114_cpuidle_init(void)
>  {
> +#ifdef CONFIG_PM_SLEEP
> +	tegra_tear_down_cpu = tegra30_tear_down_cpu;
> +#endif

Doesn't this code should go in the pm.c file ?

>  	return cpuidle_register(&tegra_idle_driver, NULL);
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
