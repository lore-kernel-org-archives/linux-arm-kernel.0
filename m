From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Apr 2017 15:38:05 +0200
Subject: [linux-sunxi] Re: [PATCH v2 1/6] clk: sunxi-ng: Add sun4i/sun7i
 CCU driver
In-Reply-To: <20170404200919.GA22159@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <ac8c4dab4f160ec605d52120517774bf1de87c2e.1490545262.git-series.plaes@plaes.org>
 <20170327075438.cw3d6s7zyeemenwr@lukather>
 <20170404200919.GA22159@plaes.org>
Message-ID: <20170407133805.aiythp3hdvuyhcrc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Tue, Apr 04, 2017 at 08:09:19PM +0000, Priit Laes wrote:
> > > +/* Not documented on A10 */
> > > +static SUNXI_CCU_GATE(pll_periph_sata_clk, "pll-periph-sata", "pll-periph",
> > > +		      0x028, BIT(14), 0);
> > 
> > The rate doesn't come from pll-periph directly, does it?
> 
> So it uses hosc (24MHz parent clock) instead of pll-periph?

I never looked too much at this, but it looks more like the input is
pll-periph-sata itself.

> > > +/* Undocumented on A10 */
> > > +static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
> > > +		       0x088, 8, 3, 0);
> > > +/* Undocumented on A10 */
> > > +static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
> > > +		       0x088, 20, 3, 0);
> > 
> > The A10 doesn't have them.
> 
> Are you sure? Although, they weren't listed in datasheet, they are defined
> in the sun4i-a10.dtsi:
> 
> mmc0_clk: clk at 01c20088 {
>         #clock-cells = <1>;
>         compatible = "allwinner,sun4i-a10-mmc-clk";
>         reg = <0x01c20088 0x4>;
>         clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
>         clock-output-names = "mmc0",
>                              "mmc0_output",
>                              "mmc0_sample";
> };

Yes, those clocks have been introduced in the A20, but we didn't find
out until much later, which is why there's still left overs in the
DT. We're not using them in the driver for the A10 either (but we do
for the A20, obviously).

> > > +/* TODO: Check whether A10 actually supports osc32k as 4th parent? */
> > > +static const char *const ir_parents_sun4i[] = { "hosc", "pll-periph",
> > > +						"pll-ddr-other" };
> > 
> > What does the BSP say about this?
> 
> sun7i datasheet mentions osc32k, but BSP code for sun4i, sun5i and sun7i
> is identical and supports only 3 first parents without osc32k.

Ok. Leave the TODO for now, we'll fix it if relevant.

> > > +/* Undocumented on A10 */
> > > +static SUNXI_CCU_MUX_WITH_GATE(spdif_clk, "spdif", audio_parents,
> > > +			       0x0c0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
> > 
> > This doesn't seem to exist at all on the A10
> 
> Wasn't listed in datasheet, but it's in BSP and also in sun4i-a10.dtsi:
> 
> spdif_clk: clk at 01c200c0 {
>         #clock-cells = <0>;
>         compatible = "allwinner,sun4i-a10-mod1-clk";
>         reg = <0x01c200c0 0x4>;
>         clocks = <&pll2 SUN4I_A10_PLL2_8X>,
>                  <&pll2 SUN4I_A10_PLL2_4X>,
>                  <&pll2 SUN4I_A10_PLL2_2X>,
>                  <&pll2 SUN4I_A10_PLL2_1X>;
>         clock-output-names = "spdif";
> };

Ack.

> > > +/*
> > > + * TODO: SATA clock also supports external clock as parent via BIT(24)
> > > + * The external clock is probably an optional crystal or oscillator
> > > + * that can be connected to the SATA-CLKM / SATA-CLKP pins.
> > > + */
> > > +static SUNXI_CCU_GATE(sata_clk, "sata", "pll-periph-sata",
> > > +		      0x0c8, BIT(31), 0);
> > 
> > The rate won't be good here either. This is supposed to be 100MHz.
> 
> Hmm.. I tested SATA with Cubietruck. Or what do you mean?

As long as you don't have any dependency on the rate itself, as long
as the gate is opened, I expect it to work. But the rate itself will
be reported wrong.

> > > +static const char *const csi_isp_parents[] = { "pll-video0", "pll-ve",
> > > +					       "pll-ddr-other", "pll-sata" };
> > > +
> > > +static SUNXI_CCU_M_WITH_MUX_GATE(csi_isp_clk, "csi-isp",
> > > +				 csi_isp_parents,
> > > +				 0x120, 0, 4, 24, 2, BIT(31), 0);
> > 
> > We've been calling it sclk in the other SoC iirc. Any particular
> > reason to call it differently?
> 
> It's called ISP in BSP and A10 manual.
> In A20 it's indeed Special Clock Register (SCLK).

Let's call it SCLK too then, for consistency.

> > > +static const char *const out_parents[] = { "hosc", "osc32k", "hosc" };
> > > +static SUNXI_CCU_MP_WITH_MUX_GATE(out_a_clk, "out-a", out_parents,
> > > +				  0x1f0, 8, 5, 20, 2, 24, 2, BIT(31), 0);
> > > +static SUNXI_CCU_MP_WITH_MUX_GATE(out_b_clk, "out-b", out_parents,
> > > +				  0x1f4, 8, 5, 20, 2, 24, 2, BIT(31), 0);
> > 
> > There's a fixed pre-divider on the first hosc of 750.
> 
> Nice catch.
> 
> So it should be something like this:
> 
> [snip]
> static const char *const out_parents[] = { "osc24M", "osc32k", "osc24M" };
> static const struct ccu_mux_fixed_prediv out_prediv = {
>         .index = 0, .div = 750
> };

I think it shoud still be hosc (or at least, the name that you used
for the gate controlling the 24MHz oscillator input).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170407/7a077fee/attachment.sig>
