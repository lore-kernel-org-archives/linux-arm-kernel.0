From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 11:09:27 +0100
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <alpine.LFD.2.02.1104212146400.3323@ionos>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
Message-ID: <20110429100927.GC5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 09:48:28PM +0200, Thomas Gleixner wrote:
> On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > + * @get:	Called by the core clock code when a device driver acquires a
> > + *		clock via clk_get(). Optional.
> > + *
> > + * @put:	Called by the core clock code when a devices driver releases a
> > + *		clock via clk_put(). Optional.
> 
> These callbacks are completely pointless. There are only two non empty
> implementations in tree:
> 
> One does a try_module_get(clk->owner), which should be done in generic
> code. The other does special clock enabling magic which wants to go to
> clk->prepare().

I disagree.  Most clocks don't live in a module - there's only one
platform which does at present.  To force every clock to have an owner
field is rediculous.  We already know that the OMAP tree represents a
significant amount of data, and for every additional unnecessary word,
it gobbles up another 4K of data space.

If we go down the route of separating clock stuff into bite-size pieces,
OMAP is going to end up with yet more struct clks, which is going to add
to the bloat even more.
