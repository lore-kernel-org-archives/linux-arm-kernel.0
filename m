From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 14:55:43 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m34md8rdol.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2702068.KRp0Bplb5Q@wuerfel> <m34md8rdol.fsf@t19.piap.pl>
Message-ID: <3062977.Ya2ztQYFaM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 14:24:10 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > Both writes leave the CPU core within the spinlock but are not serialized
> > with anything else, so there is no ordering between the CPUs when they
> > enter the shared bus, other than having address before data. You'd
> > expect to see address0, data0, address1, data1, but it could also
> > be e.g. address0, address1, data1, data0.
> 
> Ah, so it's a matter of flushing the write buffers before exiting the
> spinlock-protected code.

Yes, whatever the specific architecture requires. The normal readl()
functions are documented to having all the required barriers and
flushes, the __raw_* variants may (e.g. on x86) or may not have that.

> > The point is more what the common case is. Almost all machines we support
> > have fixed-endian devices, and the drivers are correct when using readl()
> > or in_le32() but are not endian-safe when using __raw_readl().
> 
> Sure, e.g. PCI does it this way (eventually swapping the data lanes if
> needed).
> 
> > Using __raw_readl() has the big danger of someone accidentally "fixing"
> > the driver to work like all the others in order to solve a theoretical
> > endian problem, while it should really be made obvious that the hardware
> > actively swaps its data on the bus.
> 
> Sure - if this is the case. On-chip IXP4xx peripherals don't swap data
> at all (i.e., they match CPU endianess) - accessing their registers is
> like accessing a normal CPU register. That's why they don't use
> PCI-style readl() etc. - however a better name than __raw_* would
> probably help here.
> 
> Using __raw_* in a PCI driver would be generally wrong.

I was really talking about built-in devices here. There are other platforms
that have an internal byteswap logic on the bus interface and they also
use that for PCI, see e.g. arch/sh/include/mach-common/mach/mangle-port.h.

ixp4xx is really special in that it performs hardware swapping for
internal devices based on CPU endianess but not on PCI devices.

I think some Broadcom MIPS systems are in the same category as IXP4xx,
but only because they have an extra byteswap on the PCI bus that they
can turn on, but very few other systems are.

Coming back to the specific pxa25x_udc case: using __raw_* accessors
in the driver would possibly end up breaking the PXA25x machines in
the (very unlikely) case that someone wants to make it work with
big-endian kernels, assuming it does not have the same hardware
byteswap logic as ixp4xx.

	Arnd
