From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 17 Aug 2015 22:10:02 +0800
Subject: [PATCH v2 1/5] clocksource: mediatek: do not enable GPT_CLK_EVT
 when setup
In-Reply-To: <55CC56C4.8080201@linaro.org>
References: <CAGS+omD8k_Cfxv3bYyjmjtLbiavo-WmJPn0Z-CBhN_nnv65Tag@mail.gmail.com>
 <1437552878-3684-1-git-send-email-yingjoe.chen@mediatek.com>
 <55CC56C4.8080201@linaro.org>
Message-ID: <1439820602.3414.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-08-13 at 10:35 +0200, Daniel Lezcano wrote:
> On 07/22/2015 10:14 AM, Yingjoe Chen wrote:
> > Spurious mtk timer interrupt is noticed at boot and cause kernel
> > crash. It seems if GPT is enabled, it will latch irq status even
> > when its IRQ is disabled. When irq is enabled afterward, we see
> > spurious interrupt.
> > Change init flow to only enable GPT_CLK_SRC at mtk_timer_init.
> >
> > Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >
> > Update to my patch [1], added __init as Daniel suggest. This is the
> > only patch that need to change in that series, so I only sent this one.
> >
> > http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001545.html
> >
> >   drivers/clocksource/mtk_timer.c | 16 ++++++++++------
> >   1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
> > index 68ab423..2ba5b66 100644
> > --- a/drivers/clocksource/mtk_timer.c
> > +++ b/drivers/clocksource/mtk_timer.c
> > @@ -156,9 +156,11 @@ static void mtk_timer_global_reset(struct mtk_clock_event_device *evt)
> >   	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
> >   }
> >
> > -static void
> > -mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
> > +static void __init mtk_timer_setup(struct mtk_clock_event_device *evt,
> > +				   u8 timer, u8 option, bool enable)
> >   {
> > +	u32 val;
> > +
> >   	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
> >   		evt->gpt_base + TIMER_CTRL_REG(timer));
> >
> > @@ -167,8 +169,10 @@ mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
> >
> >   	writel(0x0, evt->gpt_base + TIMER_CMP_REG(timer));
> >
> > -	writel(TIMER_CTRL_OP(option) | TIMER_CTRL_ENABLE,
> > -			evt->gpt_base + TIMER_CTRL_REG(timer));
> > +	val = TIMER_CTRL_OP(option);
> > +	if (enable)
> > +		val |= TIMER_CTRL_ENABLE;
> > +	writel(val, evt->gpt_base + TIMER_CTRL_REG(timer));
> 
> Instead of the 'enable' new option, I prefer a test with 'timer' with a 
> comment:
> 
> 	/*
> 	 * the timer hw is broken in that way ... bla bla, so we only
> 	 * enable the clocksource ...
> 	 */
> 	if (timer == GPT_CLK_SRC)
> 		val |= TIMER_CTRL_ENABLE;

Hi Daniel,

Thanks for your review.
Since this bug happens to anyone using interrupt, I'm not sure checking
timer and only enable it for GPT_CLK_SRC is easier to read. Anyway, I'll
change to this in next version.

> That said, can you have a look at commit 1096be08 ?
> "clockevents: sun5i: Fix setup_irq init sequence"
> 
> first and check if moving the interrupt request after the 
> clockevents_config_and_register could fix your issue.

I've tested this before, see:

http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000539.html
http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000551.html

Joe.C
