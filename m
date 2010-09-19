From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Sep 2010 18:34:44 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <20100919150242.GD9098@n2100.arm.linux.org.uk>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009191639.44488.arnd@arndb.de>
	<20100919150242.GD9098@n2100.arm.linux.org.uk>
Message-ID: <201009191834.44928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 September 2010 17:02:43 Russell King - ARM Linux wrote:
> Eg, on DC21285 (footbridge) systems, the PCI IO window is at 0x7c000000
> physical, mapped into 0xff000000 virtual.  So __io(0x3f8) translates to
> 0xff0003f8 virtual, which hits 0x7c0003f8 physical, and 0x3f8 as an IO
> access on the PCI bus.
> 
> Things become a little more complicated when you have PCMCIA cards with
> separate IO regions, as on SA11x0 and PXA systems.  These don't tend to
> have PCI, so we adopted there to have __io() do a 1:1 translation, and
> arrange for the "bus IO" address to be the actual virtual address.

Such a mapping sounds dangerous when you have device drivers trying
to access legacy ISA ports. Most of them are disabled on ARM, but
some drivers are hard to disable.

More importantly, having PCI I/O port numbers above 65536 will confuse
code like /dev/ioport, which then causes NULL pointer accesses
when accessed by a user application. Also, I would guess that it breaks
if you have PCI or PCMCIA cards that decode more than 16 bits of I/O port
addresses, because then the PCI I/O BAR gets set to a high number that
is not actually accessible inside the I/O space window.

The way we solved this on powerpc was to define a range of the virtual
address space as the I/O port window and map each bus's physical
I/O port window into a section of the virtual window.

	Arnd
