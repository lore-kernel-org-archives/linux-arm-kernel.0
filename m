From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 08 Jan 2010 22:45:03 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <20100108111831.GA25082@n2100.arm.linux.org.uk>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
	<1262944873.585.17.camel@pasglop>
	<20100108111831.GA25082@n2100.arm.linux.org.uk>
Message-ID: <1262951103.585.40.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-08 at 11:18 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 08, 2010 at 09:01:13PM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2010-01-08 at 09:42 +0000, Russell King - ARM Linux wrote:
> > > What is clear from the clk API as implemented today is that what's
> > > right
> > > for one platform isn't right for another platform.  That's why we have
> > > each platform implementing struct clk in their own way. 
> > 
> > Such platforms would just not set CONFIG_HAVE_COMMON_STRUCT_CLK then.
> > 
> > I think what Jeremy is trying to achieve is a way for platforms that
> > which to use the device-tree to retrieve the clock binding to be able to
> > chose to do so, using as much common code as possible.
> 
> The contents of struct clk has nothing to do with binding though.
> The binding of struct clk to devices is totally separate to the actual
> contents of struct clk - and it has to be to cope with clocks being
> shared between different devices.  So your statement makes no sense.

I think you misunderstood me and that we actually agree :-)

See below...

> The binding issue is all about how you go from a driver wanting its
> clocks to a representation of that clock which the code can deal with.
> That's basically clk_get(), and we currently have that covered both by
> both clkdev, and by simpler implementations in some platforms.
> 
> What a device-tree based implementation would have to do is provide its
> own version of clk_get() and clk_put() - it shouldn't care about the
> contents of the struct clk that it's returning at all.

Yes, more or less that's the idea.

IE. The way I envisioned it is that a platform clk_get() can use the
device-tree to get to the clock provider (clock chip driver) own
clk_get() which in turn returns the struct clk.

However, for that concept of "clock object" to work, the struct clk must
carry methods, aka, function pointers. And the intend is to try to
standardize that part of the struct clk that is purely "API" ie. those
function pointers.

My understanding is that Jeremy's patch attempts at more or less
standardizing the way those function pointers are accessed to, and thus
standardize the API-side of the clock object so that clock providers
(aka clock chip drivers) can generate those without the platform needing
to know much about the details of the fields making up a given instance
of a clock object.

I am not too familiar with your clkdev approach, or rather I don't have
the details off the top of my mind right now, but my understanding is
that it's basically the same idea without the device-tree and using a
clock name based scheme.

> > The problem with the more "static" variants of struct clk is that while
> > they are probably fine for a single SoC with a reasonably unified clock
> > mechanism, having more than one clock source programmed differently and
> > wanting to deal with potentially out-of-SoC clock links between devices
> > becomes quickly prohibitive without function pointers.
> 
> The "clock source programmed differently" argument I don't buy.  OMAP has
> the most complicated clock setup there is on the planet - with lots of
> on-chip PLLs, muxes, dividers and switches, all in a heirarchy, and it
> seems to cope, propagating changes up and down the tree.

It does ... as long as you stick to the SoC clocks. You don't have the
ability to have a re-usable clock driver for an external cypress PLL for
example on an i2c bus sourcing some other external device at the same
time.

IE. The way the OMAP code works right now is that basically, all struct
clk has to be handled by the platform, and thus more or less, be the
OMAP SoC clocks. It makes it very hard to -also- use the clk API in the
same platform to deal with other clock net dependencies outside of the
main SoC... unless you can make the API-side of the clock object generic
enough so that the platform can still issue SoC orignated struct clk,
but other clock drivers can also provide their own, different variants
of struct clk, with different callbacks, and the end device doesn't have
to know about it.

> The out-of-SoC problem is something that the clk API doesn't address,
> and it remains difficult to address all the time that SoCs can do their
> own thing - I'll cover that below.

Right, and to some extent I believe Jeremy's patch helps and the
device-tree stuff on top of it has the potential to help even more.

> You really would not want the weight of the OMAP implementation on
> something like Versatile.

Possibly yes, I'm not familiar enough here to really take a stance.

> Now we come to another problem: Versatile is one of the relatively simple
> implementations.  It's not a "real" platform in the sense that it's a
> development board with a fairly fixed clock relationship - most clocks
> are fixed, only some are variable.  It only represents the simple SoCs
> like PXA, where the only real control you have is being able to turn
> clocks on and off. Apart from the LCD clock, there's not much other
> control there.
> 
> Modern SoCs are far more complex beasts, with PLLs, dividers, muxes
> and so forth - both Samsung S3C and TI OMAP SoCs are good examples of
> these.
> 
> Basically, there are three classes when it comes to SoC clocks:
> 
> 1. damned simple, no control what so ever, just need rate info maybe
>    for one or two clocks, eg SA1100, LH7A40x, NETX.
> 2. fixed set of clocks, where the clocks can be turned on/off to
>    logical sections of the CPU - eg, PXA, W90X900 etc.
> 3. complex setups which have a tree of clocks, with muxes, dividers,
>    plls etc (Samsung, OMAP).
> 
> Trying to get a generic implementation which only addresses some of
> those classes is, I believe, very misguided.  Maybe instead we should
> be aiming for two or three "common" implementations rather than trying
> for a one-size-fits-only-a-small-subset approach?

I don't think Jeremy (again he will have to confirm) is aiming toward a
common implementation of the entire clock subsystem. The idea is that
the struct clk is a clock object. You can have many struct clk, they can
have many different capabilities and features. What the patch tries to
do is purely to get the clk_* API -> struct clk part (aka where do you
get the function pointers) common. That way, a platform can indeed
provide a variety of very different clocks with different capabilities
using the same basic infrastructure to expose them.

> I don't buy the "don't use it on those platforms then" argument -
> because that means not using it on the platforms which are the likely
> places people brought up the concerns on - the PXA/Samsung/OMAP types
> of platforms.

The "don't use on those platforms" arguemnt was mostly aimed at
platforms that don't want the overhead of function pointers at all.

My point is that once you have function pointers, aka, different clock
sources with different methods for enable/disable/set_rate/..., then it
make sense to try to have at least the API part of it common, and leave
the differences to the implementation, aka, to what the clock provider
actually instanciate when clk_get() is called.

Look at it that way: struct clk is the base class that provides the
standard API methods. clk_get() returns an instance of a subclass that
can be a larger structure with all sort of SoC specific bits in it, but
at least how to go from struct clk to the ->enable() method is well
defined.

The way I thought of it initially is that clk_get() goes to the platform
which is ultimately responsible for giving out the right clock object.
It may or may not use the device-tree, if it does, then the DT provides
it with a link to a clock provider object which has its own clk_get()
and creates the struct clk & returns it, though it doesn't have to do
so.

Cheers,
Ben.
