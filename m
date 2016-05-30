From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 01:09:45 +0200
Subject: [PATCH 2/5] clocksource: rockchip: remove unnecessary clear irq
 before request_irq
In-Reply-To: <1464169802-6033-3-git-send-email-wxt@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-3-git-send-email-wxt@rock-chips.com>
Message-ID: <574CC839.60608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2016 11:49 AM, Caesar Wang wrote:
> From: Huang Tao <huangtao@rock-chips.com>
>
> rk_timer_interrupt_clear and rk_timer_disable is unnecessary before
> request_irq. Timer should keep disabled before booting Linux.

That's true in the perfect world :/ Some version has u-boot letting the 
timer with irq enabled, therefore as soon as request_irq is done, an irq 
fires and leads to a kernel panic.

On the other side, this timer is not used on the other rockchip version 
than rk3399 because of no need of a broadcast timer, so removing these 
two lines may be acceptable.

Can try the changes with another board, eg rk3288 (and forcing to use 
this timer). Can you do the test and confirm it does not break with 
different version of u-boot ?

Thanks!

   -- Daniel

> Signed-off-by: Huang Tao <huangtao@rock-chips.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>   drivers/clocksource/rockchip_timer.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
> index b991b28..b93fed6 100644
> --- a/drivers/clocksource/rockchip_timer.c
> +++ b/drivers/clocksource/rockchip_timer.c
> @@ -158,9 +158,6 @@ static void __init rk_timer_init(struct device_node *np)
>   	ce->cpumask = cpumask_of(0);
>   	ce->rating = 250;
>
> -	rk_timer_interrupt_clear(ce);
> -	rk_timer_disable(ce);
> -
>   	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
>   	if (ret) {
>   		pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
