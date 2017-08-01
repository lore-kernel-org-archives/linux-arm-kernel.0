From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Aug 2017 11:53:45 +0100
Subject: [PATCH] arm64: acpi/gtdt: validate CNTFRQ after having enabled
 the frame
In-Reply-To: <20170724151053.17769-1-ard.biesheuvel@linaro.org>
References: <20170724151053.17769-1-ard.biesheuvel@linaro.org>
Message-ID: <20170801105345.GB9347@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Thanks for this. Sorry it's taken a while to reply.

On Mon, Jul 24, 2017 at 04:10:53PM +0100, Ard Biesheuvel wrote:
> The ACPI GTDT code validates the CNTFRQ field of each MMIO timer
> frame against the CNTFRQ system register of the current CPU, to
> ensure that they are equal, which is mandated by the architecture.
> 
> However, reading the CNTFRQ field of a frame is not possible until
> the RFRQ bit in the frame's CNTACRn register is set, and doing so
> before that willl produce the following error:
> 
>   arch_timer: [Firmware Bug]: CNTFRQ mismatch: frame @ 0x00000000e0be0000: (0x00000000), CPU: (0x0ee6b280)
>   arch_timer: Disabling MMIO timers due to CNTFRQ mismatch
>   arch_timer: Failed to initialize memory-mapped timer.
> 
> The reason is that the CNTFRQ field is RES0 if access is not enabled.
> 
> So move the validation of CNTFRQ into the loop that iterates over the
> timers to find the best frame, and only validate the frame that has
> been selected as the best frame (and has thus been enabled).

The intention here was to verify all frames, such that if/when we choose
to use other frames in future, CNTFRQ will be valid. This is stricter
than the DT case, which I'd also make stricter were it not for legacy.

So while that check needs to be corrected, I'd like to retain the check
for all frames.

> (Note that there is no point in trying other frames of the same timer
> if the validation fails, since they are all architecturally guaranteed
> to have the same value for CNTFRQ)
> 
> Oh, and while we're at it, fix the bogus 'i = i' initializer in the
> for() loop that iterates over the timers.

Matthias Kaehlcke just sent a patch for this alone. I'd like to take
that as an ortohogonal fix while we sort out the dodgy CNTFRQ check.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/522472.html

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 44 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 8b5c30062d99..8fb632633331 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1387,22 +1387,12 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  
>  #ifdef CONFIG_ACPI_GTDT
>  static int __init
> -arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
> +arch_timer_mem_verify_cntfrq(struct arch_timer_mem_frame *frame)
>  {
> -	struct arch_timer_mem_frame *frame;
>  	u32 rate;
> -	int i;
> -
> -	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> -		frame = &timer_mem->frame[i];
> -
> -		if (!frame->valid)
> -			continue;
> -
> -		rate = arch_timer_mem_frame_get_cntfrq(frame);
> -		if (rate == arch_timer_rate)
> -			continue;
>  
> +	rate = arch_timer_mem_frame_get_cntfrq(frame);
> +	if (rate != arch_timer_rate) {
>  		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
>  			&frame->cntbase,
>  			(unsigned long)rate, (unsigned long)arch_timer_rate);
> @@ -1428,24 +1418,30 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>  	if (ret || !timer_count)
>  		goto out;
>  
> -	for (i = 0; i < timer_count; i++) {
> -		ret = arch_timer_mem_verify_cntfrq(&timers[i]);
> -		if (ret) {
> -			pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
> -			goto out;
> -		}
> -	}
> -
>  	/*
>  	 * While unlikely, it's theoretically possible that none of the frames
> -	 * in a timer expose the combination of feature we want.
> +	 * in a timer expose the combination of features we want.
>  	 */
> -	for (i = i; i < timer_count; i++) {
> +	for (i = 0; i < timer_count; i++) {
>  		timer = &timers[i];
>  
>  		frame = arch_timer_mem_find_best_frame(timer);
> -		if (frame)
> +		if (!frame)
> +			continue;
> +
> +		/* validate CNTFRQ after having enabled the frame */
> +		ret = arch_timer_mem_verify_cntfrq(frame);
> +		if (!ret)
>  			break;
> +
> +		/*
> +		 * If this timer provides a suitable frame but with the wrong
> +		 * value for the CNTFRQ field, there is no point in trying other
> +		 * frames of the same timer, given that they are architecturally
> +		 * guaranteed to carry the same CNTFRQ value. So just carry on
> +		 * with the next timer instead.
> +		 */
> +		frame = NULL;
>  	}
>  
>  	if (frame)
> -- 
> 2.9.3
> 
