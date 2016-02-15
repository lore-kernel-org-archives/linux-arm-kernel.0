From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 10:33:08 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m3a8n2bf72.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2202960.HHsdV23CYi@wuerfel> <m3a8n2bf72.fsf@t19.piap.pl>
Message-ID: <2926427.2IOxhm2GZo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 08:33:37 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> >> Anyway, I think readl()/writel() do the right thing: in BE mode they
> >> swap PCI accesses and don't swap normal registers, in LE mode nothing is
> >> swapped.
> >
> > This seems to be true when CONFIG_IXP4XX_INDIRECT_PCI is set, but
> > not otherwise. For the indirect variant, writel() is a __raw_writel()
> > without barrier or byteswap on non-PCI memory, while with that
> > option disabled, we use the standard implementation that has both
> > a byteswap and a barrier.
> >
> > According to your description, that would mean the version without
> > indirect PCI access is broken and it appears to have been that way
> > since before the start of git history in 2.6.12.
> >
> > It's possible that nobody cared because all drivers for non-PCI
> > devices on ixp4xx (the on chip ones) just use __raw_readl or
> > direct pointer references.
> 
> Well, it is possible. I recall I probably used __raw_* instead of
> readl()/writel() in qmgr/npe/Ethernet drivers for this very reason.
> 
> I think Direct pointer references are only used for locations in RAM
> (DMA buffers), they have their own share of problems because the
> peripherals are always big endian.
> 
> I think I still have an early IXP425 board with UDC connector so I will
> try to dig it up and test this code.
> 
> I wonder if we should switch the driver to use __raw_*, too. The problem
> is almost nobody uses UDC with this CPU.
> 

I consider the use of __raw_* accessors a bug, I don't think we should
ever do that because it hides how the hardware actually works, it doesn't
work with spinlocks, and it can lead to the compiler splitting up accesses
into byte sized ones (not on ARM with the current definition, but
possible in general).

Almost all hardware is fixed-endian, so you have to use swapping accessors
when the CPU is the other way, except for device RAM and FIFO registers
that are always used to transfer a byte stream (see the definition of
readsl() and memcpy_fromio()). When you have hardware that adds byteswaps
on the bus interface, you typically end up with MMIO registers requiring
no swap (or double swap) and readsl()/memcpy_fromio()) suddenly requiring
a swap that is counterintuitive.

	Arnd
