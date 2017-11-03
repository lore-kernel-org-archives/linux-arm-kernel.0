From: tpiepho@impinj.com (Trent Piepho)
Date: Fri, 3 Nov 2017 20:09:19 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <20171103193649.jcoiy3raefikko2h@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
 <1509736735.5473.87.camel@impinj.com>
 <20171103193649.jcoiy3raefikko2h@sirena.co.uk>
Message-ID: <1509739759.5473.93.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-11-03 at 19:36 +0000, Mark Brown wrote:
> On Fri, Nov 03, 2017 at 07:18:56PM +0000, Trent Piepho wrote:
> > On Fri, 2017-11-03 at 18:37 +0000, Mark Brown wrote:
> > > If there are non-standard bindings then mark them as deprecated.  I
> > > can't immediately find *any* binding documentation for this controller.
> > > The last commit looks like it was more attempting to work round broken
> > > board bindings and do something sensible than add a new binding, at
> > > least that's what I remember my sense of it being.
> > The non-standard part is needing to add cs-gpios = <0> to get a native
> > chip select when that is documented as being optional.  It doesn't
> > follow the spec.  It doesn't match other drivers (and dw-spi is equally
> > as broken in the same manner, probably others too) that do follow the
> > spec.
> 
> Is there any documentation of the bindings for this driver at all?  I
> wasn't able to find it.

Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

Doesn't note anything special about the native chip selects.

> > > If the hardware is as broken as these controllers always were in the
> > > past and there are workarounds which work in all practical situations
> > > (AFAIK all the relevant SoCs permit GPIO usage on the chip select pins)
> > Comments in the driver indicate that some SoCs do not allow GPIO usage
> > on all chip select pins.
> 
> Ah, that's an issue.  We will need support for the hardware chip selects
> then.

And they are already supported too.  The issue I want to fix is the
need for non-standard bindings to use them.

> > > documenting something as supported is just going to make people
> > > miserable.  The reason I know about this breakage is that I had to go
> > > through the process of working out that the native chip select support
> > > didn't work on a system.
> > I just don't see how not following the device tree binding
> > specification documents the hardware flaw, or how following the spec
> > documents that the flaw does not exist.
> 
> Hardware chip selects aren't present in all controllers and at times
> have entertaining enumerations in the hardware, the details on them need
> to be covered in the device specific binding (which like I say seems to
> be missing for this controller).  If they just don't work well the
> kindest thing may be to not support them and document the binding that
> way.
> 
> > > Yes, better documentation would be great.
> > How about I add something to Documentation/spi and add a note in
> > Kconfig, but make the driver standard compliant in its device tree
> > bindings?
> 
> Writing a binding document for the controller would probably cover it.

Ok, I'll adjust the series to document the real issue.
