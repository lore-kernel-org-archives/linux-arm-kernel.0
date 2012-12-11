From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Dec 2012 17:29:16 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211173819.6f2cf32b@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
 <201212111615.03262.arnd@arndb.de>
 <20121211162325.GR14363@n2100.arm.linux.org.uk>
 <20121211173819.6f2cf32b@skate>
Message-ID: <20121211172916.2668a5be@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Could you enlighten my very naive understanding of things about PCI/ISA
> IO space? On x86, I seem to understand this is the separate address
> space accessed by the special in/out CPU instructions. Are there ARM
> platforms with the same sort of things?

An x86 processor has two address spaces

A memory space
An I/O space

They are both visible to the PCI bus and both transaction types are
present on the bus and distinct.

> As far as I understand, on my ARM Marvell system, everything is
> memory-mapped, so there isn't such a separate PCI/ISA IO space.

There is if you ask the PCI bridge or beyond.

> Therefore, why would I need to "select HAVE_IOPORT" simply to be able
> to build libata-sff.c, that is used for PCI drivers that work fine with
> purely memory-mapped registers?

Because the drivers talk to the hardware beyond the bridge which knows
the difference.


So on x86 we have

	inb(0xf00);

	generates an I/O transaction on the PCI bus for I/O 0xf00

	*0xf00

	generates a memory transacion on the PCI bus for memory 0xf00
	and the two are *not* the same thing or address

On many other platforms we have 

	inb(0xf00)

	actually produces the equivalent of (*io_window+0xf00)

	which the PCI bridge turns into an I/O transaction for 0xf00

	(and for the out case may have an explicit barrier needed to get
	the I/O ordering rules)

	while

	*0xf00

	gets turned by the bridge into a memory transaction for 0xf00



The "no I/O space" case really applies to things like the S/390 mainframe
which simply have no such concept on the system or the devices. In the
ARM case the bus has an I/O space and the bridge glues the processors
simpler model to the bridge model.

For compatibility reasons (so you an boot old software) the PCI bus also
has some automatic magic mappings in I/O space, and a lot of LPC bus
devices also have magic I/O mappings. For example a SATA controller in
compatibility mode appears at a specified I/O address on the bus and is
always on a specific IRQ (matching the old ISA PC mappings which map the
old ISA MFM controller mappings whose offsets map compatiblity to the
register mappings for the WD MFM controller used on the PC/AT)

In PC space this stuff is important and it's why up until Windows 7 era
PC hardware you can boot DOS, as well as being why you can have one
generic kernel for almost any PC hardware instead of the one per board
problem some other platforms have.

Alan
