From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 10 Oct 2013 13:59:16 +0300
Subject: [PATCH 1/5] clk: tegra: Add support for PLLSS
In-Reply-To: <20131010103915.GA6735@ulmo.nvidia.com>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-2-git-send-email-pdeschrijver@nvidia.com>
 <20131010103915.GA6735@ulmo.nvidia.com>
Message-ID: <20131010105916.GQ4233@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 12:39:16PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Oct 04, 2013 at 12:12:40PM +0300, Peter De Schrijver wrote:
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> This is missing a commit description.
> 
> > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> [...]
> > +const struct clk_ops tegra_clk_pllss_ops = {
> 
> static?
> 

While this could be static, I think conceptually it is exported. So I rather
leave it not static. Unless you expect name space problems.

> > +struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
> > +				void __iomem *clk_base, unsigned long flags,
> > +				unsigned long fixed_rate,
> > +				struct tegra_clk_pll_params *pll_params,
> > +				struct tegra_clk_pll_freq_table *freq_table,
> > +				spinlock_t *lock)
> > +{
> [...]
> > +	pll = _tegra_init_pll(clk_base, NULL, fixed_rate, pll_params,
> > +				pll_flags, freq_table, lock);
> > +
> > +	if (IS_ERR(pll))
> 
> I'd leave out the blank line separating the assignment of pll and the
> check for validity. Grouping them together like that makes it
> immediately clear that they belong together.
> 
> > +		return ERR_CAST(pll);
> > +
> > +	val = pll_readl_base(pll);
> > +
> > +	if (val & (3 << 25)) {
> 
> Same here. Also 3 << 25 could probably be a symbolic constant, something
> like PLLSS_REF_SRC_SEL_MASK perhaps?
> 
> > +		WARN(1, "Unknown parent selected for %s: %d\n", name,
> > +			val >> 25);
> 
> Similarly, this should be something like:
> 
> 		(val & PLLSS_REF_SRC_SEL_MASK) >> PLLSS_REF_SRC_SEL_SHIFT
> 
> > +		kfree(pll);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +	_get_pll_mnp(pll, &cfg);
> 
> Nit: I'd put a blank line before this, to separate the block and the
> function call. That is:
> 
> 	}
> 
> 	_get_pll_mnp(...);
> 
> > +
> > +	if (cfg.n > 1) {
> > +		WARN(1, "%s should not be initialized\n", name);
> > +		kfree(pll);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> 
> Is this really fatal? Can't we just configure the PLL from scratch?
> 

At least in downstream it is. I'm assuming there is a good reason for this.

Cheers,

Peter.
