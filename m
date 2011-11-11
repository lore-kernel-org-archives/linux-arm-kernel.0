From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Nov 2011 10:27:27 +0000
Subject: [PATCH V2 01/14] clk: add helper functions clk_prepare_enable
 and clk_disable_unprepare
In-Reply-To: <20111111091556.GI16886@pengutronix.de>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
 <1320973829-4388-2-git-send-email-richard.zhao@linaro.org>
 <20111111084950.GH16886@pengutronix.de>
 <20111111090546.GC14617@b20223-02.ap.freescale.net>
 <20111111091556.GI16886@pengutronix.de>
Message-ID: <20111111102727.GC12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 10:15:56AM +0100, Sascha Hauer wrote:
> On Fri, Nov 11, 2011 at 05:05:47PM +0800, Richard Zhao wrote:
> > {
> > 	int ret;
> > 
> > 	ret = clk_prepare(clk);
> > 	if (ret)
> > 		return ret;
> > 	ret = clk_enable(clk);
> > 	if (ret)
> > 		clk_unprepare(clk);
> > 	return ret;
> 
> Yes, looks good.

While this looks like a nice easy solution for converting existing
drivers, I'd suggest thinking about this a little more...

I would suggest some thought is given to the placement of clk_enable()
and clk_disable() when adding clk_prepare(), especially if your existing
clk_enable() function can only be called from non-atomic contexts.

Obviously, the transition path needs to be along these lines:

1. add clk_prepare() to drivers
2. implement clk_prepare() and make clk_enable() callable from non-atomic
   contexts
3. move clk_enable() in drivers to places it can be called from non-atomic
   contexts to achieve greater power savings (maybe via the runtime pm)

and where a driver is shared between different sub-architectures which
have non-atomic clk_enable()s, (3) can only happen when all those sub-
architectures have been updated to step (2).
