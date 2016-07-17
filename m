From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Jul 2016 22:41:35 +0200
Subject: [PATCH v0 06/10] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <alpine.DEB.2.11.1607170959090.19980@marmot.wormnet.eu>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <4290281.AD5Bhg23o6@wuerfel>
 <alpine.DEB.2.11.1607170959090.19980@marmot.wormnet.eu>
Message-ID: <6404488.GyOP57DJrV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 17, 2016 10:39:01 AM CEST Jamie Lentin wrote:
> On Sat, 16 Jul 2016, Arnd Bergmann wrote:

> > The other patches all appear good to me, but I find this one suspicious.
> >
> > Why are you not using the device tree for probing PCI? Is there anything
> > missing in drivers/pci/host/pci-mvebu.c, or do you just need help
> > describing it in DT?
> 
> Unlike the other SoC's supported by pci-mvebu.c, orion5x has one PCI port 
> as well as a PCIe port. Given no other orion5x boards seem to use 
> pci-mvebu, I'm assuming there's work to be done before the PCI port can be 
> used via. pci-mvebu.c
> 
> This is something I can look into if there aren't patches out there, but 
> wanted to get the rest into a reasonable state first.

Ok, I see your point. However, we also don't have any other Orion5x machines
using DT that rely on old probe method, and I this is something that
is particularly hard to retrofit later.

I would assume that the PCIe port should work out of the box with the driver
we have, but the PCI controller does not, and it will require some work.
Looking at https://wiki.openwrt.org/toh/netgear/wnr854t, I assume that
you want only PCI but not PCIe, correct?

The good news is that we can completely separate the two, we just have two
different PCI domains if both are enabled, so we just need to add a new
driver for the PCI port to drivers/pci/host. The pci_ops can be copied
from the existing driver, although a couple of minor cleanups would be
possible. The special handling of bus numbers and the rc_pci_fixup()
can probably just go away, and the latter part is particularly
important, because building a kernel with the fixup included might
break any system with a Marvell host bridge.

We also don't seem to need any MBUS window setup for the I/O and
memory spaces, which greatly simplifies the driver compared to the
pci-mvebu one, it would be a fairly straightforward implementation
based on pci-host-generic.c (which unfortunately just got way
more complicated and might need to go on a diet).

	Arnd
