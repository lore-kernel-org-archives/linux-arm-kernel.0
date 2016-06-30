From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jun 2016 22:40:01 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <20160625034511.7966-7-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
Message-ID: <20160630204001.GC5485@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 05:45:03AM +0200, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> PLL1 on H3 requires special factors application algorithm,
> when the rate is changed. This algorithm was extracted
> from the arisc code that handles frequency scaling
> in the BSP kernel.
> 
> This commit adds optional apply function to
> struct factors_data, that can implement non-trivial
> factors application method, when necessary.
> 
> Also struct clk_factors_config is extended with position
> of the PLL lock flag.

Have you tested the current implementation, and found that it was not
working, or did you duplicate the arisc code directly?

>  /**
> + * sun8i_h3_apply_pll1_factors() - applies n, k, m, p factors to the
> + * register using an algorithm that tries to reserve the PLL lock
> + */
> +
> +static void sun8i_h3_apply_pll1_factors(struct clk_factors *factors, struct factors_request *req)
> +{
> +	const struct clk_factors_config *config = factors->config;
> +	u32 reg;
> +
> +	/* Fetch the register value */
> +	reg = readl(factors->reg);
> +
> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) < req->p) {
> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
> +
> +		writel(reg, factors->reg);
> +		__delay(2000);
> +	}

So there was some doubts about the fact that P was being used, or at
least that it was useful.

> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) < req->m) {
> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
> +
> +		writel(reg, factors->reg);
> +		__delay(2000);
> +	}
> +
> +	reg = FACTOR_SET(config->nshift, config->nwidth, reg, req->n);
> +	reg = FACTOR_SET(config->kshift, config->kwidth, reg, req->k);
> +
> +	writel(reg, factors->reg);
> +	__delay(20);
> +
> +	while (!(readl(factors->reg) & (1 << config->lock)));

So, they are applying the dividers first, and then applying the
multipliers, and then wait for the PLL to stabilize.

> +
> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) > req->m) {
> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
> +
> +		writel(reg, factors->reg);
> +		__delay(2000);
> +	}
> +
> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) > req->p) {
> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
> +
> +		writel(reg, factors->reg);
> +		__delay(2000);
> +	}

However, this is kind of weird, why would you need to re-apply the
dividers? Nothing really changes. Have you tried without that part?

Since this is really specific, I guess you could simply make the
clk_ops for the nkmp clocks public, and just re-implement set_rate
using that logic.

You might also need to set an upper limit on P, since the last value
(4) is not a valid one.

I guess you could do that by adding a max field in the __ccu_div
structure.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/57038018/attachment.sig>
