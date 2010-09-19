From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Sep 2010 16:02:43 +0100
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <201009191639.44488.arnd@arndb.de>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009161912.12330.arnd@arndb.de>
	<4C961906.4040303@compulab.co.il>
	<201009191639.44488.arnd@arndb.de>
Message-ID: <20100919150242.GD9098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 19, 2010 at 04:39:44PM +0200, Arnd Bergmann wrote:
> On Sunday 19 September 2010 16:07:02 Mike Rapoport wrote:
> > As far as I understand, the IO space should be mapped prior to use and __io 
> > should return the virtual address.
> 
> That's right. You already map all the PCI registers including the I/O port
> mapping at initialization time, but you must not attempt to access these
> during boot before that time.

Yes.  __io() takes the IO port address, and returns a virtual address
for the inb() et.al. macros to deference to perform the actual access.

So, for example if you have a PCI serial card inserted which appears at
0x3f8, then inb(0x3f8) should access the first register on the PCI serial
card.  As inb(0x3f8) equates to __raw_readb(__io(0x3f8)), __io(0x3f8)
must return the virtual address to access that port.

Eg, on DC21285 (footbridge) systems, the PCI IO window is at 0x7c000000
physical, mapped into 0xff000000 virtual.  So __io(0x3f8) translates to
0xff0003f8 virtual, which hits 0x7c0003f8 physical, and 0x3f8 as an IO
access on the PCI bus.

Things become a little more complicated when you have PCMCIA cards with
separate IO regions, as on SA11x0 and PXA systems.  These don't tend to
have PCI, so we adopted there to have __io() do a 1:1 translation, and
arrange for the "bus IO" address to be the actual virtual address.
