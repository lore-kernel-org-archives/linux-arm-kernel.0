From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Tue, 29 Mar 2016 08:15:42 -0400
Subject: [PATCH V3 1/3] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <147496989.L43SVC7xRY@wuerfel>
References: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
 <98854818.NJS35fvhsb@wuerfel>
 <e736f6bc775cdca8a4bb0dab20654823@codeaurora.org>
 <147496989.L43SVC7xRY@wuerfel>
Message-ID: <8f766d081b33d91f196e7bd5e13b6f33@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-29 07:25, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 06:59:15 okaya at codeaurora.org wrote:
>> On 2016-03-29 05:25, Arnd Bergmann wrote:
>> > On Monday 28 March 2016 09:35:22 Sinan Kaya wrote:
>> >> The code is using the compatible DT string to associate a reset driver
>> >> with
>> >> the actual device itself. The compatible string does not exist on ACPI
>> >> based systems. HID is the unique identifier for a device driver
>> >> instead.
>> >> The change allows a driver to register with DT compatible string or
>> >> ACPI
>> >> HID and then match the object with one of these conditions.
>> >>
>> >> Rules for loading the reset driver are as follow:
>> >> - ACPI HID needs match for ACPI systems
>> >> - DT compat needs to match for OF systems
>> >>
>> >> Tested-by: Eric Auger <eric.auger@linaro.org> (device tree only)
>> >> Tested-by: Shanker Donthineni <shankerd@codeaurora.org> (ACPI only)
>> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> >>
>> >
>> >
>> > This really feels wrong for two reasons:
>> >
>> > * device assignment of non-PCI devices is really special and doesn't
>> >   seem to make sense on general purpose servers that would be the
>> > target
>> >   for ACPI normally
>> 
>> 
>> Why is it special? Acpi is not equal to pci. Platform devices are 
>> first
>> class devices too. Especially, _cls was introduced for this reason.
> 
> It still feels like a hack. The normal design for a server is to have
> all internal devices show up on the PCI host bridge, next to the PCIe
> ports, to have a simple way to manage any device, both internal and
> off-chip. Putting a device on random MMIO registers outside of the
> discoverable buses and have the firmware work around the lack of
> discoverability will always be inferior.
> 

It is a HW implementation choice. Having everything as pci problem has 
been already solved. I would vote for it when we had SW pci bridge layer 
just to use usb and sata. Not anymore. Especially, _cls solves this 
problem



>> >
>> > * If there is indeed a requirement for ACPI to handle something like
>> > this,
>> >   it should be part of the ACPI spec, with a well-defined method of
>> > handling
>> >   reset, rather than having to add a device specific hack for each
>> >   device separately.
>> >
>> 
>> I see. Normally, this is done by calling _rst method. AFAIK, Linux
>> doesn?t support _rst. I can check its presence and call it if it is
>> there.
> 
> Yes, that sounds reasonable: In patch 2 where you check for the
> presence of the reset method, just keep the existing logic for
> DT based systems, and use _rst on ACPI based systems instead,
> then you can drop both patches 1 and 3.
> 

I can certainly drop patch #3 and push the reset responsibility to acpi.

I never liked having a fragmented sw design across multiple drivers.

I need something for patch #1. Compatible is a DT property not ACPI.but 
then, I won't have a reset driver anymore.

If we think about how vfio pci works, we pass the pci vendor and device 
id to new_id file to find out which pci device needs to be pass thru.

I can go to a similar route. This time we pass the object id through 
new_id and I call reset method on this object.

Let me know what you think?

> 	Arnd
