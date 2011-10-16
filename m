From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 16 Oct 2011 20:26:49 +0200
Subject: [PATCH v2 4/7] clk: Add simple gated clock
In-Reply-To: <CAJOA=zPw7BF1iNFaG9js2k6++qPnXz5S3dq4rsPmUWOcUztL0g@mail.gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-5-git-send-email-mturquette@ti.com>
	<20111012064646.GA31037@b20223-02.ap.freescale.net>
	<CAJOA=zPw7BF1iNFaG9js2k6++qPnXz5S3dq4rsPmUWOcUztL0g@mail.gmail.com>
Message-ID: <20111016182649.GB13565@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 07:59:19AM -0700, Turquette, Mike wrote:
> On Tue, Oct 11, 2011 at 11:46 PM, Richard Zhao
> <richard.zhao@freescale.com> wrote:
> > On Thu, Sep 22, 2011 at 03:26:59PM -0700, Mike Turquette wrote:
> >> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> >>
> >> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> >> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> >> Signed-off-by: Mike Turquette <mturquette@ti.com>
> >> ---
> >> Changes since v1:
> >> Add copyright header
> >> Fold in Jamie's patch for set-to-disable clks
> >> Use BIT macro instead of shift
> >>
> >> ?drivers/clk/Kconfig ? ?| ? ?4 ++
> >> ?drivers/clk/Makefile ? | ? ?1 +
> >> ?drivers/clk/clk-gate.c | ? 78 ++++++++++++++++++++++++++++++++++++++++++++++++
> >> ?include/linux/clk.h ? ?| ? 13 ++++++++
> >> ?4 files changed, 96 insertions(+), 0 deletions(-)
> >> ?create mode 100644 drivers/clk/clk-gate.c
> >
> > I feel hard to tell the tree the clk parent, at register/init time. For the
> > simple gate clk, the only way is to set .get_parent. But normally, for clk
> > without any divider we set .get_parent to NULL. Maybe we can put .parent to
> > struct clk_hw?
> 
> For non-mux clocks, whose parent is *always* going to be the same, you
> should create a duplicate .parent in the clk_hw_* structure and then
> have .get_parent return clk_hw_*->parent.

Maybe I do not understand what you mean here, but I think there is
something missing in the gate.

> 
> This is analogous to the way clk_hw_fixed returns clk_hw_fixed->rate
> when .recalc is called on it.
> 
> >> +
> >> +static unsigned long clk_gate_get_rate(struct clk_hw *clk)
> >> +{
> >> + ? ? return clk_get_rate(clk_get_parent(clk->clk));
> >> +}

clk_get_parent goes down to clk_gate_set_enable_ops.get_parent below...

> >> +
> >> +
> >> +struct clk_hw_ops clk_gate_set_enable_ops = {
> >> + ? ? .recalc_rate = clk_gate_get_rate,
> >> + ? ? .enable = clk_gate_enable_set,
> >> + ? ? .disable = clk_gate_disable_clear,
> >> +};

...but this does not have a get_parent pointer, so clk_get_parent()
for a gate always returns NULL which means that a gate never has
a valid rate.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
