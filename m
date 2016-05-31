From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 10:25:34 +0200
Subject: [PATCH 3/4] clocksource: sp804: use sp804_timer_disable() where
 possible
In-Reply-To: <1464428033-52106-4-git-send-email-wangkefeng.wang@huawei.com>
References: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
 <1464428033-52106-4-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <574D4A7E.7000301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2016 11:33 AM, Kefeng Wang wrote:
> Use sp804_timer_disable() where possible, prepare for 64bit mode timer support.

Explain this change please.

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/clocksource/timer-sp804.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index b8848e5..2ff8777 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -105,7 +105,7 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
>   		return;
>
>   	/* setup timer 0 as free-running clocksource */
> -	writel(0, base + TIMER_CTRL);
> +	sp804_timer_disable(base);
>   	writel(0xffffffff, base + TIMER_VALUE);
>   	sp804_load_mode_set(base, 0xffffffff, TIMER_CTRL_PERIODIC & ~TIMER_CTRL_IE);
>
> @@ -196,8 +196,7 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
>   	evt->irq = irq;
>   	evt->cpumask = cpu_possible_mask;
>
> -	writel(0, base + TIMER_CTRL);
> -
> +	sp804_timer_disable(base);
>   	setup_irq(irq, &sp804_timer_irq);
>   	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
>   }
> @@ -216,8 +215,8 @@ static void __init sp804_of_init(struct device_node *np)
>   		return;
>
>   	/* Ensure timers are disabled */
> -	writel(0, base + TIMER_CTRL);
> -	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
> +	sp804_timer_disable(base);
> +	sp804_timer_disable(base + TIMER_2_BASE);
>
>   	if (initialized || !of_device_is_available(np))
>   		goto err;
> @@ -274,7 +273,7 @@ static void __init integrator_cp_of_init(struct device_node *np)
>   		return;
>
>   	/* Ensure timer is disabled */
> -	writel(0, base + TIMER_CTRL);
> +	sp804_timer_disable(base);
>
>   	if (init_count == 2 || !of_device_is_available(np))
>   		goto err;
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
