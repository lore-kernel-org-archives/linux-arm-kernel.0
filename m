From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 7 May 2015 09:42:36 +0800
Subject: [PATCH v3 2/7] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <CAPDyKFr+FTXAzYVn3F41dmw2zW01pSbSHPfGJHXbUFLJfvQ5CA@mail.gmail.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
 <1430214525-19198-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFq=R9B6ZHHgmDcSg-TNSfqQKAUKc2NjACvpwxFpmk954g@mail.gmail.com>
 <1430895299.15154.9.camel@mhfsdcap03>
 <CAPDyKFr+FTXAzYVn3F41dmw2zW01pSbSHPfGJHXbUFLJfvQ5CA@mail.gmail.com>
Message-ID: <1430962956.15154.48.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ulf,

Thanks!
Below is my comment:

On Wed, 2015-05-06 at 18:31 +0200, Ulf Hansson wrote:
> On 6 May 2015 at 08:54, chaotian.jing <chaotian.jing@mediatek.com> wrote:
> > Dear Ulf,
> >
> > Thanks for your review.
> > I must do a explain of our MMC host:
> > Source clock is source clock of the MMC bus, MMC host has a divider to
> > get different bus clock frequency. now the runtime suspend is gating
> > this clock.
> >
> > Hclk is the power domain of the MMC host, if Hclk is gated, the MMC host
> > cannot work(all registers readout is zero). and, all registers would be
> > reset to default value if Hclk is gated/ungated.
> > At MT8173, MSDC0 and MSDC2 has independent Hclk, MSDC1 and MSDC3's Hclk
> > was controlled by "Infra module".
Sorry for mistake, MSDC0 and MSDC3 has independent Hclk, MSDC1 and
MSDC2's Hclk was controlled by "Infra module". the Infra module is a
"power saving module", when the system go to sleep, Infra module will be
set and MSDC1 & MSDC2's Hclk will be gated automatically.
> 
> Thanks for clarifying!
> 
> I don't have enough knowledge about your SoC to understand the detail,
> but it seems like we are mixing clocks and power domains. I would
> rather keep this separate - if the HW allows it.
> 
> I guess the key question I have is the following:
> 1) Is it hardware wise possible to gate the hclk, but without gating
> the power domain?
> 2) At what level is the reference counting done for each device in the
> power domain? In HW or in sofftware?
> 

Actually, Our MMC host do not have power domain, all the control of the
host is the Hclk.
> >
> > And, our MMC host has ability to control the gate/ungate of bus clock
> > automatically, in MSDC_CFG bit 1, if this bit is set to 0, then "bus
> > clock is gated to 0 if no command or data is transmitted".
> > So, if the runtime PM do not control the Source clock, Hclk, then the
> > runtime PM is needless.
> >
> > if runtime PM do gate/ungate Hclk, then need do save/restore the
> > registers meanwhile.
> 
> Yes agree, that's a common thing to deal with from runtime PM callbacks.
> That means that the runtime PM need gate/ungate source clock and Hclk ?
If it is, then need do save registers before gate Hclk and restore
registers after ungate Hclk.
> >
> > So, how about your suggestion ?
> > do we still need runtime PM ?
> 
> Yes, I definitely think you need it!
> 
> Kind regards
> Uffe
