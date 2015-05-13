From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 May 2015 21:12:30 +0100
Subject: Automatic clock disabling on clk_put()
In-Reply-To: <5553A9C8.2070701@codeaurora.org>
References: <20150511060129.GG6325@pengutronix.de>
 <55528B84.5050700@codeaurora.org>
 <20150513064550.GE28888@pengutronix.de>
 <5553A9C8.2070701@codeaurora.org>
Message-ID: <20150513201230.GT2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 12:45:12PM -0700, Stephen Boyd wrote:
> On 05/12/15 23:45, Uwe Kleine-K?nig wrote:
> >
> >> that hard to call clk_disable_unprepare() on a clock at the end of an
> >> error path? Maybe you could add a devm_clk_get_prepare_enable() that
> >> does what you want and then call clk_disable_unprepare on the exit path?
> > You mean clk_disable_unprepare is called in the same function that calls
> > clk_put I assume such that you don't have to do anything in the exit
> > path.
> >
> 
> Yes that's what I mean.

In terms of stopping people doing:

	clk = clk_get(...);
	clk_prepare_enable(clk);
	clk_put(clk);

I think this is a good thing, because it ensures that people can't do
this anymore.

I think you need to audit the code properly first, and fix any instances
of that _before_ posting patches with your idea - let's try to avoid as
much as possible any breakage resulting from this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
