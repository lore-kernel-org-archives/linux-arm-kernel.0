From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 19 Jul 2010 12:07:38 +0200
Subject: [PATCH 3/4] ARM: SAMSUNG SoC: Clock Framework: Flag Support for
	struct clk.
In-Reply-To: <1279528236-6076-4-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-3-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-4-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <4C4423EA.3070501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 19-07-10 10:30, MyungJoo Ham schreef:
> Add a .flag property to the struct clk. The flag can have the following
> information:
>
> 	The clock is enabled at the boot time.
> 	The clock cannot be disabled.
> 	The clock is enabled at the boot time and cannot be disabled.
> 	The clock is disabled at the boot time. Note that both
> CLKFLAGS_BOOT_ON and CLKFLAGS_CANNOT_DISABLE can override
> CLKFLAGS_BOOT_OFF.
> 	Please stop using this clock. When a DEPRECATED clock is
> clk_get'd, clk_get function will printk a warning message.
>
> The previous patch related with powerdomain / blcok-gating control
> requires this patch for the stability related with clocks that are
> turned on at the boot time.
>
> Note that clocks without both BOOT_ON and BOOT_OFF keep the previous
> states; however, powerdomain / block-gating controls do NOT have any
> information about the states of such clocks, which in turn, may incur
> instable kernel behaviors. For example, a powerdomain may be turned off
> while a clock of the domain is still being used. With the flag support
> feature, we highly recommend to define .flag fields fully for clocks
> related to powerdomain and block-gating. Clocks not connected to
> powerdomain and block-gating are ok without flag field.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/clock.c              |   70 ++++++++++++++++++++++++++-
>  arch/arm/plat-samsung/include/plat/clock.h |   12 +++++
>  2 files changed, 79 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> index f8a30f7..9ff9d63 100644
> --- a/arch/arm/plat-samsung/clock.c
> +++ b/arch/arm/plat-samsung/clock.c
> @@ -103,6 +103,14 @@ struct clk *clk_get(struct device *dev, const char *id)
>  	}
>  
>  	spin_unlock(&clocks_lock);
> +
> +	if (!IS_ERR(clk) && clk)
> +		if (clk->flags & CLKFLAGS_DEPRECATED)
> +			printk(KERN_WARNING "[%s:%d] clk %s:%d is deprecated. "
> +					"Please reconsider using it.\n",
> +					__FILE__, __LINE__, clk->name,
> +					clk->id);

What's the use of __FILE__ and __LINE__? If you wanted to print the caller you
could do something like pr_warn("[%pS]: ...", __builtin_return_address(0), ...).

Also, pr_warn(...)

