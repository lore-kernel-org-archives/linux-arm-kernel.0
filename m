From: horms@verge.net.au (Simon Horman)
Date: Tue, 10 Oct 2017 09:22:25 +0200
Subject: [PATCH v3 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <CAMuHMdVg4sFkZvqfv0SZkefSy1UN=eBtwQrii7OtbYqyjfmC=Q@mail.gmail.com>
References: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
 <1507209837-16938-3-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWpbZ5r5s2+29rLBcPABUaN0BBXEZreryoCSriDcqqdkQ@mail.gmail.com>
 <CAMuHMdVg4sFkZvqfv0SZkefSy1UN=eBtwQrii7OtbYqyjfmC=Q@mail.gmail.com>
Message-ID: <20171010072224.GG2518@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 08:56:35AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Oct 9, 2017 at 10:02 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Oct 5, 2017 at 3:23 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> >> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >>
> >> This patch adds Z2 clock divider support for R-Car Gen3 SoC.
> >>
> >> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> ---
> >> v2 [Simon Horman]
> >> * Consolidate Z and Z2 clock ops
> >> * Allow setting of Z2 clock
> >
> > Thanks for the update!
> >
> >> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> >> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c
> >
> >> @@ -88,8 +90,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> >>         if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
> >>                 return -EBUSY;
> >>
> >> -       val = clk_readl(zclk->reg) & ~CPG_FRQCRC_ZFC_MASK;
> >> -       val |= FIELD_PREP(CPG_FRQCRC_ZFC_MASK, 32 - mult);
> >> +       val = clk_readl(zclk->reg) & ~zclk->mask;
> >> +       val |= ((32 - mult) << __bf_shf(zclk->mask)) & zclk->mask;
> >
> > Any special reason you're now open coding FIELD_PREP()?
> 
> Now I know: to circumvent the
> BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask), ...) in
> __BF_FIELD_CHECK(), called from FIELD_PREP().

Yes, that is correct.
A comment is probably in order.

> Given <linux/bitfield.h> is intended to work with constant masks
> only, I think it's best to not use it, and replace __bf_shf() by __ffs().

I see there has been some discussion of this elsewhere.
Perhaps its best to let that cool down before I repost.

> 
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Oops, looks like you forgot to replace CPG_FRQCRC_ZFC_MASK in
> cpg_z_clk_recalc_rate() by zclk->mask.
> Sorry for missing that.

Thanks, will fix.
