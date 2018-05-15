From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 May 2018 19:12:35 +0530
Subject: [PATCH v10 03/27] clk: davinci: psc: allow for dev == NULL
In-Reply-To: <20180509172606.29387-4-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-4-david@lechnology.com>
Message-ID: <2f1056b3-6d29-0651-1d7d-9c74cd50861c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
> @@ -261,10 +263,14 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
>  	lpsc->pd = pd;
>  	lpsc->flags = flags;
>  
> -	ret = devm_clk_hw_register(dev, &lpsc->hw);
> +	ret = clk_hw_register(dev, &lpsc->hw);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> +	/* for now, genpd is only registered when using device-tree */
> +	if (!dev || !dev->of_node)
> +		return lpsc;
> +
>  	/* genpd attach needs a way to look up this clock */
>  	ret = clk_hw_register_clkdev(&lpsc->hw, name, best_dev_name(dev));
>  
> @@ -378,11 +384,11 @@ __davinci_psc_register_clocks(struct device *dev,
>  	struct regmap *regmap;
>  	int i, ret;
>  
> -	psc = devm_kzalloc(dev, sizeof(*psc), GFP_KERNEL);
> +	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
>  	if (!psc)
>  		return ERR_PTR(-ENOMEM);
>  
> -	clks = devm_kmalloc_array(dev, num_clks, sizeof(*clks), GFP_KERNEL);
> +	clks = kmalloc_array(num_clks, sizeof(*clks), GFP_KERNEL);
>  	if (!clks)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -396,14 +402,14 @@ __davinci_psc_register_clocks(struct device *dev,
>  	for (i = 0; i < num_clks; i++)
>  		clks[i] = ERR_PTR(-ENOENT);
>  
> -	pm_domains = devm_kcalloc(dev, num_clks, sizeof(*pm_domains), GFP_KERNEL);
> +	pm_domains = kcalloc(num_clks, sizeof(*pm_domains), GFP_KERNEL);
>  	if (!pm_domains)
>  		return ERR_PTR(-ENOMEM);
>  
>  	psc->pm_data.domains = pm_domains;
>  	psc->pm_data.num_domains = num_clks;
>  
> -	regmap = devm_regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
> +	regmap = regmap_init_mmio(dev, base, &davinci_psc_regmap_config);
>  	if (IS_ERR(regmap))
>  		return ERR_CAST(regmap);

Here and in the PLL driver, you have dropped the devm_* variants (like
agreed upon), but not added any error path handling. For the clocks
needed for boot, its probably fine, but the same code path is used for
non-essential clocks too. Just from a code completeness perspective, it
will be nice to see the error path correctly handled.

Apart from that both 1/27 and 3/27 look good to me.

Thanks,
Sekhar
