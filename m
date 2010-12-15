From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 15 Dec 2010 20:09:12 +0800
Subject: [RFC] i.MX clock support
In-Reply-To: <20101215111237.GA6017@pengutronix.de>
References: <20101213102538.GB6017@pengutronix.de>
	<20101213150120.GE26210@pengutronix.de>
	<20101213154142.GP6017@pengutronix.de>
	<AANLkTimGa757yD1FPBLRm7WBTVA_0EHX8eMUHVieyodO@mail.gmail.com>
	<20101215111237.GA6017@pengutronix.de>
Message-ID: <20101215120912.GA1921@b20223-2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 12:12:37PM +0100, Sascha Hauer wrote:
> On Wed, Dec 15, 2010 at 07:20:08AM +0800, Richard Zhao wrote:
> > 2010/12/13 Sascha Hauer <s.hauer@pengutronix.de>:
> > > On Mon, Dec 13, 2010 at 04:01:20PM +0100, Uwe Kleine-K?nig wrote:
> > >> Hi Sascha,
> > >>
> > >> On Mon, Dec 13, 2010 at 11:25:38AM +0100, Sascha Hauer wrote:
> > >> > I am not willing to accept patches for adding i.MX50 support in the mess
> > >> > we currently have. These patches offer a way to cleanup the clock support
> > >> > and the i.MX50 may be a good test bed for an implementation without
> > >> > old cruft to worry about. That said the following patch is not set in
> > >> > stone, it's a request for comments and I'm of course open to other
> > >> > suggestions, but it's clear that we have to do something.
> > >> Full ack.
> > >>
> > >> > +#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))
> > >> > +
> > >> > +static unsigned long clk_divider_get_rate(struct clk *clk)
> > >> > +{
> > >> > + ? struct clk_divider *divider = to_clk_divider(clk);
> > >> > +
> > >> > + ? unsigned long rate = clk_get_rate(divider->parent);
> > >> > + ? unsigned int div = 1;
> > >> > +
> > >> > + ? if (divider->reg) {
> > >> > + ? ? ? ? ? div = readl(divider->reg) >> divider->shift;
> > >> > + ? ? ? ? ? div &= (1 << divider->width) - 1;
> > >> > + ? ? ? ? ? div++;
> > >> > + ? }
> > >> > +
> > >> > + ? return rate / div / divider->div * divider->mult;
> > >> Maybe you need to spend more effort to exactness e.g. by using
> > >> DIV_ROUND_CLOSEST and/or reordering?
> > >> (You didn't describe div and mult in struct clk_divider (below), so this
> > >> is a bit guess work for me here.)
> > >
> > > Ok, this needs some work. My original idea was to have seperate fixed
> > > dividers and configurable dividers. Then I decided to combine these into
> > > one divider. The end result was a mixure of both. We have a struct
> > > clk_divider_fixed, which is described but unused.
> > >
> > >>
> > >> > +}
> > >> > +
> > >> > +static long clk_divider_round_rate(struct clk *clk, unsigned long rate)
> > >> > +{
> > >> > + ? struct clk_divider *divider = to_clk_divider(clk);
> > >> > + ? unsigned long parent_rate = clk_get_rate(divider->parent);
> > >> > + ? unsigned int max_div, div;
> > >> > +
> > >> > + ? if (rate > parent_rate)
> > >> > + ? ? ? ? ? return parent_rate;
> > >> > +
> > >> > + ? max_div = 1 << divider->width;
> > >> > +
> > >> > + ? div = parent_rate / rate;
> > >> > + ? div = max(div, max_div);
> > >> > +
> > >> > + ? return parent_rate / div / divider->div * divider->mult;
> > >> ditto
> > >>
> > >> > +}
> > >> > +
> > >> > +static int clk_divider_set_rate(struct clk *clk, unsigned long rate)
> > >> > +{
> > >> > + ? struct clk_divider *divider = to_clk_divider(clk);
> > >> > + ? unsigned long parent_rate = clk_get_rate(divider->parent);
> > >> > + ? unsigned int max_div, div;
> > >> > + ? u32 val;
> > >> > +
> > >> > + ? parent_rate /= divider->div;
> > >> > + ? parent_rate *= divider->mult;
> > >> > +
> > >> > + ? if (rate > parent_rate)
> > >> > + ? ? ? ? ? rate = parent_rate;
> > >> > +
> > >> > + ? max_div = 1 << divider->width;
> > >> > +
> > >> > + ? div = parent_rate / rate;
> > >> > +
> > >> > + ? div = max(div, max_div);
> > >> > + ? div--;
> > >> > +
> > >> > + ? val = readl(divider->reg);
> > >> > + ? val &= ~(((1 << divider->width) - 1) << divider->shift);
> > >> > + ? val |= div << divider->shift;
> > >> > + ? writel(val, divider->reg);
> > >> > +
> > >> > + ? return 0;
> > >> You could spend more efforts here, but I think this is OK for now.
> > >>
> > >> > [...]
> > >> > +struct clk_ops clk_multiplexer_ops = {
> > >> > + ? .enable = clk_parent_enable,
> > >> > + ? .disable = clk_parent_disable,
> > >> > + ? .get_rate = clk_parent_get_rate,
> > >> > + ? .round_rate = clk_parent_round_rate,
> > >> > + ? .set_rate = clk_parent_set_rate,
> > >> Oh, this might have surprising effects if the parent is "public".
> > >> Is this intended?
> > >
> > > I have no idea what the best way is here. We could remove it and wait
> > > if somebody comes up with a good reason to add it again.
> > How about adding a child_count. If child_count >1, we stop its child
> > calling its set_rate/set_parent. In such way, we have to register
> > every clock, which is easier to debug. child_count maybe none zero
> > intend, in case there're some clocks in physical we don't set up in
> > software.
> 
> Instead of a child count I would rather suggest a flag
> allowing/disallowing the set_rate function propagating to the parent.
flag works too. 
> Currently propagating stops at a multiplexer which might be enough for
> most cases already.
But some clocks can not set_parent, which mean it doesn't need
any multiplexer. 

Richard

> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
