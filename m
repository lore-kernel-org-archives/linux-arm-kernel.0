From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 30 Apr 2011 20:30:35 +0200
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <20110429110115.GI5126@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<20110429100927.GC5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291223250.3005@ionos>
	<20110429110115.GI5126@n2100.arm.linux.org.uk>
Message-ID: <20110430183034.GA3108@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2011-04-29 12:01:15, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 12:45:00PM +0200, Thomas Gleixner wrote:
> > On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> > 
> > > On Thu, Apr 21, 2011 at 09:48:28PM +0200, Thomas Gleixner wrote:
> > > > On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > > > > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > > > + * @get:	Called by the core clock code when a device driver acquires a
> > > > > + *		clock via clk_get(). Optional.
> > > > > + *
> > > > > + * @put:	Called by the core clock code when a devices driver releases a
> > > > > + *		clock via clk_put(). Optional.
> > > > 
> > > > These callbacks are completely pointless. There are only two non empty
> > > > implementations in tree:
> > > > 
> > > > One does a try_module_get(clk->owner), which should be done in generic
> > > > code. The other does special clock enabling magic which wants to go to
> > > > clk->prepare().
> > > 
> > > I disagree.  Most clocks don't live in a module - there's only one
> > > platform which does at present.  To force every clock to have an owner
> > > field is rediculous.  We already know that the OMAP tree represents a
> > 
> > So we trade an owner field (which can be NULL) versus two function
> > pointers in the clk_ops struct, which are of course subject to be
> > abused for all kind of crap which does not belong there at all.
> 
> And the current __clk_get/__clk_put stuff has been abused to hell and
> back hasn't it with just three implementations.  While I agree with your
> sentiment, lets agree to address that _if_ it becomes a problem.  At
> the moment, we have _enough_ problems to deal with, we don't need to
> invent new ones which really don't matter at this stage.

So lets.. add the pointer and see if 4K lost is a problem for
someone...?

It should be 'nice abstractions first, optimalizations later'...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
