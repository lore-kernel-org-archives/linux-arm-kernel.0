From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 May 2015 14:02:04 +0200
Subject: [PATCH v2 2/5] clk: sunxi: support the cpus (cpu special) clock
 on the Allwinner A80
In-Reply-To: <CAGb2v67mZvcfwiYc9vABuFQ2SaiENWZzOGYz6zc0JLU-MK3fNA@mail.gmail.com>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
 <1430410206-4410-3-git-send-email-wens@csie.org>
 <20150504125146.GA3274@lukather>
 <CAGb2v64brwadGPdpdQ9ebOPwZQse2W6m8t8wV6JX=y4Hpw0puQ@mail.gmail.com>
 <20150505082544.GF3274@lukather>
 <CAGb2v67mZvcfwiYc9vABuFQ2SaiENWZzOGYz6zc0JLU-MK3fNA@mail.gmail.com>
Message-ID: <20150505120204.GK3274@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 06:01:16PM +0800, Chen-Yu Tsai wrote:
> On Tue, May 5, 2015 at 4:25 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, May 04, 2015 at 11:22:33PM +0800, Chen-Yu Tsai wrote:
> >> Hi,
> >>
> >> On Mon, May 4, 2015 at 8:51 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Hi,
> >> >
> >> > On Fri, May 01, 2015 at 12:10:03AM +0800, Chen-Yu Tsai wrote:
> >> >> The "cpus" clock is the clock for the embedded processor in the A80.
> >> >> It is also part of the PRCM clock tree.
> >> >>
> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
> >> >>  drivers/clk/sunxi/Makefile                        |   2 +-
> >> >>  drivers/clk/sunxi/clk-sun9i-cpus.c                | 243 ++++++++++++++++++++++
> >> >>  3 files changed, 245 insertions(+), 1 deletion(-)
> >> >>  create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> >> index 2015b2beb957..c52735b0b924 100644
> >> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> >> @@ -27,6 +27,7 @@ Required properties:
> >> >>       "allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
> >> >>       "allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
> >> >>       "allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
> >> >> +     "allwinner,sun9i-a80-cpus-clk" - for the CPUS on A80
> >> >>       "allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
> >> >>       "allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
> >> >>       "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
> >> >> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> >> >> index 058f273d6154..f0f33131b048 100644
> >> >> --- a/drivers/clk/sunxi/Makefile
> >> >> +++ b/drivers/clk/sunxi/Makefile
> >> >> @@ -13,4 +13,4 @@ obj-y += clk-usb.o
> >> >>
> >> >>  obj-$(CONFIG_MFD_SUN6I_PRCM) += \
> >> >>       clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
> >> >> -     clk-sun8i-apb0.o
> >> >> +     clk-sun8i-apb0.o clk-sun9i-cpus.o
> >> >
> >> > I'm really not sure about that option selection.
> >> >
> >> > If you only select the A31, you will get drivers that won't be
> >> > relevant at all here.
> >> >
> >> > How about something like
> >> >
> >> > ifeq ($(CONFIG_MFD_SUN6I_PRCM), y)
> >> > obj-$(CONFIG_MACH_SUN6I) = ....
> >> > obj-$(CONFIG_MACH_SUN8I) = ....
> >> > obj-$(CONFIG_MACH_SUN9I) = ....
> >> > endif
> >> >
> >> > ?
> >>
> >> I suppose that works, though sun9i shares apb0 (apbs) clock with
> >> sun8i.
> >
> > I'd expect that if you set the files to build multiple time,
> > everything would just work, so that we could have apbs built both in
> > the list for sun8i and sun9i.
> 
> It should, but would it be included twice? I suppose the linker
> is smart enough to spot this?

It looks like it is:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/Makefile

Maybe not the linker itself, but the build system seems to handle that
just fine.

