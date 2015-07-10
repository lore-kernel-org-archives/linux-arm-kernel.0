From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 13:46:37 +0800
Subject: [PATCH v2 2/2] clk: mediatek: Add MT8173 MMPLL change rate support
In-Reply-To: <559DC44A.1030900@codeaurora.org>
References: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436344666-25645-3-git-send-email-jamesjj.liao@mediatek.com>
 <559DC44A.1030900@codeaurora.org>
Message-ID: <1436507197.3526.119.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, 2015-07-08 at 17:46 -0700, Stephen Boyd wrote:
> On 07/08/2015 01:37 AM, James Liao wrote:
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index 68af518..622e7b6 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -138,16 +138,28 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >  		u32 freq, u32 fin)
> >  {
> >  	unsigned long fmin = 1000 * MHZ;
> > +	const struct mtk_pll_div_table *div_table = pll->data->div_table;
> >  	u64 _pcw;
> >  	u32 val;
> >  
> >  	if (freq > pll->data->fmax)
> >  		freq = pll->data->fmax;
> >  
> > -	for (val = 0; val < 4; val++) {
> > +	if (div_table) {
> > +		if (freq > div_table[0].freq)
> > +			freq = div_table[0].freq;
> > +
> > +		for (val = 0; div_table[val + 1].freq != 0; val++) {
> > +			if (freq > div_table[val + 1].freq)
> > +				break;
> > +		}
> >  		*postdiv = 1 << val;
> > -		if (freq * *postdiv >= fmin)
> > -			break;
> > +	} else {
> > +		for (val = 0; val < 5; val++) {
> > +			*postdiv = 1 << val;
> > +			if ((u64)freq * *postdiv >= fmin)
> >
> 
> No mention of this cast in the commit text. Is this fixing a bug? If so,
> please mention it and/or split this bug fix off of this patch.
> 

Yes, this is a fix to avoid u32 overflow. I'll split it in next patch.


Best regards,

James
