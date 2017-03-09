From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Mar 2017 11:55:35 +0100
Subject: [PATCH 1/15] clk: divider: Make divider_round_rate take the
 parent clock
In-Reply-To: <20170307141157.GC10239@codeaurora.org>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <7ebd073b4941e4b7c619f15ff0a375ff7919d403.1488876832.git-series.maxime.ripard@free-electrons.com>
 <20170307141157.GC10239@codeaurora.org>
Message-ID: <20170309105535.wdypl3j2ha4ekzyb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Mar 07, 2017 at 06:11:57AM -0800, Stephen Boyd wrote:
> On 03/07, Maxime Ripard wrote:
> > So far, divider_round_rate only considers the parent clock returned by
> > clk_hw_get_parent.
> > 
> > This works fine on clocks that have a single parents, this doesn't work on
> > muxes, since we will only consider the first parent, while other parents
> > may totally be able to provide a better combination.
> > 
> > Clocks in that case cannot use divider_round_rate, so would have to come up
> > with a very similar logic to work around it. Instead of having to do
> > something like this, and duplicate that logic everywhere, give an
> > additional parameter for the parent clock to consider.
> > 
> > Current users have been converted using the following coccinelle script
> > 
> > @@
> > identifier hw, rate, prate, table, width, flags;
> > @@
> > 
> > -long divider_round_rate(struct clk_hw *hw,
> > +long divider_round_rate(struct clk_hw *hw, struct clk_hw *parent,
> >                         unsigned long rate,
> >                         unsigned long *prate,
> >                         const struct clk_div_table *table,
> >                         u8 width,
> >                         unsigned long flags) { ... }
> > 
> > @@
> > identifier fn, hw;
> > expression E2, E3, E4, E5, E6;
> > @@
> >  fn (struct clk_hw *hw, ...) {
> >  <...
> > -divider_round_rate(hw, E2, E3, E4, E5, E6)
> > +divider_round_rate(hw, clk_hw_get_parent(hw), E2, E3, E4, E5, E6)
> >  ...>
> > }
> 
> Why not introduce another function like 
> 
> 	divider_round_rate_parent()
> 	divider_round_rate_mux()
> 
> that takes the extra parent argument? Technically, a divider is
> considered to only have one parent, and if it has more than one
> parent, then it is a mux and a divider.

Yes, that would work too, without needing the cross tree change. I'll
do that in the next version.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/a0d9c6db/attachment.sig>
