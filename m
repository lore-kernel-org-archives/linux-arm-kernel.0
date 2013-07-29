From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 29 Jul 2013 16:14:51 +0200
Subject: [PATCH 4/7] cpuidle: calxeda: add support to use PSCI calls
In-Reply-To: <1375048598-15637-5-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
 <1375048598-15637-5-git-send-email-robherring2@gmail.com>
Message-ID: <51F678DB.3030308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2013 11:56 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This updates the Calxeda cpuidle driver to use PSCI calls to powergate
> cores. This is needed to enable cpuidle for the ECX-2000.
> 
> This could possibly become a generic PSCI driver, but there are no other
> PSCI users in the kernel other than mach-virt.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm at vger.kernel.org
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Rob,

Shall I take the patch in my tree ?

Thanks
  -- Daniel


>  drivers/cpuidle/cpuidle-calxeda.c | 40 ++++++---------------------------------
>  1 file changed, 6 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> index 0e6e408..01cfecf3 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -22,51 +22,23 @@
>  
>  #include <linux/cpuidle.h>
>  #include <linux/init.h>
> -#include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/time.h>
> -#include <linux/delay.h>
> -#include <linux/suspend.h>
>  #include <asm/cpuidle.h>
> -#include <asm/proc-fns.h>
> -#include <asm/smp_scu.h>
>  #include <asm/suspend.h>
> -#include <asm/cacheflush.h>
> -#include <asm/cp15.h>
> -
> -extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
> -extern void *scu_base_addr;
> -
> -static noinline void calxeda_idle_restore(void)
> -{
> -	set_cr(get_cr() | CR_C);
> -	set_auxcr(get_auxcr() | 0x40);
> -	scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
> -}
> +#include <asm/psci.h>
>  
>  static int calxeda_idle_finish(unsigned long val)
>  {
> -	/* Already flushed cache, but do it again as the outer cache functions
> -	 * dirty the cache with spinlocks */
> -	flush_cache_all();
> -
> -	set_auxcr(get_auxcr() & ~0x40);
> -	set_cr(get_cr() & ~CR_C);
> -
> -	scu_power_mode(scu_base_addr, SCU_PM_DORMANT);
> -
> -	cpu_do_idle();
> -
> -	/* Restore things if we didn't enter power-gating */
> -	calxeda_idle_restore();
> -	return 1;
> +	const struct psci_power_state ps = {
> +		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
> +	};
> +	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
>  }
>  
>  static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv,
>  				int index)
>  {
> -	highbank_set_cpu_jump(smp_processor_id(), cpu_resume);
>  	cpu_suspend(0, calxeda_idle_finish);
>  	return index;
>  }
> @@ -90,7 +62,7 @@ static struct cpuidle_driver calxeda_idle_driver = {
>  
>  static int __init calxeda_cpuidle_init(void)
>  {
> -	if (!of_machine_is_compatible("calxeda,highbank"))
> +	if (!of_machine_is_compatible("calxeda,highbank") || !psci_ops.cpu_suspend)
>  		return -ENODEV;
>  
>  	return cpuidle_register(&calxeda_idle_driver, NULL);
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
