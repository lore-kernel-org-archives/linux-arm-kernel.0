From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 17 May 2018 20:05:52 +0530
Subject: [PATCH v10 25/27] ARM: davinci: add device tree support to timer
In-Reply-To: <20180509172606.29387-26-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-26-david@lechnology.com>
Message-ID: <8fa98514-7651-58cb-595e-6c7f713540b8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Wednesday 09 May 2018 10:56 PM, David Lechner wrote:
> This adds device tree support to the davinci timer so that when clocks
> are moved to device tree, the timer will still work.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

> +static int __init of_davinci_timer_init(struct device_node *np)
> +{
> +	struct clk *clk;
> +
> +	clk = of_clk_get(np, 0);
> +	if (IS_ERR(clk)) {
> +		struct of_phandle_args clkspec;
> +
> +		/*
> +		 * Fall back to using ref_clk if the actual clock is not
> +		 * available. There will be problems later if the real clock
> +		 * source is disabled.
> +		 */
> +
> +		pr_warn("%s: falling back to ref_clk\n", __func__);
> +
> +		clkspec.np = of_find_node_by_name(NULL, "ref_clk");
> +		if (IS_ERR(clkspec.np)) {
> +			pr_err("%s: No clock available for timer!\n", __func__);
> +			return PTR_ERR(clkspec.np);
> +		}
> +		clk = of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
> +	}

Do we need this error path now?

Thanks,
Sekhar
