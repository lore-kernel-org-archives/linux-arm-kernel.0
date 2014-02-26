From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 17:59:21 +0900
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <CAMuHMdUy6uj5vJ125Edp8g5NNxcWbG5wmD-j_gp=GgzXYAUAEw@mail.gmail.com>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUy6uj5vJ125Edp8g5NNxcWbG5wmD-j_gp=GgzXYAUAEw@mail.gmail.com>
Message-ID: <20140226085921.GD7720@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 09:05:05AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 26, 2014 at 8:33 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> > @@ -0,0 +1,26 @@
> > +* Renesas R8A7779 Clock Pulse Generator (CPG)
> > +
> > +The CPG generates core clocks for the R8A7779. It includes one PLL and
> > +and several fixed ratio dividers
> 
> Double "and"
> 
> > +++ b/drivers/clk/shmobile/clk-r8a7779.c
> 
> > +/*
> > + *             MD1 = 1                 MD1 = 0
> > + *             (PLLA = 1500)           (PLLA = 1600)
> > + *             (MHz)                   (MHz)
> > + *------------------------------------------------+--------------------
> > + * clkz                1000   (2/3)            800   (1/2)
> > + * clkzs        250   (1/6)            200   (1/8)
> > + * clki                 750   (1/2)            800   (1/2)
> > + * clks                 250   (1/6)            200   (1/8)
> > + * clks1        125   (1/12)           100   (1/16)
> > + * clks3        187.5 (1/8)            200   (1/8)
> > + * clks4         93.7 (1/16)           100   (1/16)
> > + * clkp                  62.5 (1/24)            50   (1/32)
> > + * clkg                  62.5 (1/24)            66.6 (1/24)
> > + * clkb, CLKOUT
> > + * (MD2 = 0)     62.5 (1/24)            66.6 (1/24)
> > + * (MD2 = 1)     41.6 (1/36)            50   (1/32)
> > + */
> > +
> > +#define CPG_CLK_CONFIG_INDEX(md)       (((md) & (BIT(1)|BIT(2))) >> 1)
> > +
> > +struct cpg_clk_config {
> > +       unsigned int z_mult;
> > +       unsigned int z_div;
> > +       unsigned int zs_and_s_div;
> > +       unsigned int s1_div;
> > +       unsigned int p_div;
> > +       unsigned int out_div;
> > +};
> > +
> > +static const struct cpg_clk_config cpg_clk_configs[4] __initconst = {
> > +       { 1, 2, 8, 16, 32, 24 },
> > +       { 1, 2, 8, 16, 32, 24 },
> > +       { 2, 3, 6, 12, 24, 36 },
> > +       { 2, 3, 6, 12, 24, 32 },
> > +};
> 
> Shouldn't this be
> 
> +static const struct cpg_clk_config cpg_clk_configs[4] __initconst = {
> +       { 1, 2, 8, 16, 32, 24 },
> +       { 2, 3, 6, 12, 24, 24 },
> +       { 1, 2, 8, 16, 32, 32 },
> +       { 2, 3, 6, 12, 24, 36 },
> +};
> 
> ?
> 
> I think you got confused by writing the bitmask as "BIT(1)|BIT(2)" instead
> of "BIT(2)|BIT(1)".

Probably, thanks for noticing.

> > +/*
> > + *   MD                PLLA Ratio
> > + * 12 11
> > + *------------------------
> > + * 0  0                x42
> > + * 0  1                x48
> > + * 1  0                x56
> > + * 1  1                x64
> > + */
> > +#define CPG_PLL_CONFIG_INDEX(md)       ((((md) & BIT(14)) >> 12) | \
> > +                                        (((md) & BIT(13)) >> 12) | \
> > +                                        (((md) & BIT(19)) >> 19))
> > +struct cpg_pll_config {
> > +       unsigned int extal_div;
> > +       unsigned int pll1_mult;
> > +       unsigned int pll3_mult;
> > +};
> 
> CPG_PLL_CONFIG_INDEX() and struct cpg_pll_config are unused, and
> disrupt the reading experience for the casual reviewer, as they split the
> section about MD12 and M11 in two.
> 
> > +
> > +#define CPG_PLLA_MULT_INDEX(md)        (((md) & (BIT(12)|BIT(11))) >> 11)

Thanks, I will remove them.