> +
>  	return clk;
>  }
>  
> @@ -169,7 +177,25 @@ void clk_disable(struct clk *clk)
>  	spin_lock(&clocks_lock);
>  
>  	if ((--clk->usage) == 0) {
> -		(clk->enable)(clk, 0);
> +#ifdef CONFIG_SAMSUNG_POWERDOMAIN
> +		if ((clk->flags | CLKFLAGS_BOOT_ON) &&
> +				!(clk->flags | CLKFLAGS_CANNOT_DISABLE)) {

Russel already mentioned this, did you wanted to do (clk->flags & CLKFLAGS_*)?

> +			/* BOOT_ON became NO EFFECT. Let PD/BD be able
> +			 * to turn themselves off */
> +
> +			if (clk->pd)
> +				clk->pd->num_clks_boot_on--;
> +#ifdef CONFIG_SAMSUNG_BLOCKGATING
> +			if (clk->bd)
> +				clk->bd->num_clks_boot_on--;
> +#endif
> +			clk->flags &= ~CLKFLAGS_BOOT_ON;
> +		}
> +#endif
> +
> +		if (clk->enable && !(clk->flags | CLKFLAGS_CANNOT_DISABLE))
> +			(clk->enable)(clk, 0);
> +
>  #ifdef CONFIG_SAMSUNG_POWERDOMAIN
>  		if (clk->pd) {
>  			if (clk->pd->ref_count == 1 &&
> @@ -193,7 +219,9 @@ void clk_disable(struct clk *clk)
>  	}
>  
>  	spin_unlock(&clocks_lock);
> -	clk_disable(clk->parent);
> +
> +	if (!(clk->flags | CLKFLAGS_CANNOT_DISABLE))
> +		clk_disable(clk->parent);
>  }
>  
>  
> @@ -370,6 +398,13 @@ struct clk s3c24xx_uclk = {
>   */
>  int s3c24xx_register_clock(struct clk *clk)
>  {
> +	int ret = 0;
> +
> +	if (clk == NULL)
> +		return -EINVAL;
> +	if (clk->name == NULL)
> +		return -EINVAL;
> +
>  	if (clk->enable == NULL)
>  		clk->enable = clk_null_enable;
>  
> @@ -382,6 +417,21 @@ int s3c24xx_register_clock(struct clk *clk)
>  	list_add(&clk->list, &clocks);
>  	spin_unlock(&clocks_lock);
>  
> +	if (clk->flags & CLKFLAGS_BOOT_ON) {
> +		/* Use clk_enable, not clk->enable as clk's parent is
> +		 * also required to be turned on */
> +		clk_enable(clk);
> +
> +#ifdef CONFIG_SAMSUNG_POWERDOMAIN
> +		if (clk->pd)
> +			clk->pd->num_clks_boot_on++;
> +#endif
> +#ifdef CONFIG_SAMSUNG_BLOCKGATING
> +		if (clk->bd)
> +			clk->bd->num_clks_boot_on++;
> +#endif
> +	}
> +
>  #ifdef CONFIG_SAMSUNG_POWERDOMAIN
>  	if (clk->pd) {
>  		spin_lock(&clocks_lock);
> @@ -397,7 +447,21 @@ int s3c24xx_register_clock(struct clk *clk)
>  	}
>  #endif
>  
> -	return 0;
> +	if (clk->flags & CLKFLAGS_BOOT_OFF) {
> +		if ((clk->flags & CLKFLAGS_BOOT_ON) ||
> +				(clk->flags & CLKFLAGS_CANNOT_DISABLE)) {
> +			printk(KERN_WARNING "[%s:%d] clk %s:%d has incompatible"
> +					" initilization flags: %x.\n",
> +					__FILE__, __LINE__, clk->name, clk->id,
> +					clk->flags);

Same comment, also s/initilization/initialization/.

> +			ret = -EINVAL;
> +		} else
> +			/* Do NOT use clk_disable(clk) because clk_disable
> +			 * may disable clk's parent */
> +			ret = (clk->enable)(clk, 0);
> +	}
> +
> +	return ret;
>  }
>  
>  /**
> diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
> index bf851e1..0f7d556 100644
> --- a/arch/arm/plat-samsung/include/plat/clock.h
> +++ b/arch/arm/plat-samsung/include/plat/clock.h
> @@ -59,6 +59,17 @@ struct clk_ops {
>  	int		    (*set_parent)(struct clk *c, struct clk *parent);
>  };
>  
> +/* Note that when BOOT_ON and OFF are both not set, the kernel
> + * keeps the state initialized by the boot-loader or cpu.
> + */
> +#define CLKFLAGS_BOOT_ON	(0x1)
> +#define CLKFLAGS_CANNOT_DISABLE	(0x2)
> +#define CLKFLAGS_ALWAYS_ON	(CLKFLAGS_BOOT_ON | CLKFLAGS_CANNOT_DISABLE)
> +#define CLKFLAGS_BOOT_OFF	(0x4) /* Force off when boot */
> +#define CLKFLAGS_DEPRECATED	(0x8) /* Warn when clk_get'd */
> +/* Note that CLKFLAGS_BOOT_ON and CLKFLAGS_CANNOT_DISABLE overrides
> + * CLKFLAGS_BOOT_OFF */
> +
>  struct clk {
>  	struct list_head      list;
>  	struct module        *owner;
> @@ -79,6 +90,7 @@ struct clk {
>  	struct powerdomain	*bd;
>  	struct list_head	blockgating_list;
>  #endif
> +	unsigned int		flags;
>  };
>  
>  /* other clocks which may be registered by board support */


-- 
Maurus Cuelenaere
