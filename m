From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 14:44:20 +0200
Subject: [PATCH V3 1/3] vfio,
 platform: add support for ACPI while detecting the reset driver
In-Reply-To: <8f766d081b33d91f196e7bd5e13b6f33@codeaurora.org>
References: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
 <147496989.L43SVC7xRY@wuerfel>
 <8f766d081b33d91f196e7bd5e13b6f33@codeaurora.org>
Message-ID: <4981390.J9tsJr16lM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 08:15:42 okaya at codeaurora.org wrote:
> >> >
> >> > * If there is indeed a requirement for ACPI to handle something like
> >> > this,
> >> >   it should be part of the ACPI spec, with a well-defined method of
> >> > handling
> >> >   reset, rather than having to add a device specific hack for each
> >> >   device separately.
> >> >
> >> 
> >> I see. Normally, this is done by calling _rst method. AFAIK, Linux
> >> doesn?t support _rst. I can check its presence and call it if it is
> >> there.
> > 
> > Yes, that sounds reasonable: In patch 2 where you check for the
> > presence of the reset method, just keep the existing logic for
> > DT based systems, and use _rst on ACPI based systems instead,
> > then you can drop both patches 1 and 3.
> > 
> 
> I can certainly drop patch #3 and push the reset responsibility to acpi.
> 
> I never liked having a fragmented sw design across multiple drivers.
> 
> I need something for patch #1. Compatible is a DT property not ACPI.but 
> then, I won't have a reset driver anymore.
> 
> If we think about how vfio pci works, we pass the pci vendor and device 
> id to new_id file to find out which pci device needs to be pass thru.
> 
> I can go to a similar route. This time we pass the object id through 
> new_id and I call reset method on this object.
> 
> Let me know what you think?

It would certainly be nice to make it work more like PCI VFIO does
here, where you can assign any device as long as it has an IOMMU
(and a _rst method in this case).

	Arnd
