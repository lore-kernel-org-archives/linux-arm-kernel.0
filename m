From: tpiepho@impinj.com (Trent Piepho)
Date: Fri, 3 Nov 2017 17:53:59 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
Message-ID: <1509731639.5473.60.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-11-02 at 15:14 +0000, Mark Brown wrote:
> On Tue, Oct 31, 2017 at 04:57:42PM +0000, Trent Piepho wrote:
> > On Tue, 2017-10-31 at 11:19 +0000, Mark Brown wrote:
> > > Do the native chip selects actually work usefully on this hardware?
> > > There used to be problems with it wanting to do things like bounce the
> > > chip select on every word which made it extremely difficult to use with
> > > Linux.
> > Still are annoying, but on the device we have connected to it, it ends
> > up working as desired.
> > I've not thoroughly investigated this hardware to find the details. 
> > IIRC, the designware SPI on Altera SoCFPGA had the same issue, but it
> > was a flaw in the driver and I was able to fix it.  I've come to expect
> > it, as every new SPI master I use doesn't work properly in some
> > different way.
> 
> It's one of the reasons why I'm suspicous of making the GPIO optional,
> lots of chips use GPIO chipselects because a lot of the breakage is
> confined to chip select handling and I remember the i.MX as being
> especially far from useful.

Just to be clear, one doesn't need to use GPIOs with the driver as is. 
But the bindings to do that are non-standard and these patches make the
driver follow the standard. (and don't break anyone).

It's unfortunate that this, and in my experience every, SPI master
doesn't always (or ever) generate the waveforms it should according to
the Linux API.  But I don't think not following the specification for
the device tree bindings is a mitigation of this.  If anything, it just
creates more problems.

As someone who has done bringup a more than a few devices, I know what
I want the hardware to do, and I know the proper bindings to do that. 
But someone comes back and says they don't work and now I need to dig
into the driver source and figure out what its particular flavor of
non-standard behavior is.  I don't think that helped me any.  It didn't
tell what the hardware/driver's quirks are w.r.t. ability to follow the
Linux SPI API either.

This also happens after the hardware is designed and built, so it's a
little late to choose another pin.

If the goal is to document the hardware quirks, then shouldn't this be
done through documentation?  A note or pointer in the kconfig,
something in the source, a better description in Documention/
somewhere, etc.  That would have a better chance of being seen before
hardware is designed, and would explain the issue too, instead of just
appearing as another quirk in device tree bindings.

Also consider there is a lot of re-implemented code in each driver
relating to device tree parsing and also GPIO CS.  Non-standard
behavior in a driver doesn't help any refactoring effort.
