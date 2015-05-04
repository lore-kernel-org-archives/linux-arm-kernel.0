From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 04 May 2015 10:14:56 +0200
Subject: [PATCH 1/7] clocksource: mediatek: Don't run event_handler if
 it is NULL
In-Reply-To: <1430466210-22963-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
 <1430466210-22963-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <55472A80.9020904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2015 09:43 AM, Yingjoe Chen wrote:
> Spurious timer interrupt is noticed in mtk timer and cause kernel
> crash. In mtk_timer_interrupt(), only run event_handler if it is
> not NULL.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>   drivers/clocksource/mtk_timer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
> index 68ab423..85e0ab5 100644
> --- a/drivers/clocksource/mtk_timer.c
> +++ b/drivers/clocksource/mtk_timer.c
> @@ -143,7 +143,8 @@ static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
>
>   	/* Acknowledge timer0 irq */
>   	writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
> -	evt->dev.event_handler(&evt->dev);
> +	if (evt->dev.event_handler)
> +		evt->dev.event_handler(&evt->dev);
>
>   	return IRQ_HANDLED;
>   }
>

This fix does not look good.

Could you try by requesting the irq *after* 
clockevents_config_and_register in the init sequence [1] ?

Thanks
   -- Daniel

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1096be084ac59927158ce80ff1d31c33eed0e565

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
