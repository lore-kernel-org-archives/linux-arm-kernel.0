From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 11:51:54 +0200
Subject: [PATCH 4/6] clk: sunxi-ng: Add A33 CCU support
In-Reply-To: <CAGb2v66z4KMbfOr2kcNXSSXzVqXQ1uZ9p_-uNyvb_7_ACdNCqQ@mail.gmail.com>
References: <20160901141617.9777-1-maxime.ripard@free-electrons.com>
 <20160901141617.9777-5-maxime.ripard@free-electrons.com>
 <CAGb2v66z4KMbfOr2kcNXSSXzVqXQ1uZ9p_-uNyvb_7_ACdNCqQ@mail.gmail.com>
Message-ID: <20160905095153.GC6322@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Sep 05, 2016 at 02:34:21PM +0800, Chen-Yu Tsai wrote:
> > +static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
> > +                                    "osc24M", 0x000,
> > +                                    8, 5,              /* N */
> > +                                    4, 2,              /* K */
> > +                                    0, 2,              /* M */
> > +                                    16, 2,             /* P */
> 
> Manual says there's no divider for P = 0x3.
> You'll need a table here.

Hmmm, Indeed. Or rather, a max value. We discussed that in the past, I
guess it's time to introduce it.

> > +                                    BIT(31),           /* gate */
> > +                                    BIT(28),           /* lock */
> > +                                    0);
> > +
> > +/*
> > + * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
> > + * the base (2x, 4x and 8x), and one variable divider (the one true
> > + * pll audio).
> > + *
> > + * We don't have any need for the variable divider for now, so we just
> > + * hardcode it to match with the clock names
> > + */
> > +#define SUN8I_A33_PLL_AUDIO_REG        0x008
> > +
> > +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> > +                                  "osc24M", 0x008,
> > +                                  8, 7,                /* N */
> > +                                  0, 5,                /* M */
> > +                                  BIT(31),             /* gate */
> > +                                  BIT(28),             /* lock */
> > +                                  CLK_SET_RATE_UNGATE);
> 
> Are you sure about this? I suspect CLK_SET_RATE_GATE (clk must be
> gated before set rate) is what you want, given the non-DVFS
> nature of the PLL. Same for the other PLLs.

Yes, I'm sure about it. The lock, on the A33 at least, this has to be
confirmed on other SoCs, won't work if the clock is gated.

So, every time we call clk_set_rate, we will hit the WARN_ON because
of the lock timeout unless the clock runs.

> > +static SUNXI_CCU_GATE(bus_mipi_dsi_clk,        "bus-mipi-dsi", "ahb1",
> > +                     0x060, BIT(1), 0);
> 
> Nit: we know which bus these peripherals are on.
> Can we be more explicit with the names?

I wanted to be consistent with the datasheet, and would really prefer
to stick to it.

> > +static SUNXI_CCU_GATE(bus_ce_clk,      "bus-ce",       "ahb1",
> > +                     0x060, BIT(5), 0);
> 
> Nit: manual says Security System.
> 
> (Maybe I should change the name on sun6i to say Crypto Engine
>  if that's what we're going with?)

But I can't really use reject that argument there then :)

The rationale was that it's called CE in the H3 which was already
merged, but I'll change it.

> [...]
> 
> > +static SUNXI_CCU_GATE(usb_hsic_12M_clk,        "usb-hsic-12M", "osc24M",
> > +                     0x0cc, BIT(11), 0);
> 
> A TODO note saying we should have a fixed-factor-gate for this
> would be nice.

Hmmm? I'm not sure what you're saying.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/d9a7c81e/attachment.sig>
