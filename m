From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Oct 2012 12:09:49 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210241329230.1282-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210241329230.1282-100000@iolanthe.rowland.org>
Message-ID: <50882EED.9020200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 11:46 AM, Alan Stern wrote:
> On Wed, 24 Oct 2012, Stephen Warren wrote:
> 
>>> How do we determine which existing drivers claim to support usb-ehci?  
>>> A quick search under arch/ and drivers/ turns up nothing but
>>> drivers/usb/host/ehci-ppc-of.c.  Changing it to a more HW-specific
>>> match should be easy enough, and then "usb-ehci" would be safe to use
>>> in ehci-platform.c.
>>
>> It's not drivers that claim to support usb-ehci, but device tree files
>> that contain nodes that include "usb-ehci" in their compatible value,
>> yet need to be handled by a driver that isn't the generic USB EHCI
>> driver, and that driver binds to the other more specific compatible value:
>>
>>> $ grep -HrnI usb-ehci arch/*/boot/dts
...
>> and then search for all those other compatible values in drivers. The
>> ARM instances certainly all have this issue (although perhaps it's worth
>> investigating if a generic could work for them instead). The PPC
>> instances need more investigation; the values don't show up in of match
>> tables but rather in code.
> 
> Ah, now I'm starting to get the picture.
> 
> So by listing "usb-ehci" in its device ID table, a driver would
> essentially be saying that it can handle _all_ USB EHCI controllers.  

Yes, exactly.

> (Which means that the entry in ehci-ppc-of.c is questionable; perhaps
> the intention is that this driver really does handle all EHCI
> controllers on any PPC-based OpenFirmware platform bus.)

Yes, that seems questionable, although perhaps within the context of
only enabling the driver on PPC specifically, it may be reasonable.

>> This doesn't continue forever though; you typically only list the
>> specific HW model, the base specific model it's compatible with, and any
>> generic value needed. So, a hypothetical Tegra40 EHCI controller would be:
>>
>> compatible = "nvidia,tegra40-ehci", "nvidia,tegra20-ehci", "usb-ehci".
> 
> What's the reason for listing the generic value if drivers can't key
> off it?  Does it contain any information that's not already present in 
> the specific values?

This may or may not be a mistake.

The idea is that usb-ehci is included in the device node's compatible
list iff the HW is 100% compatible with a "usb-ehci" HW device, and
hence a pure usb-ehci driver can handle the hardware without any
additional knowledge. (That's true in general for any compatible value).

It's quite possible that this often gets translated to the subtly
different "the HW is an EHCI controller, so it gets
compatible="usb-ehci"" when writing .dts files.

So yes we probably should remove compatible="usb-ehci" from any device
node for HW which really isn't a pure EHCI device. That would presumably
require looking at the existing custom drivers and/or HW specs to
determine what, if anything, is different about the HW.

Related, at least on Tegra, the PHY handling is IIRC pretty tightly
coupled into the EHCI driver. We probably should have separate nodes
for, and drivers for, the PHYs instead. I don't know if that would
remove all the non-standard attributes of the Tegra EHCI HW and hence
allow Tegra's EHCI to be handled by the generic driver. From memory,
there are certainly some HW workarounds in the Tegra EHCI driver that
would need to be ported though.

> It sounds like the ehci-platform driver should simply list all the
> specific HW device types (or base HW device types) that it handles, and
> it shouldn't include "usb-ehci" in the list.  As more DT board files
> are created or as ehci-platform becomes capable to taking over from
> other drivers, its device list would grow.

That's certainly a reasonable way to go too. I think the only downside
with that approach is that every new device needs a kernel update to add
it to the table, whereas using a generic compatible="usb-ehci" wouldn't,
assuming no quirks were required for the new device.
