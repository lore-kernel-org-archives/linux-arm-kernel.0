From: plaes@plaes.org (Priit Laes)
Date: Tue, 4 Apr 2017 20:09:19 +0000
Subject: [linux-sunxi] Re: [PATCH v2 1/6] clk: sunxi-ng: Add sun4i/sun7i
 CCU driver
In-Reply-To: <20170327075438.cw3d6s7zyeemenwr@lukather>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
 <20170327075438.cw3d6s7zyeemenwr@lukather>
Message-ID: <20170404200919.GA22159@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 09:54:38AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Thanks a lot for working on this.
> 
> On Sun, Mar 26, 2017 at 08:20:16PM +0300, Priit Laes wrote:
> > Introduce a clock controller driver for sun4i A10 and sun7i A20
> > series SoCs.
> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  drivers/clk/sunxi-ng/Kconfig                  |   13 +-
> >  drivers/clk/sunxi-ng/Makefile                 |    1 +-
> >  drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.c      | 1532 ++++++++++++++++++-
> >  drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.h      |   59 +-
> >  include/dt-bindings/clock/sunxi-a10-a20-ccu.h |  208 ++-
> >  include/dt-bindings/reset/sunxi-a10-a20-ccu.h |   66 +-
> 
> I'm not too fond of those sunxi-<all the SoCs supported>. We're not
> doing that for any other driver, I don't really know why this has
> became a trend lately.
> 
> You can call them ccu-sun4i-a10.h, and it will work just fine.

OK, will do!

> 
> > +/* Not documented on A10 */
> > +static SUNXI_CCU_GATE(pll_periph_sata_clk, "pll-periph-sata", "pll-periph",
> > +		      0x028, BIT(14), 0);
> 
> The rate doesn't come from pll-periph directly, does it?

So it uses hosc (24MHz parent clock) instead of pll-periph?

> 
> > +#define SUN4I_AHB_REG		0x054
> > +static struct ccu_mux cpu_clk = {
> > +	.mux		= {
> > +		.shift		= 16,
> > +		.width		= 2,
> > +		.fixed_predivs	= cpu_predivs,
> > +		.n_predivs	= ARRAY_SIZE(cpu_predivs),
> > +	},
> > +	.common		= {
> > +		.reg		= 0x054,
> 
> Why did you define this one, even though you don't seem to be using it
> anywhere?

Leftover from when I also included A10 support.

> 
> > +static const char *const ahb_parents[] = { "axi", "pll-periph",
> > +					   "pll-periph-2x" };
> > +static const struct ccu_mux_fixed_prediv ahb_predivs[] = {
> > +	{ .index = 2, .div = 2, },
> > +};
> 
> This seems to be only true for the A20, and not the A10.
> 
> Are you sure here? The pll-periph-2x seem to be only used in the MBUS
> clock in our current code.

Nope...
> 
> And then, using pll-periph-2x, and then dividing it by 2 just gives us
> pll-periph, which is also our previous parent :)

...will investigate.

> 
> > +/* Undocumented on A10 */
> > +static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
> > +		       0x088, 8, 3, 0);
> > +/* Undocumented on A10 */
> > +static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
> > +		       0x088, 20, 3, 0);
> 
> The A10 doesn't have them.

Are you sure? Although, they weren't listed in datasheet, they are defined
in the sun4i-a10.dtsi:

mmc0_clk: clk at 01c20088 {
        #clock-cells = <1>;
        compatible = "allwinner,sun4i-a10-mmc-clk";
        reg = <0x01c20088 0x4>;
        clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
        clock-output-names = "mmc0",
                             "mmc0_output",
                             "mmc0_sample";
};

> > +/* TODO: Check whether A10 actually supports osc32k as 4th parent? */
> > +static const char *const ir_parents_sun4i[] = { "hosc", "pll-periph",
> > +						"pll-ddr-other" };
> 
> What does the BSP say about this?

sun7i datasheet mentions osc32k, but BSP code for sun4i, sun5i and sun7i
is identical and supports only 3 first parents without osc32k.


