From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 May 2016 16:02:00 +0200
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160513114559.786221e415ce5956e161dd5b@free.fr>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
 <20160513114559.786221e415ce5956e161dd5b@free.fr>
Message-ID: <20160518140200.GN27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Francois,

On Fri, May 13, 2016 at 11:45:59AM +0200, Jean-Francois Moine wrote:
> On Sun,  8 May 2016 22:01:50 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Add the list of clocks and resets found in the H3 CCU.
> 
> Hi Maxime,
> 
> Nice job. I like this new way for defining the sunxi clocks.
> But it does not yet fully work for the H3 (apart the other already
> signalled errors). See below.

I'm glad you like it, it should make everyone's life easier.

And I was kind of expecting you'd uncover a bunch of bugs testing that
with the HDMI audio patches you have.

> 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Makefile        |   2 +
> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 757 +++++++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
> >  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
> >  4 files changed, 1024 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> >  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
> >  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
> > 
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index c794f57b6fb1..67ff6a92f124 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -13,3 +13,5 @@ obj-y += ccu_nkmp.o
> >  obj-y += ccu_nm.o
> >  obj-y += ccu_p.o
> >  obj-y += ccu_phase.o
> > +
> > +obj-y += ccu-sun8i-h3.o
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> > new file mode 100644
> > index 000000000000..5ce699e95c32
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> > @@ -0,0 +1,757 @@
> 	[snip]
> > +static struct ccu_nkmp pll_cpux_clk = {
> > +	.enable		= BIT(31),
> > +	.lock		= BIT(28),
> > +
> > +	.m		= SUNXI_CLK_FACTOR(0, 2),
> > +	.k		= SUNXI_CLK_FACTOR(4, 2),
> > +	.n		= SUNXI_CLK_FACTOR(8, 5),
> > +	.p		= SUNXI_CLK_FACTOR(16, 2),
> > +
> > +	.common		= {
> > +		.reg		= 0x000,
> > +		.features	= CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> 
> It seems to me that these flags are redondant with the .enable
> and .lock fields (always != 0 when used).

Yes, kind of, but not exactly. The features flags describe in a
generic manner what the clock can and cannot do, while the fields
themselves are per-structure.

This will allow the core if we ever need it to probe what each clock
implements. And since we are using it for other features that can be
shared by multiple clock classes (muxes, post-div, pre-div and so on),
I think it would be best to keep it consitent and use it here.

But I agree that it's not really a strong argument.

> 
> > +		.hw.init	= SUNXI_HW_INIT("pll-cpux",
> > +						"osc24M",
> > +						&ccu_nkmp_ops,
> > +						0),
> > +	},
> > +};
> 
> The 'p' factor must be used only for very low rates (< 288MHz).
> I think that it should be ignored.

Yeah, I noticed it as well during the development. I just re-used the
current behaviour of the A23 PLL1 that uses P as well. I was not
really willing to change any behaviour here at first, this patch set
is already quite intrusive.

But we can definitely change that later.

> > +
> > +static struct ccu_nm pll_audio_base_clk = {
> > +	.enable		= BIT(31),
> > +	.lock		= BIT(28),
> > +
> > +	.m		= SUNXI_CLK_FACTOR(0, 5),
> > +	.n		= SUNXI_CLK_FACTOR(8, 7),
> > +
> > +	.common		= {
> > +		.reg		= 0x008,
> > +		.features	= CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> > +		.hw.init	= SUNXI_HW_INIT("pll-audio-base",
> > +						"osc24M",
> > +						&ccu_nm_ops,
> > +						0),
> > +	},
> > +};
> > +
> > +static SUNXI_CCU_M(pll_audio_clk, "pll-audio", "pll-audio-base",
> > +		   0x008, 16, 4, 0);
> > +
> > +static SUNXI_CCU_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
> > +			      "pll-audio-base", 2, 1, 0);
> > +static SUNXI_CCU_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
> > +			      "pll-audio-base", 1, 1, 0);
> > +static SUNXI_CCU_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
> > +			      "pll-audio-base", 1, 2, 0);
> 
> Forcing the post divider 'p' to 4 would simplify this PLL.

Yes and no. It would simplify the clock rate computation and
propagation across the tree, but it would also add more code in there,
and we would not be able to read the clock rate properly.

Chaining clocks like that should also be supported and working, so I'd
still be very much in favour of implementing it as it is supposed to
be, and fixing whatever bug there might be in there.

