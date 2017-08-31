From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Aug 2017 22:26:30 -0700
Subject: [PATCH] clk: bulk: call of_clk_get() when id is NULL
In-Reply-To: <AM3PR04MB3064504A935B4AA0CBEE962809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1502243442-28055-1-git-send-email-shawnguo@kernel.org>
 <20170809173318.GD2146@codeaurora.org>
 <20170813141851.GD31819@dragon>
 <AM3PR04MB3064504A935B4AA0CBEE962809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170831052630.GU21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30, A.s. Dong wrote:
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > Sent: Sunday, August 13, 2017 10:19 PM
> > To: Stephen Boyd
> > Cc: Michael Turquette; A.s. Dong; linux-clk at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; Shawn Guo
> > Subject: Re: [PATCH] clk: bulk: call of_clk_get() when id is NULL
> > 
> > Hi Stephen,
> > 
> > On Wed, Aug 09, 2017 at 10:33:18AM -0700, Stephen Boyd wrote:
> > > > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c index
> > > > c834f5abfc49..65cee595a67e 100644
> > > > --- a/drivers/clk/clk-bulk.c
> > > > +++ b/drivers/clk/clk-bulk.c
> > > > @@ -39,7 +39,10 @@ int __must_check clk_bulk_get(struct device *dev,
> > int num_clks,
> > > >  		clks[i].clk = NULL;
> > > >
> > > >  	for (i = 0; i < num_clks; i++) {
> > > > -		clks[i].clk = clk_get(dev, clks[i].id);
> > > > +		if (clks[i].id)
> > > > +			clks[i].clk = clk_get(dev, clks[i].id);
> > > > +		else if (dev->of_node)
> > > > +			clks[i].clk = of_clk_get(dev->of_node, i);
> > >
> > > This seems a little too magical. The omission of an id in an array of
> > > clks would mean that only that one clk is acquired through
> > > of_clk_get(). We could have a mixture of ids and no ids for some
> > > device, and then do very odd things.
> > >
> > > How about we add a flag to clk_bulk_data that indicates we want it to
> > > use of_clk_get() instead of clk_get() for all of the clks?
> > > Then the id is ignored for the entire function.
> > 
> > I have sent v2 to add a flag to clk_bulk_data to address your comments.
> > But I just found it might not be what you want exactly, because the
> > current bulk clk APIs defines clk_bulk_data in a different way from what
> > you are asking here.
> > 
> > It seems that you think clk_bulk_data represents all the clocks that bulk
> > APIs manage, but actually it only represents one of the multiple clocks.
> > Callers need to prepare an array of clk_bulk_data to represent multiple
> > clocks.  That said, the flag we add to clk_bulk_data only affects one
> > clock instead of all clocks.
> > 
> > I feel this is something we can improve.  clk_bulk_data can be used to
> > represent all clocks, something like below.  In this case, bulk clk APIs
> > do not need to take num_clks as a separate parameter, and callers do not
> > need to maintain multiple clk_bulk_data instances.  Since we do not have
> > any in tree users of bulk clk APIs yet, we can make this semantic change
> > quickly.  Thoughts?
> > 
> 
> Flags may be better used for extending per clk feature support in the future.
> 
> IMHO how about implement a of_clk_bulk_get() to handle this issue as we already
> have a of_clk_get?
> e.g.
> 
> int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
>                               struct clk_bulk_data *clks)
> {
>         for (i = 0; i < num_clks; i++) {
>                 clks[i].clk = of_clk_get(dev, clks[i].id);
> ...
> 
> }
> 
> Then it's less intrusive.
> 

This looks ok too. Go ahead and send this version instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
