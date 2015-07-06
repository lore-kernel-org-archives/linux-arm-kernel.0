From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Jul 2015 14:32:10 -0700
Subject: [PATCH v4] clk: change clk_ops' ->determine_rate() prototype
In-Reply-To: <1436202872-26533-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1436202872-26533-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150706213210.GB20866@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06, Boris Brezillon wrote:
> Clock rates are stored in an unsigned long field, but ->determine_rate()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lead
> to long overflow if the clock rate exceed 2Ghz.
> 
> Change ->determine_rate() prototype to return 0 or an error code, and pass
> a pointer to a clk_rate_request structure containing the expected target
> rate and the rate constraints imposed by clk users.
> 
> The clk_rate_request structure might be extended in the future to contain
> other kind of constraints like the rounding policy, the maximum clock
> inaccuracy or other things that are not yet supported by the CCF
> (power consumption constraints ?).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Which files did you compile? 

drivers/clk/mmp/clk-mix.c: In function ?mmp_clk_mix_determine_rate?:
drivers/clk/mmp/clk-mix.c:221:13: error: ?rate? undeclared (first use in this function)

> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 44e57ec..cd27457 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -462,43 +462,38 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
>  /**
>   * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
>   * @hw: pointer to the clock to determine rate for
> - * @rate: target rate for the DPLL
> - * @best_parent_rate: pointer for returning best parent rate
> - * @best_parent_clk: pointer for returning best parent clock
> + * @req: target rate request
>   *
>   * Determines which DPLL mode to use for reaching a desired target rate.
>   * Checks whether the DPLL shall be in bypass or locked mode, and if
>   * locked, calculates the M,N values for the DPLL via round-rate.
> - * Returns a positive clock rate with success, negative error value
> - * in failure.
> + * Returns a 0 on success, negative error value in failure.
>   */
> -long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
> -				       unsigned long min_rate,
> -				       unsigned long max_rate,
> -				       unsigned long *best_parent_rate,
> -				       struct clk_hw **best_parent_clk)
> +int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	struct dpll_data *dd;
>  
> -	if (!hw || !rate)
> +	if (!hw || !req || !req->rate)

Why do we need to check for req? It shouldn't be NULL.

>  		return -EINVAL;
>  
>  	dd = clk->dpll_data;
>  	if (!dd)
>  		return -EINVAL;
>  
> -	if (__clk_get_rate(dd->clk_bypass) == rate &&
> +	if (__clk_get_rate(dd->clk_bypass) == req->rate &&
>  	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> -		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
> +		req->best_parent_hw = __clk_get_hw(dd->clk_bypass);
>  	} else {
> -		rate = omap2_dpll_round_rate(hw, rate, best_parent_rate);
> -		*best_parent_clk = __clk_get_hw(dd->clk_ref);
> +		req->rate = omap2_dpll_round_rate(hw, req->rate,
> +					  &req->best_parent_rate);
> +		req->best_parent_hw = __clk_get_hw(dd->clk_ref);
>  	}
>  
> -	*best_parent_rate = rate;
> +	req->best_parent_rate = req->rate;
>  
> -	return rate;
> +	return 0;
>  }
>  
>  /**
> diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
> index f231be0..d615571 100644
> --- a/arch/arm/mach-omap2/dpll44xx.c
> +++ b/arch/arm/mach-omap2/dpll44xx.c
> @@ -191,42 +191,36 @@ out:
>  /**
>   * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
>   * @hw: pointer to the clock to determine rate for
> - * @rate: target rate for the DPLL
> - * @best_parent_rate: pointer for returning best parent rate
> - * @best_parent_clk: pointer for returning best parent clock
> + * @req: target rate request
>   *
>   * Determines which DPLL mode to use for reaching a desired rate.
>   * Checks whether the DPLL shall be in bypass or locked mode, and if
>   * locked, calculates the M,N values for the DPLL via round-rate.
> - * Returns a positive clock rate with success, negative error value
> - * in failure.
> + * Returns 0 on success and a negative error value otherwise.
>   */
> -long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
> -					unsigned long min_rate,
> -					unsigned long max_rate,
> -					unsigned long *best_parent_rate,
> -					struct clk_hw **best_parent_clk)
> +int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
> +				       struct clk_rate_request *req)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	struct dpll_data *dd;
>  
> -	if (!hw || !rate)
> +	if (!hw || !req || !req->rate)

