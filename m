From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 25 Jan 2015 22:52:02 +0100
Subject: [PATCH] clocksource: arm_arch_timer: Rename arch_timer_probed
 to reflect behaviour
In-Reply-To: <1421488012-5098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1421488012-5098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <54C56582.6080809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2015 10:46 AM, Laurent Pinchart wrote:
> The arch_timer_probed function returns whether the given time doesn't
> need to be probed. This can be the case when the timer has been probed
> already, but also when it has no corresponding enabled node in DT.
>
> Rename the function to arch_timer_need_probe and invert its return value
> to better reflect the function's purpose and behaviour.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I would like to have an ack from Sudeep or Mark (Cc'ed) before taking 
this patch.

Thanks
   -- Daniel

> ---
>   drivers/clocksource/arm_arch_timer.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 095c1774592c..3cbdd563a967 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -660,17 +660,17 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
>   };
>
>   static bool __init
> -arch_timer_probed(int type, const struct of_device_id *matches)
> +arch_timer_need_probe(int type, const struct of_device_id *matches)
>   {
>   	struct device_node *dn;
> -	bool probed = true;
> +	bool need_probe = false;
>
>   	dn = of_find_matching_node(NULL, matches);
>   	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
> -		probed = false;
> +		need_probe = true;
>   	of_node_put(dn);
>
> -	return probed;
> +	return need_probe;
>   }
>
>   static void __init arch_timer_common_init(void)
> @@ -679,9 +679,10 @@ static void __init arch_timer_common_init(void)
>
>   	/* Wait until both nodes are probed if we have two timers */
>   	if ((arch_timers_present & mask) != mask) {
> -		if (!arch_timer_probed(ARCH_MEM_TIMER, arch_timer_mem_of_match))
> +		if (arch_timer_need_probe(ARCH_MEM_TIMER,
> +					  arch_timer_mem_of_match))
>   			return;
> -		if (!arch_timer_probed(ARCH_CP15_TIMER, arch_timer_of_match))
> +		if (arch_timer_need_probe(ARCH_CP15_TIMER, arch_timer_of_match))
>   			return;
>   	}
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
