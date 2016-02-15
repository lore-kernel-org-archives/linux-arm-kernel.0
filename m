From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 15 Feb 2016 08:33:37 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <2202960.HHsdV23CYi@wuerfel> (Arnd Bergmann's message of "Fri, 29
 Jan 2016 18:06:58 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-3-git-send-email-arnd@arndb.de>
 <m3a8nogy0u.fsf@t19.piap.pl> <2202960.HHsdV23CYi@wuerfel>
Message-ID: <m3a8n2bf72.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

>> Anyway, I think readl()/writel() do the right thing: in BE mode they
>> swap PCI accesses and don't swap normal registers, in LE mode nothing is
>> swapped.
>
> This seems to be true when CONFIG_IXP4XX_INDIRECT_PCI is set, but
> not otherwise. For the indirect variant, writel() is a __raw_writel()
> without barrier or byteswap on non-PCI memory, while with that
> option disabled, we use the standard implementation that has both
> a byteswap and a barrier.
>
> According to your description, that would mean the version without
> indirect PCI access is broken and it appears to have been that way
> since before the start of git history in 2.6.12.
>
> It's possible that nobody cared because all drivers for non-PCI
> devices on ixp4xx (the on chip ones) just use __raw_readl or
> direct pointer references.

Well, it is possible. I recall I probably used __raw_* instead of
readl()/writel() in qmgr/npe/Ethernet drivers for this very reason.

I think Direct pointer references are only used for locations in RAM
(DMA buffers), they have their own share of problems because the
peripherals are always big endian.

I think I still have an early IXP425 board with UDC connector so I will
try to dig it up and test this code.

I wonder if we should switch the driver to use __raw_*, too. The problem
is almost nobody uses UDC with this CPU.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
