From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 10:48:32 +0000
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
Message-ID: <20110204104832.GE14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 05:54:24PM +0800, Richard Zhao wrote:
> On Tue, Feb 01, 2011 at 09:24:09PM +0000, Russell King - ARM Linux wrote:
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
>
> but how can we check prepare count without mutex lock? Even if prepare count
> is atomic_t, it can not guarantee the clock is actually prepared or unprepared.
> So it's important for driver writer to maintain the call sequence.

Forget atomic_t - it's the most abused type in the kernel.  Just because
something says its atomic doesn't make it so.  In a use like this,
atomic_t just buys you additional needless complexity with no benefit.

Of course we can check the prepared count.  What we can't do is check
that it doesn't change concurrently - but that's something we can't do
anyway.

int clk_enable(struct clk *clk)
{
	unsigned long flags;
	int ret = 0;

	if (clk) {
		if (WARN_ON(!clk->prepare_count))
			return -EINVAL;

		spin_lock_irqsave(&clk->lock, flags);
		if (clk->enable_count++ == 0)
			ret = clk->ops->enable(clk);
		spin_unlock_irqrestore(&clk->lock, flags);
	}
	return ret;
}

is entirely sufficient to catch the case of a single-use clock not being
prepared before clk_enable() is called.

We're after detecting drivers missing calls to clk_prepare(), we're not
after detecting concurrent calls to clk_prepare()/clk_unprepare().
