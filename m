From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 26 Feb 2016 17:43:15 +0800
Subject: [PATCH 8/9] clockevents/drivers/arm_global_timer: Implement
 ->set_state_oneshot_stopped()
In-Reply-To: <1456407438-6131-8-git-send-email-daniel.lezcano@linaro.org>
References: <56CF00F6.9010301@linaro.org>
 <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
 <1456407438-6131-8-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160226174315.392a2b6d@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel, Viresh,

On Thu, 25 Feb 2016 14:37:16 +0100 Daniel Lezcano wrote:

> From: Viresh Kumar <viresh.kumar@linaro.org>
> 
> set_state_oneshot_stopped() is called by the clkevt core, when the next
> event is required at an expiry time of 'KTIME_MAX'. This normally
> happens with NO_HZ_{IDLE|FULL} in both LOWRES/HIGHRES modes.
> 
> This patch makes the clockevent device to stop on such an event, to
> avoid spurious interrupts, as explained by: commit 8fff52fd5093
> ("clockevents: Introduce CLOCK_EVT_STATE_ONESHOT_STOPPED state").

Inspired by this commit, I think dw_apb_timer also needs similar patch because
it only supports PERIODIC mode and the driver emulate ONESHOT over that" as
described in commit 8fff52fd5093. What do you think?

I'm cooking one patch for this purpose.

Thanks for the inspiration,
Jisheng

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/arm_global_timer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 36998fa..9df0d16 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -175,6 +175,7 @@ static int gt_clockevents_init(struct clock_event_device *clk)
>  	clk->set_state_shutdown = gt_clockevent_shutdown;
>  	clk->set_state_periodic = gt_clockevent_set_periodic;
>  	clk->set_state_oneshot = gt_clockevent_shutdown;
> +	clk->set_state_oneshot_stopped = gt_clockevent_shutdown;
>  	clk->set_next_event = gt_clockevent_set_next_event;
>  	clk->cpumask = cpumask_of(cpu);
>  	clk->rating = 300;
