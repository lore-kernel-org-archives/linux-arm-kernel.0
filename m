From: tpiepho@impinj.com (Trent Piepho)
Date: Fri, 3 Nov 2017 19:18:56 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
Message-ID: <1509736735.5473.87.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-11-03 at 18:37 +0000, Mark Brown wrote:
> On Fri, Nov 03, 2017 at 05:53:59PM +0000, Trent Piepho wrote:
> 
> > Just to be clear, one doesn't need to use GPIOs with the driver as is. 
> > But the bindings to do that are non-standard and these patches make the
> > driver follow the standard. (and don't break anyone).
> 
> If there are non-standard bindings then mark them as deprecated.  I
> can't immediately find *any* binding documentation for this controller.
> The last commit looks like it was more attempting to work round broken
> board bindings and do something sensible than add a new binding, at
> least that's what I remember my sense of it being.

The non-standard part is needing to add cs-gpios = <0> to get a native
chip select when that is documented as being optional.  It doesn't
follow the spec.  It doesn't match other drivers (and dw-spi is equally
as broken in the same manner, probably others too) that do follow the
spec.

> If the hardware is as broken as these controllers always were in the
> past and there are workarounds which work in all practical situations
> (AFAIK all the relevant SoCs permit GPIO usage on the chip select pins)

Comments in the driver indicate that some SoCs do not allow GPIO usage
on all chip select pins.

> documenting something as supported is just going to make people
> miserable.  The reason I know about this breakage is that I had to go
> through the process of working out that the native chip select support
> didn't work on a system.

I just don't see how not following the device tree binding
specification documents the hardware flaw, or how following the spec
documents that the flaw does not exist.

> > If the goal is to document the hardware quirks, then shouldn't this be
> > done through documentation?  A note or pointer in the kconfig,
> > something in the source, a better description in Documention/
> > somewhere, etc.  That would have a better chance of being seen before
> > hardware is designed, and would explain the issue too, instead of just
> > appearing as another quirk in device tree bindings.
> 
> Yes, better documentation would be great.

How about I add something to Documentation/spi and add a note in
Kconfig, but make the driver standard compliant in its device tree
bindings?

The goal here is that everyone doesn't have to stick a scope on the
board and re-discover that the native CS doesn't do what they want,
right? Been there, done that, and can appreciate the sentiment.

I don't think not following the standard is an effective way to do
that.  From a sample of three developers, two came up with dt bindings
to use native cs and decided they apparently misunderstood the spi dt
spec to explain why what should have worked did not.  The third (me)
looked into the driver source to find the why, and even then it wasn't
clear the behavior was intentional or an oversight.  I think
documenting the known flaws would be a better and more effective way to
get that information across.
