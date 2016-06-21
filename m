From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 21 Jun 2016 20:29:19 +0200
Subject: [PATCH v2 00/15] clk: sunxi: introduce "modern" clock support
In-Reply-To: <20160621144752.GR26668@lukather>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160621114044.811e2136eca5c1d863d79ac6@free.fr>
 <20160621144752.GR26668@lukather>
Message-ID: <20160621202919.b9fff30f050cc00c9acb7688@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jun 2016 16:47:52 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > But I had some problems with some features as the 'mode select' in the
> > A83T MMC2 clock.
> > Also, I think that you did not go far enough in the changes.
> 
> At some point, you also have to support what's used out there,
> otherwise it just becomes an un-maintainable mess. Plus, it really
> doesn't have to be perfect from day one, it just has to works as it
> used to, we can always add more stuff later on.

I was not thinking about the client interface, but about the sunxi new
clock driver itself. The way the clocks are declared may be enhanced.
Then, the particular features of some clocks (as MMC2 mode select) ask
for a hard re-think of your structures.

> At it works way better than what we had.

Maybe for the actual drivers of the H3, but not for DDR for example.

> The question also is: is there anyone that we depend on using it
> (mainline u-boot)? and is it something we need? If both answers are
> no, then it's just dead code, which shouldn't be here in the first
> place.

I don't understand what you mean.

> > For example, most clock gates as well as most resets could be removed
> > from the DT and automatically set/de-asserted on clock prepare or clock
> > enable.
> 
> No. The semantics are completely different between the bus gates, bus
> resets and the module clocks. For example, the module clock can be
> shut down while retaining the register state, while the gate clock
> can't. And drivers are already using that semantic.

A quick look at the H3 drivers showed me that they always do
reset-deassert, bus gate enable and clock gate enable at probe time.
On the other side, it seems that the order of doing these settings is
important (Programming Guidelines in the CCU section of the Allwinner's
doc). So, it seems better to me to centralize these settings in the
clock driver.

> Some other problems arise from that as well: this would break the DT
> ABI, and it deviates way too much from what the other SoCs are doing
> (which is the whole reason for that rework in the first place).

Defining empty reset/bus gate clocks would not imply changes in the
DTs, nor in the drivers.

> > So, I am rewriting a generic sunxi clock driver into one file (about
> > 1000 lines) and I have the full (simpler and clearer) description of
> > the H3 and the A863T clocks.
> > 
> > Coding is not finished yet. I will submit a RFC as soon as I will have
> > something working.
> 
> Please don't. I don't want to waste any more time on this, this is way
> overdue.

OK. I need such a new driver for clocks which cannot be handled with
your structures. I will propose it later, when it will be time...

<parenthesis>
Just have a glimpse at my declaration of the A83T audio PLL.
Isn't it easier to create and read?

/* audio */
/*	rate = 24MHz * n / (d1 + 1) / (d2 + 1) / (p + 1) */
static struct ccu pll_audio_clk = {
	CCU_REG(0x008),
	CCU_HW("pll-audio", "osc24M", &ccu_pll_ops, 0),
	CCU_GATE(0x008, 31),
	CCU_LOCK(0x20c, 2),
	CCU_N(8, 8), .n_min = 12,
	CCU_D1(16, 1),
	CCU_D2(18, 1),
	CCU_M(0, 6),		/* p = divider */
	.features = CCU_FEATURE_N0,
};

</parenthesis>

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
