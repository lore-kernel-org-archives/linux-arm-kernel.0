From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 12:09:52 +0100
Subject: [RFC] i.MX clock support
In-Reply-To: <20101214023056.GA546@b20223-2.ap.freescale.net>
References: <20101213102538.GB6017@pengutronix.de>
	<20101214023056.GA546@b20223-2.ap.freescale.net>
Message-ID: <20101215110951.GZ6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 10:30:56AM +0800, Richard Zhao wrote:
> Hello Sascha,
> 
> On Mon, Dec 13, 2010 at 11:25:38AM +0100, Sascha Hauer wrote:
> > Hi,
> > 
> > I played around with Jeremys common struct clk patches and I think they
> > offer a great potential for cleaning up the i.MX51 (and i.MX in general)
> > clock support.
> > 
> > Currently on i.MX we have clocks implementing varying sets of the clk
> > functions and most of the time the functions are reimplemented for
> > each clock. The i.MX51 clock support shows that this becomes
> > unmaintainable. The following patch allows for a different approach.
> > Instead of making each clock a full featured clock we split the clocks
> > into their basic building blocks. Currently we have:
> > 
> > * multiplexer   Choose from a set of parent clocks (clk_[get|set]_parent)
> > * divider       clock divider (clk_[get|set|round]_rate)
> > * gates         clk_[en|dis]able
> > * groups        Group together clocks which should be enabled at once.
> > 
> > Of course these are the building blocks on other architectures aswell,
> > so we may move parts of the patch to a more generic place.
> The building blocks  are reasonable. But your implementation is breaking clock
> boundaries. One macro clock is divided to some sub clocks (gate, divider,
> multiplexer and group). It makes things a little complicated. Why not just use:
> struct mxc_clk {
> 	.multiplexer =
> 	.divider =
> 	.gates =
> 	.groups =
> }

I think *this* is making it complicated, because this way you always
have to think what a clock is and what not. I want implementing a
clock tree to be a straight forward task, with only looking at the
building block pictures in the datasheet.

> And there're many clk_parent_xxx. If it's calling its own macro clock set_rate
> and dis/enable, it's ok. But if it's calling its macro clock's real parents,
> it's not a correct way.

I don't understand what you mean here.

> > +#define to_clk_gate(clk) (container_of(clk, struct clk_gate, clk))
> > +
> > +static int clk_gate_enable(struct clk *clk)
> > +{
> > +       struct clk_gate *gate = to_clk_gate(clk);
> > +       u32 val, mask;
> > +
> > +       if (gate->flags & CLK_GATE_TWO_BITS)
> > +               mask = 3 << (gate->shift * 2);
> I'm not sure whether it's always 3.

There are some cases where the clock is enabled in run mode and disabled
in stop mode. I haven't implemented this yet.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
