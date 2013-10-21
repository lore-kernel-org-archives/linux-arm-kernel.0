From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Oct 2013 10:32:42 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131020231134.GR25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
Message-ID: <20131021083242.GB30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 12:11:34AM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> > The only thing we've really moved out of the kernel is the exact IDs of
> > which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
> > simple stuff not the hard stuff. The code hasn't really been simplified
> > by DT - if anything, it's more complicated since we now have to parse
> > those values from DT rather than putting them into simple data-structures.
> 
> Here's my random thoughts this evening on DT, orientated mostly on a
> problem area I've been paying attention to recently.
> 
> In some ways, DT has made things much harder.  I don't know whether
> you've taken a look at DRM and the various drivers we have under there,
> it's quite a mess of unreliable code which is trying to bend the DRM
> card based model to a DT based multi-device component based description
> with lots of sub-drivers.
> 
> What DRM currently expects is a certain initialisation order: the main
> drm_device structure is created by the DRM code, and then supplied to
> the DRM driver to populate all the different parts of the "DRM card".
> 
> Once all parts of the card have been setup (the CRTCs, encoders,
> connectors, etc) then some helpers can be initialised.  Once the
> helpers have been initialised, the "dimensions" of the "DRM card"
> become rather fixed until the helper is torn down.
> 
> The problem is this: if you have a multi-driver based card, there is
> no way to prevent any of those sub-drivers from being unbound from
> their drivers at any time.  module refcounts don't save you from this.
> Meanwhile, (at the moment) you can't half-tear down a "DRM card" and
> have it still in a usable state.  The internals just don't allow for
> it at present.
> 
> Yes, work can be put in to solve this problem, but it's being solved
> because of a desire to bend the subsystem to the DT way of doing things.
> That may or may not be the best idea.  However, what I do know is that
> there is now great pressure to "bend stuff so that it works with DT
> at all costs".  Evidence is the Exynos driver and the imx-drm driver.

In fact it was the other way round. We modeled the IPU devicetree
binding after the hardware and bended the driver around it. The DRM
single-card model is the limiting fator here, not the devicetree.

> 
> Now, the flip side to this is that some DRM solutions include an I2C
> device, which is itself a separate driver, and would appear to suffer
> from this same problem.  This is handled via the drm_encoder_slave
> infrastructure.  As it currently is written (ignoring DT) it get
> around the problem by not actually using the driver model "properly".
> If it were to, it would run into this same problem.

Indeed. The drm_encoder_slave stuff depends on the I2C bus driver being
compiled into the kernel. Once the I2C bus driver is modular and the DRM
driver is not it won't work anymore. The drm_encoder_slave only works
properly for PCI/AGP cards which have their own I2C bus master on the
card (which is implemented by the same monolithic DRM driver).

> 
> How would we sort this out pre-DT?  We'd pass a chunk of platform data
> into a driver to describe the various options: eg, whether we wanted
> HDMI output, the I2C bus details of the DDC bus, etc., which results
> in a simpler solution - though traditionally a driver specific solution.
> 
> However, "driver specific solution" is bad - always has been.  What was
> missed is that the platform datas should never have been specific to
> any particular device.  They should have been class specific.  I tried
> to do that with flash_platform_data for example - some people got the
> idea, but the vast majority didn't.

The problem probably was that most people (including me) were simply not
aware of the idea to have class specific platform data.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
