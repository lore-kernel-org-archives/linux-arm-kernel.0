From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Sep 2013 11:47:34 +0100
Subject: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not
 yet ready
In-Reply-To: <20130921120006.47b00fe7@armhf>
References: <20130921120006.47b00fe7@armhf>
Message-ID: <20130921104734.GJ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 12:00:06PM +0200, Jean-Francois Moine wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a004769..582abc8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2181,7 +2181,7 @@ EXPORT_SYMBOL_GPL(of_clk_del_provider);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
>  {
>  	struct of_clk_provider *provider;
> -	struct clk *clk = ERR_PTR(-ENOENT);
> +	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
>  
>  	/* Check if we have such a provider in our array */
>  	mutex_lock(&of_clk_lock);
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 442a313..f8b28d9 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -157,8 +157,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  
>  	if (dev) {
>  		clk = of_clk_get_by_name(dev->of_node, con_id);
> -		if (!IS_ERR(clk) && __clk_get(clk))
> -			return clk;
> +		if (!IS_ERR(clk)) {
> +			if (__clk_get(clk))
> +				return clk;
> +		} else {
> +			if (PTR_ERR(clk) == -EPROBE_DEFER)
> +				return clk;
> +		}

Another comment.  This is broken - it will never fall through if a
'dev' is given, because of_clk_get_by_name() will always return an
-EPROBE_DEFER error pointer in that case.

So this approach is unworkable.
