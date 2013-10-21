From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Oct 2013 09:48:54 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131021083242.GB30088@pengutronix.de>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
Message-ID: <20131021084854.GV25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 10:32:42AM +0200, Sascha Hauer wrote:
> On Mon, Oct 21, 2013 at 12:11:34AM +0100, Russell King - ARM Linux wrote:
> > On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> > > The only thing we've really moved out of the kernel is the exact IDs of
> > > which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
> > > simple stuff not the hard stuff. The code hasn't really been simplified
> > > by DT - if anything, it's more complicated since we now have to parse
> > > those values from DT rather than putting them into simple data-structures.
> > 
> > Here's my random thoughts this evening on DT, orientated mostly on a
> > problem area I've been paying attention to recently.
> > 
> > In some ways, DT has made things much harder.  I don't know whether
> > you've taken a look at DRM and the various drivers we have under there,
> > it's quite a mess of unreliable code which is trying to bend the DRM
> > card based model to a DT based multi-device component based description
> > with lots of sub-drivers.
> > 
> > What DRM currently expects is a certain initialisation order: the main
> > drm_device structure is created by the DRM code, and then supplied to
> > the DRM driver to populate all the different parts of the "DRM card".
> > 
> > Once all parts of the card have been setup (the CRTCs, encoders,
> > connectors, etc) then some helpers can be initialised.  Once the
> > helpers have been initialised, the "dimensions" of the "DRM card"
> > become rather fixed until the helper is torn down.
> > 
> > The problem is this: if you have a multi-driver based card, there is
> > no way to prevent any of those sub-drivers from being unbound from
> > their drivers at any time.  module refcounts don't save you from this.
> > Meanwhile, (at the moment) you can't half-tear down a "DRM card" and
> > have it still in a usable state.  The internals just don't allow for
> > it at present.
> > 
> > Yes, work can be put in to solve this problem, but it's being solved
> > because of a desire to bend the subsystem to the DT way of doing things.
> > That may or may not be the best idea.  However, what I do know is that
> > there is now great pressure to "bend stuff so that it works with DT
> > at all costs".  Evidence is the Exynos driver and the imx-drm driver.
> 
> In fact it was the other way round. We modeled the IPU devicetree
> binding after the hardware and bended the driver around it. The DRM
> single-card model is the limiting fator here, not the devicetree.

There are several points which I think you failed to understand:

1. DRM vs device tree is an incompatibility.
2. Trying to bend DRM to DT with independent driver solutions such as
   the abomination that is imx-drm creates its own set of problems.

If a subsystem doesn't work well with DT, then the choices are either:

(a) don't use DT with the subsystem
(b) fix the subsystem

The choices do not include:

(c) creating an abomination that is fragile, and is trivially easy to
oops the kernel.

This comes back to the root problem I'm trying to highlight: we are not
trying to strive for DT forsaking everything else.  If moving to DT
means we give up with proper code design, then we've quite literally
lost the plot.

Honestly, I don't see imx-drm ever moving out of drivers/staging except
by deletion or being rewritten.
