From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 11:18:31 +0000
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <1262944873.585.17.camel@pasglop>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
	<1262944873.585.17.camel@pasglop>
Message-ID: <20100108111831.GA25082@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 09:01:13PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2010-01-08 at 09:42 +0000, Russell King - ARM Linux wrote:
> > What is clear from the clk API as implemented today is that what's
> > right
> > for one platform isn't right for another platform.  That's why we have
> > each platform implementing struct clk in their own way. 
> 
> Such platforms would just not set CONFIG_HAVE_COMMON_STRUCT_CLK then.
> 
> I think what Jeremy is trying to achieve is a way for platforms that
> which to use the device-tree to retrieve the clock binding to be able to
> chose to do so, using as much common code as possible.

The contents of struct clk has nothing to do with binding though.
The binding of struct clk to devices is totally separate to the actual
contents of struct clk - and it has to be to cope with clocks being
shared between different devices.  So your statement makes no sense.

The binding issue is all about how you go from a driver wanting its
clocks to a representation of that clock which the code can deal with.
That's basically clk_get(), and we currently have that covered both by
both clkdev, and by simpler implementations in some platforms.

What a device-tree based implementation would have to do is provide its
own version of clk_get() and clk_put() - it shouldn't care about the
contents of the struct clk that it's returning at all.

> The problem with the more "static" variants of struct clk is that while
> they are probably fine for a single SoC with a reasonably unified clock
> mechanism, having more than one clock source programmed differently and
> wanting to deal with potentially out-of-SoC clock links between devices
> becomes quickly prohibitive without function pointers.

The "clock source programmed differently" argument I don't buy.  OMAP has
the most complicated clock setup there is on the planet - with lots of
on-chip PLLs, muxes, dividers and switches, all in a heirarchy, and it
seems to cope, propagating changes up and down the tree.

The out-of-SoC problem is something that the clk API doesn't address,
and it remains difficult to address all the time that SoCs can do their
own thing - I'll cover that below.

You really would not want the weight of the OMAP implementation on
something like Versatile.

Now we come to another problem: Versatile is one of the relatively simple
implementations.  It's not a "real" platform in the sense that it's a
development board with a fairly fixed clock relationship - most clocks
are fixed, only some are variable.  It only represents the simple SoCs
like PXA, where the only real control you have is being able to turn
clocks on and off. Apart from the LCD clock, there's not much other
control there.

Modern SoCs are far more complex beasts, with PLLs, dividers, muxes
and so forth - both Samsung S3C and TI OMAP SoCs are good examples of
these.

Basically, there are three classes when it comes to SoC clocks:

1. damned simple, no control what so ever, just need rate info maybe
   for one or two clocks, eg SA1100, LH7A40x, NETX.
2. fixed set of clocks, where the clocks can be turned on/off to
   logical sections of the CPU - eg, PXA, W90X900 etc.
3. complex setups which have a tree of clocks, with muxes, dividers,
   plls etc (Samsung, OMAP).

Trying to get a generic implementation which only addresses some of
those classes is, I believe, very misguided.  Maybe instead we should
be aiming for two or three "common" implementations rather than trying
for a one-size-fits-only-a-small-subset approach?

I don't buy the "don't use it on those platforms then" argument -
because that means not using it on the platforms which are the likely
places people brought up the concerns on - the PXA/Samsung/OMAP types
of platforms.
