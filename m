From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 31 Oct 2016 11:06:47 -0700
Subject: [PATCH v14 1/4] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1477896558.5376.13.camel@mtksdaap41>
References: <1477020742-13889-1-git-send-email-erin.lo@mediatek.com>
 <1477020742-13889-2-git-send-email-erin.lo@mediatek.com>
 <20161028011753.GS26139@codeaurora.org>
 <1477896558.5376.13.camel@mtksdaap41>
Message-ID: <20161031180647.GR16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31, James Liao wrote:
> On Thu, 2016-10-27 at 18:17 -0700, Stephen Boyd wrote:
> > On 10/21, Erin Lo wrote:
> > > @@ -244,3 +256,31 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
> > >  			clk_data->clks[mc->id] = clk;
> > >  	}
> > >  }
> > > +
> > > +void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> > > +			int num, void __iomem *base, spinlock_t *lock,
> > > +				struct clk_onecell_data *clk_data)
> > > +{
> > > +	struct clk *clk;
> > > +	int i;
> > > +
> > > +	for (i = 0; i <  num; i++) {
> > > +		const struct mtk_clk_divider *mcd = &mcds[i];
> > > +
> > > +		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> > 
> > NULL is a valid clk. IS_ERR_OR_NULL is usually wrong.
> 
> Why NULL is a valid clk?

Perhaps at some point we'll want to return a NULL pointer to
clk_get() callers so that they can handle things like optional
clocks easily without having any storage requirements. I don't
know if we'll ever do that, but that's just a possibility.

> 
> clk_data is designed for multiple initialization from different clock
> types, such as infra_clk_data in clk-mt2701.c. So it will ignore valid
> clocks to avoid duplicated clock registration. Here I assume a clock
> pointer with error code or NULL to be an invalid (not initialized)
> clock.
> 

Ok. Would it be possible to initialize the array with all error
pointers? That would make things less error prone, but it
probably doesn't matter at all anyway because this is done during
registration time. IS_ERR_OR_NULL makes me take a second look
each time, because it's usually wrong.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
