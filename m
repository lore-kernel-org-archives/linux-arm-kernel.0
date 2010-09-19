From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Sep 2010 17:40:40 +0100
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <201009191834.44928.arnd@arndb.de>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009191639.44488.arnd@arndb.de>
	<20100919150242.GD9098@n2100.arm.linux.org.uk>
	<201009191834.44928.arnd@arndb.de>
Message-ID: <20100919164040.GG9098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 19, 2010 at 06:34:44PM +0200, Arnd Bergmann wrote:
> On Sunday 19 September 2010 17:02:43 Russell King - ARM Linux wrote:
> > Eg, on DC21285 (footbridge) systems, the PCI IO window is at 0x7c000000
> > physical, mapped into 0xff000000 virtual.  So __io(0x3f8) translates to
> > 0xff0003f8 virtual, which hits 0x7c0003f8 physical, and 0x3f8 as an IO
> > access on the PCI bus.
> > 
> > Things become a little more complicated when you have PCMCIA cards with
> > separate IO regions, as on SA11x0 and PXA systems.  These don't tend to
> > have PCI, so we adopted there to have __io() do a 1:1 translation, and
> > arrange for the "bus IO" address to be the actual virtual address.
> 
> Such a mapping sounds dangerous when you have device drivers trying
> to access legacy ISA ports. Most of them are disabled on ARM, but
> some drivers are hard to disable.

Seems reliable on SA11x0 and PXA platforms.

> More importantly, having PCI I/O port numbers above 65536 will confuse
> code like /dev/ioport, which then causes NULL pointer accesses
> when accessed by a user application. Also, I would guess that it breaks
> if you have PCI or PCMCIA cards that decode more than 16 bits of I/O port
> addresses, because then the PCI I/O BAR gets set to a high number that
> is not actually accessible inside the I/O space window.

This machine I'm using to send this email has in /proc/ioports:

90000000-9000ffff : IOP3XX PCI I/O Space
  90000000-900000ff : 0000:00:01.0
    90000000-900000ff : r8169
  90000400-900004ff : 0000:00:02.0
    90000400-900004ff : r8169
  90000800-9000081f : 0000:00:04.0
    90000800-9000081f : uhci_hcd
  90000820-9000083f : 0000:00:04.1
    90000820-9000083f : uhci_hcd
  90000840-9000084f : 0000:00:03.0
  90000850-90000857 : 0000:00:03.0
  90000858-9000085f : 0000:00:03.0
  90000860-90000863 : 0000:00:03.0
  90000864-90000867 : 0000:00:03.0

which works fine - and yes, if you insert an ISA driver it probably will
crash.  But then you can crash an x86 PC by using setserial to define
a serial port at a wrong address.

The answer to the latter issue is "don't do that then", and I'd suggest
that also goes for the "don't insert an ISA driver when the platform
doesn't support it".

But yes, in principle I agree that PCI IO space should be 0 - 0xffff
rather than having addresses assigned at the memory mapped IO address.
Unfortunately, broken hardware (bridges) sometimes gets in the way of
that.
