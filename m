From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 16 Feb 2016 14:24:10 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <2702068.KRp0Bplb5Q@wuerfel> (Arnd Bergmann's message of "Tue, 16
 Feb 2016 12:26:23 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <4239208.KBB6rfivoa@wuerfel> <m3d1rxqa4p.fsf@t19.piap.pl>
 <2702068.KRp0Bplb5Q@wuerfel>
Message-ID: <m34md8rdol.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Both writes leave the CPU core within the spinlock but are not serialized
> with anything else, so there is no ordering between the CPUs when they
> enter the shared bus, other than having address before data. You'd
> expect to see address0, data0, address1, data1, but it could also
> be e.g. address0, address1, data1, data0.

Ah, so it's a matter of flushing the write buffers before exiting the
spinlock-protected code.

> The point is more what the common case is. Almost all machines we support
> have fixed-endian devices, and the drivers are correct when using readl()
> or in_le32() but are not endian-safe when using __raw_readl().

Sure, e.g. PCI does it this way (eventually swapping the data lanes if
needed).

> Using __raw_readl() has the big danger of someone accidentally "fixing"
> the driver to work like all the others in order to solve a theoretical
> endian problem, while it should really be made obvious that the hardware
> actively swaps its data on the bus.

Sure - if this is the case. On-chip IXP4xx peripherals don't swap data
at all (i.e., they match CPU endianess) - accessing their registers is
like accessing a normal CPU register. That's why they don't use
PCI-style readl() etc. - however a better name than __raw_* would
probably help here.

Using __raw_* in a PCI driver would be generally wrong.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
