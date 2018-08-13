From: robh@kernel.org (Rob Herring)
Date: Mon, 13 Aug 2018 16:04:54 -0600
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180813181808.GA2357@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org>
Message-ID: <20180813220454.GA28913@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 08:18:08PM +0200, Sam Ravnborg wrote:
> Hi Nicholas.
> 
> On Mon, Aug 13, 2018 at 05:54:48PM +0200, Nicolas Ferre wrote:
> > On 12/08/2018 at 20:41, Sam Ravnborg wrote:
> > >New DRM based driver for at91sam9 SOC's that uses the
> > >Atmel LCDC IP core.
> > 
> > I'm delighted to see this work: Thanks a lot Sam!
> Glad to hear.
> I was a bit worried that the response would be "this is
> waste of time as we have a working driver already".
> 
> > 
> > >This is first version of a patch set that adds
> > >drivers for the Atmel LCDC IP core.
> > >Posted for review as the basics works now.
> > >
> > >The LCDC IP core contains two devices:
> > >- a PWM often used for backlight
> > >- a LCD display controller
> > >
> > >Both devices are supported today by the atmel_lcdfb driver.
> > >For this new set of drivers the compatible strings was
> > >selected to avoid clash with the existing compatible
> > >strings used for the atmel_lcdfb driver to allow them
> > >to co-exist.
> > 
> > Would be good to have a plan to phase-out the old atmel_lcdfb fbdev
> > driver when this one addresses some TODO items that make sense.
> Agree on this.
> One approach could be to say that when all in-kernel users of atmel_lcdfb
> are ported, then the old driver could be dropped after a kernel release.
> 
> > The mfd suffix seems strange to me. What about "atmel,at91sam9263-lcdc-mfd"
> > => "atmel,at91sam9263-lcd" (or "microchip,at91sam9263-lcdc").
> The "-mfd" suffix was added to avoid clashing with the current
> compatible string used by the atmel_lcdfb driver.

I don't know that 2 registers for a backlight PWM constitute an MFD. A 
single node can be both an LCD controller and a PWM.

The fact that the OS has 2 drivers is irrelevant to the binding and DT 
is not a way to select drivers. Your choice with Linux is either kconfig 
or manual module loading.

> I susggest we do the following:
> - use the microchip prefix, as this is now owned by microchip
> - and add the driver to a drm/microchip/ directory
> (Then we can only hope that microchip do not change name or
> are purchased by someone else).

I would not do that. Then you have a dts with a mixture based on when 
you got around to writing each binding. i.MX has continued using 'fsl' 
even on new chips today. Probably a good choice had the QCom acq had 
gone thru.

Rob
