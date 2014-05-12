From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 11:37:27 +0200
Subject: [PATCH v2 1/4] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <1399772463-859-2-git-send-email-matthias.bgg@gmail.com>
References: <1399772463-859-1-git-send-email-matthias.bgg@gmail.com>
 <1399772463-859-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <4169260.qB0vPmmJCY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 May 2014 03:41:00 Matthias Brugger wrote:
> +
> +static void __iomem *gpt_base;
> +static u32 ticks_per_jiffy;
> +

This is not wrong, because there will only be one timer, but the
preferred way to express this in general would be to add it to the
clock_event_device pointer:

struct mtk_clock_event_device {
	void __iomem *gpt_base;
	u32 ticks_per_jiffy;
	struct clock_event_device dev;
};

static inline struct mtk_clock_event_device *to_mtk_clock(struct clock_event_device *c)
{
	return container_of(c, struct mtk_clock_event_device, dev);
}

static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
{
       struct mtk_clock_event_device *evt = dev_id;

       /* Acknowledge timer0 irq */
       writel(GPT_IRQ_ACK(GPT_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
       evt->dev.event_handler(evt);

       return IRQ_HANDLED;
}

static void mtk_clkevt_mode(enum clock_event_mode mode,
                             struct clock_event_device *clk)
{
	struct mtk_clock_event_device *evt = to_mtk_clock(clk);

        mtk_clkevt_time_stop(GPT_CLK_EVT);

        switch (mode) {
        case CLOCK_EVT_MODE_PERIODIC:
               mtk_clkevt_time_setup(evt->ticks_per_jiffy, GPT_CLK_EVT);
               mtk_clkevt_time_start(true, GPT_CLK_EVT);
               break;
        case CLOCK_EVT_MODE_ONESHOT:
               mtk_clkevt_time_start(false, GPT_CLK_EVT);
               break;
        case CLOCK_EVT_MODE_UNUSED:
        case CLOCK_EVT_MODE_SHUTDOWN:
        default:
               /* No more interrupts will occur as source is disabled */
               break;
        }
}

	Arnd
