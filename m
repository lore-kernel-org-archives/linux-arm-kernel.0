From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jul 2017 16:02:59 -0700
Subject: [PATCH v2 3/5] clk: qcom: gdsc: Add support to control
 associated clks
In-Reply-To: <1500526099-9935-4-git-send-email-rnayak@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
 <1500526099-9935-4-git-send-email-rnayak@codeaurora.org>
Message-ID: <20170727230259.GR2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Rajendra Nayak wrote:
> @@ -166,6 +169,29 @@ static inline void gdsc_assert_clamp_io(struct gdsc *sc)
>  			   GMEM_CLAMP_IO_MASK, 1);
>  }
>  
> +static inline int gdsc_clk_enable(struct gdsc *sc)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < sc->clk_count; i++) {
> +		ret = clk_prepare_enable(sc->clks[i]);
> +		if (ret) {
> +			for (i--; i >= 0; i--)

while (--i >= 0) ?

> +				clk_disable_unprepare(sc->clks[i]);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static inline void gdsc_clk_disable(struct gdsc *sc)
> +{
> +	int i;
> +
> +	for (i = 0; i < sc->clk_count; i++)

Could also be the same while loop.

> +		clk_disable_unprepare(sc->clks[i]);
> +}
> +
>  static int gdsc_enable(struct generic_pm_domain *domain)
>  {
>  	struct gdsc *sc = domain_to_gdsc(domain);
> @@ -193,6 +219,10 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>  	 */
>  	udelay(1);
>  
> +	ret = gdsc_clk_enable(sc);
> +	if (ret)
> +		return ret;
> +
>  	/* Turn on HW trigger mode if supported */
>  	if (sc->flags & HW_CTRL) {
>  		ret = gdsc_hwctrl(sc, true);
> @@ -241,6 +271,8 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  			return ret;
>  	}
>  
> +	gdsc_clk_disable(sc);

Can we call sleeping APIs (i.e. prepare/unprepare) from within
the power domains? I thought that didn't work generically because
someone could set their runtime PM configuration to be atomic
context friendly. Is there some way we can block that from
happening if we hook up a power domain that is no longer safe to
call from atomic context?

> +
>  	if (sc->pwrsts & PWRSTS_OFF)
>  		gdsc_clear_mem_on(sc);
>  
> @@ -254,7 +286,27 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> -static int gdsc_init(struct gdsc *sc)
> +static inline int gdsc_clk_get(struct device *dev, struct gdsc *sc)
> +{
> +	if (sc->clk_count) {

We could drop this check. kmalloc with size zero is OK as long as
we don't use the returned pointer value. We shouldn't use it
assuming the for loop is maintained.

> +		int i;
> +
> +		sc->clks = devm_kcalloc(dev, sc->clk_count, sizeof(*sc->clks),
> +					GFP_KERNEL);
> +		if (!sc->clks)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < sc->clk_count; i++) {
> +			sc->clks[i] = devm_clk_hw_get_clk(dev, sc->clk_hws[i],
> +							  NULL);
> +			if (IS_ERR(sc->clks[i]))
> +				return PTR_ERR(sc->clks[i]);
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int gdsc_init(struct device *dev, struct gdsc *sc)
>  {
>  	u32 mask, val;
>  	int on, ret;
> @@ -284,6 +336,10 @@ static int gdsc_init(struct gdsc *sc)
>  	if (on < 0)
>  		return on;
>  
> +	ret = gdsc_clk_get(dev, sc);
> +	if (ret)
> +		return ret;
> +

This concerns me if we do probe defer on orphan clks. We may get
into some situation where the gdsc is setup by a clk driver that
is trying to probe before some parent clk has registered for the
clks we're "getting" here. For example, this could easily happen
if we insert XO into the tree at the top and everything defers.

I suppose this is not a problem because in this case we don't
have any clk here that could be orphaned even if RPM clks are
inserted into the clk tree for XO? I mean to say that we won't
get into a probe defer due to orphan clk loop. I'm always afraid
someone will make hardware that send a clk from one controller to
another and then back again (we did that with pcie) and then
we'll be unable to get out of the defer loop because we'll be
deferred on orphan status.


>  	/*
>  	 * Votable GDSCs can be ON due to Vote from other masters.
>  	 * If a Votable GDSC is ON, make sure we have a Vote.
> @@ -327,7 +383,7 @@ int gdsc_register(struct gdsc_desc *desc,
>  			continue;
>  		scs[i]->regmap = regmap;
>  		scs[i]->rcdev = rcdev;
> -		ret = gdsc_init(scs[i]);
> +		ret = gdsc_init(dev, scs[i]);
>  		if (ret)
>  			return ret;
>  		data->domains[i] = &scs[i]->pd;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
