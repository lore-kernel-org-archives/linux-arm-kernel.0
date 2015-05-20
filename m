From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 20 May 2015 12:22:38 +0200
Subject: [PATCH v2 3/9] clocksource: mediatek: do not enable GPT_CLK_EVT
 when setup
In-Reply-To: <1431763110-443-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeKFv7vCtz7WC8eiea1jBvUY9JFgJbYgjhy6LfTnBRTogw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-16 9:58 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> Spurious mtk timer interrupt is noticed at boot and cause kernel
> crash. It seems if GPT is enabled, it will latch irq status even
> when its IRQ is disabled. When irq is enabled afterward, we see
> spurious interrupt.
> Change init flow to only enable GPT_CLK_SRC at mtk_timer_init.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/clocksource/mtk_timer.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
> index 68ab423..91206f9 100644
> --- a/drivers/clocksource/mtk_timer.c
> +++ b/drivers/clocksource/mtk_timer.c
> @@ -157,8 +157,11 @@ static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
>  }
>
>  static void
> -mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
> +mtk_timer_setup(struct mtk_clock_event_device *evt,
> +               u8 timer, u8 option, u8 enable)

Nicer would be:
static void mtk_timer_setup(struct mtk_clock_event_device *evt,    u8 timer,
            u8 option, u8 enable)

Apart from that parameter enable should be of type bool.

Thanks,
Matthias

-- 
motzblog.wordpress.com
