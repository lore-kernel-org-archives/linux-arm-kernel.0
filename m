From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Oct 2012 10:45:13 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210241233040.1282-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210241233040.1282-100000@iolanthe.rowland.org>
Message-ID: <50881B19.3080609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 10:38 AM, Alan Stern wrote:
> On Wed, 24 Oct 2012, Stephen Warren wrote:
> 
>> On 10/24/2012 09:26 AM, Sebastian Andrzej Siewior wrote:
>>> On Wed, Oct 24, 2012 at 10:57:00AM -0400, Alan Stern wrote:
>>>> Under the circumstances, do we really need a new binding document for 
>>>> the ehci-platform driver?
>>
>> It seems reasonable to add the new properties to usb-ehci.txt, since
>> they do describe the HW.
>>
>>>> We should be able to use the existing 
>>>> usb-ehci binding, perhaps with some new properties added:
>>>>
>>>> 	has-synopsys-hc-bug
>>>> 	no-io-watchdog
>>>> 	has-tt
>>
>> That sounds fine to me.
>>
>> However, there is an implementation issue here. I believe the way Linux
>> searches for a driver for a particular node is:
>>
>> for every driver that's registered
>>     if the driver's supported compatible list matches the device
>>         use the driver
>>
>> (See drivers/base/platform.c:platform_match() which implements the if
>> statement above, and I assume the driver core implements the outer for
>> loop above)
> 
> Yes, it does.
> 
>> That means that if the generic driver supports compatible="usb-ehci", it
>> may "steal" device nodes that have
>> compatible="something-custom","usb-ehci", even if there's a driver
>> specifically for "something-custom". We would need to re-arrange the
>> driver matching code to:
>>
>> for each compatible value in the node:
>>     for each driver that's registered:
>>         if the driver supports the compatible value:
>>             use the driver.
> 
> Which might be difficult since the inner loop would be controlled by
> the outer code in the driver core.
> 
> How do we determine which existing drivers claim to support usb-ehci?  
> A quick search under arch/ and drivers/ turns up nothing but
> drivers/usb/host/ehci-ppc-of.c.  Changing it to a more HW-specific
> match should be easy enough, and then "usb-ehci" would be safe to use
> in ehci-platform.c.

It's not drivers that claim to support usb-ehci, but device tree files
that contain nodes that include "usb-ehci" in their compatible value,
yet need to be handled by a driver that isn't the generic USB EHCI
driver, and that driver binds to the other more specific compatible value:

> $ grep -HrnI usb-ehci arch/*/boot/dts
> arch/arm/boot/dts/spear3xx.dtsi:76:			compatible = "st,spear600-ehci", "usb-ehci";
> arch/arm/boot/dts/at91sam9x5.dtsi:399:			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> arch/arm/boot/dts/spear13xx.dtsi:145:			compatible = "st,spear600-ehci", "usb-ehci";
> arch/arm/boot/dts/spear13xx.dtsi:152:			compatible = "st,spear600-ehci", "usb-ehci";
> arch/arm/boot/dts/tegra20.dtsip:215:		compatible = "nvidia,tegra20-ehci", "usb-ehci";
> arch/arm/boot/dts/tegra20.dtsip:224:		compatible = "nvidia,tegra20-ehci", "usb-ehci";
> arch/arm/boot/dts/tegra20.dtsip:232:		compatible = "nvidia,tegra20-ehci", "usb-ehci";
> arch/arm/boot/dts/spear600.dtsi:88:			compatible = "st,spear600-ehci", "usb-ehci";
> arch/arm/boot/dts/spear600.dtsi:96:			compatible = "st,spear600-ehci", "usb-ehci";
> arch/arm/boot/dts/at91sam9g45.dtsi:392:			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
> arch/powerpc/boot/dts/sequoia.dts:156:			compatible = "ibm,usb-ehci-440epx", "usb-ehci";
> arch/powerpc/boot/dts/wii.dts:120:			compatible = "nintendo,hollywood-usb-ehci",
> arch/powerpc/boot/dts/wii.dts:121:					"usb-ehci";
> arch/powerpc/boot/dts/canyonlands.dts:167:			compatible = "ibm,usb-ehci-460ex", "usb-ehci";

and then search for all those other compatible values in drivers. The
ARM instances certainly all have this issue (although perhaps it's worth
investigating if a generic could work for them instead). The PPC
instances need more investigation; the values don't show up in of match
tables but rather in code.