> > +/* Undocumented on A10 */
> > +static SUNXI_CCU_MUX_WITH_GATE(spdif_clk, "spdif", audio_parents,
> > +			       0x0c0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
> 
> This doesn't seem to exist at all on the A10

Wasn't listed in datasheet, but it's in BSP and also in sun4i-a10.dtsi:

spdif_clk: clk at 01c200c0 {
        #clock-cells = <0>;
        compatible = "allwinner,sun4i-a10-mod1-clk";
        reg = <0x01c200c0 0x4>;
        clocks = <&pll2 SUN4I_A10_PLL2_8X>,
                 <&pll2 SUN4I_A10_PLL2_4X>,
                 <&pll2 SUN4I_A10_PLL2_2X>,
                 <&pll2 SUN4I_A10_PLL2_1X>;
        clock-output-names = "spdif";
};


> 
> > +/*
> > + * TODO: SATA clock also supports external clock as parent via BIT(24)
> > + * The external clock is probably an optional crystal or oscillator
> > + * that can be connected to the SATA-CLKM / SATA-CLKP pins.
> > + */
> > +static SUNXI_CCU_GATE(sata_clk, "sata", "pll-periph-sata",
> > +		      0x0c8, BIT(31), 0);
> 
> The rate won't be good here either. This is supposed to be 100MHz.

Hmm.. I tested SATA with Cubietruck. Or what do you mean?

> > +static const char *const csi_isp_parents[] = { "pll-video0", "pll-ve",
> > +					       "pll-ddr-other", "pll-sata" };
> > +
> > +static SUNXI_CCU_M_WITH_MUX_GATE(csi_isp_clk, "csi-isp",
> > +				 csi_isp_parents,
> > +				 0x120, 0, 4, 24, 2, BIT(31), 0);
> 
> We've been calling it sclk in the other SoC iirc. Any particular
> reason to call it differently?

It's called ISP in BSP and A10 manual.
In A20 it's indeed Special Clock Register (SCLK).

> > +static const char *const out_parents[] = { "hosc", "osc32k", "hosc" };
> > +static SUNXI_CCU_MP_WITH_MUX_GATE(out_a_clk, "out-a", out_parents,
> > +				  0x1f0, 8, 5, 20, 2, 24, 2, BIT(31), 0);
> > +static SUNXI_CCU_MP_WITH_MUX_GATE(out_b_clk, "out-b", out_parents,
> > +				  0x1f4, 8, 5, 20, 2, 24, 2, BIT(31), 0);
> 
> There's a fixed pre-divider on the first hosc of 750.

Nice catch.

So it should be something like this:

[snip]
static const char *const out_parents[] = { "osc24M", "osc32k", "osc24M" };
static const struct ccu_mux_fixed_prediv out_prediv = {
        .index = 0, .div = 750
};

static struct ccu_mp out_a_clk = {
        .enable         = BIT(31),
        .m              = _SUNXI_CCU_DIV(8, 5),
        .p              = _SUNXI_CCU_DIV(20, 2),
        .mux            = {
                .shift          = 24,
                .width          = 2,
                .fixed_predivs  = &out_prediv,
                .n_predivs      = ARRAY_SIZE(out_prediv),
        },
        .common         = {
                .reg            = 0x1f0,
                .features       = CCU_FEATURE_FIXED_PREDIV,
                .hw.init        = CLK_HW_INIT_PARENTS("out-a",
                                                      out_parents,
                                                      &ccu_mp_ops,
                                                      0),
        },
};
[/snip]


> > +static void init_clocks(void __iomem *reg)
> > +{
> > +	u32 val;
> > +
> > +	/* Force the PLL-Audio-1x divider to 4 */
> > +	val = readl(reg + SUN4I_PLL_AUDIO_REG);
> > +	val &= ~GENMASK(19, 16);
> > +	writel(val | (3 << 16), reg + SUN4I_PLL_AUDIO_REG);
> > +
> > +	/* Use PLL6 as parent for AHB */
> > +	val = readl(reg + SUN4I_AHB_REG);
> > +	val &= ~GENMASK(7, 6);
> > +	writel(val | (2 << 6), reg + SUN4I_AHB_REG);
> 
> Keeping some kind of comment similar to what was in the DT would be
> great, otherwise we lose *why* we need to do so.

OK

> > +}
> > +
> > +static void __init sun4i_a10_ccu_setup(struct device_node *node)
> > +{
> > +	void __iomem *reg;
> > +
> > +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > +	if (IS_ERR(reg)) {
> > +		pr_err("%s: Could not map the clock registers\n",
> > +		       of_node_full_name(node));
> > +		return;
> > +	}
> > +
> > +	init_clocks(reg);
> > +
> > +	sunxi_ccu_probe(node, reg, &sun4i_a10_ccu_desc);
> 
> Can't you move the request_and_map / probe in the common function?

Will do.

> > +#ifndef _DT_BINDINGS_CLK_SUNXI_A10_A20_H_
> > +#define _DT_BINDINGS_CLK_SUNXI_A10_A20_H_
> > +
> > +#define CLK_HOSC		1
> > +#define CLK_PLL_PERIPH_SATA	16
> 
> That one looks suspicious. I don't see why we would need the PLL,
> while we have a perfectly functional SATA clock below. Have you tried
> gating the bit31 of the register 0xc8 to see if it has any impact?

Will try it...

> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
