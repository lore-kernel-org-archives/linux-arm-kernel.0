From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 24 Sep 2013 11:35:27 +0200
Subject: [PATCH V2 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379982078-23381-1-git-send-email-abrestic@chromium.org>
Message-ID: <52415CDF.4090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/09/13 02:21, Andrew Bresticker wrote:
> @@ -62,24 +64,29 @@ static struct syscore_ops exynos_audss_clk_syscore_ops = {
>  #endif /* CONFIG_PM_SLEEP */
>  
>  /* register exynos_audss clocks */
> -static void __init exynos_audss_clk_init(struct device_node *np)
> +static int exynos_audss_clk_probe(struct platform_device *pdev)
>  {
> -	reg_base = of_iomap(np, 0);
> -	if (!reg_base) {
> -		pr_err("%s: failed to map audss registers\n", __func__);
> -		return;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg_base)) {
> +		dev_err(&pdev->dev, "failed to map audss registers\n");
> +		return PTR_ERR(reg_base);
>  	}
>  
> -	clk_table = kzalloc(sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
> +	clk_table = devm_kzalloc(&pdev->dev,
> +				sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
>  				GFP_KERNEL);
>  	if (!clk_table) {
> -		pr_err("%s: could not allocate clk lookup table\n", __func__);
> -		return;
> +		dev_err(&pdev->dev, "could not allocate clk lookup table\n");

You could drop this error log, k*alloc() functions already log any errors.

> +		return -ENOMEM;
>  	}
>  
>  	clk_data.clks = clk_table;
>  	clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
> -	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +	of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
> +				&clk_data);

>  	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
>  				mout_audss_p, ARRAY_SIZE(mout_audss_p),
> @@ -128,8 +135,53 @@ static void __init exynos_audss_clk_init(struct device_node *np)
>  #endif
>  
>  	pr_info("Exynos: Audss: clock setup completed\n");
> +
> +	return 0;
> +}
> +
> +static int exynos_audss_clk_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < EXYNOS_AUDSS_MAX_CLKS; i++) {
> +		if (clk_table[i])

This would need to be:
		if (!IS_ERR(clk_table[i]))

Note the clock provider should be unregistered first, to avoid potential
race condition, where the clock provider returns an invalid pointer to
a clock, which has already been unregistered and freed.

I just noticed the sequence in probe needs to be fixed as well. i.e.
clocks should be created with clk_register() before the clock provider
is actually registered. It might warrant a separate patch but it's
probably also fine to make such change part of this patch.

> +			clk_unregister(clk_table[i]);
> +	}
> +
> +	of_clk_del_provider(pdev->dev.of_node);
> +
> +	return 0;
>  }

--
Thanks,
Sylwester
