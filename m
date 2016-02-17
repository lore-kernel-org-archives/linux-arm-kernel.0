From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 17 Feb 2016 09:36:37 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <3062977.Ya2ztQYFaM@wuerfel> (Arnd Bergmann's message of "Tue, 16
 Feb 2016 14:55:43 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2702068.KRp0Bplb5Q@wuerfel> <m34md8rdol.fsf@t19.piap.pl>
 <3062977.Ya2ztQYFaM@wuerfel>
Message-ID: <m3ziuzpwbu.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> ixp4xx is really special in that it performs hardware swapping for
> internal devices based on CPU endianess but not on PCI devices.

Again, IXP4xx does not perform hardware (nor any other) swapping for
registers of on-chip devices. The registers are connected 1:1,
bit 0 to bit 0 etc.

(Yes, IXP4xx can be optionally programmed for such swapping, depending
on silicon revision, but it is not used in mainline kernel).

The only hardware swapping happens on PCI bus (in BE mode), to be
compatible with other platforms and non-IXP4xx-specific PCI drivers.

> Coming back to the specific pxa25x_udc case: using __raw_* accessors
> in the driver would possibly end up breaking the PXA25x machines in
> the (very unlikely) case that someone wants to make it work with
> big-endian kernels, assuming it does not have the same hardware
> byteswap logic as ixp4xx.

I'd expect both CPUs to behave in exactly the same manner, i.e., to
not swap anything on the internal bus. If true, it would mean it should
"just work" in both BE and LE modes (including BE mode on PXA, should
it be actually possible).
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
