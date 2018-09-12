From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 13 Sep 2018 00:16:32 +0800
Subject: [linux-sunxi] Re: [PATCH 08/27] clk: sunxi-ng: Add support for H6
 DE3 clocks
In-Reply-To: <1702684.jtWEXlagAO@jernej-laptop>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <1677668.BePkXd9qNa@jernej-laptop>
 <CAGb2v66kojjjM4f_tO9NwzkCzD3LMM2eiq+PJ6Bk=1Rra=UnYg@mail.gmail.com>
 <1702684.jtWEXlagAO@jernej-laptop>
Message-ID: <CAGb2v652fPojGYE1nkAeEzFBcWjebi1zSnPGwm7zjPbE7ojD0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 10:55 PM Jernej ?krabec <jernej.skrabec@siol.net> wrote:
>
> Dne sreda, 12. september 2018 ob 14:20:08 CEST je Chen-Yu Tsai napisal(a):
> > On Wed, Sep 5, 2018 at 1:46 AM Jernej ?krabec <jernej.skrabec@siol.net>
> wrote:
> > > Dne torek, 04. september 2018 ob 11:04:21 CEST je Chen-Yu Tsai napisal(a):
> > > > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > wrote:
> > > > > Support for mixer0, mixer1, writeback and rotation units is added.
> > > > >
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > >
> > > > >  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 65
> > > > >  ++++++++++++++++++++++++++++
> > > > >  drivers/clk/sunxi-ng/ccu-sun8i-de2.h |  1 +
> > > > >  2 files changed, 66 insertions(+)
> > > > >
> > > > > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > > > b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c index
> > > > > bae5ee67a797..4535c1c27d27
> > > > > 100644
> > > > > --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > > > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > > > @@ -31,6 +31,8 @@ static SUNXI_CCU_GATE(bus_mixer1_clk, "bus-mixer1",
> > > > > "bus-de",>
> > > > >
> > > > >                       0x04, BIT(1), 0);
> > > > >
> > > > >  static SUNXI_CCU_GATE(bus_wb_clk,      "bus-wb",       "bus-de",
> > > > >
> > > > >                       0x04, BIT(2), 0);
> > > > >
> > > > > +static SUNXI_CCU_GATE(bus_rot_clk,     "bus-rot",      "bus-de",
> > > > > +                     0x04, BIT(3), 0);
> > > > >
> > > > >  static SUNXI_CCU_GATE(mixer0_clk,      "mixer0",       "mixer0-div",
> > > > >
> > > > >                       0x00, BIT(0), CLK_SET_RATE_PARENT);
> > > > >
> > > > > @@ -38,6 +40,8 @@ static SUNXI_CCU_GATE(mixer1_clk,     "mixer1",
> > > > > "mixer1-div",>
> > > > >
> > > > >                       0x00, BIT(1), CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_GATE(wb_clk,          "wb",           "wb-div",
> > > > >
> > > > >                       0x00, BIT(2), CLK_SET_RATE_PARENT);
> > > > >
> > > > > +static SUNXI_CCU_GATE(rot_clk,         "rot",          "rot-div",
> > > > > +                     0x00, BIT(3), CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > @@ -45,6 +49,8 @@ static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div",
> > > > > "de",
> > > > > 0x0c, 4, 4,>
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > +static SUNXI_CCU_M(rot_div_clk, "rot-div", "de", 0x0c, 0x0c, 4,
> > > > > +                  CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_M(mixer0_div_a83_clk, "mixer0-div", "pll-de", 0x0c,
> > > > >  0,
> > > > >  4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > @@ -53,6 +59,24 @@ static SUNXI_CCU_M(mixer1_div_a83_clk,
> > > > > "mixer1-div",
> > > > > "pll-de", 0x0c, 4, 4,>
> > > > >
> > > > >  static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > +static struct ccu_common *sun50i_h6_de3_clks[] = {
> > > > > +       &mixer0_clk.common,
> > > > > +       &mixer1_clk.common,
> > > > > +       &wb_clk.common,
> > > > > +
> > > > > +       &bus_mixer0_clk.common,
> > > > > +       &bus_mixer1_clk.common,
> > > > > +       &bus_wb_clk.common,
> > > > > +
> > > > > +       &mixer0_div_clk.common,
> > > > > +       &mixer1_div_clk.common,
> > > > > +       &wb_div_clk.common,
> > > > > +
> > > > > +       &bus_rot_clk.common,
> > > > > +       &rot_clk.common,
> > > > > +       &rot_div_clk.common,
> > > > > +};
> > > > > +
> > > > >
> > > > >  static struct ccu_common *sun8i_a83t_de2_clks[] = {
> > > > >
> > > > >         &mixer0_clk.common,
> > > > >         &mixer1_clk.common,
> > > > >
> > > > > @@ -92,6 +116,26 @@ static struct ccu_common *sun8i_v3s_de2_clks[] = {
> > > > >
> > > > >         &wb_div_clk.common,
> > > > >
> > > > >  };
> > > > >
> > > > > +static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks = {
> > > > > +       .hws    = {
> > > > > +               [CLK_MIXER0]            = &mixer0_clk.common.hw,
> > > > > +               [CLK_MIXER1]            = &mixer1_clk.common.hw,
> > > > > +               [CLK_WB]                = &wb_clk.common.hw,
> > > > > +               [CLK_ROT]               = &rot_clk.common.hw,
> > > > > +
> > > > > +               [CLK_BUS_MIXER0]        = &bus_mixer0_clk.common.hw,
> > > > > +               [CLK_BUS_MIXER1]        = &bus_mixer1_clk.common.hw,
> > > > > +               [CLK_BUS_WB]            = &bus_wb_clk.common.hw,
> > > > > +               [CLK_BUS_ROT]           = &bus_rot_clk.common.hw,
> > > > > +
> > > > > +               [CLK_MIXER0_DIV]        = &mixer0_div_clk.common.hw,
> > > > > +               [CLK_MIXER1_DIV]        = &mixer1_div_clk.common.hw,
> > > > > +               [CLK_WB_DIV]            = &wb_div_clk.common.hw,
> > > > > +               [CLK_ROT_DIV]           = &rot_div_clk.common.hw,
> > > > > +       },
> > > > > +       .num    = 12,
> > > >
> > > > It's best not to openly code these. It is error prone, like having
> > > > an index beyond .num, which then never gets registered.
> > > >
> > > > Instead, please update CLK_NUMBERS and use that instead.
> > > > sunxi_ccu_probe()
> > > > can handle holes in .hws.
> > >
> > > I'm not sure this will work. All newly introduced indices are at the end,
> > > so other arrays will still have same length (hole at the end). You will
> > > just claim that arrays are larger than they really are, which means bad
> > > things.
> > >
> > > But I take any other suggestion. I really can't think of better solution.
> >
> > Then maybe have macros for both cases instead?
> > CLK_NUMBER_WITH_ROT / CLK_NUMBER_WITHOUT_ROT?
>
> That sounds reasonable. Do you want separate patch which renames original
> macro CLK_NUMBER to CLK_NUMBER_WITHOUT_ROT?

I don't think that's necessary. Just mention the name change in the changelog,
and justifying it by the addition of the ROT clocks.

Thanks
