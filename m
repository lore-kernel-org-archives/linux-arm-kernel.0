From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 23 Oct 2014 10:39:18 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't wait for probe of
 unexisting timers
In-Reply-To: <1414085558-2148-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414085558-2148-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <54493D46.6040202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2014 10:32 AM, Laurent Pinchart wrote:
> Commit c387f07e6205 ("clocksource: arm_arch_timer: Discard unavailable
> timers correctly") attempted to avoid waiting for probe of disabled
> timers, but got its condition check wrong and resulted in the driver
> waiting for probe of timers not present in DT at all. Fix it.
>
> Fixes: c387f07e6205 ("clocksource: arm_arch_timer: Discard unavailable timers correctly")
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---

You're the third one. I like how the function has been renamed in this
patch. arch_timer_probed() is not accurately describing the intention of
the code so arch_timer_need_probe() reads better. Maybe your rename of
the function can be squashed into Marc's patch.

>  drivers/clocksource/arm_arch_timer.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> This patch fixes a regression introduced in v3.18-rc1.
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 2133f9d..5caf32c 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -657,17 +657,17 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
>  };
>  
>  static bool __init
> -arch_timer_probed(int type, const struct of_device_id *matches)
> +arch_timer_need_probe(int type, const struct of_device_id *matches)
>  {
>  	struct device_node *dn;
> -	bool probed = false;
> +	bool need_probe = false;
>  
>  	dn = of_find_matching_node(NULL, matches);
> -	if (dn && of_device_is_available(dn) && (arch_timers_present & type))
> -		probed = true;
> +	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
> +		need_probe = true;
>  	of_node_put(dn);
>  
> -	return probed;
> +	return need_probe;
>  }
>  
>  static void __init arch_timer_common_init(void)
> @@ -676,9 +676,10 @@ static void __init arch_timer_common_init(void)
>  
>  	/* Wait until both nodes are probed if we have two timers */
>  	if ((arch_timers_present & mask) != mask) {
> -		if (!arch_timer_probed(ARCH_MEM_TIMER, arch_timer_mem_of_match))
> +		if (arch_timer_need_probe(ARCH_MEM_TIMER,
> +					  arch_timer_mem_of_match))
>  			return;
> -		if (!arch_timer_probed(ARCH_CP15_TIMER, arch_timer_of_match))
> +		if (arch_timer_need_probe(ARCH_CP15_TIMER, arch_timer_of_match))
>  			return;
>  	}
>  


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
