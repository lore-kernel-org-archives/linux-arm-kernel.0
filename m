From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Jun 2014 11:15:39 +0200
Subject: [PATCH v4 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <53A4A6C6.9000703@cogentembedded.com>
References: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
 <4490558.0d3xbrzEgW@wuerfel> <53A4A6C6.9000703@cogentembedded.com>
Message-ID: <4805472.0q1PyyoD4W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 June 2014 01:25:26 Sergei Shtylyov wrote:
> On 06/21/2014 01:10 AM, Arnd Bergmann wrote:

> >>> It also needs a device_type property.
> 
> >>      Hm, are you sure about that? I thought only PCI devices should have it...
> 
> > Yes, pretty sure it's needed in both the host controller and the
> > devices.
> 
>      I don't understand the case of the PCI devices, honestly. Shouldn't the 
> "device_type" prop reflect the device's functionality rather than the bus 
> where it's located?

It probably made more sense on real Open Firmware than it does on FDT, but
we're trying to follow the bindings anyway.

I believe the "device_type=pci" originally indicated a device that has
a readable config space (through the OF client interface), which is true
for both the host and the devices.

> >>> I realize that the driver doesn't currently use them, but you should
> >>> adhere to the binding anyway, so we can fix the driver at some point.
> 
> >>      Sigh, agreed about the need to fix the driver. Too bad you've spoken up
> >> only now though. And you've ACKed the DT bindings without those properties
> >> documented or even present in an example...
> 
> > Yes, I realized that too late as well, sorry about it. For some reason
> > I only looked at the interrupt-map being done right and forgot to
> > check the ranges.
> 
> > We definitely need to move the code handling the ranges into a common
> > location to avoid this mistake in the future.
> 
>     It is already in the common location, AFAIK; what's lacking there is the 
> code that parses "dma-ranges" as well but that should be pretty easy to add...

We have some common helpers for "ranges" parsing already, but we should
improve them so a driver has to do much less in the future.

For "dma-ranges", we still to write need most of the code. For platform
devices, we can now calculate the offset for the simple (no IOMMU) case,
but we still need to calculate the dma mask correctly (that part should
be simple, maybe you can help there as you have an immediate need),
and we need to handle the IOMMU and swiotlb cases better.

For PCI devices, we need to do all the same things we do for platform
devices, and we can probably share most of the code.

	Arnd
