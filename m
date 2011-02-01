From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 15:24:58 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201151846.GD1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
Message-ID: <20110201152458.GP31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 04:18:46PM +0100, Uwe Kleine-K?nig wrote:
> yeah, didn't thought about multiple consumers, so (as Jeremy suggested)
> the right thing is to sleep until CLK_BUSY is cleared.

A simpler way to write this is:

int clk_prepare(struct clk *clk)
{
	int ret = 0;

	mutex_lock(&clk->mutex);
	if (clk->prepared == 0)
		ret = clk->ops->prepare(clk);
	if (ret == 0)
		clk->prepared++;
	mutex_unlock(&clk->mutex);

	return ret;
}

I think we want to take a common mutex not only for clk_prepare(), but
also for clk_set_rate().  If prepare() is waiting for a PLL to lock,
we don't want a set_rate() interfering with that.

I'd also be tempted at this stage to build-in a no-op dummy clock,
that being the NULL clk:

int clk_prepare(struct clk *clk)
{
	int ret = 0;

	if (clk) {
		mutex_lock(&clk->mutex);
		if (clk->prepared == 0)
			ret = clk->ops->prepare(clk);
		if (ret == 0)
			clk->prepared++;
		mutex_unlock(&clk->mutex);
	}

	return ret;
}

as we have various platforms defining a dummy struct clk as a way of
satisfying various driver requirements.  These dummy clocks are exactly
that - they're complete no-ops.
