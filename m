From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Jan 2018 20:54:45 +0530
Subject: [PATCH v5 24/44] ARM: da850: add new clock init using common
 clock framework
In-Reply-To: <1515377863-20358-25-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-25-git-send-email-david@lechnology.com>
Message-ID: <4ccda6ea-057d-11ed-84fc-a2db50b21467@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:47 AM, David Lechner wrote:

> +#ifndef CONFIG_COMMON_CLK
>  static int da850_set_armrate(struct clk *clk, unsigned long rate);
>  static int da850_round_armrate(struct clk *clk, unsigned long rate);
>  static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
> @@ -583,6 +588,7 @@ static struct clk_lookup da850_clks[] = {
>  	CLK("ecap.2",		"fck",		&ecap2_clk),
>  	CLK(NULL,		NULL,		NULL),
>  };
> +#endif

Don't like these temporary ifdefs (which I am sure is the case with you
too). But don't have any other good idea for splitting these patches
into review-able and build-able pieces. So lets go with this for now.

>  void __init da850_init_time(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll0, *pll1, *psc0, *psc1;
> +	struct clk *clk;
> +	struct clk_hw *parent;
> +
> +	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
> +	pll1 = ioremap(DA850_PLL1_BASE, SZ_4K);
> +	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
> +	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);

Overall, this and other functions like this in this series need some
more line spacing. Please add a space here..

> +	da850_pll_clk_init(pll0, pll1);

.. and here.

> +	clk = clk_register_mux(NULL, "async3",
> +		(const char * const[]){ "pll0_sysclk2", "pll1_sysclk2" },
> +		2, 0, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG),
> +		ilog2(CFGCHIP3_ASYNC3_CLKSRC), 1, 0, NULL);

.. here before the comment ..

> +	/* pll1_sysclk2 is not affected by CPU scaling, so use it for async3 */
> +	parent = clk_hw_get_parent_by_index(__clk_get_hw(clk), 1);
> +	if (parent)
> +		clk_set_parent(clk, parent->clk);
> +	else
> +		pr_warn("%s: Failed to find async3 parent clock\n", __func__);

.. and here. And so on.

I have not taken a closer look at mach patches. But may be you should
send the next version anyway and make sure everyone is happy with the
driver first.

Thanks,
Sekhar
