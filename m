From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 30 Dec 2015 19:15:29 +0100
Subject: [PATCH 02/69] clocksource/drivers/mtk_timer: Fix pr_warn()
 messages in mtk_timer_init
In-Reply-To: <1450448302-27429-2-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
 <1450448302-27429-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <56841F41.8030203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/12/15 15:17, Daniel Lezcano wrote:
> From: Alexey Klimov <alexey.klimov@linaro.org>
>
> 1) Change pr_warn()s to pr_err()s. These messages are actually errors and not
>     warnings.
> 2) Add missing \n.
> 3) Error message for kzalloc() failure is removed per suggestion by Joe Perches.
>     There is generic stack_dump() for allocation issues.
>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

>   drivers/clocksource/mtk_timer.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
> index 8f99cd7..e1e0642 100644
> --- a/drivers/clocksource/mtk_timer.c
> +++ b/drivers/clocksource/mtk_timer.c
> @@ -189,10 +189,8 @@ static void __init mtk_timer_init(struct device_node *node)
>   	struct clk *clk;
>
>   	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> -	if (!evt) {
> -		pr_warn("Can't allocate mtk clock event driver struct");
> +	if (!evt)
>   		return;
> -	}
>
>   	evt->dev.name = "mtk_tick";
>   	evt->dev.rating = 300;
> @@ -206,31 +204,31 @@ static void __init mtk_timer_init(struct device_node *node)
>
>   	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer");
>   	if (IS_ERR(evt->gpt_base)) {
> -		pr_warn("Can't get resource\n");
> +		pr_err("Can't get resource\n");
>   		return;
>   	}
>
>   	evt->dev.irq = irq_of_parse_and_map(node, 0);
>   	if (evt->dev.irq <= 0) {
> -		pr_warn("Can't parse IRQ");
> +		pr_err("Can't parse IRQ\n");
>   		goto err_mem;
>   	}
>
>   	clk = of_clk_get(node, 0);
>   	if (IS_ERR(clk)) {
> -		pr_warn("Can't get timer clock");
> +		pr_err("Can't get timer clock\n");
>   		goto err_irq;
>   	}
>
>   	if (clk_prepare_enable(clk)) {
> -		pr_warn("Can't prepare clock");
> +		pr_err("Can't prepare clock\n");
>   		goto err_clk_put;
>   	}
>   	rate = clk_get_rate(clk);
>
>   	if (request_irq(evt->dev.irq, mtk_timer_interrupt,
>   			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
> -		pr_warn("failed to setup irq %d\n", evt->dev.irq);
> +		pr_err("failed to setup irq %d\n", evt->dev.irq);
>   		goto err_clk_disable;
>   	}
>
>
