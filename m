From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 6 May 2015 18:31:07 +0200
Subject: [PATCH v3 2/7] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <1430895299.15154.9.camel@mhfsdcap03>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
 <1430214525-19198-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g@mail.gmail.com>
 <1430895299.15154.9.camel@mhfsdcap03>
Message-ID: <CAPDyKFr+FTXAzYVn3F41dmw2zW01pSbSHPfGJHXbUFLJfvQ5CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 May 2015 at 08:54, chaotian.jing <chaotian.jing@mediatek.com> wrote:
> Dear Ulf,
>
> Thanks for your review.
> I must do a explain of our MMC host:
> Source clock is source clock of the MMC bus, MMC host has a divider to
> get different bus clock frequency. now the runtime suspend is gating
> this clock.
>
> Hclk is the power domain of the MMC host, if Hclk is gated, the MMC host
> cannot work(all registers readout is zero). and, all registers would be
> reset to default value if Hclk is gated/ungated.
> At MT8173, MSDC0 and MSDC2 has independent Hclk, MSDC1 and MSDC3's Hclk
> was controlled by "Infra module".

Thanks for clarifying!

I don't have enough knowledge about your SoC to understand the detail,
but it seems like we are mixing clocks and power domains. I would
rather keep this separate - if the HW allows it.

I guess the key question I have is the following:
1) Is it hardware wise possible to gate the hclk, but without gating
the power domain?
2) At what level is the reference counting done for each device in the
power domain? In HW or in sofftware?

>
> And, our MMC host has ability to control the gate/ungate of bus clock
> automatically, in MSDC_CFG bit 1, if this bit is set to 0, then "bus
> clock is gated to 0 if no command or data is transmitted".
> So, if the runtime PM do not control the Source clock, Hclk, then the
> runtime PM is needless.
>
> if runtime PM do gate/ungate Hclk, then need do save/restore the
> registers meanwhile.

Yes agree, that's a common thing to deal with from runtime PM callbacks.

>
> So, how about your suggestion ?
> do we still need runtime PM ?

Yes, I definitely think you need it!

Kind regards
Uffe
