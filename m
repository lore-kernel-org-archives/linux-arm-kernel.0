From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Oct 2012 13:46:42 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <50881B19.3080609@wwwdotorg.org>
Message-ID: <Pine.LNX.4.44L0.1210241329230.1282-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2012, Stephen Warren wrote:

> > How do we determine which existing drivers claim to support usb-ehci?  
> > A quick search under arch/ and drivers/ turns up nothing but
> > drivers/usb/host/ehci-ppc-of.c.  Changing it to a more HW-specific
> > match should be easy enough, and then "usb-ehci" would be safe to use
> > in ehci-platform.c.
> 
> It's not drivers that claim to support usb-ehci, but device tree files
> that contain nodes that include "usb-ehci" in their compatible value,
> yet need to be handled by a driver that isn't the generic USB EHCI
> driver, and that driver binds to the other more specific compatible value:
> 
> > $ grep -HrnI usb-ehci arch/*/boot/dts
> > arch/arm/boot/dts/spear3xx.dtsi:76:			compatible = "st,spear600-ehci", "usb-ehci";
> > arch/arm/boot/dts/at91sam9x5.dtsi:399:			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> > arch/arm/boot/dts/spear13xx.dtsi:145:			compatible = "st,spear600-ehci", "usb-ehci";
> > arch/arm/boot/dts/spear13xx.dtsi:152:			compatible = "st,spear600-ehci", "usb-ehci";
> > arch/arm/boot/dts/tegra20.dtsip:215:		compatible = "nvidia,tegra20-ehci", "usb-ehci";
> > arch/arm/boot/dts/tegra20.dtsip:224:		compatible = "nvidia,tegra20-ehci", "usb-ehci";
> > arch/arm/boot/dts/tegra20.dtsip:232:		compatible = "nvidia,tegra20-ehci", "usb-ehci";
> > arch/arm/boot/dts/spear600.dtsi:88:			compatible = "st,spear600-ehci", "usb-ehci";
> > arch/arm/boot/dts/spear600.dtsi:96:			compatible = "st,spear600-ehci", "usb-ehci";
> > arch/arm/boot/dts/at91sam9g45.dtsi:392:			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> > arch/powerpc/boot/dts/sequoia.dts:156:			compatible = "ibm,usb-ehci-440epx", "usb-ehci";
> > arch/powerpc/boot/dts/wii.dts:120:			compatible = "nintendo,hollywood-usb-ehci",
> > arch/powerpc/boot/dts/wii.dts:121:					"usb-ehci";
> > arch/powerpc/boot/dts/canyonlands.dts:167:			compatible = "ibm,usb-ehci-460ex", "usb-ehci";
> 
> and then search for all those other compatible values in drivers. The
> ARM instances certainly all have this issue (although perhaps it's worth
> investigating if a generic could work for them instead). The PPC
> instances need more investigation; the values don't show up in of match
> tables but rather in code.

Ah, now I'm starting to get the picture.

So by listing "usb-ehci" in its device ID table, a driver would
essentially be saying that it can handle _all_ USB EHCI controllers.  
(Which means that the entry in ehci-ppc-of.c is questionable; perhaps
the intention is that this driver really does handle all EHCI
controllers on any PPC-based OpenFirmware platform bus.)

> This doesn't continue forever though; you typically only list the
> specific HW model, the base specific model it's compatible with, and any
> generic value needed. So, a hypothetical Tegra40 EHCI controller would be:
> 
> compatible = "nvidia,tegra40-ehci", "nvidia,tegra20-ehci", "usb-ehci".

What's the reason for listing the generic value if drivers can't key
off it?  Does it contain any information that's not already present in 
the specific values?

It sounds like the ehci-platform driver should simply list all the
specific HW device types (or base HW device types) that it handles, and
it shouldn't include "usb-ehci" in the list.  As more DT board files
are created or as ehci-platform becomes capable to taking over from
other drivers, its device list would grow.

And it sounds like the only property we really need to add to the 
usb-ehci binding at the moment is "has-tt".

Alan Stern
