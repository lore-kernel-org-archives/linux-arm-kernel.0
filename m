From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 12:38:23 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104291302420.3005@ionos>
References: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110429104951.GG5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291302420.3005@ionos>
Message-ID: <20110429113823.GK5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 01:11:25PM +0200, Thomas Gleixner wrote:
> I tend to disagree. Yes, he created the minimal common level for a
> struct clk and the ops around it. But does that change anything about
> the status quo of duplicated functions walking the tree, duplicated
> functions to validate and round clock rates? The whole approach will
> keep the whole code mess in the SoCs the same as it is now and just
> enforce a common data structure and a dozen wrapper "API" functions
> around it.
> 
> So omap will simply have their bloat in a struct omap_clk() and every
> other SoC will do the same. The duplicated code, the locking mess
> etc. will all remain in totally incompatible ways. So what's the win?

I disagree.  With a 'divider+mux' clk, OMAP can move those clocks
over.  With a 'pll' clk, OMAP can move the PLL stuff over.  With a
simple enable/disable clk, OMAP can move those over.  That's a
significant portion of the OMAP clk mess converted over to smaller,
much more well defined, self contained clk structures.

I don't see any reason with this why OMAP - or anyone else - should
have their own platform_clk structure if we have the necessary building
blocks, and provided there is sufficient review to ensure that those
building blocks which are found to be lacking get fixed along the way.

As for the locking mess, that's what happens when you try to generalize
stuff and end up with a finer locking scheme.  The more locks you have,
the more complex the locking rules become, and the more problems you
encounter with potential deadlocks.  And it seems that lockdep also
starts to struggle too (as it operates on classes of locks not actual
locks.)
