From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Sep 2014 09:04:30 +0200
Subject: [PATCH v2 1/3] clocksource: arm_arch_timer: change clocksource
 name if CP15 unavailable
In-Reply-To: <1411052390-27238-2-git-send-email-nathan_lynch@mentor.com>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
 <1411052390-27238-2-git-send-email-nathan_lynch@mentor.com>
Message-ID: <54250FFE.2050605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 04:59 PM, Nathan Lynch wrote:
> The arm and arm64 VDSOs need CP15 access to the architected counter.
> If this is unavailable (which is allowed by ARM v7), indicate this by
> changing the clocksource name to "arch_mem_counter" before registering
> the clocksource.
>
> Suggested by Stephen Boyd.
>
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Hi Nathan,

is it possible to have the acked-by of the different maintainers for the 
other patches ?

Are these patches targeted to be merged for 3.18 ?

Thanks
   -- Daniel

> ---
>   drivers/clocksource/arm_arch_timer.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 5163ec13429d..c99afdf12e98 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -429,11 +429,19 @@ static void __init arch_counter_register(unsigned type)
>   	u64 start_count;
>
>   	/* Register the CP15 based counter if we have one */
> -	if (type & ARCH_CP15_TIMER)
> +	if (type & ARCH_CP15_TIMER) {
>   		arch_timer_read_counter = arch_counter_get_cntvct;
> -	else
> +	} else {
>   		arch_timer_read_counter = arch_counter_get_cntvct_mem;
>
> +		/* If the clocksource name is "arch_sys_counter" the
> +		 * VDSO will attempt to read the CP15-based counter.
> +		 * Ensure this does not happen when CP15-based
> +		 * counter is not available.
> +		 */
> +		clocksource_counter.name = "arch_mem_counter";
> +	}
> +
>   	start_count = arch_timer_read_counter();
>   	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
>   	cyclecounter.mult = clocksource_counter.mult;
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
