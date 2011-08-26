From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 10:53:27 +0200
Subject: [PATCH 02/11] clk: Implement clk_set_rate
In-Reply-To: <1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110826085327.GE7526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 02:15:50PM +0100, Mark Brown wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> Implemenent clk_set_rate by adding a set_rate callback to clk_hw_ops,
> and core code to handle propagation of rate changes up and down the
> clock tree.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/clk/clk.c   |   74 ++++++++++++++++++++++++++++++++++++++++++++++----
>  include/linux/clk.h |   12 ++++++++
>  2 files changed, 80 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ad90a90..3a4d70e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -21,6 +21,8 @@ struct clk {
>  	unsigned int		enable_count;
>  	unsigned int		prepare_count;
>  	struct clk		*parent;
> +	struct hlist_head	children;
> +	struct hlist_node	child_node;
>  	unsigned long		rate;
>  };
>  
> @@ -176,10 +178,61 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
>  }
>  EXPORT_SYMBOL_GPL(clk_round_rate);
>  
> +/*
> + * clk_recalc_rates - Given a clock (with a recently updated clk->rate),
> + *	notify its children that the rate may need to be recalculated, using
> + *	ops->recalc_rate().
> + */
> +static void clk_recalc_rates(struct clk *clk)
> +{
> +	struct hlist_node *tmp;
> +	struct clk *child;
> +
> +	if (clk->ops->recalc_rate)
> +		clk->rate = clk->ops->recalc_rate(clk->hw);
> +
> +	hlist_for_each_entry(child, tmp, &clk->children, child_node)
> +		clk_recalc_rates(child);
> +}
> +
>  int clk_set_rate(struct clk *clk, unsigned long rate)
>  {
> -	/* not yet implemented */
> -	return -ENOSYS;
> +	unsigned long parent_rate, new_rate;
> +	int ret;
> +
> +	if (!clk->ops->set_rate)
> +		return -ENOSYS;
> +
> +	new_rate = rate;
> +
> +	/* prevent racing with updates to the clock topology */
> +	mutex_lock(&prepare_lock);
> +
> +propagate:
> +	ret = clk->ops->set_rate(clk->hw, new_rate, &parent_rate);

You have to check for clk->ops->set_rate != NULL here for the
propagation case.

> +
> +	if (ret < 0)
> +		return ret;

This returns with a mutex held. Also, some rates may already have
changed here. I suggest a goto recalc_rates here.

> +
> +	/* ops->set_rate may require the parent's rate to change (to
> +	 * parent_rate), we need to propagate the set_rate call to the
> +	 * parent.
> +	 */
> +	if (ret == CLK_SET_RATE_PROPAGATE) {
> +		new_rate = parent_rate;
> +		clk = clk->parent;
> +		goto propagate;

before propagating you should check if the parent already has the
desired rate. The parent may be a fixed clock which does not have
a set_rate function, still this function shall succeed in this
case.

> +	}
> +
> +	/* If successful (including propagation to the parent clock(s)),
> +	 * recalculate the rates of the clock, including children.  We'll be
> +	 * calling this on the 'parent-most' clock that we propagated to.
> +	 */

recalc_rates:

> +	clk_recalc_rates(clk);
> +
> +	mutex_unlock(&prepare_lock);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(clk_set_rate);
>  
> @@ -213,16 +266,25 @@ struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
>  	clk->hw = hw;
>  	hw->clk = clk;
>  
> -	/* Query the hardware for parent and initial rate */
> +	/* Query the hardware for parent and initial rate. We may alter
> +	 * the clock topology, making this clock available from the parent's
> +	 * children list. So, we need to protect against concurrent
> +	 * accesses through set_rate
> +	 */
> +	mutex_lock(&prepare_lock);
>  
> -	if (clk->ops->get_parent)
> -		/* We don't to lock against prepare/enable here, as
> -		 * the clock is not yet accessible from anywhere */
> +	if (clk->ops->get_parent) {
>  		clk->parent = clk->ops->get_parent(clk->hw);
> +		if (clk->parent)
> +			hlist_add_head(&clk->child_node,
> +					&clk->parent->children);
> +	}
>  
>  	if (clk->ops->recalc_rate)
>  		clk->rate = clk->ops->recalc_rate(clk->hw);
>  
> +	mutex_unlock(&prepare_lock);
> +
>  
>  	return clk;
>  }
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 93ff870..e0969d2 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -58,6 +58,12 @@ struct clk_hw {
>   *		parent. Currently only called when the clock is first
>   *		registered.
>   *
> + * @set_rate	Change the rate of this clock. If this callback returns
> + *		CLK_SET_RATE_PROPAGATE, the rate change will be propagated to
> + *		the parent clock (which may propagate again). The requested
> + *		rate of the parent is passed back from the callback in the
> + *		second 'unsigned long *' argument.
> + *
>   * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
>   * implementations to split any work between atomic (enable) and sleepable
>   * (prepare) contexts.  If a clock requires sleeping code to be turned on, this
> @@ -76,9 +82,15 @@ struct clk_hw_ops {
>  	void		(*disable)(struct clk_hw *);
>  	unsigned long	(*recalc_rate)(struct clk_hw *);
>  	long		(*round_rate)(struct clk_hw *, unsigned long);
> +	int		(*set_rate)(struct clk_hw *,
> +					unsigned long, unsigned long *);
>  	struct clk *	(*get_parent)(struct clk_hw *);
>  };
>  
> +enum {
> +	CLK_SET_RATE_PROPAGATE = 1,
> +};
> +
>  /**
>   * clk_prepare - prepare clock for atomic enabling.
>   *
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
