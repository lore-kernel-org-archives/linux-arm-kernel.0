From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Sep 2014 11:49:15 +0200
Subject: [PATCHv2 4/4] clocksource: tcb_clksrc: unprepare clock in case
 of failure
In-Reply-To: <1409329003-17252-5-git-send-email-g.portay@overkiz.com>
References: <1409329003-17252-1-git-send-email-g.portay@overkiz.com>
 <1409329003-17252-5-git-send-email-g.portay@overkiz.com>
Message-ID: <5406E41B.1040406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2014 06:16 PM, Ga?l PORTAY wrote:
> The clock is not unprepared in case of the request IRQ fails.
>
> Also update to request_irq.
>
> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/tcb_clksrc.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index f922e81..8bdbc45 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -178,12 +178,6 @@ static irqreturn_t ch2_irq(int irq, void *handle)
>   	return IRQ_NONE;
>   }
>
> -static struct irqaction tc_irqaction = {
> -	.name		= "tc_clkevt",
> -	.flags		= IRQF_TIMER,
> -	.handler	= ch2_irq,
> -};
> -
>   static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
>   {
>   	int ret;
> @@ -198,15 +192,16 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
>
>   	clkevt.regs = tc->regs;
>   	clkevt.clk = t2_clk;
> -	tc_irqaction.dev_id = &clkevt;
>
>   	timer_clock = clk32k_divisor_idx;
>
>   	clkevt.clkevt.cpumask = cpumask_of(0);
>
> -	ret = setup_irq(irq, &tc_irqaction);
> -	if (ret)
> +	ret = request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
> +	if (ret) {
> +		clk_disable_unprepare(t2_clk);
>   		return ret;
> +	}
>
>   	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
