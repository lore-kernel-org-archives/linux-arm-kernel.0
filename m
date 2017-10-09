From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Oct 2017 10:02:34 +0200
Subject: [PATCH v3 1/6] clk: renesas: rcar-gen3: Add Z clock divider
 support
In-Reply-To: <1507209837-16938-2-git-send-email-horms+renesas@verge.net.au>
References: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
 <1507209837-16938-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUKEP1BvzLBBJmARUz2PcsmwHsruumXqt+csY5gkUDmcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 5, 2017 at 3:23 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds Z clock divider support for R-Car Gen3 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>
> v2 [Simon Horman]
> * Use DIV_ROUND_CLOSEST_ULL instead of open-coding the same behaviour
>   using div_u64()
> * Do not round rate to 100MHz in cpg_z_clk_recalc_rate
> * Remove calculation for PLL post-divider, this is bogus.
>   Instead do not round to closest in cpg_z_clk_round_rate()
> * Drop check for !prate in cpg_z_clk_round_rate

Thanks for the updates!

> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c

> +static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
> +                                          unsigned long parent_rate)
> +{
> +       struct cpg_z_clk *zclk = to_z_clk(hw);
> +       unsigned int mult;
> +
> +       mult = 32 - FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
> +       return DIV_ROUND_CLOSEST_ULL(parent_rate * mult, 32);

While parent_rate is unsigned long and thus 64-bit on arm64, this will work
fine on R-Car Gen3.  However, if someone ever tries to reuse this on a
32-bit platform, the multiplication may overflow.
Hence I recommend to make this a 64-bit multiplication explicitly, i.e.

    return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, 32);

> +}
> +
> +static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long *parent_rate)
> +{
> +       unsigned long prate = *parent_rate;
> +       unsigned int mult;
> +
> +       mult = div_u64((u64)rate * 32, prate);

You can avoid the cast by making the constant 64-bit:

    mult = div_u64(rate * 32ULL, prate);

> +       mult = clamp(mult, 1U, 32U);
> +
> +       return *parent_rate * mult / 32;

Again, *parent_rate is 64-bit on arm64, but not on 32-bit platforms.

> +       /*
> +        * Note: There is no HW information about the worst case latency.
> +        *
> +        * Using experimental measurements, it seems that no more than
> +        * ~10 iterations are needed, independently of the CPU rate.
> +        * Since this value might be dependent of external xtal rate, pll1
> +        * rate or even the other emulation clocks rate, use 1000 as a

another emulated clock rate?
(Yeah, copied from Gen2 ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
