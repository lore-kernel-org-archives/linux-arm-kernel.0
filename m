From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Mar 2014 11:13:11 +0100
Subject: [PATCH v2] ARM: dts: imx6qdl-sabresd.dtsi: Add red led
In-Reply-To: <20140305193925.GY21483@n2100.arm.linux.org.uk>
References: <20140305062216.GI8784@S2101-09.ap.freescale.net>
 <1394007383-21874-1-git-send-email-vincent.stehle@freescale.com>
 <20140305114223.GN8784@S2101-09.ap.freescale.net>
 <20140305193925.GY21483@n2100.arm.linux.org.uk>
Message-ID: <20140306101311.GZ17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 07:39:26PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 05, 2014 at 07:42:28PM +0800, Shawn Guo wrote:
> > It's not a hog pin, so shouldn't be added here.  (Right, most of the
> > existing pins shouldn't be here from the beginning)
> 
> On the subject of that kind of thing... I have an issue with the existing
> pinmux stuff.  This is a wider issue than your discussion above...
> 
> I regard the idea of requiring the pinmux to be configured as part of
> the driver probe a rather broken concept - yes, it makes sense in some
> scenarios, but for the vast majority of cases, it doesn't.
> 
> Let's take an example.  A pin is wired to a SPDIF transceiver.  The
> out-of-reset SoC configuration results in the pin turning the LED on
> in the SPDIF transceiver.
> 
> With the way stuff is setup, with the driver having the pinmux settings
> for itself, the point at which that pin gets configured is when the
> driver loads, which may be a module - so that can happen quite late in
> the boot sequence.  A failure to boot can result in it not happening at
> all.
> 
> So, this brings up the obvious question: is this proper behaviour of the
> hardware, or is this something we should do better with - such as where
> we know what the settings should be for a platform, and these settings
> never change, we arrange for that to happen at kernel boot time as a
> once-off.
> 
> For example, in the above case, we know it's board XYZ, we know that this
> pin is connected to the SPDIF transceiver, so maybe we should configure
> it early on in the boot sequence whether or not the driver has been
> configured and/or loaded.

I have a similar case here on my desk. Our customer provided us a
complete list of pinmux and drive strength settings which must just be
written into registers. It's very convenient to skip the entire kernel
pinmux setup. With the driver core setting up the pins this is easily
possible, we only have to skip the pinctrl nodes from the devices.
The only exception currently is the imx-esdhci which manually tries
to setup its pinmux.

So with the current pinctrl stuff it's possible to do pinctrl completely
in the bootloader or as Shawn suggested, you can also put it in the hog
group.

Maybe we just have to state somewhere that doing so is not just a
byproduct but instead can and should be done if necessary.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
