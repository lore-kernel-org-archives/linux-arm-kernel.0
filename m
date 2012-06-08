From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Jun 2012 12:20:40 +0200
Subject: mach/io.h cleanup and removal question
Message-ID: <20120608102040.GA26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

Your patchset for mach/io.h cleanup and remove, causes problems on
Orion5x.

mach/io.h for orion5x had a:

#define IO_SPACE_LIMIT		0xffffffff

which got removed. This results in a panic at boot:

        /*
         * IORESOURCE_IO
         */
        sys->io_offset = 0;
        res[0].name = "PCIe I/O Space";
        res[0].flags = IORESOURCE_IO;
        res[0].start = ORION5X_PCIE_IO_BUS_BASE;
        res[0].end = res[0].start + ORION5X_PCIE_IO_SIZE - 1;
        if (request_resource(&ioport_resource, &res[0]))
                panic("Request PCIe IO resource failed\n");

ORION5X_PCIE_IO_SIZE is 1MB, so the allocation fails because of the
64K default.

arch/arm/include/asm/io.h has the comment:

/*
 * This is the limit of PC card/PCI/ISA IO space, which is by default
 * 64K if we have PC card, PCI or ISA support.  Otherwise, default to
 * zero to prevent ISA/PCI drivers claiming IO space (and potentially
 * oopsing.)
 *
 * Only set this larger if you really need inb() et.al. to operate over
 * a larger address space.  Note that SOC_COMMON ioremaps each sockets
 * IO space area, and so inb() et.al. must be defined to operate as per
 * readb() et.al. on such platforms.
 */

Now, i know nothing about how PCI works... So i have a question:

Which is better, put back parts of io.h so allowing the 1MB
request_resource, or reduce ORION5X_PCIE_IO_SIZE to 64KB, since from
the comment it is unlikely an PCI card needs more than 64KB?

    Thanks
	Andrew
