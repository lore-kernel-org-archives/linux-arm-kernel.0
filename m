From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Sep 2011 12:03:20 -0700
Subject: [PATCH 01/11] clk: Add a generic clock infrastructure
In-Reply-To: <1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4E6FA8F8.2010807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/11 06:15, Mark Brown wrote:
> +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
> +		const char *name)
> +{
> +	struct clk *clk;
> +
> +	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> +	if (!clk)
> +		return NULL;
> +
> +	clk->name = name;
> +	clk->ops = ops;
> +	clk->hw = hw;
> +	hw->clk = clk;
> +
> +	/* Query the hardware for parent and initial rate */
> +
> +	if (clk->ops->get_parent)
> +		/* We don't to lock against prepare/enable here, as
> +		 * the clock is not yet accessible from anywhere */
> +		clk->parent = clk->ops->get_parent(clk->hw);
> +
> +	if (clk->ops->recalc_rate)
> +		clk->rate = clk->ops->recalc_rate(clk->hw);
> +
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(clk_register);

How will this play with clkdev? I think we'll need to add another
function on top of this one that allows you to register a clk_hw and an
array of clk_lookups at the same time. Otherwise we're going to get
about 10 different implementations of the same code.

Something like:

struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw, 
		const char *name, struct clk_lookup *lookups, 
		size_t num_lookups)


?

> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1d37f42..93ff870 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -11,17 +12,103 @@
>  #ifndef __LINUX_CLK_H
>  #define __LINUX_CLK_H
>  
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +

I don't see these includes used in this header.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
