From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 11:30:55 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104202113250.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
Message-ID: <20110429103055.GE5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 09:52:15PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > struct clk has no parent member, there is only clk_get_parent(). If
> 
> Which is a complete failure to begin with. Why the heck do you need a
> callback to figure that out?

Thomas, you're wrong.  You're looking at things far too simply, because
all you can see is a tree of clocks.

When you have MUXes, a clock can have one of many parents.  So a single
clk->parent doesn't hack it.  That's one reason why clk_get_parent()
exists, so that MUXes can return the appropriate parent for the current
MUX setting.

You may wish to store the current setting in clk->parent, but I'd argue
that's a recipe for things going wrong when the MUX settings differ from
the cached clk->parent value.  Instead, having clk_get_parent()s
implementation return the _current_ parent and let MUXes do the right
thing depending on hardware is much easier and more reliably correct.

So I don't agree with you on some of these points.
