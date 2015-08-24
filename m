From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 24 Aug 2015 22:35:24 +0800
Subject: [PATCH] clockevents/drivers/mtk: Fix spurious interrupt leading
 to crash
In-Reply-To: <1440423045-7883-1-git-send-email-daniel.lezcano@linaro.org>
References: <1440167950.20169.29.camel@mtksdaap41>
 <1440423045-7883-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1440426924.17418.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-24 at 15:30 +0200, Daniel Lezcano wrote:
> After analysis done by Yingjoe Chen, the timer appears to have a pending
> interrupt when it is enabled.
>
> Fix this by acknowledging the pending interrupt when enabling the timer
> interrupt.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,


Thanks for your patch, this can fix the boot issue.
Tested-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

> ---
>  drivers/clocksource/mtk_timer.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
> index 4cd16fb..13543a8 100644
> --- a/drivers/clocksource/mtk_timer.c
> +++ b/drivers/clocksource/mtk_timer.c
> @@ -156,14 +156,6 @@ static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
> -{
> -	/* Disable all interrupts */
> -	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
> -	/* Acknowledge all interrupts */
> -	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
> -}
> -
>  static void
>  mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
>  {
> @@ -183,6 +175,9 @@ static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
>  {
>  	u32 val;
>  
> +        /* Acknowledge all spurious pending interrupts */
> +        writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);

This should use tab to indent.

> +
>  	val = readl(evt->gpt_base + GPT_IRQ_EN_REG);
>  	writel(val | GPT_IRQ_ENABLE(timer),
>  			evt->gpt_base + GPT_IRQ_EN_REG);
> @@ -232,8 +227,6 @@ static void __init mtk_timer_init(struct device_node *node)
>  	}
>  	rate = clk_get_rate(clk);
>  
> -	mtk_timer_global_reset(evt);
> -

I think we should keep this one, or at least disable irq first in
mtk_timer_enable_irq. MT8173 firmware didn't use this GPT, but I think
it is a good ideat to do it just in case firmware in some other platform
use it.

Joe.C
