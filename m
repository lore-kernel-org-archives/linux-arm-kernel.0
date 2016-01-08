From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 8 Jan 2016 17:48:53 +0800
Subject: [PATCH] clk: mediatek: Allow changing PLL rate when it is off
In-Reply-To: <20160108091510.GC13058@pengutronix.de>
References: <1452240997-35316-1-git-send-email-jamesjj.liao@mediatek.com>
 <20160108091510.GC13058@pengutronix.de>
Message-ID: <1452246533.31362.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, 2016-01-08 at 10:15 +0100, Sascha Hauer wrote:
> On Fri, Jan 08, 2016 at 04:16:37PM +0800, James Liao wrote:
> > Some modules may need to change its clock rate before turn on it.
> > So changing PLL's rate when it is off should be allowed.
> > This patch removes PLL enabled check before set rate, so that
> > PLLs can set new frequency even if they are off.
> 
> This sounds like the software refused to change the rate on disabled
> PLLs, but this is not the case.

In fact the major change of this patch is trigger (set) CON0_PCW_CHG no
matter PLL is on or not.

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
> >  		int postdiv)
> >  {
> >  	u32 con1, val;
> > -	int pll_en;
> > -
> > -	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> >  
> >  	/* set postdiv */
> >  	val = readl(pll->pd_addr);
> > @@ -114,15 +111,13 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  
> >  	con1 = readl(pll->base_addr + REG_CON1);
> >  
> > -	if (pll_en)
> > -		con1 |= CON0_PCW_CHG;
> > +	con1 |= CON0_PCW_CHG;
> 
> This bit is described as "Feedback divide ratio update". To me this
> sounds like we have to inform the hardware that the PLL registers have
> been updated. The current code only sets this bit when the PLL is
> enabled which sounds sane to me.
> 
> >  
> >  	writel(con1, pll->base_addr + REG_CON1);
> >  	if (pll->tuner_addr)
> >  		writel(con1 + 1, pll->tuner_addr);
> >  
> > -	if (pll_en)
> > -		udelay(20);
> > +	udelay(20);
> 
> We seem to have to wait here until the PLL is really running at the new
> frequency. Normally we don't have to do this when the PLL is disabled.
> 
> I'm sure this patch solves a real problem, from looking at it it's just
> not clear to me what the problem is. Could you clarify this a bit?

On MT8173 for example, ARMPLL's enable bit can be controlled by other
HW. That means ARMPLL may be turned on even if we (CPU / SW) set
ARMPLL's enable bit as 0. In this case, SW may want and can still change
ARMPLL's rate by changing its pcw and postdiv settings. But without this
patch, new pcw setting will not be applied because its enable bit is 0.


Best regards,

James
