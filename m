From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Apr 2013 11:31:27 -0700
Subject: [PATCH/RESEND] ARM: arch_timer: Silence debug preempt warnings
In-Reply-To: <1366241178-16626-1-git-send-email-sboyd@codeaurora.org>
References: <1366241178-16626-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5179767F.5030405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/13 16:26, Stephen Boyd wrote:
> Hot-plugging with CONFIG_DEBUG_PREEMPT=y on a device with arm
> architected timers causes a slew of "using smp_processor_id() in
> preemptible" warnings:
>
>   BUG: using smp_processor_id() in preemptible [00000000] code: sh/111
>   caller is arch_timer_cpu_notify+0x14/0xc8
>
> This happens because sometimes the cpu notifier,
> arch_timer_cpu_notify(), is called in preemptible context and
> other times in non-preemptible context but we use this_cpu_ptr()
> to retrieve the clockevent in all cases. We're only going to
> actually use the pointer in non-preemptible context though, so
> push the this_cpu_ptr() access down into the cases to force the
> checks to occur only in non-preemptible contexts.
>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <Marc.Zyngier@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> Resending to arm-soc maintainers instead of timekeeping maintainers. Who
> maintains this driver?

Ping.

>
>  drivers/clocksource/arm_arch_timer.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index d7ad425..a65a710 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -248,14 +248,16 @@ static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
>  static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
>  					   unsigned long action, void *hcpu)
>  {
> -	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
> -
> +	/*
> +	 * Grab cpu pointer in each case to avoid spurious
> +	 * preemptible warnings
> +	 */
>  	switch (action & ~CPU_TASKS_FROZEN) {
>  	case CPU_STARTING:
> -		arch_timer_setup(evt);
> +		arch_timer_setup(this_cpu_ptr(arch_timer_evt));
>  		break;
>  	case CPU_DYING:
> -		arch_timer_stop(evt);
> +		arch_timer_stop(this_cpu_ptr(arch_timer_evt));
>  		break;
>  	}
>  


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
