From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Feb 2011 11:21:20 +0100
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110204095424.GB2347@richard-laptop>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D48741F.8060006@codeaurora.org>
	<20110201212409.GU31216@n2100.arm.linux.org.uk>
	<20110204095424.GB2347@richard-laptop>
Message-ID: <20110204102120.GJ30452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Fri, Feb 04, 2011 at 05:54:24PM +0800, Richard Zhao wrote:
> On Tue, Feb 01, 2011 at 09:24:09PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 01, 2011 at 12:59:11PM -0800, Stephen Boyd wrote:
> > > On 02/01/2011 07:24 AM, Russell King - ARM Linux wrote:
> > > > I'd also be tempted at this stage to build-in a no-op dummy clock,
> > > > that being the NULL clk:
> > > >
> > > > int clk_prepare(struct clk *clk)
> > > > {
> > > > 	int ret = 0;
> > > >
> > > > 	if (clk) {
> > > > 		mutex_lock(&clk->mutex);
> > > > 		if (clk->prepared == 0)
> > > > 			ret = clk->ops->prepare(clk);
> > > > 		if (ret == 0)
> > > > 			clk->prepared++;
> > > > 		mutex_unlock(&clk->mutex);
> > > > 	}
> > > >
> > > > 	return ret;
> > > > }
> > > 
> > > I'm afraid this will hide enable/disable imbalances on some targets and
> > > then expose them on others. Maybe its not a big problem though since
> > > this also elegantly handles the root(s) of the tree.
> > 
> > You can't catch enable/disable imbalances in the prepare code, and you
> > can't really catch them in the unprepare code either.
> > 
> > Consider two drivers sharing the same struct clk.  When the second driver
> > prepares the clock, the enable count could well be non-zero, caused by
> > the first driver.  Ditto for when the second driver is removed, and it
> > calls unprepare - the enable count may well be non-zero.
> > 
> > The only thing you can check is that when the prepare count is zero,
> > the enable count is also zero.  You can also check in clk_enable() and
> > clk_disable() that the prepare count is non-zero.
> but how can we check prepare count without mutex lock? Even if prepare count
> is atomic_t, it can not guarantee the clock is actually prepared or unprepared.
> So it's important for driver writer to maintain the call sequence.
I happily point out that the prepare_count needs to be protected by a
spinlock and you need a flag that signals a prepare or unprepare is
currently running.

SCNR
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
