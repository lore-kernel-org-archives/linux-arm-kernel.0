From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 Jul 2014 17:34:34 +0200
Subject: [PATCH V2 3/3] clk: exynos-audss: Use samsung clock APIs to
 register/unregister clocks
In-Reply-To: <1405080036-6651-4-git-send-email-tushar.b@samsung.com>
References: <1405080036-6651-1-git-send-email-tushar.b@samsung.com>
 <1405080036-6651-4-git-send-email-tushar.b@samsung.com>
Message-ID: <53C3F88A.8080005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/14 14:00, Tushar Behera wrote:
> @@ -103,17 +140,11 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
>  		return PTR_ERR(reg_base);
>  	}
>  
> -	clk_table = devm_kzalloc(&pdev->dev,
> -				sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
> -				GFP_KERNEL);
> -	if (!clk_table)
> +	ctx = samsung_clk_init(pdev->dev.of_node, reg_base, nr_clks);

There is an issue here that this registers the clk provider before all
its clocks are registered with the clk core. Therefore it introduces
a race condition.

Please have a look at patch [1], you may want to rebase this series
onto that patch.

> +	samsung_clk_register_div(ctx, exynos_audss_div_clks,
> +				ARRAY_SIZE(exynos_audss_div_clks));
[...]
> +	samsung_clk_register_gate(ctx, exynos_audss_gate_clks,
> +				ARRAY_SIZE(exynos_audss_gate_clks));
[...]
> -	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
> -					&clk_data);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to add clock provider\n");
> -		goto unregister;
> +		samsung_clk_register_gate(ctx, exynos5420_audss_gate_clks,
> +					ARRAY_SIZE(exynos5420_audss_gate_clks));
>  	}

[1]
https://git.kernel.org/cgit/linux/kernel/git/tfiga/samsung-clk.git/commit/?h=samsung-clk-next&id=d5e136a21b2028fb1f45143ea7112d5869bfc6c7

--
Regards,
Sylwester
