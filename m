From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 19:50:39 +0530
Subject: [PATCH v6 21/41] ARM: da850: add new clock init using common
 clock framework
In-Reply-To: <1516468460-4908-22-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-22-git-send-email-david@lechnology.com>
Message-ID: <73d2c30d-ee86-1269-dd4b-1ebfe88a3149@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
>  void __init da850_init_time(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll0, *pll1, *psc0, *psc1;
> +	struct regmap *cfgchip;
> +	struct clk *clk;
> +	struct clk_hw *parent;
> +
> +	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
> +	pll1 = ioremap(DA850_PLL1_BASE, SZ_4K);
> +	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
> +	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
> +
> +	cfgchip = da8xx_register_cfgchip();
> +	if (WARN(IS_ERR(cfgchip), "failed to register CFGCHIP syscon"))
> +		return;
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
> +
> +	da850_pll_clk_init(pll0, pll1);
> +
> +	da8xx_cfgchip_register_div4p5(cfgchip);
> +
> +	da8xx_cfgchip_register_async1(cfgchip);
> +
> +	clk = clk_register_fixed_factor(NULL, "async2", "pll0_auxclk", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
> +	clk_register_clkdev(clk, "timer0", NULL);
> +	clk_register_clkdev(clk, NULL, "davinci-wdt");

I think its better to get these clkdevs registered in
da850_pll_clk_init() itself.

> +
> +	clk = da8xx_cfgchip_register_async3(cfgchip);
> +
> +	/* pll1_sysclk2 is not affected by CPU scaling, so use it for async3 */
> +	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk), 1);
> +	if (parent)
> +		clk_set_parent(clk, parent->clk);
> +	else
> +		pr_warn("%s: Failed to find async3 parent clock\n", __func__);
> +
> +	da850_psc_clk_init(psc0, psc1);
> +
> +	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
> +	clk_register_clkdev(clk, "rmii", NULL);

Like in da830, can drop this rmii clock, I think.

Thanks,
Sekhar
