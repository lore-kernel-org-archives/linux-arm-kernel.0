From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Sep 2011 12:03:28 -0700
Subject: [PATCH 02/11] clk: Implement clk_set_rate
In-Reply-To: <1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4E6FA900.7050101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/11 06:15, Mark Brown wrote:
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

Shouldn't these hlist nodes be initialized in clk_register() via
INIT_HLIST_*()? I guess it's not explicitly needed because kzalloc is
used, but perhaps it is better to be explicit should the kzalloc change
to a kmalloc.

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
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
