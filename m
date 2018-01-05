From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Jan 2018 15:04:05 +0100
Subject: [PATCH v4 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <CAMuHMdXcLhFD825Xi2Uk=6_OAgLd7BEp14rWpgb7pv6rOM2H2Q@mail.gmail.com>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
 <20180103121840.29316-3-horms+renesas@verge.net.au>
 <CAMuHMdXcLhFD825Xi2Uk=6_OAgLd7BEp14rWpgb7pv6rOM2H2Q@mail.gmail.com>
Message-ID: <20180105140401.7iitpzdrlyqtasvz@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Jan 3, 2018 at 1:18 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > This patch adds Z2 clock divider support for R-Car Gen3 SoC.
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v4 [Simon Horman]
> > * Rebase
> > * Use __ffs as FIELD_{GET,PREP} don't not work with non-constant masks
> > * Use correct mask in cpg_z_clk_recalc_rate()
> 
> Thanks for the update!
> 
> > --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> > +++ b/drivers/clk/renesas/rcar-gen3-cpg.c
> > @@ -63,7 +63,7 @@ static void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
> >  }
> >
> >  /*
> > - * Z Clock
> > + * Z Clock & Z2 Clock
> >   *
> >   * Traits of this clock:
> >   * prepare - clk_prepare only ensures that parents are prepared
> > @@ -75,11 +75,13 @@ static void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
> >  #define CPG_FRQCRB_KICK                        BIT(31)
> >  #define CPG_FRQCRC                     0x000000e0
> >  #define CPG_FRQCRC_ZFC_MASK            GENMASK(12, 8)
> > +#define CPG_FRQCRC_Z2FC_MASK           GENMASK(4, 0)
> >
> >  struct cpg_z_clk {
> >         struct clk_hw hw;
> >         void __iomem *reg;
> >         void __iomem *kick_reg;
> > +       unsigned long mask;
> >  };
> >
> >  #define to_z_clk(_hw)  container_of(_hw, struct cpg_z_clk, hw)
> > @@ -89,8 +91,10 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
> >  {
> >         struct cpg_z_clk *zclk = to_z_clk(hw);
> >         unsigned int mult;
> > +       u32 val;
> >
> > -       mult = 32 - FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
> > +       val = clk_readl(zclk->reg) & zclk->mask;
> > +       mult = 32 - (val >> (__ffs(zclk->mask) - 1));
> 
> Shouldn't that be
> 
>         mult = 32 - (val >> __ffs(zclk->mask));
> 
> (same below)?
> 
> __ffs() returns 0..31, so you will shift right by 7 (Z) or -1 (Z2)?

Thanks, I'll look at fixing that.

> As the CPG/MSSR driver now has suspend/resume support, do we need
> a notifier to restore the Z or Z2 registers? Or is that handled automatically
> by cpufreq during system resume, for both the primary and the secondary
> CPU cores?

I am a bit unsure.

When using the A57 cores, which is the default case, the Z clk is queried
by CPUFreq on resume. It appears that on my system its already set to the
correct value but I assume if it was not then it would be reset. However,
this does not cover Z2 clk. So perhaps to be safe we need to register
notifiers and make sure they they play nicely with CPUFreq?
