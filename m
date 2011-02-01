From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 17:06:37 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201155344.GF1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
Message-ID: <20110201170637.GR31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 04:53:44PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Feb 01, 2011 at 03:24:58PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 01, 2011 at 04:18:46PM +0100, Uwe Kleine-K?nig wrote:
> > > yeah, didn't thought about multiple consumers, so (as Jeremy suggested)
> > > the right thing is to sleep until CLK_BUSY is cleared.
> > 
> > A simpler way to write this is:
> > 
> > int clk_prepare(struct clk *clk)
> > {
> > 	int ret = 0;
> > 
> > 	mutex_lock(&clk->mutex);
> > 	if (clk->prepared == 0)
> > 		ret = clk->ops->prepare(clk);
> > 	if (ret == 0)
> > 		clk->prepared++;
> > 	mutex_unlock(&clk->mutex);
> > 
> > 	return ret;
> > }
> But you cannot call this in atomic context when you know the clock is
> already prepared.

So?  You're not _supposed_ to call it from any atomic context ever.
