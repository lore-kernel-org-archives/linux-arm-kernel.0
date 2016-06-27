From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jun 2016 22:46:47 +0200
Subject: [PATCH v2 00/15] clk: sunxi: introduce "modern" clock support
In-Reply-To: <20160621202919.b9fff30f050cc00c9acb7688@free.fr>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160621114044.811e2136eca5c1d863d79ac6@free.fr>
 <20160621144752.GR26668@lukather>
 <20160621202919.b9fff30f050cc00c9acb7688@free.fr>
Message-ID: <20160627204647.GZ4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 08:29:19PM +0200, Jean-Francois Moine wrote:
> On Tue, 21 Jun 2016 16:47:52 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > But I had some problems with some features as the 'mode select' in the
> > > A83T MMC2 clock.
> > > Also, I think that you did not go far enough in the changes.
> > 
> > At some point, you also have to support what's used out there,
> > otherwise it just becomes an un-maintainable mess. Plus, it really
> > doesn't have to be perfect from day one, it just has to works as it
> > used to, we can always add more stuff later on.
> 
> I was not thinking about the client interface, but about the sunxi new
> clock driver itself. The way the clocks are declared may be enhanced.

Maybe.

> Then, the particular features of some clocks (as MMC2 mode select) ask
> for a hard re-think of your structures.

And a hard re-think of the clock framework as a whole, for a feature
that we do not need, or care about.

> > At it works way better than what we had.
> 
> Maybe for the actual drivers of the H3, but not for DDR for example.

Which, let's be reasonable, we won't ever support in Linux (and if
that ever happens, would be trivial to implement).

> > The question also is: is there anyone that we depend on using it
> > (mainline u-boot)? and is it something we need? If both answers are
> > no, then it's just dead code, which shouldn't be here in the first
> > place.
> 
> I don't understand what you mean.

If a feature is useless to us, and is not used by U-Boot, any support
for it is effictively dead code.

> > > For example, most clock gates as well as most resets could be removed
> > > from the DT and automatically set/de-asserted on clock prepare or clock
> > > enable.
> > 
> > No. The semantics are completely different between the bus gates, bus
> > resets and the module clocks. For example, the module clock can be
> > shut down while retaining the register state, while the gate clock
> > can't. And drivers are already using that semantic.
> 
> A quick look at the H3 drivers showed me that they always do
> reset-deassert, bus gate enable and clock gate enable at probe time.

For the H3, that might be true. That's not true for some other SoCs,
and we plan to use that framework on all the SoCs.

> On the other side, it seems that the order of doing these settings is
> important (Programming Guidelines in the CCU section of the Allwinner's
> doc). So, it seems better to me to centralize these settings in the
> clock driver.

If that ever becomes a problem, we have other ways to deal with it too
(like the clock power domains).

> > Some other problems arise from that as well: this would break the DT
> > ABI, and it deviates way too much from what the other SoCs are doing
> > (which is the whole reason for that rework in the first place).
> 
> Defining empty reset/bus gate clocks would not imply changes in the
> DTs, nor in the drivers.

Of course it would. If you define an empty clock, that would change
its semantic since either the interface or the functional clock would
be missing while the driver would expect (and drive) both.

Or, if you fix all the drivers, the old DTs would not work anymore,
since they would drive only one clock, instead of both.

> > > So, I am rewriting a generic sunxi clock driver into one file (about
> > > 1000 lines) and I have the full (simpler and clearer) description of
> > > the H3 and the A863T clocks.
> > > 
> > > Coding is not finished yet. I will submit a RFC as soon as I will have
> > > something working.
> > 
> > Please don't. I don't want to waste any more time on this, this is way
> > overdue.
> 
> OK. I need such a new driver for clocks which cannot be handled with
> your structures. I will propose it later, when it will be time...
> 
> <parenthesis>
> Just have a glimpse at my declaration of the A83T audio PLL.
> Isn't it easier to create and read?
> 
> /* audio */
> /*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) / (p + 1) */
> static struct ccu pll_audio_clk = {
> 	CCU_REG(0x008),
> 	CCU_HW("pll-audio", "osc24M", &ccu_pll_ops, 0),
> 	CCU_GATE(0x008, 31),
> 	CCU_LOCK(0x20c, 2),
> 	CCU_N(8, 8), .n_min = 12,
> 	CCU_D1(16, 1),
> 	CCU_D2(18, 1),
> 	CCU_M(0, 6),		/* p = divider */
> 	.features = CCU_FEATURE_N0,
> };
> 
> </parenthesis>

I don't see what's so different than declaring the structure directly
without using the macros, which is something we can do.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/b257f72f/attachment.sig>
