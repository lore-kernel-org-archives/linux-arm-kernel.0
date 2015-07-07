From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Jul 2015 07:10:11 +0200
Subject: [PATCH v4] clk: change clk_ops' ->determine_rate() prototype
In-Reply-To: <20150706213210.GB20866@codeaurora.org>
References: <1436202872-26533-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150706213210.GB20866@codeaurora.org>
Message-ID: <20150707071011.399b9b78@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, 6 Jul 2015 14:32:10 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 07/06, Boris Brezillon wrote:
> > Clock rates are stored in an unsigned long field, but ->determine_rate()
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can lead
> > to long overflow if the clock rate exceed 2Ghz.
> > 
> > Change ->determine_rate() prototype to return 0 or an error code, and pass
> > a pointer to a clk_rate_request structure containing the expected target
> > rate and the rate constraints imposed by clk users.
> > 
> > The clk_rate_request structure might be extended in the future to contain
> > other kind of constraints like the rounding policy, the maximum clock
> > inaccuracy or other things that are not yet supported by the CCF
> > (power consumption constraints ?).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Which files did you compile? 
> 
> drivers/clk/mmp/clk-mix.c: In function ?mmp_clk_mix_determine_rate?:
> drivers/clk/mmp/clk-mix.c:221:13: error: ?rate? undeclared (first use in this function)
> 

Hm, I only compile tested the multi_v5 and multi_v7 defconfigs, and
obviously it was a bad idea (just thought all the impacted platforms
were already converted to multiplatform support).

[...]

> > -long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
> > -				       unsigned long min_rate,
> > -				       unsigned long max_rate,
> > -				       unsigned long *best_parent_rate,
> > -				       struct clk_hw **best_parent_clk)
> > +int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
> > +				      struct clk_rate_request *req)
> >  {
> >  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> >  	struct dpll_data *dd;
> >  
> > -	if (!hw || !rate)
> > +	if (!hw || !req || !req->rate)
> 
> Why do we need to check for req? It shouldn't be NULL.

We don't, I'll remove this test.

[...]

> > -long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
> > -					unsigned long min_rate,
> > -					unsigned long max_rate,
> > -					unsigned long *best_parent_rate,
> > -					struct clk_hw **best_parent_clk)
> > +int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
> > +				       struct clk_rate_request *req)
> >  {
> >  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> >  	struct dpll_data *dd;
> >  
> > -	if (!hw || !rate)
> > +	if (!hw || !req || !req->rate)
> 
> Same comment here. And why would we care about hw being NULL
> either for that matter.

Yes, but I'm not sure this removal should be done in the same patch.
Let me know if you think otherwise.


> > -static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
> > -			      unsigned long min_rate,
> > -			      unsigned long max_rate,
> > -			      unsigned long *best_parent_rate,
> > -			      struct clk_hw **best_parent_p)
> > +static int mmc_clk_determine_rate(struct clk_hw *hw,
> > +				  struct clk_rate_request *req)
> >  {
> >  	struct clk_mmc *mclk = to_mmc(hw);
> > -	unsigned long best = 0;
> >  
> > -	if ((rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
> > -		rate = 13000000;
> > -		best = 26000000;
> > -	} else if (rate <= 26000000) {
> > -		rate = 25000000;
> > -		best = 180000000;
> > -	} else if (rate <= 52000000) {
> > -		rate = 50000000;
> > -		best = 360000000;
> > -	} else if (rate <= 100000000) {
> > -		rate = 100000000;
> > -		best = 720000000;
> > +	req->best_parent_hw = __clk_get_hw(__clk_get_parent(hw->clk));
> > +
> 
> Where did this come from? We weren't setting the best_parent_p
> pointer before.

It comes from a previous version where I was not assigning the
->best_parent_hw field to the current parent in the core code.
I fixed it in the meantime, but forgot to remove this assignment.


> > -static long
> > -clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
> > -		       unsigned long min_rate, unsigned long max_rate,
> > -		       unsigned long *p_rate, struct clk_hw **p)
> > +static int
> > +clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> >  {
> > +	struct clk *parent = __clk_get_parent(hw->clk);
> >  	struct clk_pll *pll = to_clk_pll(hw);
> >  	const struct pll_freq_tbl *f;
> >  
> > -	f = find_freq(pll->freq_tbl, rate);
> > +	req->best_parent_hw = __clk_get_hw(parent);
> > +	req->best_parent_rate = __clk_get_rate(parent);
> > +
> > +	f = find_freq(pll->freq_tbl, req->rate);
> >  	if (!f)
> > -		return clk_pll_recalc_rate(hw, *p_rate);
> > +		req->rate = clk_pll_recalc_rate(hw, req->best_parent_rate);
> > +	else
> > +		req->rate = f->freq;
> >  
> >  	return f->freq;
> 
> return 0?
> 

Yes, I'll fix that one too.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
