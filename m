From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 01 Apr 2013 01:41:44 +0200
Subject: [PATCH] ARM: timer: Shutdown clock event device when stopping
 local timer
In-Reply-To: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
References: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
Message-ID: <5158C9B8.3070208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 10:24 AM, ning.n.jiang at gmail.com wrote:
> From: Ning Jiang <ning.n.jiang@gmail.com>
> 
> Currently there are two problems when we try to stop local timer.
> First, it calls set_mode function directly so mode state is not
> updated for the clock event device. Second, it makes the device
> unused instead of shutdown.
> 
> A subtle error will happen because of it. When a cpu is plugged out
> it will stop the local timer. It will call tick_nohz_idle_enter()
> in idle thread afterwards. It will cancel the sched timer and try
> to reprogram the next event. This is wrong since the local timer
> is supposed to be stopped.
> 
> The right way to stop the local timer is to shutdown it by calling
> clockevents_set_mode(). Thus when we try to reprogram the clock
> event device, it will return directly without doing anything since
> the clock mode is CLOCK_EVT_MODE_SHUTDOWN.
> 
> Signed-off-by: Ning Jiang <ning.n.jiang@gmail.com>
> ---
>  arch/arm/kernel/smp_twd.c                |    2 +-
>  arch/arm/mach-exynos/mct.c               |    2 +-
>  arch/arm/mach-msm/timer.c                |    2 +-
>  drivers/clocksource/arm_arch_timer.c     |    2 +-
>  drivers/clocksource/time-armada-370-xp.c |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 3f25650..c1d4ab4 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -92,7 +92,7 @@ static int twd_timer_ack(void)
>  
>  static void twd_timer_stop(struct clock_event_device *clk)
>  {
> -	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
> +	clockevents_set_mode(clk, CLOCK_EVT_MODE_SHUTDOWN);
>  	disable_percpu_irq(clk->irq);

Wouldn't be clockevents_shutdown more adequate here ? The next event
will be also set.



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
