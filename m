From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 20 May 2013 15:48:16 -0400
Subject: [PATCHv2 3/5] clocksource: arch_timer: use virtual counters
In-Reply-To: <1368631441-28434-4-git-send-email-mark.rutland@arm.com>
References: <1368631441-28434-1-git-send-email-mark.rutland@arm.com>
 <1368631441-28434-4-git-send-email-mark.rutland@arm.com>
Message-ID: <519A7E00.7090600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 05/15/2013 11:23 AM, Mark Rutland wrote:

[...]

> Instead, this patch makes us always use the virtual counters. If we're a
> guest, or don't have hyp mode, we'll use the virtual timers, and as such
> don't care about CNTVOFF as long as it doesn't change in such a way as
> to make time travel backwards. If we do have hyp mode, and might be a
> KVM host, we have to use the physical timers, and require CNTVOFF to be
> zero so as to have a consistent view of time between the physical timers
> and virtual counters.

[...]

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a2b2541..053d846 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -287,7 +279,7 @@ static int __init arch_timer_register(void)
>  	cyclecounter.mult = clocksource_counter.mult;
>  	cyclecounter.shift = clocksource_counter.shift;
>  	timecounter_init(&timecounter, &cyclecounter,
> -			 arch_counter_get_cntpct());
> +			 arch_counter_get_cntvct());
>  
>  	if (arch_timer_use_virtual) {
>  		ppi = arch_timer_ppi[VIRT_PPI];

[...]


You say "we have to use the physical timers", but then change the code to read
exclusively from the virtual counter. I think it'd make more sense to just say
that CNTVOFF has to be zero (and why exactly?).

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
