From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 11 Apr 2013 17:10:55 +0530
Subject: [PATCH 1/3] clk: composite: rename 'div' references to 'rate'
In-Reply-To: <1365631378-16103-2-git-send-email-mturquette@linaro.org>
References: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
 <1365631378-16103-1-git-send-email-mturquette@linaro.org>
 <1365631378-16103-2-git-send-email-mturquette@linaro.org>
Message-ID: <5166A147.1050505@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013 03:32 AM, Mike Turquette wrote:
> Rename all div_hw and div_ops related variables and functions to use
> rate_hw, rate_ops, etc.  This is to make the rate-change portion of the
> composite clk implementation more generic.  A patch following this one
> will allow for fixed-rate clocks to reuse this infrastructure.
>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Emilio L?pez <emilio@elopez.com.ar>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   drivers/clk/clk-composite.c  |   40 ++++++++++++++++++++--------------------
>   include/linux/clk-provider.h |   14 +++++++-------
>   2 files changed, 27 insertions(+), 27 deletions(-)
>
<snip>

>   
>   	if (composite->gate_hw)
>   		composite->gate_hw->clk = clk;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 9fdfae7..f5ba8c5 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -352,11 +352,11 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
>    * struct clk_composite - aggregate clock of mux, divider and gate clocks
>    *
>    * @hw:		handle between common and hardware-specific interfaces
> - * @mux_hw:	handle between composite and hardware-specifix mux clock
> - * @div_hw:	handle between composite and hardware-specifix divider clock
> - * @gate_hw:	handle between composite and hardware-specifix gate clock
> + * @mux_hw:	handle between composite and hardware-specific mux clock
> + * @rate_hw:	handle between composite and hardware-specific rateider clock

Small nitpick s/rateider/rate

Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>

> + * @gate_hw:	handle between composite and hardware-specific gate clock
>    * @mux_ops:	clock ops for mux
> - * @div_ops:	clock ops for divider
> + * @rate_ops:	clock ops for rateider
>    * @gate_ops:	clock ops for gate
>    */
>   struct clk_composite {
> @@ -364,18 +364,18 @@ struct clk_composite {
>   	struct clk_ops	ops;
>   
>   	struct clk_hw	*mux_hw;
> -	struct clk_hw	*div_hw;
> +	struct clk_hw	*rate_hw;
>   	struct clk_hw	*gate_hw;
>   
>   	const struct clk_ops	*mux_ops;
> -	const struct clk_ops	*div_ops;
> +	const struct clk_ops	*rate_ops;
>   	const struct clk_ops	*gate_ops;
>   };
>   
>   struct clk *clk_register_composite(struct device *dev, const char *name,
>   		const char **parent_names, int num_parents,
>   		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
> -		struct clk_hw *div_hw, const struct clk_ops *div_ops,
> +		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
>   		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
>   		unsigned long flags);
>   
