From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 18:06:58 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m3a8nogy0u.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-3-git-send-email-arnd@arndb.de>
 <m3a8nogy0u.fsf@t19.piap.pl>
Message-ID: <2202960.HHsdV23CYi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 January 2016 17:18:09 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > The unclear part here is for IXP4xx, which supports both big-endian
> > and little-endian configurations. So far, the driver has done
> > no byteswap in either case. I suspect that is wrong and it would
> > actually need to swap in one or the other case, but I don't know
> > which.
> 
> If at all, I guess it should swap in LE mode. But it's far from certain.
> 
> > It's also possible that there is some magic setting in
> > the chip that makes the endianess of the MMIO register match the
> > CPU, and in that case, the code actually does the right thing
> > for all configurations, both before and after this patch.
> 
> This is IMHO most probable.
> 
> Actually, the IXP4xx is "natural" in BE mode (except for PCI) and
> normally in LE mode it's order-coherent, meaning 32-bit "integer"
> accesses need no swapping, but 8-bit and (mostly unused) 16-bit
> transfers need swapping.

I see.

> Anyway, I think readl()/writel() do the right thing: in BE mode they
> swap PCI accesses and don't swap normal registers, in LE mode nothing is
> swapped.

This seems to be true when CONFIG_IXP4XX_INDIRECT_PCI is set, but
not otherwise. For the indirect variant, writel() is a __raw_writel()
without barrier or byteswap on non-PCI memory, while with that
option disabled, we use the standard implementation that has both
a byteswap and a barrier.

According to your description, that would mean the version without
indirect PCI access is broken and it appears to have been that way
since before the start of git history in 2.6.12.

It's possible that nobody cared because all drivers for non-PCI
devices on ixp4xx (the on chip ones) just use __raw_readl or
direct pointer references.

> LE data-coherent mode (which has never landed in the
> official kernel) is a bit different, but still, readl()/writel() do the
> right thing.
> I remember the "string" (block) functions preserve 8-bit ordering, and
> thus 32-bit values transfered using them may need swapping.

This is the normal behavior, yes: readsl/writesl should not swap data,
and you should not use them to access registers other than FIFOs
that contain byte-sequential data. If the bus swaps data, then the
implementation of the readsl/writesl function has to swap it back,
as the indirect versions of these do.

	Arnd
