From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 20 May 2015 16:46:34 +0800
Subject: [PATCH v2 5/9] ARM: mediatek: enable gpt6 on boot up to make
 arch timer working
In-Reply-To: <CABuKBeKgWc8YJeacr1VeVaOQ1hzpqdTskarDJk6W2AdfWqQ9nw@mail.gmail.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-6-git-send-email-yingjoe.chen@mediatek.com>
 <555B9438.9020404@codeaurora.org>
 <CABuKBeKgWc8YJeacr1VeVaOQ1hzpqdTskarDJk6W2AdfWqQ9nw@mail.gmail.com>
Message-ID: <1432111594.20394.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-20 at 10:43 +0200, Matthias Brugger wrote:
> 2015-05-19 21:51 GMT+02:00 Stephen Boyd <sboyd@codeaurora.org>:
> > On 05/16/15 00:58, Yingjoe Chen wrote:
> >> diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> >> index a954900..6b38d67 100644
> >> --- a/arch/arm/mach-mediatek/mediatek.c
> >> +++ b/arch/arm/mach-mediatek/mediatek.c
> >> @@ -16,6 +16,34 @@
> >>   */
> >>  #include <linux/init.h>
> >>  #include <asm/mach/arch.h>
> >> +#include <linux/of.h>
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/clocksource.h>
> >> +
> >> +
> >> +#define GPT6_CON_MT65xx 0x10008060
> >> +#define GPT_ENABLE      0x31
> >> +
> >> +static void __init mediatek_timer_init(void)
> >> +{
> >> +     void __iomem *gpt_base = 0;
> >
> >  = NULL ?
> >
> >> +
> >> +     if (of_machine_is_compatible("mediatek,mt6589") ||
> >> +         of_machine_is_compatible("mediatek,mt8135") ||
> >> +         of_machine_is_compatible("mediatek,mt8127")) {
> >> +             /* turn on GPT6 which ungates arch timer clocks */
> >> +             gpt_base = ioremap(GPT6_CON_MT65xx, 0x04);
> >> +     }
> >> +
> >> +     /* enabel clock and set to free-run */
> >
> > s/enabel/enable/
> >
> >> +     if (gpt_base) {
> >> +             writel(GPT_ENABLE, gpt_base);
> >> +             iounmap(gpt_base);
> >> +     }
> >> +
> >
> > Why not join the two conditions together?
> 
> The initial patch supposed that on different SoCs GPT6_CON register
> would be mapped on different addresses, but that seems not the case.
> So yes, we can join the two conditions together.
> 
> Yingjoe, can you add the changes in the next series or do you want me to do it?

Hi,

I'll change these in next series. Thanks.

Joe.C
