From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 17:12:54 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m3y4amqdym.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2926427.2IOxhm2GZo@wuerfel> <m3y4amqdym.fsf@t19.piap.pl>
Message-ID: <4239208.KBB6rfivoa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 14:51:13 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > I consider the use of __raw_* accessors a bug, I don't think we should
> > ever do that because it hides how the hardware actually works, it doesn't
> > work with spinlocks, and it can lead to the compiler splitting up accesses
> > into byte sized ones (not on ARM with the current definition, but
> > possible in general).
> 
> Well, then maybe we should fix them, or add another set.
> Why don't they work with spinlocks?

The barriers on a spinlock synchronize between CPUs but not an external
bus, so (on some architectures) a spinlock protecting an MMIO register
does not guarantee that two CPUs doing

	spin_lock();
	__raw_writel(address);
	__raw_writel(data);
	spin_unlock();

would cause pairs of address/data to be seen on the bus.

Of course this is meaningless on ixp4xx, as there is only one CPU.

> To be honest, I remember this was already discussed a bit years ago.
> I think I proposed back then a set of read_le32 (which would be
> equivalent of current readl(), and could be named pci_readl() as well),
> read_be32, read_host (without swapping).
> The names could be better, though.

It keeps coming back, but so far the status quo has been stronger,
any it generally works for portable code either hardcoding whichever
endianess the device has, or using runtime detection when the same
device can be used in various ways (e.g. USB ehci).

On powerpc, we have in_le32/in_be32 for SoC-internal register access,
while only PCI devices are allowed to be accessed using readl().

> > Almost all hardware is fixed-endian, so you have to use swapping accessors
> > when the CPU is the other way, except for device RAM and FIFO registers
> > that are always used to transfer a byte stream (see the definition of
> > readsl() and memcpy_fromio()). When you have hardware that adds byteswaps
> > on the bus interface, you typically end up with MMIO registers requiring
> > no swap (or double swap) and readsl()/memcpy_fromio()) suddenly requiring
> > a swap that is counterintuitive.
> 
> Sure, but the __raw_* are used just to be sure there is absolutely no
> swapping.
> E.g. for IXP4xx, the registers never require swapping, thus readl() etc.
> are not suitable for this. What is needed here is simple "atomic" 32-bit
> straight to/from register (MM)IO (assuming 4-byte address alignment).
> 
> If not __raw_* then what?

I would suggest using an ixp4xx specific set of accessors that comes down
to either readl() or ioread32_be(), depending on whether CONFIG_CPU_BIG_ENDIAN
is set. That makes it clear that there is a magic bus involved and that it
works on this platform but not in portable code.

	Arnd
