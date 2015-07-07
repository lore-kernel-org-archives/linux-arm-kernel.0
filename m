From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 07 Jul 2015 12:46:49 +0200
Subject: [PATCH] clk: mediatek: Add MT8173 MMPLL change rate support
In-Reply-To: <1436262525.3526.103.camel@mtksdaap41>
References: <1433222760-5924-1-git-send-email-jamesjj.liao@mediatek.com>
 <1618189.7QkIIkOn1c@diego> <1436262525.3526.103.camel@mtksdaap41>
Message-ID: <20520682.74UErhVrG0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. Juli 2015, 17:48:45 schrieb James Liao:
> Hi Heiko,
> 
> On Tue, 2015-07-07 at 11:34 +0200, Heiko St?bner wrote:
> > > > > @@ -135,16 +138,26 @@ static void mtk_pll_calc_values(struct
> > > > > mtk_clk_pll
> > > > > *pll, u32 *pcw, u32 *postdiv, u32 freq, u32 fin)
> > > > > 
> > > > >  {
> > > > >  
> > > > >  	unsigned long fmin = 1000 * MHZ;
> > > > > 
> > > > > +	const unsigned long *div_rate = pll->data->div_rate;
> > > > > 
> > > > >  	u64 _pcw;
> > > > >  	u32 val;
> > > > >  	
> > > > >  	if (freq > pll->data->fmax)
> > > > >  	
> > > > >  		freq = pll->data->fmax;
> > > > > 
> > > > > -	for (val = 0; val < 4; val++) {
> > > > > +	if (div_rate) {
> > > > > +		for (val = 1; div_rate[val] != 0; val++) {
> > > > > +			if (freq > div_rate[val])
> > > > > +				break;
> > > > > +		}
> > > > > +		val--;
> > > > 
> > > > if you're changing the table struct, this of course also would need to
> > > > be
> > > > adapted.
> > > > 
> > > > 
> > > > Hmm, what I don't understand is, what does MT8173_PLL_FMAX in the
> > > > table,
> > > > if
> > > > you ignore it here all the time?
> > > > 
> > > > So the table should probably look more like [when using the concept
> > > > from
> > > > above]
> > > > 
> > > > static const struct mtk_pll_div_table mmpll_div_rate[] = {
> > > > 
> > > > 	{ .freq = 1000000000, .div = 0 },
> > > > 	{ .freq = 702000000, .div = 1 },
> > > > 	{ .freq = 253500000, .div = 2 },
> > > > 	{ .freq = 126750000, .div = 3 },
> > > > 	{ /* sentinel */ },
> > > > 
> > > > };
> > > 
> > > The freq-div table describes the maximum frequency of each divider
> > > setting. Although the first element doesn't used in current
> > > implementation, I think it's better to keep freq-div table's
> > > completeness.
> > 
> > the issue I see is, that its value is currently 0 and the code substracts
> > 1. So if anything would (accidentially) select MT8173_PLL_FMAX, the u32
> > val would wrap around, as you're subtracting 1 from 0 .
> 
> Subtracting 1 from val is safe now because it starts from 1:
> 
>   for (val = 1; div_rate[val] != 0; val++) {
>     ...
>   }
>   val--;
> 
> I can change this implementation to a more readable one such as:
> 
>   for (val = 0; div_rate[val + 1] != 0; val++) {
>     if (freq <= div_rate[val] && freq > div_rate[val + 1]) {
>       ...
> 
> Do you think it is OK?

My issue is, that you have the MT8173_PLL_FMAX entry in the table, which is 
effectively unused, as it is ignored by the for loop. They why have it all, if 
nothing cares about it.

So if in the future somebody notices, "oh this is ignoring the first entry" 
without look further what the code does, this explodes ;-)


Heiko
