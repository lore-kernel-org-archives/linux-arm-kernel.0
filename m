From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 24 Sep 2013 23:15:39 +0200
Subject: [PATCH V3 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
References: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
 <1380046016-5811-1-git-send-email-abrestic@chromium.org>
Message-ID: <524200FB.8010004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 08:06 PM, Andrew Bresticker wrote:
> +static int exynos_audss_clk_probe(struct platform_device *pdev)
>   {
[...]
>   	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
>   				mout_audss_p, ARRAY_SIZE(mout_audss_p),
> @@ -123,13 +124,83 @@ static void __init exynos_audss_clk_init(struct device_node *np)
>   				"div_pcm0", CLK_SET_RATE_PARENT,
>   				reg_base + ASS_CLK_GATE, 5, 0,&lock);
>
> +	for (i = 0; i<  EXYNOS_AUDSS_MAX_CLKS; i++) {
> +		if (IS_ERR(clk_table[i])) {
> +			dev_err(&pdev->dev, "failed to regsiter clock %d\n", i);

typo: regsiter -> register

> +			ret = PTR_ERR(clk_table[i]);
> +			goto unregister;
> +		}
> +	}
> +
> +	clk_data.clks = clk_table;
> +	clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS;
> +	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
> +					&clk_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add clock provider\n");
> +		goto unregister;
> +	}
> +
[...]
> +	return 0;
> +
> +unregister:
> +	for (i = 0; i<  EXYNOS_AUDSS_MAX_CLKS; i++) {
> +		if (!IS_ERR_OR_NULL(clk_table[i]))
> +			clk_unregister(clk_table[i]);
> +	}

Couldn't this instead be:

	while (--i >= 0)
		clk_unregister(clk_table[i]);

?
> +static int exynos_audss_clk_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	of_clk_del_provider(pdev->dev.of_node);
> +
> +	for (i = 0; i<  EXYNOS_AUDSS_MAX_CLKS; i++) {
> +		if (!IS_ERR_OR_NULL(clk_table[i]))
> +			clk_unregister(clk_table[i]);
> +	}

Since we only get here if all the clocks are registered properly and we
always register EXYNOS_AUDSS_MAX_CLKS clocks, couldn't this simply be:

	for (i = 0; i < EXYNOS_AUDSS_MAX_CLKS; i++)
		clk_unregister(clk_table[i]);

?
> +	return 0;
> +}

Otherwise the whole series looks good to me. Feel free to add:

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>


--
Thanks,
Sylwester