> > +static struct ccu_nm pll_video_clk = {
> > +	.enable		= BIT(31),
> > +	.lock		= BIT(28),
> > +
> > +	.m		= SUNXI_CLK_FACTOR(0, 4),
> > +	.n		= SUNXI_CLK_FACTOR(8, 7),
> > +
> > +	.common		= {
> > +		.reg		= 0x010,
> > +		.features	= CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> > +		.hw.init	= SUNXI_HW_INIT("pll-video",
> > +						"osc24M",
> > +						&ccu_nm_ops,
> > +						0),
> > +	},
> > +};
> 
> The legacy u-boot I use (lichee) forces this PLL to 297MHz in
> fractional mode (FRAC_CLK_OUT = 1 and PLL_MODE_SEL = 0).
> As these bits are not managed, getting the rate is false and setting it
> is not possible.

Ah, interesting.

I'll add support for fractional clocks in the next version then.

Just out of curiosity, is there any particular reason for sticking
with Allwinner's U-Boot over using mainline U-Boot?

> > +static struct ccu_nk pll_periph0_clk = {
> > +	.enable		= BIT(31),
> > +	.lock		= BIT(28),
> > +
> > +	.k		= SUNXI_CLK_FACTOR(4, 2),
> > +	.n		= SUNXI_CLK_FACTOR(8, 5),
> > +	.fixed_post_div	= 2,
> > +
> > +	.common		= {
> > +		.reg		= 0x028,
> > +		.features	= (CCU_FEATURE_GATE |
> > +				   CCU_FEATURE_LOCK |
> > +				   CCU_FEATURE_FIXED_POSTDIV),
> > +		.hw.init	= SUNXI_HW_INIT("pll-periph0",
> > +						"osc24M",
> > +						&ccu_nk_ops,
> > +						0),
> > +	},
> > +};
> 
> As told previously, the H3 documentation says:
> 
>  Note: The PLL Output should be fixed to 600MHz, it is not recommended to
>  vary this value arbitrarily.
> 
> So, is it useful to offer the possibility to change the rate of this PLL
> (and same for pll-periph1)?
> (I force the rate in the DT with assigned-clock-rates to avoid any problem)

assigned-clock-rates will not change anything unfortunately. It sets a
default rate at boot time, but it doesn't prevent the rate from being
changed.

Fortunately, that rate will never be modified, since none of the child
clock have CLK_SET_RATE_PARENT.

If that was to change, and when that time comes, we can always use the
clk boundaries to deal with it nicely.

> > +
> > +static SUNXI_CCU_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
> > +			      "pll-periph0", 1, 2, 0);
> > +
> 	[snip]
> > +static const char * const nand_parents[] = { "osc24M", "pll-periph0",
> > +					     "pll-periph1" };
> > +static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", nand_parents, 0x080,
> > +				  0, 4,		/* M */
> > +				  16, 2,	/* P */
> > +				  24, 2,	/* mux */
> > +				  BIT(31),	/* gate */
> > +				  0);
> 
> The mux width is 2, meaning there may be 4 parents. Then, there may be
> an access out of the parent array (and same for mmcx and spix).

The mux relies on the number of parents registered in the clock
framework, which is 3 in this case, so that won't happen.

Or am I missing what you're saying?

> > +
> > +static const char * const mmc0_parents[] = { "osc24M", "pll-periph0",
> > +					     "pll-periph1" };
> 
> The parent tables of nand, mmcx and spix are the same. One table should
> be enough.

Ack.

> > +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc0_parents, 0x088,
> > +				  0, 4,		/* M */
> > +				  16, 2,	/* P */
> > +				  24, 2,	/* mux */
> > +				  BIT(31),	/* gate */
> > +				  0);
> > +
> > +static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
> > +		       0x088, 20, 3, 0);
> > +static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
> > +		       0x088, 8, 3, 0);
> 	[snip]
> > +static const char * const i2s0_parents[] = { "pll-audio-8x", "pll-audio-4x",
> > +					     "pll-audio-2x" , "pll-audio" };
> > +static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s0_parents,
> > +			       0x0b0, 16, 2, BIT(31), 0);
> > +
> > +static const char * const i2s1_parents[] = { "pll-audio-8x", "pll-audio-4x",
> > +					     "pll-audio-2x" , "pll-audio" };
> > +static SUNXI_CCU_MUX_WITH_GATE(i2s1_clk, "i2s1", i2s1_parents,
> > +			       0x0b4, 16, 2, BIT(31), 0);
> > +
> > +static const char * const i2s2_parents[] = { "pll-audio-8x", "pll-audio-4x",
> > +					     "pll-audio-2x" , "pll-audio" };
> > +static SUNXI_CCU_MUX_WITH_GATE(i2s2_clk, "i2s2", i2s2_parents,
> > +			       0x0b8, 16, 2, BIT(31), 0);
> 	[snip]
> 
> Same parent tables.
> This occurs for other clocks.

Ack.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160518/dec7f73c/attachment-0001.sig>
