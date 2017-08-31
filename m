From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Aug 2017 18:47:54 +0100
Subject: [PATCH v2] arm64: acpi/gtdt: validate CNTFRQ after having
 enabled the frame
In-Reply-To: <20170821095623.27691-1-ard.biesheuvel@linaro.org>
References: <20170821095623.27691-1-ard.biesheuvel@linaro.org>
Message-ID: <20170831174754.GB28341@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Thanks for respinning this, and apologies for the delay.

On Mon, Aug 21, 2017 at 10:56:23AM +0100, Ard Biesheuvel wrote:
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index aae87c4c546e..c16fa694a47b 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1217,7 +1217,8 @@ arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
>  }
>  
>  static struct arch_timer_mem_frame * __init
> -arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
> +arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem,
> +			       bool verify_freq)
>  {
>  	struct arch_timer_mem_frame *frame, *best_frame = NULL;
>  	void __iomem *cntctlbase;
> @@ -1259,6 +1260,11 @@ arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
>  		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
>  			continue;
>  
> +		if (verify_freq &&
> +		    arch_timer_mem_frame_get_cntfrq(frame) != arch_timer_rate) {
> +			pr_err(FW_BUG "Ignoring MMIO timer frame with incorrect CNTFRQ\n");
> +			continue;
> +		}

I don't think this is quite right, since we only check this after
skipping over frames (which are valid, but don't match our preferences
w.r.t. the timer and counter).

Can we move this before checking the CNTACR_RWPT and CNTACR_RPCT bits?

I's still prefer that we give up (as we previously did), rather than
skipping timers with bad CNTFRQ values, but I guess that really depends
on whether we think we'll use more than one MMIO timer in future. Maybe
we'll want to use one per socket or something like that.

> @@ -1443,7 +1414,7 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>  	for (i = i; i < timer_count; i++) {
>  		timer = &timers[i];
>  
> -		frame = arch_timer_mem_find_best_frame(timer);
> +		frame = arch_timer_mem_find_best_frame(timer, true);
>  		if (frame)
>  			break;

Previously we'd have checked all timers, then chosen the best one,
whereas now we bail out once we find a timer with a usable frame.

Is there any way we can make this check the remaining timers?

Thanks,
Mark.
