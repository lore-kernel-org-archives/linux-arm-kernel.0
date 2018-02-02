From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 19:42:42 +0530
Subject: [PATCH v6 20/41] ARM: da830: add new clock init using common
 clock framework
In-Reply-To: <1516468460-4908-21-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-21-git-send-email-david@lechnology.com>
Message-ID: <4b2f45f5-7f0d-f0e6-6854-9992e19f45f2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>  void __init da830_init_time(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll0, *psc0, *psc1;
> +	struct clk *clk;
> +
> +	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
> +	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
> +	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
> +
> +	da8xx_register_cfgchip();
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
> +
> +	da830_pll_clk_init(pll0);
> +
> +	da830_psc_clk_init(psc0, psc1);
> +

> +	clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
> +
> +	clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, "timer0", NULL);
> +
> +	clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "davinci-wdt");

Isn't this better done in da830_pll_clk_init() ? I think we can get rid
of the dummy fixed factor clock too and directly use the pll0_auxclk.
That reminds me, is "pll0_aux_clk" above correct, or should it be
"pll0_auxclk" like in da830_pll_clk_init()?

> +
> +	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
> +	clk_register_clkdev(clk, "rmii", NULL);

I don't see any driver looking for this clock using con_id "rmii". I
know this came from existing code. But its most likely a vestige and can
be dropped.

Thanks,
Sekhar
