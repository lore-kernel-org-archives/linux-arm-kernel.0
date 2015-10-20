From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Oct 2015 09:34:50 +0200
Subject: [PATCH v5 1/5] clk: Add a basic multiplier clock
In-Reply-To: <CAGb2v65bZGQEHyS6UoBUsrDoJ33jYwa--BkmfomZ4AGAy0djNw@mail.gmail.com>
References: <1445242139-20965-1-git-send-email-maxime.ripard@free-electrons.com>
 <1445242139-20965-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65bZGQEHyS6UoBUsrDoJ33jYwa--BkmfomZ4AGAy0djNw@mail.gmail.com>
Message-ID: <20151020073450.GA2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 04:22:15PM +0800, Chen-Yu Tsai wrote:
> On Mon, Oct 19, 2015 at 4:08 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some clocks are using a multiplier component, however, unlike their mux,
> > gate or divider counterpart, these factors don't have a basic clock
> > implementation.
> >
> > This leads to code duplication across platforms that want to use that kind
> > of clocks, and the impossibility to use the composite clocks with such a
> > clock without defining your own rate operations.
> >
> > Create such a driver in order to remove these issues, and hopefully factor
> > the implementations, reducing code size across platforms and consolidating
> > the various implementations.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/Makefile         |   1 +
> >  drivers/clk/clk-multiplier.c | 181 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk-provider.h |  42 ++++++++++
> >  3 files changed, 224 insertions(+)
> >  create mode 100644 drivers/clk/clk-multiplier.c
> >
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index d08b3e5985be..0b2101039508 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)        += clk-divider.o
> >  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-factor.o
> >  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-rate.o
> >  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
> > +obj-$(CONFIG_COMMON_CLK)       += clk-multiplier.o
> >  obj-$(CONFIG_COMMON_CLK)       += clk-mux.o
> >  obj-$(CONFIG_COMMON_CLK)       += clk-composite.o
> >  obj-$(CONFIG_COMMON_CLK)       += clk-fractional-divider.o
> > diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
> > new file mode 100644
> > index 000000000000..fed71de801ca
> > --- /dev/null
> > +++ b/drivers/clk/clk-multiplier.c
> 
> <snip>
> 
> > +static unsigned long __bestmult(struct clk_hw *hw, unsigned long rate,
> > +                               unsigned long *best_parent_rate,
> > +                               u8 width, unsigned long flags)
> > +{
> > +       unsigned long orig_parent_rate = *best_parent_rate;
> > +       unsigned long parent_rate, current_rate, best_rate = ~0;
> > +       unsigned int i, bestmult = 0;
> > +
> > +       if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT))
> > +               return rate / *best_parent_rate;
> > +
> > +       for (i = 1; i < ((1 << width) - 1); i++) {
> > +               if (rate * i == orig_parent_rate) {
> 
> The tested multiplier "i" is on the wrong side of the equation when
> compared to the statement "current_rate = parent_rate * i"
> 
> Since this should be a clock multiplier, that test can only be true
> when i == 1, given that rate >= parent_rate. In all other cases it'll
> fallback to the clk_hw_round_rate() call below.
> 
> Am I missing something?

You're totally right, I just completely forgot this comment before
sending the new version :/

I'll send a new version.

> Otherwise, this is
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/e344ca5e/attachment.sig>
