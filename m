From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Oct 2017 10:02:48 +0200
Subject: [PATCH v3 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <1507209837-16938-3-git-send-email-horms+renesas@verge.net.au>
References: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
 <1507209837-16938-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWpbZ5r5s2+29rLBcPABUaN0BBXEZreryoCSriDcqqdkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 5, 2017 at 3:23 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds Z2 clock divider support for R-Car Gen3 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2 [Simon Horman]
> * Consolidate Z and Z2 clock ops
> * Allow setting of Z2 clock

Thanks for the update!

> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c

> @@ -88,8 +90,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
>                 return -EBUSY;
>
> -       val = clk_readl(zclk->reg) & ~CPG_FRQCRC_ZFC_MASK;
> -       val |= FIELD_PREP(CPG_FRQCRC_ZFC_MASK, 32 - mult);
> +       val = clk_readl(zclk->reg) & ~zclk->mask;
> +       val |= ((32 - mult) << __bf_shf(zclk->mask)) & zclk->mask;

Any special reason you're now open coding FIELD_PREP()?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
