From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 21:57:40 +0100
Subject: [PATCH v2 09/15] ARM: mxs: Add clock support
In-Reply-To: <1291739523-25077-8-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-8-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101208205740.GG17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 12:31:59AM +0800, Shawn Guo wrote:
> Add clock for MXS-based SoCs, MX23 and MX28.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Shift pll0_clock freq 480MHz in children freq computation to avoid overflow
really?

> [...]
> +/*
> + * pll_clk
> + */
> +static unsigned long pll_clk_get_rate(struct clk *clk)
> +{
> +	return 480000000;
pll's get_rate still returns 0x1c9c3800

> [...]
> +/*
> + * ref_clk
> + */
> +#define _CLK_GET_RATE_REF(name, sr, ss)					\
> +static unsigned long name##_get_rate(struct clk *clk)			\
> +{									\
> +	unsigned long parent_rate;					\
> +	u32 reg, div;							\
> +									\
> +	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##sr);		\
> +	div = (reg >> BP_CLKCTRL_##sr##_##ss##FRAC) & 0x3f;		\
> +	parent_rate = clk_get_rate(clk->parent);			\
> +									\
> +	return parent_rate * 18 / div;					\
> +}
> +
> +_CLK_GET_RATE_REF(ref_cpu_clk, FRAC, CPU)
ref_cpu_clk's get_rate still uses parent_rate * 18

> +_CLK_GET_RATE_REF(ref_emi_clk, FRAC, EMI)
> +_CLK_GET_RATE_REF(ref_pix_clk, FRAC, PIX)
> +_CLK_GET_RATE_REF(ref_io_clk, FRAC, IO)
> +
> +#define _DEFINE_CLOCK_REF(name, er, es)					\
> +	static struct clk name = {					\
> +		.enable_reg	= CLKCTRL_BASE_ADDR + HW_CLKCTRL_##er,	\
> +		.enable_shift	= BP_CLKCTRL_##er##_CLKGATE##es,	\
> +		.get_rate	= name##_get_rate,			\
> +		.enable		= _raw_clk_enable,			\
> +		.disable	= _raw_clk_disable,			\
> +		.parent		= &pll_clk,				\
> +	}
> +
> +_DEFINE_CLOCK_REF(ref_cpu_clk, FRAC, CPU);
ref_cpu_clk's parent still is pll_clk

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
