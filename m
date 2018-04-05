From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Apr 2018 17:00:01 +0530
Subject: [PATCH v8 40/42] ARM: davinci: add device tree support to timer
In-Reply-To: <1521168778-27236-41-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-41-git-send-email-david@lechnology.com>
Message-ID: <205cae72-4e91-aca2-e3b2-829a12066dc8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2018 08:22 AM, David Lechner wrote:
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
> +		 * available. This currently always happens because platform
> +		 * clocks (i.e PLLs and PSCs) are registered as platform
> +		 * devices and therefore are not available at this point in
> +		 * the boot process.

It seems to me that this is not going to be a temporary problem (or at
least will be around for quite a while). So, I think we can as well just
look for ref_clk directly.

> +		 */
> +		clkspec.np = of_find_node_by_name(NULL, "ref_clk");
> +		if (IS_ERR(clkspec.np)) {
> +			pr_err("%s: No clock available for timer!\n", __func__);
> +			return PTR_ERR(clkspec.np);
> +		}
> +		clk = of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
> +	}
> +
> +	davinci_timer_init(clk);
> +
> +	return 0;
> +}
> +TIMER_OF_DECLARE(davinci_timer, "ti,davinci-timer", of_davinci_timer_init);

Here, I think we should use "ti,da850-timer" so we can change the fixed
clock we are looking for based on the SoC. At a minimum, we should have
"ti,da850-timer" in the DT along with "ti,davinci-timer".

BTW, I noticed that "ti,davinci-timer" is not documented. I think we
need to add a binding documentation too.

Thanks,
Sekhar
