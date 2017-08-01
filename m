From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Aug 2017 12:12:23 +0100
Subject: [PATCH] clocksource: arm_arch_timer: Fix mem frame loop
 initialization
In-Reply-To: <20170731183728.61087-1-mka@chromium.org>
References: <20170731183728.61087-1-mka@chromium.org>
Message-ID: <20170801111222.GC9347@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 11:37:28AM -0700, Matthias Kaehlcke wrote:
> The loop to find the best memory frame in arch_timer_mem_acpi_init()
> initializes the loop counter with itself ('i = i'), which is suspicious
> in the first place and pointed out by clang. The loop condition is
> 'i < timer_count' and a prior for loop exits when 'i' reaches
> 'timer_count', therefore the second loop is never executed.
> 
> Initialize the loop counter with 0 to iterate over all timers, which
> supposedly was the intention before the typo monster attacked.
> 
> Fixes: c2743a36765d3 ("clocksource: arm_arch_timer: add GTDT support for memory-mapped timer")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Ard also spotted this issue [1], along with another issue we still need
to solve. In the mean time it would be nice to have this fixed, so:

Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> 
Acked-by: Mark Rutland <mark.rutland@arm.com>

Daniel, Thomas,

Could one of you please pick this up as a fix, with the above tags?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520779.html

> ---
>  drivers/clocksource/arm_arch_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index aae87c4c546e..72bbfccef113 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1440,7 +1440,7 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>  	 * While unlikely, it's theoretically possible that none of the frames
>  	 * in a timer expose the combination of feature we want.
>  	 */
> -	for (i = i; i < timer_count; i++) {
> +	for (i = 0; i < timer_count; i++) {
>  		timer = &timers[i];
>  
>  		frame = arch_timer_mem_find_best_frame(timer);
> -- 
> 2.14.0.rc0.400.g1c36432dff-goog
> 
