From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 3 May 2018 18:48:20 +0530
Subject: [PATCH v9 09/27] ARM: davinci: dm644x: add new clock init using
 common clock framework
In-Reply-To: <20180427001745.4116-10-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-10-david@lechnology.com>
Message-ID: <cfce1685-296a-a669-bb7d-bf14d43004ed@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>  void __init dm644x_init_time(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll1, *psc;
> +	struct clk *clk;
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
> +
> +	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
> +	dm355_pll1_init(NULL, pll1, NULL);

This should be dm644x_*()

> +
> +	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
> +	dm355_psc_init(NULL, psc);

This one should be dm644x_*()

With those fixes, I was able to bootup on DM644x EVM and a visual
inspection of clock debug dump shows it remains same before and after
the conversion.

Thanks,
Sekhar
