From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 14:47:13 -0600
Subject: [PATCH] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
References: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <5050F4D1.5020700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2012 02:19 AM, Shawn Guo wrote:
> From: Mike Turquette <mturquette@linaro.org>
> 
> Running cpufreq driver on imx6q, the following warning is seen.
> 
> $ BUG: sleeping function called from invalid context at kernel/mutex.c:269
...
> It looks that the warning is caused by that twd_update_frequency() gets
> called from an atomic context while it calls clk_get_rate() where
> a mutex gets held.
> 
> To fix the warning, let's convert the existing code to use clk notifiers
> in place of CPUfreq notifiers.  This works out nicely for Cortex-A9
> MPcore designs that scale all CPUs at the same frequency.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

At least in next-20120912, this doesn't appear to cause any issue on
either Tegra20 or Tegra30. I'm copying Prashant to verify this is OK for
Tegra.

For reference, the situation for Tegra is:

Pre-3.7:

Tegra20: Does not use common clock, and there is NO "smp_twd" clock defined.

Tegra30: Does not use common clock, and there IS a "smp_twd" clock defined.

In 3.7 will be:

Tegra20: Supports common clock, but there is NO "smp_twd" clock defined.

Tegra30: Supports common clock, and there IS a "smp_twd" clock defined.

I believe Prashant will be sending a patch very soon to define an
"smp_twd" clock for Tegra20.

The Tegra cpufreq driver currently only initializes on Tegra20 and not
Tegra30 right now due to some clock-naming differences. I don't expect
this to change in 3.7, but who knows, someone might send a patch in the
next 2 days or so...

> ---
>  arch/arm/kernel/smp_twd.c |   32 +++++++++++++-------------------
>  1 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index fef42b2..635e3ea 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
> -#include <linux/cpufreq.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -96,51 +95,46 @@ static void twd_timer_stop(struct clock_event_device *clk)
>  	disable_percpu_irq(clk->irq);
>  }
>  
> -#ifdef CONFIG_CPU_FREQ
> -
>  /*
>   * Updates clockevent frequency when the cpu frequency changes.
>   * Called on the cpu that is changing frequency with interrupts disabled.
>   */
> -static void twd_update_frequency(void *data)
> +static void twd_update_frequency(void *new_rate)
>  {
> -	twd_timer_rate = clk_get_rate(twd_clk);
> +	twd_timer_rate = *((unsigned long *) new_rate);
>  
>  	clockevents_update_freq(*__this_cpu_ptr(twd_evt), twd_timer_rate);
>  }
>  
> -static int twd_cpufreq_transition(struct notifier_block *nb,
> -	unsigned long state, void *data)
> +static int twd_rate_change(struct notifier_block *nb,
> +	unsigned long flags, void *data)
>  {
> -	struct cpufreq_freqs *freqs = data;
> +	struct clk_notifier_data *cnd = data;
>  
>  	/*
>  	 * The twd clock events must be reprogrammed to account for the new
>  	 * frequency.  The timer is local to a cpu, so cross-call to the
>  	 * changing cpu.
>  	 */
> -	if (state == CPUFREQ_POSTCHANGE || state == CPUFREQ_RESUMECHANGE)
> -		smp_call_function_single(freqs->cpu, twd_update_frequency,
> -			NULL, 1);
> +	if (flags == POST_RATE_CHANGE)
> +		smp_call_function(twd_update_frequency,
> +				  (void *)&cnd->new_rate, 1);
>  
>  	return NOTIFY_OK;
>  }
>  
> -static struct notifier_block twd_cpufreq_nb = {
> -	.notifier_call = twd_cpufreq_transition,
> +static struct notifier_block twd_clk_nb = {
> +	.notifier_call = twd_rate_change,
>  };
>  
> -static int twd_cpufreq_init(void)
> +static int twd_clk_init(void)
>  {
>  	if (twd_evt && *__this_cpu_ptr(twd_evt) && !IS_ERR(twd_clk))
> -		return cpufreq_register_notifier(&twd_cpufreq_nb,
> -			CPUFREQ_TRANSITION_NOTIFIER);
> +		return clk_notifier_register(twd_clk, &twd_clk_nb);
>  
>  	return 0;
>  }
> -core_initcall(twd_cpufreq_init);
> -
> -#endif
> +core_initcall(twd_clk_init);
>  
>  static void __cpuinit twd_calibrate_rate(void)
>  {
> 
