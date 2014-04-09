From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 9 Apr 2014 13:58:50 -0700
Subject: [PATCH 1/4] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <1397072736-10793-2-git-send-email-matthias.bgg@gmail.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <1397072736-10793-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20140409205850.GO9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09, Matthias Brugger wrote:
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 96918e1..bb29321 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -144,6 +144,10 @@ config VF_PIT_TIMER
>  config SYS_SUPPORTS_SH_CMT
>          bool
>  
> +config MTK_TIMER
> +	bool
> +
> +

Why two newlines?

> diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
> new file mode 100644
> index 0000000..bf901e3
> --- /dev/null
> +++ b/drivers/clocksource/mtk_timer.c
> @@ -0,0 +1,248 @@
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/sched_clock.h>

Were you planning on registering a sched_clock source?

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
[...]
> +
> +static struct clock_event_device mtk_clockevent = {
> +	.name = "mtk_tick",
> +	.rating = 300,
> +	.shift = 32,

This is unnecessary as it's handled by
clockevents_config_and_register().

> +	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.set_mode = mtk_clkevt_mode,
> +	.set_next_event = mtk_clkevt_next_event,
> +};
> +
> +
> +static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;

Unnecessary cast from void.

> +
> +	/* Acknowledge timer0 irq */
> +	writel(GPT_IRQ_ACK(GPT_CLK_EVT), gpt_base + GPT_IRQ_ACK_REG);
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
[...]
> +
> +static struct irqaction mtk_timer_irq = {
> +	.name = "mtk_timer0",
> +	.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,

IRQF_DISABLED is a nop. Remove it.

> +	.handler = mtk_timer_interrupt,
> +	.dev_id = &mtk_clockevent,
> +};
> +
> +static u32 mtk_timer_sched_read(void)
> +{
> +	return readl(gpt_base + TIMER_CNT_REG(GPT_CLK_SRC));
> +}

This is unused unless you register a sched_clock source.

> +
> +static void __init mtk_timer_init(struct device_node *node)
> +{
> +	unsigned long rate = 0;
> +	struct clk *clk;
> +	int ret, irq;
> +	u32 val;
> +
> +	gpt_base = of_iomap(node, 0);
> +	if (!gpt_base)
> +		panic("Can't map registers");
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0)
> +		panic("Can't parse IRQ");
> +
> +	clk = of_clk_get_by_name(node, "sys_clk");
> +	if (IS_ERR(clk))
> +		panic("Can't get timer clock");
> +	clk_prepare_enable(clk);
> +
> +	rate = clk_get_rate(clk);
> +
> +	mtk_timer_global_reset();
> +
> +	/* Configure clock source */
> +	mtk_timer_reset(GPT_CLK_SRC);
> +
> +	writel(TIMER_CLK_SRC(TIMER_CLK_SRC_SYS13M) | TIMER_CLK_DIV1,
> +			gpt_base + TIMER_CLK_REG(GPT_CLK_SRC));
> +
> +	writel(TIMER_CTRL_OP(TIMER_CTRL_OP_FREERUN) | TIMER_CTRL_ENABLE,
> +				gpt_base + TIMER_CTRL_REG(GPT_CLK_SRC));
> +
> +	clocksource_mmio_init(gpt_base + TIMER_CNT_REG(GPT_CLK_SRC), node->name,
> +			      rate, 300, 32, clocksource_mmio_readl_up);
> +
> +	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
> +
> +	/* Configure clock event */
> +	mtk_timer_reset(GPT_CLK_EVT);
> +
> +	writel(TIMER_CLK_SRC(TIMER_CLK_SRC_SYS13M) | TIMER_CLK_DIV1,
> +			gpt_base + TIMER_CLK_REG(GPT_CLK_EVT));
> +	writel(0, gpt_base + TIMER_CMP_REG(GPT_CLK_EVT));
> +
> +	writel(TIMER_CTRL_OP(TIMER_CTRL_OP_REPEAT) | TIMER_CTRL_ENABLE,
> +			gpt_base + TIMER_CTRL_REG(GPT_CLK_EVT));
> +
> +	ret = setup_irq(irq, &mtk_timer_irq);

Most clocksource drivers use request_irq() nowadays. Can you use
that?

> +	if (ret)
> +		pr_warn("failed to setup irq %d\n", irq);
> +
> +	/* Enable timer0 interrupt */
> +	val = readl(gpt_base + GPT_IRQ_EN_REG);
> +	writel(val | GPT_IRQ_ENABLE(GPT_CLK_EVT), gpt_base + GPT_IRQ_EN_REG);
> +
> +	mtk_clockevent.cpumask = cpumask_of(0);

Is it possible for this timer to be used on SMP hardware? If so,
this should probably be cpu_all_mask. Please assign the .irq
member here as well.

> +
> +	clockevents_config_and_register(&mtk_clockevent, rate, 0x3,
> +					0xffffffff);
> +}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
