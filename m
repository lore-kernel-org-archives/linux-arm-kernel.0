From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Jan 2012 08:08:37 -0800
Subject: [PATCH v4 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <1327061042-14857-15-git-send-email-marc.zyngier@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <4F22CC05.6040709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/12 04:04, Marc Zyngier wrote:
> Convert the MSM timers to the runtime registration interface.
>
>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

> Tested-by: David Brown <davidb@codeaurora.org>
> Acked-by: David Brown <davidb@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-msm/timer.c |   79 +++++++++++++++++++++++++--------------------
>  1 files changed, 44 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 11d0d8f..75f4be4 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
>
[snip]
> +
> +static struct local_timer_ops msm_local_timer_ops __cpuinitdata = {
> +	.setup	= msm_local_timer_setup,
> +	.stop	= msm_local_timer_stop,

Would this be a good time to rename these to start/stop? setup sounds
like it's done once, but its actually done every cpu up from what I recall.

> +};
> +#endif /* CONFIG_LOCAL_TIMERS */
> +
>  static void __init msm_timer_init(void)
>  {
>  	struct clock_event_device *ce = &msm_clockevent;
> @@ -173,8 +212,12 @@ static void __init msm_timer_init(void)
>  		*__this_cpu_ptr(msm_evt.percpu_evt) = ce;
>  		res = request_percpu_irq(ce->irq, msm_timer_interrupt,
>  					 ce->name, msm_evt.percpu_evt);
> -		if (!res)
> +		if (!res) {
>  			enable_percpu_irq(ce->irq, 0);
> +#ifdef CONFIG_LOCAL_TIMERS
> +			local_timer_register(&msm_local_timer_ops);
> +#endif
> +		}

It's unfortunate we can't avoid this ifdef here. O well.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
