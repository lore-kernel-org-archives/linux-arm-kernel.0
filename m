From: drinkcat@chromium.org (Nicolas Boichat)
Date: Wed, 28 Nov 2018 07:54:00 +0800
Subject: [PATCH v2 03/11] clk: mediatek: Disable tuner_en before change
 PLL rate
In-Reply-To: <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com>
References: <20181127034254.24721-1-weiyi.lu@mediatek.com>
 <20181127034254.24721-5-weiyi.lu@mediatek.com>
 <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com>
Message-ID: <CANMq1KB4tt9jdmE+LJXfji=QXC9-6wuhXWjJPkpNfo6hEMXH=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 4:37 AM Sean Wang <sean.wang@kernel.org> wrote:
>
> Weiyi Lu <weiyi.lu@mediatek.com> ? 2018?11?26? ?? ??7:45???
> >
> > From: Owen Chen <owen.chen@mediatek.com>
> >
> > PLLs with tuner_en bit, such as APLL1, need to disable
> > tuner_en before apply new frequency settings, or the new frequency
> > settings (pcw) will not be applied.
> > The tuner_en bit will be disabled during changing PLL rate
> > and be restored after new settings applied.
>
> It looks like a bug fix. If so, you should add a fixes tag and even cc
> stable tree
>
> >
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index 1db161aced31..81400601f107 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -27,7 +27,7 @@
> >  #define CON0_BASE_EN           BIT(0)
> >  #define CON0_PWR_ON            BIT(0)
> >  #define CON0_ISO_EN            BIT(1)
> > -#define CON0_PCW_CHG           BIT(31)
> > +#define CON1_PCW_CHG           BIT(31)
>
> it seems like an unnecessary change

Below, you have:
con1 |= CON1_PCW_CHG;

Presumably PCW_CHG is on BIT(31) of CON1(?), so I think this is a good
change. Maybe this needs to be a separate patch, though?

> >
> >  #define AUDPLL_TUNER_EN                BIT(31)
> >
> > @@ -97,9 +97,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  {
> >         u32 con1, val;
> >         int pll_en;
> > +       u32 tuner_en = 0;
> > +       u32 tuner_en_mask;
> > +       void __iomem *tuner_en_addr = NULL;
> >
> >         pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> >
> > +       /* disable tuner */
>
> similar code pieces are ready on mtk_pll_[un]prepare. maybe we can add
> common tuner operations for them to reuse.
>
> > +       if (pll->tuner_en_addr) {
> > +               tuner_en_addr = pll->tuner_en_addr;
> > +               tuner_en_mask = BIT(pll->data->tuner_en_bit);
> > +       } else if (pll->tuner_addr) {
> > +               tuner_en_addr = pll->tuner_addr;
> > +               tuner_en_mask = AUDPLL_TUNER_EN;
> > +       }
> > +
> > +       if (tuner_en_addr) {
> > +               val = readl(tuner_en_addr);
> > +               tuner_en = val & tuner_en_mask;
> > +
> > +               if (tuner_en) {
> > +                       val &= ~tuner_en_mask;
> > +                       writel(val, tuner_en_addr);
> > +               }
> > +       }
> > +
> >         /* set postdiv */
> >         val = readl(pll->pd_addr);
> >         val &= ~(POSTDIV_MASK << pll->data->pd_shift);
> > @@ -120,12 +142,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >         con1 = readl(pll->base_addr + REG_CON1);
> >
> >         if (pll_en)
> > -               con1 |= CON0_PCW_CHG;
> > +               con1 |= CON1_PCW_CHG;
> >
> >         writel(con1, pll->base_addr + REG_CON1);
> >         if (pll->tuner_addr)
> >                 writel(con1 + 1, pll->tuner_addr);
> >
> > +       /* restore tuner_en */
> > +       if (tuner_en_addr && tuner_en) {
>
> if (tuner_en) is sufficient
>
> > +               val = readl(tuner_en_addr);
> > +               val |= tuner_en_mask;
> > +               writel(val, tuner_en_addr);
> > +       }
> > +
> >         if (pll_en)
> >                 udelay(20);
> >  }
> > --
> > 2.18.0
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
