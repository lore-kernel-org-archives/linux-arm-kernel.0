From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 01:16:46 +0200
Subject: [PATCH 3/5] clocksource: rockchip: add dynamic irq flag to the
 timer
In-Reply-To: <1464169802-6033-4-git-send-email-wxt@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-4-git-send-email-wxt@rock-chips.com>
Message-ID: <574CC9DE.1050501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2016 11:50 AM, Caesar Wang wrote:
> From: Huang Tao <huangtao@rock-chips.com>
>
> The rockchip timer is broadcast timer. Add CLOCK_EVT_FEAT_DYNIRQ
> flag and set cpumask to all cpu to save power by avoid unnecessary
> wakeups and IPIs.
>
> Signed-off-by: Huang Tao <huangtao@rock-chips.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>   drivers/clocksource/rockchip_timer.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
> index b93fed6..f3dfb1a 100644
> --- a/drivers/clocksource/rockchip_timer.c
> +++ b/drivers/clocksource/rockchip_timer.c
> @@ -150,12 +150,13 @@ static void __init rk_timer_init(struct device_node *np)
>   	}
>
>   	ce->name = TIMER_NAME;
> -	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> +		       CLOCK_EVT_FEAT_DYNIRQ;
>   	ce->set_next_event = rk_timer_set_next_event;
>   	ce->set_state_shutdown = rk_timer_shutdown;
>   	ce->set_state_periodic = rk_timer_set_periodic;
>   	ce->irq = irq;
> -	ce->cpumask = cpumask_of(0);
> +	ce->cpumask = cpu_all_mask;

s/cpu_all_mask/cpu_possible_mask/

>   	ce->rating = 250;
>
>   	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
