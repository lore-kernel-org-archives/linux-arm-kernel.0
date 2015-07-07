From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 7 Jul 2015 17:28:38 +0800
Subject: [PATCH] clk: mediatek: Add MT8173 MMPLL change rate support
In-Reply-To: <57452978.oOaMP89yJM@diego>
References: <1433222760-5924-1-git-send-email-jamesjj.liao@mediatek.com>
 <57452978.oOaMP89yJM@diego>
Message-ID: <1436261318.3526.96.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tue, 2015-07-07 at 10:58 +0200, Heiko St?bner wrote:
> > +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
> > +			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
> > +			_pcw_shift)					\
> > +		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, \
> > +			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, \
> > +			NULL)
> > +
> > +const unsigned long mmpll_div_rate[] = {
> 
> static?

OK. I'll add it.

> 
> > +	MT8173_PLL_FMAX,
> > +	1000000000,
> > +	702000000,
> > +	253500000,
> > +	126750000,
> > +	0,
> 
> it's more common to label sentinel entries (the 0 marking the end) with
> 	/* sentinel */
> instead of value 0.

OK. I'll add it.

> 
> If I'm reading the code correctly, this is a mapping divider -> frequency, 
> right? So it may be nice to make this a bit more explicit, like:
> 
> struct mtk_pll_div_table {
> 	unsigned int    freq;
> 	unsigned int    div;
> };
> 
> static const struct mtk_pll_div_table mmpll_div_rate[] = {
> 	{ .freq = MT8173_PLL_FMAX, .div = 0 },
> 	{ .freq = 1000000000, .div = 1 },
> 	{ .freq = 702000000, .div = 2 },
> 	{ .freq = 253500000, .div = 3 },
> 	{ .freq = 126750000, .div = 4 },
> 	{ /* sentinel */ },
> };

Hmm.. OK. I'll try to use a more readable way to implement it.

> -------------
> 
> > -	u32 con1, pd, val;
> > +	u32 con1, val;
> >  	int pll_en;
> > 
> > -	/* set postdiv */
> > -	pd = readl(pll->pd_addr);
> > -	pd &= ~(POSTDIV_MASK << pll->data->pd_shift);
> > -	pd |= (ffs(postdiv) - 1) << pll->data->pd_shift;
> > -	writel(pd, pll->pd_addr);
> > -
> >  	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> > 
> > -	/* set pcw */
> > -	val = readl(pll->pcw_addr);
> > +	/* set postdiv */
> > +	val = readl(pll->pd_addr);
> > +	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
> > +	val |= (ffs(postdiv) - 1) << pll->data->pd_shift;
> > +
> > +	/* postdiv and pcw need to set at the same time if on same register */
> > +	if (pll->pd_addr != pll->pcw_addr) {
> > +		writel(val, pll->pd_addr);
> > +		val = readl(pll->pcw_addr);
> > +	}
> > 
> > +	/* set pcw */
> >  	val &= ~GENMASK(pll->data->pcw_shift + pll->data->pcwbits - 1,
> >  			pll->data->pcw_shift);
> >  	val |= pcw << pll->data->pcw_shift;
> 
> This whole block probably wants to be a separate patch ;-) .
> 
> While it may not affect previous pll implementations, it changes how register 
> accesses are handled and should not hide in another patch.

OK, I'll separate it.

> > @@ -135,16 +138,26 @@ static void mtk_pll_calc_values(struct mtk_clk_pll
> > *pll, u32 *pcw, u32 *postdiv, u32 freq, u32 fin)
> >  {
> >  	unsigned long fmin = 1000 * MHZ;
> > +	const unsigned long *div_rate = pll->data->div_rate;
> >  	u64 _pcw;
> >  	u32 val;
> > 
> >  	if (freq > pll->data->fmax)
> >  		freq = pll->data->fmax;
> > 
> > -	for (val = 0; val < 4; val++) {
> > +	if (div_rate) {
> > +		for (val = 1; div_rate[val] != 0; val++) {
> > +			if (freq > div_rate[val])
> > +				break;
> > +		}
> > +		val--;
> 
> if you're changing the table struct, this of course also would need to be 
> adapted.
> 
> 
> Hmm, what I don't understand is, what does MT8173_PLL_FMAX in the table, if 
> you ignore it here all the time?
> 
> So the table should probably look more like [when using the concept from 
> above]
> 
> static const struct mtk_pll_div_table mmpll_div_rate[] = {
> 	{ .freq = 1000000000, .div = 0 },
> 	{ .freq = 702000000, .div = 1 },
> 	{ .freq = 253500000, .div = 2 },
> 	{ .freq = 126750000, .div = 3 },
> 	{ /* sentinel */ },
> };

The freq-div table describes the maximum frequency of each divider
setting. Although the first element doesn't used in current
implementation, I think it's better to keep freq-div table's
completeness.


Best regards,

James
