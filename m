From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 15:25:24 +0100
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <4E89C3FA.9020206@gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E89C3FA.9020206@gmail.com>
Message-ID: <20111003142524.GN3731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 09:17:30AM -0500, Rob Herring wrote:
> On 09/22/2011 05:26 PM, Mike Turquette wrote:

A lot of stuff that should really have been cut plus...

> > +	if (clk->ops->get_parent)
> > +		/* We don't to lock against prepare/enable here, as
> > +		 * the clock is not yet accessible from anywhere */
> > +		clk->parent = clk->ops->get_parent(clk->hw);

> I don't think this is going to work. This implies that the parent clock
> is already registered. For simple clk trees, that's probably not an
> issue, but for chips with lots of muxing it will be impossible to get
> the order correct for all cases. This is not an issue today as most
> clocks are statically created.

> I think what is needed is a 2 stage init. The 1st stage to create all
> the clocks and a 2nd stage to build the tree once all clocks are created.

> Tracking the parents using struct clk_hw instead would help as long as
> clocks are still statically allocated. However, that won't help for
> devicetree.

This isn't in any way specific to clocks, right now the likely solution
looks to be Grant's changes for retrying probe() as new devices come on
line.  With that devices can return a code from their probe() which
tells the driver core that they couldn't get all the resources they need
and that it should retry the probe() if more devices come on-line.
