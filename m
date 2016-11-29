From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 29 Nov 2016 16:01:09 +0100
Subject: [PATCH v3 13/13] clocksource/drivers/rockchip_timer: Prevent
 ftrace recursion
In-Reply-To: <1480427118-5126-14-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480427118-5126-1-git-send-email-al.kochet@gmail.com>
 <1480427118-5126-14-git-send-email-al.kochet@gmail.com>
Message-ID: <7837485.H9nfDmPu0F@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 29. November 2016, 16:45:18 schrieb Alexander Kochetkov:
> Currently rockchip_timer can be used as a scheduler clock. We properly
> marked rk_timer_sched_clock_read() as notrace but we then call another
> function rk_timer_counter_read() that _wasn't_ notrace.
> 
> Having a traceable function in the sched_clock() path leads to a recursion
> within ftrace and a kernel crash.
> 
> Fix this by adding an extra notrace function to keep other users of
> rk_timer_counter_read() traceable.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

you introduced the issue yourself in patch 11/13. In general any patch should 
never leave the kernel in a worse state than it was before, so no patch should 
ever introduce known issues itself.

In that line of thought, don't patches 10+11 introduce warnings about unused 
functions as well when applied without patch 12?

Maybe merge them?


Heiko

> ---
>  drivers/clocksource/rockchip_timer.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/rockchip_timer.c
> b/drivers/clocksource/rockchip_timer.c index 1af80a0..a127822 100644
> --- a/drivers/clocksource/rockchip_timer.c
> +++ b/drivers/clocksource/rockchip_timer.c
> @@ -87,7 +87,7 @@ static void rk_timer_update_counter(u64 cycles, struct
> rk_timer *timer) writel_relaxed(upper, timer->base + TIMER_LOAD_COUNT1);
>  }
> 
> -static u64 rk_timer_counter_read(struct rk_timer *timer)
> +static u64 notrace _rk_timer_counter_read(struct rk_timer *timer)
>  {
>  	u64 counter;
>  	u32 lower;
> @@ -106,6 +106,11 @@ static u64 rk_timer_counter_read(struct rk_timer
> *timer) return counter;
>  }
> 
> +static u64 rk_timer_counter_read(struct rk_timer *timer)
> +{
> +	return _rk_timer_counter_read(timer);
> +}
> +
>  static void rk_timer_interrupt_clear(struct rk_timer *timer)
>  {
>  	writel_relaxed(1, timer->base + TIMER_INT_STATUS);
> @@ -168,7 +173,7 @@ static u64 notrace rk_timer_sched_clock_read(void)
>  {
>  	struct rk_clocksource *_cs = &cs_timer;
> 
> -	return ~rk_timer_counter_read(&_cs->timer);
> +	return ~_rk_timer_counter_read(&_cs->timer);
>  }
> 
>  static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
