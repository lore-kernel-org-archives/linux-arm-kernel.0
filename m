From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 10 Aug 2017 09:31:43 +0800
Subject: [PATCH] clk: bulk: call of_clk_get() when id is NULL
In-Reply-To: <20170809173318.GD2146@codeaurora.org>
References: <1502243442-28055-1-git-send-email-shawnguo@kernel.org>
 <20170809173318.GD2146@codeaurora.org>
Message-ID: <20170810013141.GC31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for the review comments.

On Wed, Aug 09, 2017 at 10:33:18AM -0700, Stephen Boyd wrote:
> On 08/09, Shawn Guo wrote:
> > From: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Most of clk API users have their clocks defined in device tree, and
> > client drivers will have to parse clk ids from DT 'clock-names'
> > property before using clk_bulk_get().  This is a burden for client
> > driver code.  And 'clock-names' being an optional DT property makes
> > it even worse.  The client driver will have no way to provide clock
> > id.
> > 
> > The patch makes a little improvement on clk_bulk_get() to call
> > of_clk_get() with index for DT users, if clock id is not available,
> > so that client drivers working with DT can use clk_bulk_get() to
> > retrieve clocks more easily.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/clk/clk-bulk.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> > index c834f5abfc49..65cee595a67e 100644
> > --- a/drivers/clk/clk-bulk.c
> > +++ b/drivers/clk/clk-bulk.c
> > @@ -39,7 +39,10 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
> >  		clks[i].clk = NULL;
> >  
> >  	for (i = 0; i < num_clks; i++) {
> > -		clks[i].clk = clk_get(dev, clks[i].id);
> > +		if (clks[i].id)
> > +			clks[i].clk = clk_get(dev, clks[i].id);
> > +		else if (dev->of_node)
> > +			clks[i].clk = of_clk_get(dev->of_node, i);
> 
> This seems a little too magical. The omission of an id in an
> array of clks would mean that only that one clk is acquired
> through of_clk_get(). We could have a mixture of ids and no ids
> for some device, and then do very odd things.

Yes, I agree.

> How about we add a flag to clk_bulk_data that indicates we want
> it to use of_clk_get() instead of clk_get() for all of the clks?
> Then the id is ignored for the entire function.

Good suggestion.

> Also, this patch needs to document the new behavior somewhere in
> the kernel-doc for this function.

Okay, I will take care of it with the new version.

Shawn
