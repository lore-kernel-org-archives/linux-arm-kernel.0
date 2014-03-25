From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Mar 2014 12:32:54 +0100
Subject: [PATCH] clocksource: exynos_mct: Fix stall after CPU hotplugging
In-Reply-To: <1395744087-8655-1-git-send-email-k.kozlowski@samsung.com>
References: <1395744087-8655-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53316966.90600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Two comments inline.

On 25.03.2014 11:41, Krzysztof Kozlowski wrote:

[snip]

> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 48f76bc05da0..0b49b09dd1a9 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -339,7 +339,14 @@ static void exynos4_mct_tick_start(unsigned long cycles,
>   static int exynos4_tick_set_next_event(unsigned long cycles,
>   				       struct clock_event_device *evt)
>   {
> -	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
> +	/*
> +	 * In case of hotplugging non-boot CPU, the set_next_event could be
> +	 * called on CPU0 by ISR before IRQ affinity is set to proper CPU.

Hmm, is this a desired behavior? I guess this is a question for Thomas 
and Daniel.

> +	 * Thus for accessing proper MCT Lx timer, 'per_cpu' for cpumask
> +	 * in event must be used instead of 'this_cpu_ptr'.
> +	 */
> +	struct mct_clock_event_device *mevt = &per_cpu(percpu_mct_tick,
> +			cpumask_first(evt->cpumask));
>
>   	exynos4_mct_tick_start(cycles, mevt);
>
> @@ -371,23 +378,13 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
>
>   static int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
>   {
> -	struct clock_event_device *evt = &mevt->evt;
> -
> -	/*
> -	 * This is for supporting oneshot mode.
> -	 * Mct would generate interrupt periodically
> -	 * without explicit stopping.
> -	 */
> -	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
> -		exynos4_mct_tick_stop(mevt);
> -
>   	/* Clear the MCT tick interrupt */
>   	if (__raw_readl(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1) {
>   		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
>   		return 1;
> -	} else {
> -		return 0;
>   	}
> +
> +	return 0;

Nobody seems to be checking return value of this function (and I don't 
see what it could be used for anyway), so I guess it could be simply 
made void.

Best regards,
Tomasz
