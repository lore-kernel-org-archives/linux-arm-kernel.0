From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Mar 2017 09:54:38 +0200
Subject: [PATCH v2 1/6] clk: sunxi-ng: Add sun4i/sun7i CCU driver
In-Reply-To: <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
Message-ID: <20170327075438.cw3d6s7zyeemenwr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks a lot for working on this.

On Sun, Mar 26, 2017 at 08:20:16PM +0300, Priit Laes wrote:
> Introduce a clock controller driver for sun4i A10 and sun7i A20
> series SoCs.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/Kconfig                  |   13 +-
>  drivers/clk/sunxi-ng/Makefile                 |    1 +-
>  drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.c      | 1532 ++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.h      |   59 +-
>  include/dt-bindings/clock/sunxi-a10-a20-ccu.h |  208 ++-
>  include/dt-bindings/reset/sunxi-a10-a20-ccu.h |   66 +-

I'm not too fond of those sunxi-<all the SoCs supported>. We're not
doing that for any other driver, I don't really know why this has
became a trend lately.

You can call them ccu-sun4i-a10.h, and it will work just fine.

> +/* Not documented on A10 */
> +static SUNXI_CCU_GATE(pll_periph_sata_clk, "pll-periph-sata", "pll-periph",
> +		      0x028, BIT(14), 0);

The rate doesn't come from pll-periph directly, does it?

> +#define SUN4I_AHB_REG		0x054
> +static struct ccu_mux cpu_clk = {
> +	.mux		= {
> +		.shift		= 16,
> +		.width		= 2,
> +		.fixed_predivs	= cpu_predivs,
> +		.n_predivs	= ARRAY_SIZE(cpu_predivs),
> +	},
> +	.common		= {
> +		.reg		= 0x054,

Why did you define this one, even though you don't seem to be using it
anywhere?

> +static const char *const ahb_parents[] = { "axi", "pll-periph",
> +					   "pll-periph-2x" };
> +static const struct ccu_mux_fixed_prediv ahb_predivs[] = {
> +	{ .index = 2, .div = 2, },
> +};

This seems to be only true for the A20, and not the A10.

Are you sure here? The pll-periph-2x seem to be only used in the MBUS
clock in our current code.

And then, using pll-periph-2x, and then dividing it by 2 just gives us
pll-periph, which is also our previous parent :)

> +/* Undocumented on A10 */
> +static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
> +		       0x088, 8, 3, 0);
> +/* Undocumented on A10 */
> +static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
> +		       0x088, 20, 3, 0);

The A10 doesn't have them.

> +/* TODO: Check whether A10 actually supports osc32k as 4th parent? */
> +static const char *const ir_parents_sun4i[] = { "hosc", "pll-periph",
> +						"pll-ddr-other" };

What does the BSP say about this?

> +/* Undocumented on A10 */
> +static SUNXI_CCU_MUX_WITH_GATE(spdif_clk, "spdif", audio_parents,
> +			       0x0c0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);

This doesn't seem to exist at all on the A10

> +/*
> + * TODO: SATA clock also supports external clock as parent via BIT(24)
> + * The external clock is probably an optional crystal or oscillator
> + * that can be connected to the SATA-CLKM / SATA-CLKP pins.
> + */
> +static SUNXI_CCU_GATE(sata_clk, "sata", "pll-periph-sata",
> +		      0x0c8, BIT(31), 0);

The rate won't be good here either. This is supposed to be 100MHz.

> +static const char *const csi_isp_parents[] = { "pll-video0", "pll-ve",
> +					       "pll-ddr-other", "pll-sata" };
> +
> +static SUNXI_CCU_M_WITH_MUX_GATE(csi_isp_clk, "csi-isp",
> +				 csi_isp_parents,
> +				 0x120, 0, 4, 24, 2, BIT(31), 0);

We've been calling it sclk in the other SoC iirc. Any particular
reason to call it differently?

> +static const char *const out_parents[] = { "hosc", "osc32k", "hosc" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(out_a_clk, "out-a", out_parents,
> +				  0x1f0, 8, 5, 20, 2, 24, 2, BIT(31), 0);
> +static SUNXI_CCU_MP_WITH_MUX_GATE(out_b_clk, "out-b", out_parents,
> +				  0x1f4, 8, 5, 20, 2, 24, 2, BIT(31), 0);

There's a fixed pre-divider on the first hosc of 750.

> +static void init_clocks(void __iomem *reg)
> +{
> +	u32 val;
> +
> +	/* Force the PLL-Audio-1x divider to 4 */
> +	val = readl(reg + SUN4I_PLL_AUDIO_REG);
> +	val &= ~GENMASK(19, 16);
> +	writel(val | (3 << 16), reg + SUN4I_PLL_AUDIO_REG);
> +
> +	/* Use PLL6 as parent for AHB */
> +	val = readl(reg + SUN4I_AHB_REG);
> +	val &= ~GENMASK(7, 6);
> +	writel(val | (2 << 6), reg + SUN4I_AHB_REG);

Keeping some kind of comment similar to what was in the DT would be
great, otherwise we lose *why* we need to do so.

> +}
> +
> +static void __init sun4i_a10_ccu_setup(struct device_node *node)
> +{
> +	void __iomem *reg;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n",
> +		       of_node_full_name(node));
> +		return;
> +	}
> +
> +	init_clocks(reg);
> +
> +	sunxi_ccu_probe(node, reg, &sun4i_a10_ccu_desc);

Can't you move the request_and_map / probe in the common function?

> +#ifndef _DT_BINDINGS_CLK_SUNXI_A10_A20_H_
> +#define _DT_BINDINGS_CLK_SUNXI_A10_A20_H_
> +
> +#define CLK_HOSC		1
> +#define CLK_PLL_PERIPH_SATA	16

That one looks suspicious. I don't see why we would need the PLL,
while we have a perfectly functional SATA clock below. Have you tried
gating the bit31 of the register 0xc8 to see if it has any impact?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/44accbf7/attachment-0001.sig>
