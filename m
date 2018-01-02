From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 02 Jan 2018 16:46:55 +1100
Subject: [PATCH v6 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <1514584997.2743.107.camel@kernel.crashing.org>
References: <20171128071908.12279-1-joel@jms.id.au>
 <20171128071908.12279-5-joel@jms.id.au>
 <20171221233927.GE7997@codeaurora.org>
 <1513910191.2743.77.camel@kernel.crashing.org>
 <1513910633.2743.79.camel@kernel.crashing.org>
 <20171227013227.GV7997@codeaurora.org>
 <1514584997.2743.107.camel@kernel.crashing.org>
Message-ID: <1514872015.2743.130.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-12-30 at 09:03 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2017-12-26 at 17:32 -0800, Stephen Boyd wrote:
> > > I noticed we do have a few i2c based clock drivers... how are they ever
> > > supposed to work ? i2c bus controllers are allowed to sleep and the i2c
> > > core takes mutexes...
> > 
> > We have clk_prepare()/clk_unprepare() for sleeping suckage. You
> > can use that, and i2c based clk drivers do that today.
> 
> "suckage" ? Hehe ... the suckage should rather be stuff that cannot
> sleep. Arbitrary latencies and jitter caused by too much code wanting
> to be "atomic" when unnecessary are a bad thing.
> 
> In the case of clocks like the aspeed where we have to wait for a
> rather long stabilization delay, way too long to legitimately do a non-
> sleepable delay with a lock held, do we need to do everything in
> prepare() then ?

BTW. Pls don't hold Joel's patches for this. Without that clk framework
a lot of the aspeed stuff already upstream doesn't actually work
without additional out-of-tree hacks or uboot black magic.

We can sort out the sleeping issues (and possibly move to using prepare
for the clocks that have that delay requirement) via subsequent
improvements.

Cheers,
Ben.