> >> >> +     struct sun9i_a80_cpus_clk *cpus = to_sun9i_a80_cpus_clk(hw);
> >> >> +     unsigned long rate;
> >> >> +     u32 reg;
> >> >> +
> >> >> +     /* Fetch the register value */
> >> >> +     reg = readl(cpus->reg);
> >> >> +
> >> >> +     /* apply pre-divider first if parent is pll4 */
> >> >> +     if (SUN9I_CPUS_MUX_GET_PARENT(reg) == SUN9I_CPUS_MUX_PARENT_PLL4)
> >> >> +             parent_rate /= SUN9I_CPUS_PLL4_DIV_GET(reg) + 1;
> >> >> +
> >> >> +     /* clk divider */
> >> >> +     rate = parent_rate / (SUN9I_CPUS_DIV_GET(reg) + 1);
> >> >> +
> >> >> +     return rate;
> >> >> +}
> >> >> +
> >> >> +static long sun9i_a80_cpus_clk_round(unsigned long rate, u8 *divp, u8 *pre_divp,
> >> >> +                              u8 parent, unsigned long parent_rate)
> >> >> +{
> >> >> +     u8 div, pre_div = 1;
> >> >> +
> >> >> +     /*
> >> >> +      * clock can only divide, so we will never be able to achieve
> >> >> +      * frequencies higher than the parent frequency
> >> >> +      */
> >> >> +     if (parent_rate && rate > parent_rate)
> >> >> +             rate = parent_rate;
> >> >> +
> >> >> +     div = DIV_ROUND_UP(parent_rate, rate);
> >> >> +
> >> >> +     /* calculate pre-divider if parent is pll4 */
> >> >> +     if (parent == SUN9I_CPUS_MUX_PARENT_PLL4 && div > 4) {
> >> >> +             /* pre-divider is 1 ~ 32 */
> >> >> +             if (div < 32) {
> >> >> +                     pre_div = div;
> >> >> +                     div = 1;
> >> >> +             } else if (div < 64) {
> >> >> +                     pre_div = DIV_ROUND_UP(div, 2);
> >> >> +                     div = 2;
> >> >> +             } else if (div < 96) {
> >> >> +                     pre_div = DIV_ROUND_UP(div, 3);
> >> >> +                     div = 3;
> >> >> +             } else {
> >> >> +                     pre_div = DIV_ROUND_UP(div, 4);
> >> >> +                     div = 4;
> >> >> +             }
> >> >> +     }
> >> >> +
> >> >> +     /* we were asked to pass back divider values */
> >> >> +     if (divp) {
> >> >> +             *divp = div - 1;
> >> >> +             *pre_divp = pre_div - 1;
> >> >> +     }
> >> >> +
> >> >> +     return parent_rate / pre_div / div;
> >> >> +}
> >> >> +
> >> >> +static long sun9i_a80_cpus_clk_determine_rate(struct clk_hw *hw,
> >> >> +                                           unsigned long rate,
> >> >> +                                           unsigned long min_rate,
> >> >> +                                           unsigned long max_rate,
> >> >> +                                           unsigned long *best_parent_rate,
> >> >> +                                           struct clk_hw **best_parent_clk)
> >> >> +{
> >> >> +     struct clk *clk = hw->clk, *parent, *best_parent = NULL;
> >> >> +     int i, num_parents;
> >> >> +     unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
> >> >> +
> >> >> +     /* find the parent that can help provide the fastest rate <= rate */
> >> >> +     num_parents = __clk_get_num_parents(clk);
> >> >> +     for (i = 0; i < num_parents; i++) {
> >> >> +             parent = clk_get_parent_by_index(clk, i);
> >> >> +             if (!parent)
> >> >> +                     continue;
> >> >> +             if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
> >> >> +                     parent_rate = __clk_round_rate(parent, rate);
> >> >> +             else
> >> >> +                     parent_rate = __clk_get_rate(parent);
> >> >> +
> >> >> +             child_rate = sun9i_a80_cpus_clk_round(rate, NULL, NULL, i,
> >> >> +                                               parent_rate);
> >> >> +
> >> >> +             if (child_rate <= rate && child_rate > best_child_rate) {
> >> >> +                     best_parent = parent;
> >> >> +                     best = parent_rate;
> >> >> +                     best_child_rate = child_rate;
> >> >> +             }
> >> >> +     }
> >> >> +
> >> >> +     if (best_parent)
> >> >> +             *best_parent_clk = __clk_get_hw(best_parent);
> >> >> +     *best_parent_rate = best;
> >> >> +
> >> >> +     return best_child_rate;
> >> >> +}
> >> >> +
> >> >> +static int sun9i_a80_cpus_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> >> >> +                                unsigned long parent_rate)
> >> >> +{
> >> >> +     struct sun9i_a80_cpus_clk *cpus = to_sun9i_a80_cpus_clk(hw);
> >> >> +     unsigned long flags;
> >> >> +     u8 div, pre_div, parent;
> >> >> +     u32 reg;
> >> >> +
> >> >> +     spin_lock_irqsave(&sun9i_a80_cpus_lock, flags);
> >> >> +
> >> >> +     reg = readl(cpus->reg);
> >> >> +
> >> >> +     /* need to know which parent is used to apply pre-divider */
> >> >> +     parent = SUN9I_CPUS_MUX_GET_PARENT(reg);
> >> >> +     sun9i_a80_cpus_clk_round(rate, &div, &pre_div, parent, parent_rate);
> >> >> +
> >> >> +     reg = SUN9I_CPUS_DIV_SET(reg, div);
> >> >> +     reg = SUN9I_CPUS_PLL4_DIV_SET(reg, pre_div);
> >> >> +     writel(reg, cpus->reg);
> >> >> +
> >> >> +     spin_unlock_irqrestore(&sun9i_a80_cpus_lock, flags);
> >> >> +
> >> >> +     return 0;
> >> >> +}
> >> >> +
> >> >> +static const struct clk_ops sun9i_a80_cpus_clk_ops = {
> >> >> +     .determine_rate = sun9i_a80_cpus_clk_determine_rate,
> >> >> +     .recalc_rate    = sun9i_a80_cpus_clk_recalc_rate,
> >> >> +     .set_rate       = sun9i_a80_cpus_clk_set_rate,
> >> >> +};
> >> >
> >> > It all looks like you could use the factors clock for this.
> >> >
> >> > The only thing that you seem to be using a custom clock for is the pre
> >> > divider on one of the parent, but that's something that could be
> >> > reused for other clocks (like the A10 pll6, or the A20 MBUS).
> >>
> >> We can add a custom recalc_rate() callback for factors clock,
> >> and also pass the parent index to the get_factors() callback.
> >> That would get rid of a lot of boilerplate.
> >>
> >> What do you think?
> >
> > I was more thinking about adding an additional callback that would
> > take the parent index as an argument, and would return for that parent
> > the multiplier or divider to apply.
> >
> > That would be quite easy to support, and would support both fixed
> > divider like the one found on the A20 MBUS, or the A20 AHB clock, and
> > dynamic factors like this one, while have most code in the core.
> 
> That means we would have to determine the pre-divider value first,
> in the case of dynamic ones, and they calculate the common factors.
>
> For most of the cases we just end up using the highest pre-divider
> to drop that parent rate closer to the others.
> 
> There's still the problem on how to set it though. If it were one
> of the factors then we'd extend .recalc_rate to cope with that factor
> not being a "common" factor. Or maybe just add an extra one. :)

