From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 29 Jan 2016 17:18:09 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <1453997843-3489728-3-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 28 Jan 2016 17:17:04 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-3-git-send-email-arnd@arndb.de>
Message-ID: <m3a8nogy0u.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The unclear part here is for IXP4xx, which supports both big-endian
> and little-endian configurations. So far, the driver has done
> no byteswap in either case. I suspect that is wrong and it would
> actually need to swap in one or the other case, but I don't know
> which.

If at all, I guess it should swap in LE mode. But it's far from certain.

> It's also possible that there is some magic setting in
> the chip that makes the endianess of the MMIO register match the
> CPU, and in that case, the code actually does the right thing
> for all configurations, both before and after this patch.

This is IMHO most probable.

Actually, the IXP4xx is "natural" in BE mode (except for PCI) and
normally in LE mode it's order-coherent, meaning 32-bit "integer"
accesses need no swapping, but 8-bit and (mostly unused) 16-bit
transfers need swapping.

Anyway, I think readl()/writel() do the right thing: in BE mode they
swap PCI accesses and don't swap normal registers, in LE mode nothing is
swapped. LE data-coherent mode (which has never landed in the
official kernel) is a bit different, but still, readl()/writel() do the
right thing.
I remember the "string" (block) functions preserve 8-bit ordering, and
thus 32-bit values transfered using them may need swapping.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
