From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 12:09:14 -0600
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <4E89C3FA.9020206@gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E89C3FA.9020206@gmail.com>
Message-ID: <20111004180914.GC2870@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 09:17:30AM -0500, Rob Herring wrote:
> On 09/22/2011 05:26 PM, Mike Turquette wrote:
> > +	/* Query the hardware for parent and initial rate */
> > +
> > +	if (clk->ops->get_parent)
> > +		/* We don't to lock against prepare/enable here, as
> > +		 * the clock is not yet accessible from anywhere */
> > +		clk->parent = clk->ops->get_parent(clk->hw);
> 
> I don't think this is going to work. This implies that the parent clock
> is already registered. For simple clk trees, that's probably not an
> issue, but for chips with lots of muxing it will be impossible to get
> the order correct for all cases. This is not an issue today as most
> clocks are statically created.
> 
> I think what is needed is a 2 stage init. The 1st stage to create all
> the clocks and a 2nd stage to build the tree once all clocks are created.
> 
> Tracking the parents using struct clk_hw instead would help as long as
> clocks are still statically allocated. However, that won't help for
> devicetree.

I disagree.  Clocks really need to be registered in dependency order.
Even in the deferral case, the driver should hold of actually
registering the clk (note: the struct clk, not the struct device)
until the clocks it depends on are available.

I also agree with the point that there are a lot of SoC clocks that
may not even show up in clkdev, and for pragmatic considerations are
better set up all at once early in the init process (ie. as part of
common SoC setup code, and doesn't change between boards).  That code
should be clue-full enough that it can register its own clocks in the
right order.

g.
