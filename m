From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 May 2017 09:39:43 +0200
Subject: [PATCH v3 3/6] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <20170518035809.15487-4-wens@csie.org>
References: <20170518035809.15487-1-wens@csie.org>
 <20170518035809.15487-4-wens@csie.org>
Message-ID: <20170518073943.hu4bsz5qggpkvyv2@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 11:58:06AM +0800, Chen-Yu Tsai wrote:
> +/*
> + * MMC2 supports both old and new timing modes. When the new timing
> + * mode is active, the output clock rate is halved by two. Here we
> + * treat it as a variable pre-divider. Note that the pre-divider is
> + * _not_ included in the possible factors during a set clock rate
> + * operation. It is only read out.
> + */
> +#define SUN8I_A83T_MMC2_REG	0x090
> +static const struct ccu_mux_var_prediv mmc2_new_timing_predivs[] = {
> +	{ .index = 0, .shift = 30, .width = 1 },
> +	{ .index = 1, .shift = 30, .width = 1 },
> +};
> +static struct ccu_mp mmc2_clk = {
> +	.enable	= BIT(31),
> +	.m	= _SUNXI_CCU_DIV(0, 4),
> +	.p	= _SUNXI_CCU_DIV(16, 2),
> +	.mux	= {
> +		.shift	= 24,
> +		.width	= 2,
> +		.var_predivs	= mmc2_new_timing_predivs,
> +		.n_var_predivs	= ARRAY_SIZE(mmc2_new_timing_predivs),
> +	},
> +	.common		= {
> +		.reg		= 0x090,
> +		.hw.init	= CLK_HW_INIT_PARENTS("mmc2",
> +						      mod0_default_parents,
> +						      &ccu_mp_ops,
> +						      CLK_GET_RATE_NOCACHE),
> +	},
> +};
> +
> +static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2-sample", "mmc2",
> +		       0x090, 20, 3, 0);
> +static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2-output", "mmc2",
> +		       0x090, 8, 3, 0);

I'm sorry to be a pain for this, but we're in the exact same situation
for the A83T than the A33 or the H3. There's no reason we'd do
something different with the MMC clocks only on the A83T.

What I'd like to happen is:
  1) Get the A83T ccu driver in, without *any* of the new mode
     handling.
  2) Work on the new mode for the A33, A83T and H3 (and the other I
     might have forgotten).

This issue really isn't A83 specific, there's no reason to come up
with A83 specific code.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/a9ec21d8/attachment.sig>
