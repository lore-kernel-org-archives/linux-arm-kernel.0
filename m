From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Jan 2016 13:55:17 +0800
Subject: [PATCH v2] clk: mediatek: Allow changing PLL rate when it is off
In-Reply-To: <20160114022637.1942.4564@quark.deferred.io>
References: <1452482936-51852-1-git-send-email-jamesjj.liao@mediatek.com>
 <20160114022637.1942.4564@quark.deferred.io>
Message-ID: <1452750917.5384.24.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, 2016-01-13 at 18:26 -0800, Michael Turquette wrote:
> Hi James,
> 
> Quoting James Liao (2016-01-10 19:28:56)
> > Some modules may need to change its clock rate before turn on it.
> > So changing PLL's rate when it is off should be allowed.
> > This patch removes PLL enabled check before set rate, so that
> > PLLs can set new frequency even if they are off.
> > 
> > On MT8173 for example, ARMPLL's enable bit can be controlled by
> > other HW. That means ARMPLL may be turned on even if we (CPU / SW)
> > set ARMPLL's enable bit as 0. In this case, SW may want and can
> > still change ARMPLL's rate by changing its pcw and postdiv settings.
> > But without this patch, new pcw setting will not be applied because
> > its enable bit is 0.
> 
> Must the clock signal be enabled to change the PLL rate? If so, does
> ARMPLL set the CLK_SET_RATE_GATE flag?

No. The controlling of PLL's rate and enable are independent. So we can
change the PLL's rate when it's enabled or disabled.

> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-pll.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index 966cab1..8e31fae 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -91,9 +91,6 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >                 int postdiv)
> >  {
> >         u32 con1, val;
> > -       int pll_en;
> > -
> > -       pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> >  
> >         /* set postdiv */
> >         val = readl(pll->pd_addr);
> > @@ -114,15 +111,13 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  
> >         con1 = readl(pll->base_addr + REG_CON1);
> >  
> > -       if (pll_en)
> > -               con1 |= CON0_PCW_CHG;
> > +       con1 |= CON0_PCW_CHG;
> 
> This unconditionally enables the PLL whenever clk_set_rate is called,
> changing the previous behavior. The clk framework still tracks the
> intent of ARMPLLs users with the enable_count. How about something like
> the following:

Not really. This patch will not enable or disable PLL when we change its
rate. The PLL enable bit is bit[0], we didn't change bit[0] in
mtk_pll_set_rate_regs(), so its state will not be changed.

This patch set CON0_PCW_CHG (bit[31]) no matter the PLL is enabled or
not. So we don't need to check the enable bit[0] nor PLL state in the
framework before set bit[31].

> 	bool pll_en = clk_hw_is_enabled(&pll->hw);
> 
> 	if (pll_en)
> 		con1 |= CON0_PCW_CHG;
> 
> 	writel(con1, pll->base_addr + REG_CON1);
> 	if (pll->tuner_addr)
> 		writel(con1 + 1, pll->tuner_addr);
> 
> 	if (pll_en)
> 		udelay(20);
> 
> This does not rely on the hardware to tell us the intent of the user,
> but instead on our framework usecounting.


Best regards,

James
