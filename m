From: plaes@plaes.org (Priit Laes)
Date: Wed, 28 Jun 2017 17:59:49 +0000
Subject: [PATCH v4 1/6] clk: sunxi-ng: div: Add support for fixed
 post-divider
In-Reply-To: <20170627094607.2hkgzkycclboemvu@flea.lan>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <bc043a64775ec8c9cfcfe6d638e348d38e34eba3.1498422562.git-series.plaes@plaes.org>
 <20170627094607.2hkgzkycclboemvu@flea.lan>
Message-ID: <20170628175949.GA3706@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 11:46:07AM +0200, Maxime Ripard wrote:
> Hi!
> 
> On Sun, Jun 25, 2017 at 11:45:42PM +0300, Priit Laes wrote:
> > SATA clock on sun4i/sun7i is of type (parent) / M / 6 where
> > 6 is fixed post-divider.
> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  drivers/clk/sunxi-ng/ccu_div.c | 12 ++++++++++--
> >  drivers/clk/sunxi-ng/ccu_div.h |  3 ++-
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
> > index c0e5c10..de30e15 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.c
> > +++ b/drivers/clk/sunxi-ng/ccu_div.c
> > @@ -62,8 +62,13 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
> >  	parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
> >  						  parent_rate);
> >  
> > -	return divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> > -				   cd->div.flags);
> > +	val = divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> > +				  cd->div.flags);
> > +
> > +	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > +		val /= cd->fixed_post_div;
> > +
> > +	return val;
> >  }
> >  
> >  static int ccu_div_determine_rate(struct clk_hw *hw,
> > @@ -89,6 +94,9 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
> >  	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
> >  			      cd->div.flags);
> >  
> > +	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > +		val *= cd->fixed_post_div;
> > +
> >  	spin_lock_irqsave(cd->common.lock, flags);
> >  
> >  	reg = readl(cd->common.base + cd->common.reg);
> 
> You also need to adjust the round rate call back to take into account
> the post divider before calling divider_round_rate_parent, and after
> since that function can modify the parent_rate.

Is there a way to trigger this function? I don't see it getting called.

> > diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
> > index 08d0744..f3a5028 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.h
> > +++ b/drivers/clk/sunxi-ng/ccu_div.h
> > @@ -86,9 +86,10 @@ struct ccu_div_internal {
> >  struct ccu_div {
> >  	u32			enable;
> >  
> > -	struct ccu_div_internal		div;
> > +	struct ccu_div_internal	div;
> 
> Spurious change?

Nope, it was not indented the same way as other variables.
Should I send it as separate patch?

> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
