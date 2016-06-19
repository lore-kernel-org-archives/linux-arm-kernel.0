From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 19 Jun 2016 22:08:38 +0200
Subject: [RFC PATCH] clocksource: arm_arch_timer: disable the evtstrm via
 the cmdline
In-Reply-To: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
References: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
Message-ID: <5766FBC6.6000405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2016 03:43 PM, Will Deacon wrote:

[ Cc'ed tglx ]

> Disabling the eventstream can be useful for debugging and development
> purposes

If it is for debugging and development, why upstream this change ?

> and is currently controlled via a Kconfig option
> (CONFIG_ARM_ARCH_TIMER_EVTSTREAM). Whilst this does the trick, it's
> often desirable to toggle the feature on the command line, so this patch
> adds a "noevtstrm" command line option to do just that.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> Sending as an RFC because we might want to remove the Kconfig option
> altogether if we have this.
>
>   drivers/clocksource/arm_arch_timer.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 4814446a0024..f579c0da7423 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -79,6 +79,15 @@ static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
>   static bool arch_timer_c3stop;
>   static bool arch_timer_mem_use_virtual;
>
> +static bool evtstrm_disable;
> +
> +static int __init early_evtstrm_disable(char *buf)
> +{
> +	evtstrm_disable = true;
> +	return 0;
> +}
> +early_param("noevtstrm", early_evtstrm_disable);
> +
>   /*
>    * Architected system timer support.
>    */
> @@ -372,7 +381,7 @@ static int arch_timer_setup(struct clock_event_device *clk)
>   		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
>
>   	arch_counter_set_user_access();
> -	if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM))
> +	if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM) && !evtstrm_disable)
>   		arch_timer_configure_evtstream();
>
>   	return 0;
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
