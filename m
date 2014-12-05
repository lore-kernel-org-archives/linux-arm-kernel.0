From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Dec 2014 10:38:49 -0800
Subject: regression: Clock changes in next-20141205 break at least omap4
In-Reply-To: <5481F79D.4010504@codeaurora.org>
References: <20141205165539.GA30437@atomide.com>
 <5481F79D.4010504@codeaurora.org>
Message-ID: <20141205183849.GB30437@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Boyd <sboyd@codeaurora.org> [141205 10:23]:
> On 12/05/2014 08:55 AM, Tony Lindgren wrote:
> > Hi,
> >
> > Looks like commit 646cafc6aa4d ("clk: Change clk_ops->determine_rate
> > to return a clk_hw as the best parent") breaks booting at least for
> > omap4.
> 
> Do you get a compilation warning in arch/arm/mach-omap2/dpll3xxx.c ?

Yes so it seems.

> From what I can tell omap3_noncore_dpll_determine_rate() hasn't been
> updated to take a clk_hw pointer instead of clk pointer. It was there in
> the original patch and I'm not sure why Mike dropped that part while
> applying.

OK that makes sense, Mike should apply that part too. Note that also
include/linux/clk/ti.h needs changed accordingly for struct clk_hw,
which you probably had in your orignal patch too. Assuming that's there,
please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 20e120d..c2da2a0 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -474,7 +474,7 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
>   */
>  long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
>  				       unsigned long *best_parent_rate,
> -				       struct clk **best_parent_clk)
> +				       struct clk_hw **best_parent_clk)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	struct dpll_data *dd;
> @@ -488,10 +488,10 @@ long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
>  
>  	if (__clk_get_rate(dd->clk_bypass) == rate &&
>  	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> -		*best_parent_clk = dd->clk_bypass;
> +		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
>  	} else {
>  		rate = omap2_dpll_round_rate(hw, rate, best_parent_rate);
> -		*best_parent_clk = dd->clk_ref;
> +		*best_parent_clk = __clk_get_hw(dd->clk_ref);
>  	}
>  
>  	*best_parent_rate = rate;
> diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
> index 535822f..0e58e5a 100644
> --- a/arch/arm/mach-omap2/dpll44xx.c
> +++ b/arch/arm/mach-omap2/dpll44xx.c
> @@ -223,7 +223,7 @@ out:
>   */
>  long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
>  					unsigned long *best_parent_rate,
> -					struct clk **best_parent_clk)
> +					struct clk_hw **best_parent_clk)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	struct dpll_data *dd;
> @@ -237,11 +237,11 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
>  
>  	if (__clk_get_rate(dd->clk_bypass) == rate &&
>  	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> -		*best_parent_clk = dd->clk_bypass;
> +		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
>  	} else {
>  		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
>  						      best_parent_rate);
> -		*best_parent_clk = dd->clk_ref;
> +		*best_parent_clk = __clk_get_hw(dd->clk_ref);
>  	}
>  
>  	*best_parent_rate = rate;
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
