From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Dec 2013 11:32:03 +0100
Subject: [REPOST PATCH] ARM: sunxi: stop timer from ticking before enabling
 interrupts
In-Reply-To: <1385976575-28011-1-git-send-email-marc.zyngier@arm.com>
References: <1385976575-28011-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <529C61A3.8010208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 10:29 AM, Marc Zyngier wrote:
> The sun4i timer can still be ticking when we enable the interrupt.
> If another timer is actually used (A7 architected timer, for example),
> odds are that the interrupt will eventually fire with the event_handler
> pointer being NULL.
>
> The obvious fix it to stop the timer before registering the interrupt.
>
> Observed and tested on sun7i (cubietruck).
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Daniel,
>
> Maxime asked me to forward this to you directly. Please consider merging
> it for 3.13.
>
> Thanks,
>
> 	M.
>
>   drivers/clocksource/sun4i_timer.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> index 2fb4695..a4f6119 100644
> --- a/drivers/clocksource/sun4i_timer.c
> +++ b/drivers/clocksource/sun4i_timer.c
> @@ -179,6 +179,9 @@ static void __init sun4i_timer_init(struct device_node *node)
>   	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
>   	       timer_base + TIMER_CTL_REG(0));
>
> +	/* Make sure timer is stopped before playing with interrupts */
> +	sun4i_clkevt_time_stop(0);
> +

It isn't possible to *not* enable it instead of stopping it ?

In the code before we have:

         writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
                TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
                timer_base + TIMER_CTL_REG(1));

If we remove the TIMER_CTL_ENABLE flag, wouldn't it fix the issue ?


>   	ret = setup_irq(irq, &sun4i_timer_irq);
>   	if (ret)
>   		pr_warn("failed to setup irq %d\n", irq);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
