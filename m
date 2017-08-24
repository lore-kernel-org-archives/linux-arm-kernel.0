From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 24 Aug 2017 14:46:45 +0200
Subject: [PATCH v2 1/6] clk: renesas: rcar-gen3: Add Z clock divider
 support
In-Reply-To: <1503320487-13591-2-git-send-email-horms+renesas@verge.net.au>
References: <1503320487-13591-1-git-send-email-horms+renesas@verge.net.au>
 <1503320487-13591-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX7HHEE=X6p_1qHicDmA0C6NNkiQfKqx=G8f7pAiZH8hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Aug 21, 2017 at 3:01 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds Z clock divider support for R-Car Gen3 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [simon: divide parent by 2; use bitops macros]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for this patch!

> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
> @@ -29,6 +30,139 @@
>  #define CPG_PLL2CR             0x002c
>  #define CPG_PLL4CR             0x01f4
>
> +/* Z Clock

/*
 * Z Clock

> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is adjustable.  clk->rate = (parent->rate * mult / 32 ) / 2
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +#define CPG_FRQCRB                     0x00000004
> +#define CPG_FRQCRB_KICK                        BIT(31)
> +#define CPG_FRQCRC                     0x000000e0
> +#define CPG_FRQCRC_ZFC_MASK            GENMASK(12, 8)
> +
> +struct cpg_z_clk {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       void __iomem *kick_reg;
> +};
> +
> +#define to_z_clk(_hw)  container_of(_hw, struct cpg_z_clk, hw)
> +
> +static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
> +                                          unsigned long parent_rate)
> +{
> +       struct cpg_z_clk *zclk = to_z_clk(hw);
> +       unsigned long rate;
> +       unsigned int mult;
> +
> +       mult = 32 - FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
> +       /* There is a PLL post-divider of 1/2,

/*
 * There is a PLL post-divider of 1/2,

> +        * thus the doubling of the divisor below.
> +        */
> +       rate = div_u64((u64)parent_rate * mult + 16, 32 * 2);

DIV_ROUND_CLOSEST_ULL()

> +       /* Round to closest value at 100MHz unit */
> +       rate = 100000000 * DIV_ROUND_CLOSEST(rate, 100000000);

Why?

With this rounding, we can no longer distinguish between e.g.
1218750000 and 1265625000 Hz.

> +
> +       return rate;
> +}
> +
> +static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long *parent_rate)
> +{
> +       unsigned long prate = *parent_rate;
> +       unsigned int mult;
> +
> +       if (!prate)
> +               prate = 1;

Can this really happen?

> +
> +       mult = div_u64((u64)rate * 32 + prate/2, prate);

mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL, prate);

> +       mult = clamp(mult, 1U, 32U);
> +
> +       return *parent_rate / 32 * mult;

To avoid losing precision, you should do the multiplication first, using
64-bit math.

> +}
> +
> +static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long parent_rate)
> +{
> +       struct cpg_z_clk *zclk = to_z_clk(hw);
> +       unsigned int mult;
> +       unsigned int i;
> +       u32 val, kick;
> +
> +       mult = div_u64((u64)rate * 32 + parent_rate/2, parent_rate);

DIV_ROUND_CLOSEST_ULL()

> +       /*
> +        * Note: There is no HW information about the worst case latency.
> +        *
> +        * Using experimental measurements, it seems that no more than
> +        * ~10 iterations are needed, independently of the CPU rate.
> +        * Since this value might be dependent of external xtal rate, pll1
> +        * rate or even the other emulation clocks rate, use 1000 as a

another emulated clock rate?
(Yeah, copied from Gen2 ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
