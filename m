From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 24 Aug 2017 15:16:57 +0200
Subject: [PATCH v2 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <1503320487-13591-3-git-send-email-horms+renesas@verge.net.au>
References: <1503320487-13591-1-git-send-email-horms+renesas@verge.net.au>
 <1503320487-13591-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXyUoRvoOaPRN8SyKtiWVOB6SLDMbtBMrC3wOSYc447tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Aug 21, 2017 at 3:01 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds Z2 clock divider support for R-Car Gen3 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [simon: add recalc_rate() helper; use bitops macros]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for this patch!

> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c

> @@ -69,6 +69,26 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
>         return rate;
>  }
>
> +static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
> +                                          unsigned long parent_rate)
> +{
> +       struct cpg_z_clk *zclk = to_z_clk(hw);
> +       unsigned int val;
> +
> +       val = FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
> +       return __cpg_z_clk_recalc_rate(parent_rate, val);
> +}
> +
> +static unsigned long cpg_z2_clk_recalc_rate(struct clk_hw *hw,
> +                                          unsigned long parent_rate)
> +{
> +       struct cpg_z_clk *zclk = to_z_clk(hw);
> +       unsigned int val;
> +
> +       val = FIELD_GET(CPG_FRQCRC_Z2FC_MASK, clk_readl(zclk->reg));
> +       return __cpg_z_clk_recalc_rate(parent_rate, val);
> +}
> +
>  static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>                                  unsigned long *parent_rate)
>  {
> @@ -129,12 +149,25 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>         return -ETIMEDOUT;
>  }
>
> +static int cpg_z2_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long parent_rate)
> +{
> +       pr_info("Do not support Z2 clock changing\n");

Oops?
This can be handled like the Z clock, can't it?
If not, please ignore some of my comments below.

> +       return 0;
> +}
> +
>  static const struct clk_ops cpg_z_clk_ops = {
>         .recalc_rate = cpg_z_clk_recalc_rate,
>         .round_rate = cpg_z_clk_round_rate,
>         .set_rate = cpg_z_clk_set_rate,
>  };
>
> +static const struct clk_ops cpg_z2_clk_ops = {
> +       .recalc_rate = cpg_z2_clk_recalc_rate,
> +       .round_rate = cpg_z_clk_round_rate,
> +       .set_rate = cpg_z2_clk_set_rate,
> +};

Apart from the field mask, above ops are identical.
What about storing the field mask in struct cpg_z_clk instead, so the ops
can be unified?
They can even be reused for the ZR (Cortex-R7) clock, which uses yet
another field mask in the same register.

The field mask can be obtained from the r8a7795_core_clks[] table,
cfr. the offset for SD clocks used by DEF_GEN3_SD().
With a new DEF_GEN3_Z() macro, we can use a single CLK_TYPE_GEN3_Z
type for all 3 clocks.

> @@ -164,6 +197,35 @@ static struct clk * __init cpg_z_clk_register(const char *name,
>         return clk;
>  }
>
> +static struct clk * __init cpg_z2_clk_register(const char *name,
> +                                             const char *parent_name,
> +                                             void __iomem *reg)
> +{

> +       init.ops = &cpg_z2_clk_ops;

This is the only difference in this function, compared to cpg_z_clk_register()
(assumed you pass the field mask to this function).

> +       zclk->reg = reg + CPG_FRQCRC;
> +       zclk->kick_reg = reg + CPG_FRQCRB;

Given the same registers are used for Z and Z2 (and ZR), what about just
storing the base address (reg) here?
And the field mask, of course.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