Yeah, maybe it would be the easiest solution.

> >> It kind of extends factors clk beyond what it was designed for. If
> >> you agree, I'd also want to (ab)use it for other A80 clocks which
> >> have multiple dividers but don't fit the current factors clock
> >> formula.
> >
> > I think we're far beyond the point where factors clock are actually to
> > handle clocks with factors ;)
> >
> > We've stretched that notion to handle multiple cases, up to the point
> > where it's basically an additional layer on top of the clock framework
> > itself.
> >
> > I'd be quite okay to extend it, but so far the assumption has always
> > been that the formula was based on
> >
> > parent * n >> p / (k * m)
> 
> I believe it's: (parent * (n * (k+1)) >> p) / (m+1)
> 
> The one I came across was: parent * n / (p+1) / (m+1)
> where "p" is not a power of two divider.

Hmmm, ok.

Then maybe we can just have a flag to say wether p is a power of two
or not, just like the clock framework itself.

> > If that formula was to change, I'm pretty sure that this would require
> > a lot of changes, both in the factors code itself, plus to all the
> > users.
> 
> Actually the only place that makes this assumption is the .recalc_rate
> callback. The other callbacks are just standard adapter stuff, putting
> together the factors into a register. Hence my suggestion for a
> .recalc_rate callback inside of factors clock. This would allow the
> implementation to do whatever it saw fit to do with the 4 factors.

Ok, feel free to post some patches doing this, and we will see then :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/e7820c11/attachment.sig>
