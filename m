From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 15 Feb 2016 14:51:13 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <2926427.2IOxhm2GZo@wuerfel> (Arnd Bergmann's message of "Mon, 15
 Feb 2016 10:33:08 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2202960.HHsdV23CYi@wuerfel> <m3a8n2bf72.fsf@t19.piap.pl>
 <2926427.2IOxhm2GZo@wuerfel>
Message-ID: <m3y4amqdym.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I consider the use of __raw_* accessors a bug, I don't think we should
> ever do that because it hides how the hardware actually works, it doesn't
> work with spinlocks, and it can lead to the compiler splitting up accesses
> into byte sized ones (not on ARM with the current definition, but
> possible in general).

Well, then maybe we should fix them, or add another set.
Why don't they work with spinlocks?

To be honest, I remember this was already discussed a bit years ago.
I think I proposed back then a set of read_le32 (which would be
equivalent of current readl(), and could be named pci_readl() as well),
read_be32, read_host (without swapping).
The names could be better, though.

> Almost all hardware is fixed-endian, so you have to use swapping accessors
> when the CPU is the other way, except for device RAM and FIFO registers
> that are always used to transfer a byte stream (see the definition of
> readsl() and memcpy_fromio()). When you have hardware that adds byteswaps
> on the bus interface, you typically end up with MMIO registers requiring
> no swap (or double swap) and readsl()/memcpy_fromio()) suddenly requiring
> a swap that is counterintuitive.

Sure, but the __raw_* are used just to be sure there is absolutely no
swapping.
E.g. for IXP4xx, the registers never require swapping, thus readl() etc.
are not suitable for this. What is needed here is simple "atomic" 32-bit
straight to/from register (MM)IO (assuming 4-byte address alignment).

If not __raw_* then what?
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
