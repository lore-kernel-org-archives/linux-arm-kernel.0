From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 19 Nov 2014 10:21:57 +0100
Subject: [PATCH] clockevent: sun4i: Fix race condition in the probe code
In-Reply-To: <1416351573-5815-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1416351573-5815-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <546C6135.90201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 11:59 PM, Maxime Ripard wrote:
> The interrupts were activated and the handler registered before the clockevent
> was registered in the probe function.
>
> The interrupt handler, however, was making the assumption that the clockevent
> device was registered.
>
> That could cause a null pointer dereferenc if the timer interrupt was firing
> during this narrow window.
>
> Fix that by moving the clockevent registration before the interrupt is enabled.
>
> Reported-by: Roman Byshko <rbyshko@gmail.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: stable at vger.kernel.org

Applied to my tree as 3.18 fix.

Thanks !

   -- Daniel

> ---
>   drivers/clocksource/sun4i_timer.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> index efb17c3ee120..f4a9c0058b4d 100644
> --- a/drivers/clocksource/sun4i_timer.c
> +++ b/drivers/clocksource/sun4i_timer.c
> @@ -182,6 +182,12 @@ static void __init sun4i_timer_init(struct device_node *node)
>   	/* Make sure timer is stopped before playing with interrupts */
>   	sun4i_clkevt_time_stop(0);
>
> +	sun4i_clockevent.cpumask = cpu_possible_mask;
> +	sun4i_clockevent.irq = irq;
> +
> +	clockevents_config_and_register(&sun4i_clockevent, rate,
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
>   	ret = setup_irq(irq, &sun4i_timer_irq);
>   	if (ret)
>   		pr_warn("failed to setup irq %d\n", irq);
> @@ -189,12 +195,6 @@ static void __init sun4i_timer_init(struct device_node *node)
>   	/* Enable timer0 interrupt */
>   	val = readl(timer_base + TIMER_IRQ_EN_REG);
>   	writel(val | TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_EN_REG);
> -
> -	sun4i_clockevent.cpumask = cpu_possible_mask;
> -	sun4i_clockevent.irq = irq;
> -
> -	clockevents_config_and_register(&sun4i_clockevent, rate,
> -					TIMER_SYNC_TICKS, 0xffffffff);
>   }
>   CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>   		       sun4i_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
