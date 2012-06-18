From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Jun 2012 09:59:45 +0200
Subject: mach/io.h cleanup and removal question
In-Reply-To: <4FD207C9.5010006@gmail.com>
References: <20120608102040.GA26034@lunn.ch>
 <20120608114316.GC15555@n2100.arm.linux.org.uk>
 <4FD207C9.5010006@gmail.com>
Message-ID: <20120618075945.GJ4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 09:10:17AM -0500, Rob Herring wrote:
> On 06/08/2012 06:43 AM, Russell King - ARM Linux wrote:
> > On Fri, Jun 08, 2012 at 12:20:40PM +0200, Andrew Lunn wrote:
> >> Your patchset for mach/io.h cleanup and remove, causes problems on
> >> Orion5x.
> >>
> >> mach/io.h for orion5x had a:
> >>
> >> #define IO_SPACE_LIMIT		0xffffffff
> >>
> >> which got removed. This results in a panic at boot:
> >>
> >>         /*
> >>          * IORESOURCE_IO
> >>          */
> >>         sys->io_offset = 0;
> >>         res[0].name = "PCIe I/O Space";
> >>         res[0].flags = IORESOURCE_IO;
> >>         res[0].start = ORION5X_PCIE_IO_BUS_BASE;
> >>         res[0].end = res[0].start + ORION5X_PCIE_IO_SIZE - 1;
> >>         if (request_resource(&ioport_resource, &res[0]))
> >>                 panic("Request PCIe IO resource failed\n");
> >>
> >> ORION5X_PCIE_IO_SIZE is 1MB, so the allocation fails because of the
> >> 64K default.
> >>
> >> arch/arm/include/asm/io.h has the comment:
> >>
> >> /*
> >>  * This is the limit of PC card/PCI/ISA IO space, which is by default
> >>  * 64K if we have PC card, PCI or ISA support.  Otherwise, default to
> >>  * zero to prevent ISA/PCI drivers claiming IO space (and potentially
> >>  * oopsing.)
> >>  *
> >>  * Only set this larger if you really need inb() et.al. to operate over
> >>  * a larger address space.  Note that SOC_COMMON ioremaps each sockets
> >>  * IO space area, and so inb() et.al. must be defined to operate as per
> >>  * readb() et.al. on such platforms.
> >>  */
> >>
> >> Now, i know nothing about how PCI works... So i have a question:
> >>
> >> Which is better, put back parts of io.h so allowing the 1MB
> >> request_resource, or reduce ORION5X_PCIE_IO_SIZE to 64KB, since from
> >> the comment it is unlikely an PCI card needs more than 64KB?
> > 
> > Well, the comment about SOC_COMMON doesn't apply as you're not using that.
> > 
> > Probably shrinking ORION5X_PCIE_IO_SIZE to 64K, unless we really have a
> > requirement to support a larger IO space.
> 
> Agreed. The next step is moving all i/o space to a fixed virtual address
> and for this we want to make i/o windows 64K.

Hi Rob

Reducing the window size to 64K stops the panic at boot, as expected.

> 
> However, I think you may also have a problem with
> ORION5X_PCIE_IO_BUS_BASE and the resource start. The i/o resource start
> should really be 0 and then the __io() macro should add the virtual i/o
> base address. However, Russell has mentioned previously that some chips
> may not work correctly with i/o space at 0 (PCI bus addresses, not host).
> 
> Do you have cards with i/o that you can test or know what devices are
> used with this platform?

I don't have any cards. I've also no idea what cards are used with
these devices. I guess they are mostly WiFi cards, since Orion5x is
normally used in NAS boxes, and there is one box supported which is an
WiFi AP.

Since the panic kills all orion5x systems, i want to at least fix
that. So i will post the patch to reduce the window size to 64K.  I
guess for the moment we have to leave PCI potentially broken, and see
if anybody complains.

Is this O.K?

   Thanks
	Andrew
