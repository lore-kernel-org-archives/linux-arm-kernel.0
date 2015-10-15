From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:10:26 -0700
Subject: [PATCH 07/13] clk: versatile-icst: refactor to allocate regmap
 separately
In-Reply-To: <1444916813-31024-8-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-8-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151015191026.GM4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Linus Walleij wrote:
> @@ -174,15 +170,7 @@ struct clk *icst_clk_register(struct device *dev,
>  	init.flags = CLK_IS_ROOT;
>  	init.parent_names = (parent_name ? &parent_name : NULL);
>  	init.num_parents = (parent_name ? 1 : 0);
> -	icst->map = regmap_init_mmio(NULL, base, &icst_regmap_conf);
> -	if (IS_ERR(icst->map)) {
> -		int ret;
> -
> -		pr_err("could not initialize ICST regmap\n");
> -		kfree(icst);
> -		ret = PTR_ERR(icst->map);
> -		return ERR_PTR(ret);

Oh now it gets moved.

> -	}
> +	icst->map = map;
>  	icst->hw.init = &init;
>  	icst->params = pclone;
>  	icst->vcoreg_off = desc->vco_offset;
> @@ -194,4 +182,28 @@ struct clk *icst_clk_register(struct device *dev,
>  
>  	return clk;
>  }
> +
> +struct clk *icst_clk_register(struct device *dev,
> +			const struct clk_icst_desc *desc,
> +			const char *name,
> +			const char *parent_name,
> +			void __iomem *base)
> +{
> +	struct regmap_config icst_regmap_conf = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +	};
> +	struct regmap *map;
> +
> +	map = regmap_init_mmio(NULL, base, &icst_regmap_conf);

Any reason we aren't passing dev as the first argument? Same
comment applies to patch 6.

> +	if (IS_ERR(map)) {
> +		int ret;
> +
> +		pr_err("could not initialize ICST regmap\n");
> +		ret = PTR_ERR(map);
> +		return ERR_PTR(ret);

Use ERR_CAST(map) instead.

> +	}
> +	return icst_clk_setup(dev, desc, name, parent_name, map);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
