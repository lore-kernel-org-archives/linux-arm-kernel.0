From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 27 Mar 2012 10:55:14 +0200
Subject: [PATCH 09/10] clk: dynamically allocate parent_names basic clk
 registration
In-Reply-To: <1332833009-4121-10-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-10-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120327085514.GI29317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 03:23:28PM +0800, Shawn Guo wrote:
> It's not necessary to have "char *parent[1]" carried in struct clk_gate
> and clk_divider.  Instead, it can be dynamically allocated in
> registration function, just like what clk_register_fixed_rate does.

I patched it the way it is to get rid of the additional malloc which
seemed unnecessary. Maybe the real question is whether the core should
duplicate the parent strings instead of the basic clock types.

Sascha

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/clk/clk-divider.c    |   14 ++++++++++----
>  drivers/clk/clk-gate.c       |   15 +++++++++++----
>  include/linux/clk-provider.h |    2 --
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index b1c4b02..df03a61 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -160,6 +160,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>  {
>  	struct clk_divider *div;
>  	struct clk *clk;
> +	const char **parent_names = NULL;
>  
>  	div = kzalloc(sizeof(struct clk_divider), GFP_KERNEL);
>  
> @@ -176,21 +177,26 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>  	div->lock = lock;
>  
>  	if (parent_name) {
> -		div->parent[0] = kstrdup(parent_name, GFP_KERNEL);
> -		if (!div->parent[0])
> +		parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
> +		if (!parent_names)
> +			goto out;
> +
> +		parent_names[0] = kstrdup(parent_name, GFP_KERNEL);
> +		if (!parent_names[0])
>  			goto out;
>  	}
>  
>  	clk = clk_register(dev, name,
>  			&clk_divider_ops, &div->hw,
> -			div->parent,
> +			parent_names,
>  			(parent_name ? 1 : 0),
>  			flags);
>  	if (clk)
>  		return clk;
>  
>  out:
> -	kfree(div->parent[0]);
> +	kfree(parent_names[0]);
> +	kfree(parent_names);
>  	kfree(div);
>  
>  	return NULL;
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index fe2ff9e..51c56cb 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -112,6 +112,7 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
>  {
>  	struct clk_gate *gate;
>  	struct clk *clk;
> +	const char **parent_names = NULL;
>  
>  	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
>  
> @@ -127,20 +128,26 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
>  	gate->lock = lock;
>  
>  	if (parent_name) {
> -		gate->parent[0] = kstrdup(parent_name, GFP_KERNEL);
> -		if (!gate->parent[0])
> +		parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
> +		if (!parent_names)
> +			goto out;
> +
> +		parent_names[0] = kstrdup(parent_name, GFP_KERNEL);
> +		if (parent_names[0])
>  			goto out;
>  	}
>  
>  	clk = clk_register(dev, name,
>  			&clk_gate_ops, &gate->hw,
> -			gate->parent,
> +			parent_names,
>  			(parent_name ? 1 : 0),
>  			flags);
>  	if (clk)
>  		return clk;
> +
>  out:
> -	kfree(gate->parent[0]);
> +	kfree(parent_names[0]);
> +	kfree(parent_names);
>  	kfree(gate);
>  
>  	return NULL;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 24c5013..7948640 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -176,7 +176,6 @@ struct clk_gate {
>  	u8		bit_idx;
>  	u8		flags;
>  	spinlock_t	*lock;
> -	char		*parent[1];
>  };
>  
>  #define CLK_GATE_SET_TO_DISABLE		BIT(0)
> @@ -214,7 +213,6 @@ struct clk_divider {
>  	u8		width;
>  	u8		flags;
>  	spinlock_t	*lock;
> -	const char	*parent[1];
>  };
>  
>  #define CLK_DIVIDER_ONE_BASED		BIT(0)
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
