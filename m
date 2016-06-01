From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 01 Jun 2016 17:46:22 +0200
Subject: [RFC PATCH 2/4] clk: rockchip: rk3399: add ddrc clock support
In-Reply-To: <CAD=FV=UQoWe7DcPe3sZrocXLmX4JNpBBF1rr+-+T_q3FttihEQ@mail.gmail.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
 <1464773739-18152-3-git-send-email-hl@rock-chips.com>
 <CAD=FV=UQoWe7DcPe3sZrocXLmX4JNpBBF1rr+-+T_q3FttihEQ@mail.gmail.com>
Message-ID: <7336973.nHpy8GhqcO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 1. Juni 2016, 08:24:48 schrieb Doug Anderson:
> Lin Huang,
> 
> On Wed, Jun 1, 2016 at 2:35 AM, Lin Huang <hl@rock-chips.com> wrote:
> > add ddrc clock setting, so we can do ddr frequency
> > scaling on rk3399 platform in future.
> > 
> > Signed-off-by: Lin Huang <hl@rock-chips.com>
> > ---
> > 
> >  drivers/clk/rockchip/clk-rk3399.c      | 16 ++++++++++++++++
> >  include/dt-bindings/clock/rk3399-cru.h |  1 +
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/clk/rockchip/clk-rk3399.c
> > b/drivers/clk/rockchip/clk-rk3399.c index f1d8e44..749ea59 100644
> > --- a/drivers/clk/rockchip/clk-rk3399.c
> > +++ b/drivers/clk/rockchip/clk-rk3399.c
> > @@ -118,6 +118,10 @@ PNAME(mux_armclkb_p)                               =
> > { "clk_core_b_lpll_src",> 
> >                                                     "clk_core_b_bpll_src",
> >                                                     "clk_core_b_dpll_src",
> >                                                     "clk_core_b_gpll_src"
> >                                                     };
> > 
> > +PNAME(mux_ddrclk_p)                            = { "clk_ddrc_lpll_src",
> > +                                                   "clk_ddrc_bpll_src",
> > +                                                   "clk_ddrc_dpll_src",
> > +                                                   "clk_ddrc_gpll_src" };
> > 
> >  PNAME(mux_aclk_cci_p)                          = { "cpll_aclk_cci_src",
> >  
> >                                                     "gpll_aclk_cci_src",
> >                                                     "npll_aclk_cci_src",
> > 
> > @@ -1377,6 +1381,18 @@ static struct rockchip_clk_branch
> > rk3399_clk_branches[] __initdata = {> 
> >         COMPOSITE_NOMUX(0, "clk_test", "clk_test_pre", CLK_IGNORE_UNUSED,
> >         
> >                         RK3368_CLKSEL_CON(58), 0, 5, DFLAGS,
> >                         RK3368_CLKGATE_CON(13), 11, GFLAGS),
> > 
> > +
> > +       /* ddrc */
> > +       GATE(0, "clk_ddrc_lpll_src", "lpll", CLK_IGNORE_UNUSED,
> > +            RK3399_CLKGATE_CON(3), 0, GFLAGS),
> > +       GATE(0, "clk_ddrc_bpll_src", "bpll", CLK_IGNORE_UNUSED,
> > +            RK3399_CLKGATE_CON(3), 1, GFLAGS),
> > +       GATE(0, "clk_ddrc_dpll_src", "dpll", CLK_IGNORE_UNUSED,
> > +            RK3399_CLKGATE_CON(3), 2, GFLAGS),
> > +       GATE(0, "clk_ddrc_gpll_src", "gpll", CLK_IGNORE_UNUSED,
> > +            RK3399_CLKGATE_CON(3), 3, GFLAGS),
> > +       COMPOSITE_DDRC(SCLK_DDRCLK, "clk_ddrc", mux_ddrclk_p,
> > CLK_IGNORE_UNUSED, +                      RK3399_CLKSEL_CON(6), 4, 2,
> > MFLAGS, 0, 3, DFLAGS),
> It seems slightly unfortunate that we need CLK_IGNORE_UNUSED on these.
> Only one of these will ever be used at once and it would be awfully
> nice if the others could get gated, right?
> 
> ...presumably this is needed because we might not have an actual
> driver for DDR Freq and we definitely want to make sure that clk_ddrc
> is enabled in that case.  I guess what we really want is something
> like CLK_ENABLE_HAND_OFF eventually, but until then I think you might
> get slightly better behavior by getting rid of all of these
> CLK_IGNORE_UNUSED and setting "clk_ddrc" as a critical clock, either
> using the table in this file or the new flag.

My current feeling is that staying with the homegrown solution for critical 
clocks might be preferable until the clk-handoff mechanism lands as well, as 
our critical clocks fall into both categories and I'd like to not touch 
everything twice.

The clock above should be controlled by the dcf, so falls into the handoff 
category (critical until a driver picks up the clock).

Also mixing both new and old approach might get confusing.

But I'm definitly open to counter-arguments :-)


> >  };
> >  
> >  static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata =
> >  {
> > 
> > diff --git a/include/dt-bindings/clock/rk3399-cru.h
> > b/include/dt-bindings/clock/rk3399-cru.h index 50a44cf..8a0f0442 100644
> > --- a/include/dt-bindings/clock/rk3399-cru.h
> > +++ b/include/dt-bindings/clock/rk3399-cru.h
> > @@ -131,6 +131,7 @@
> > 
> >  #define SCLK_DPHY_RX0_CFG              165
> >  #define SCLK_RMII_SRC                  166
> >  #define SCLK_PCIEPHY_REF100M           167
> > 
> > +#define SCLK_DDRCLK                    168
> 
> Almost certainly you'll want to create a separate patch for the
> dt-bindings change since it will need to land in a different tree so
> it can be pulled into both Heiko's clock topic branch and dts64 topic
> branch.

correct.