Same comment here. And why would we care about hw being NULL
either for that matter.

>  		return -EINVAL;
>  
>  	dd = clk->dpll_data;
>  	if (!dd)
>  		return -EINVAL;
>  
> -	if (__clk_get_rate(dd->clk_bypass) == rate &&
> +	if (__clk_get_rate(dd->clk_bypass) == req->rate &&
>  	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> -		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
> +		req->best_parent_hw = __clk_get_hw(dd->clk_bypass);
>  	} else {
> -		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
> -						      best_parent_rate);
> -		*best_parent_clk = __clk_get_hw(dd->clk_ref);
> +		req->rate = omap4_dpll_regm4xen_round_rate(hw, req->rate,
> +						&req->best_parent_rate);
> +		req->best_parent_hw = __clk_get_hw(dd->clk_ref);
>  	}
>  
> -	*best_parent_rate = rate;
> +	req->best_parent_rate = req->rate;
>  
> -	return rate;
> +	return 0;
>  }
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
> index 715d34a..e1d72e6 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -294,34 +294,31 @@ static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
>  	}
>  }
>  
> -static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
> -			      unsigned long min_rate,
> -			      unsigned long max_rate,
> -			      unsigned long *best_parent_rate,
> -			      struct clk_hw **best_parent_p)
> +static int mmc_clk_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
>  {
>  	struct clk_mmc *mclk = to_mmc(hw);
> -	unsigned long best = 0;
>  
> -	if ((rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
> -		rate = 13000000;
> -		best = 26000000;
> -	} else if (rate <= 26000000) {
> -		rate = 25000000;
> -		best = 180000000;
> -	} else if (rate <= 52000000) {
> -		rate = 50000000;
> -		best = 360000000;
> -	} else if (rate <= 100000000) {
> -		rate = 100000000;
> -		best = 720000000;
> +	req->best_parent_hw = __clk_get_hw(__clk_get_parent(hw->clk));
> +

Where did this come from? We weren't setting the best_parent_p
pointer before.

> +	if ((req->rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
> +		req->rate = 13000000;
> +		req->best_parent_rate = 26000000;
> +	} else if (req->rate <= 26000000) {
> +		req->rate = 25000000;
> +		req->best_parent_rate = 180000000;
> +	} else if (req->rate <= 52000000) {
> +		req->rate = 50000000;
> +		req->best_parent_rate = 360000000;
> +	} else if (req->rate <= 100000000) {
> +		req->rate = 100000000;
> +		req->best_parent_rate = 720000000;
>  	} else {
>  		/* max is 180M */
> -		rate = 180000000;
> -		best = 1440000000;
> +		req->rate = 180000000;
> +		req->best_parent_rate = 1440000000;
>  	}
> -	*best_parent_rate = best;
> -	return rate;
> +	return 0;
>  }
>  
>  static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
> diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
> index 245d506..f8f1d44 100644
> --- a/drivers/clk/qcom/clk-pll.c
> +++ b/drivers/clk/qcom/clk-pll.c
> @@ -135,17 +135,21 @@ struct pll_freq_tbl *find_freq(const struct pll_freq_tbl *f, unsigned long rate)
>  	return NULL;
>  }
>  
> -static long
> -clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
> -		       unsigned long min_rate, unsigned long max_rate,
> -		       unsigned long *p_rate, struct clk_hw **p)
> +static int
> +clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>  {
> +	struct clk *parent = __clk_get_parent(hw->clk);
>  	struct clk_pll *pll = to_clk_pll(hw);
>  	const struct pll_freq_tbl *f;
>  
> -	f = find_freq(pll->freq_tbl, rate);
> +	req->best_parent_hw = __clk_get_hw(parent);
> +	req->best_parent_rate = __clk_get_rate(parent);
> +
> +	f = find_freq(pll->freq_tbl, req->rate);
>  	if (!f)
> -		return clk_pll_recalc_rate(hw, *p_rate);
> +		req->rate = clk_pll_recalc_rate(hw, req->best_parent_rate);
> +	else
> +		req->rate = f->freq;
>  
>  	return f->freq;

return 0?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
