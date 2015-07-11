From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Sat, 11 Jul 2015 18:32:37 +0800
Subject: [PATCH v2 4/9] clocksource: mediatek: Use GPT as sched clock
 source
In-Reply-To: <1551938.VHQvCCENeg@ubix>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBeJhdRBBw1v1kj8J0YFVWZ27vzx5W=XU8jiwePVgL_7g_g@mail.gmail.com>
 <CAGS+omDa4X7daAYD6SDuEM6bMQwojNUCnGMGiUwnJ6M_yBTRLg@mail.gmail.com>
 <1551938.VHQvCCENeg@ubix>
Message-ID: <1436610757.17661.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-03 at 17:51 +0200, Matthias Brugger wrote:
> On Friday, July 03, 2015 09:48:42 PM Daniel Kurtz wrote:

<...>

> > >> @@ -243,6 +251,8 @@ static void __init mtk_timer_init(struct device_node
> > >> *node)>> 
> > >>         mtk_timer_setup(evt, GPT_CLK_SRC, TIMER_CTRL_OP_FREERUN, 1);
> > >>         clocksource_mmio_init(evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC),
> > >>         
> > >>                         node->name, rate, 300, 32,
> > >>                         clocksource_mmio_readl_up);
> > >> 
> > >> +       gpt_base = evt->gpt_base;
> > > 
> > > This is really hacky. We should clean up the code and provide
> > > mtk_clock_event_device globally.
> > > Please add the patch below, which does exactly this.
> > 
> > I don't think this is so hacky.
> > In light of Stephen's comment about the benefit of using
> > container_of() to extract gpt_base from the passed in struct
> > clock_event_device in the other routines, what is the benefit of
> > making more of mtk_clock_event_device global?
> > I think what Yingjoe has implemented is short and sweet.
> > 
> 
> Huh, this patch got somehow forgotten.
> Ok, just one comment. I would prefer to rename the global gpt_base to 
> gpt_sched_base or something similar and set the pointer + offset directly 
> mtk_timer_init.


In next version, I will it change to:

static void __iomem *gpt_sched_reg __read_mostly;

and in mtk_timer_init:

+       gpt_sched_reg = evt->gpt_base + TIMER_CNT_REG(GPT_CLK_SRC);

Joe.C
