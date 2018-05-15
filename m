From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 May 2018 19:01:52 +0530
Subject: [PATCH v10 02/27] clk: davinci: da850-pll: change PLL0 to
 CLK_OF_DECLARE
In-Reply-To: <20180509172606.29387-3-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-3-david@lechnology.com>
Message-ID: <9203489d-0a5a-103a-67ea-d3e89bb7ebc4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
> +void of_da850_pll0_init(struct device_node *node)
>  {
> -	return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
> -				   &da850_pll0_obsclk_info,
> -				   da850_pll0_sysclk_info, 7, base, cfgchip);
> +	void __iomem *base;
> +	struct regmap *cfgchip;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s: ioremap failed\n", __func__);
> +		return;
> +	}
> +
> +	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");

It will be nice to handle the error case here.

> +
> +	of_davinci_pll_init(NULL, node, &da850_pll0_info,
> +			    &da850_pll0_obsclk_info,
> +			    da850_pll0_sysclk_info, 7, base, cfgchip);

Apart from that, it looks good to me.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
