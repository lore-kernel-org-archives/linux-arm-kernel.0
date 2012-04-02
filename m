From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 19:05:47 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <20120402172954.GH15197@opensource.wolfsonmicro.com>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120402170442.GF24211@n2100.arm.linux.org.uk>
 <20120402172954.GH15197@opensource.wolfsonmicro.com>
Message-ID: <20120402180546.GJ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 06:34:12PM +0100, Mark Brown wrote:
> On Mon, Apr 02, 2012 at 06:04:43PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Apr 01, 2012 at 12:32:40PM +0100, Mark Brown wrote:
> > > Allow clk API users to simplify their cleanup paths by providing a
> > > managed version of clk_get().
> 
> > > Due to the lack of a standard struct clk to look up the device from a
> > > managed clk_put() is not provided, it would be very unusual to use this
> > > function so it's not a big loss.
> 
> > Err, why?  The contents of struct clk has nothing to do with clk_put().
> > You're doing something really wrong here.
> 
> It does for a devm_clk_put().  Normally this would end up being:
> 
> 	void devm_clk_put(struct clk *clk);
> 
> but the devres stuff needs us to have a struct device to get the
> underlying allocation/mapping and undo it.

So why can't we do:

	void devm_clk_put(struct device *, struct clk *);

just like other interfaces which free up devres stuff take a struct device.

> Probably what would actually end up
> happening is that we'd instead have a signature like:
> 
> 	devm_clk_put(struct device *dev, struct clk *clk);
> 
> but I didn't particularly feel like making that decision right now,
> especially if we do end up going with per user allocations and can use
> the more idiomatic signature.

Well that's what other subsystems do, so I see no reason to be different.
To be different would make us intentionally different from other
implementations which would be bad - and means that we're more reliant
on the underlying clk implementation.

That's bad news, especially for something that's going to end up being
used in multiple drivers (in terms of fixing the API if the underlying
implementation changes.)

Given that we're at this cross-roads already, just pass the struct device
and be done with it.
