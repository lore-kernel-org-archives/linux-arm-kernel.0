From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 16 Feb 2016 10:26:14 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <4239208.KBB6rfivoa@wuerfel> (Arnd Bergmann's message of "Mon, 15
 Feb 2016 17:12:54 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2926427.2IOxhm2GZo@wuerfel> <m3y4amqdym.fsf@t19.piap.pl>
 <4239208.KBB6rfivoa@wuerfel>
Message-ID: <m3d1rxqa4p.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The barriers on a spinlock synchronize between CPUs but not an external
> bus, so (on some architectures) a spinlock protecting an MMIO register
> does not guarantee that two CPUs doing
>
> 	spin_lock();
> 	__raw_writel(address);
> 	__raw_writel(data);
> 	spin_unlock();
>
> would cause pairs of address/data to be seen on the bus.
>
> Of course this is meaningless on ixp4xx, as there is only one CPU.

I still don't get it. If the spinlocks synchronize between CPUs, there
can only be one CPU (or core) doing the pair of raw_writel(), so how
would it be possible to not get the address/data pair written out?
IOW, how is it different from a system with a single CPU?

> On powerpc, we have in_le32/in_be32 for SoC-internal register access,
> while only PCI devices are allowed to be accessed using readl().

Yeah, this seems like a sane solution.

> I would suggest using an ixp4xx specific set of accessors that comes down
> to either readl() or ioread32_be(), depending on whether CONFIG_CPU_BIG_ENDIAN
> is set. That makes it clear that there is a magic bus involved and that it
> works on this platform but not in portable code.

Hmm. This is actually the opposite - while there may be some magic
(swapping) in readl() and friends, there is absolutely no magic in the
__raw_readl() etc. They are essentially equivalent to
*(volatile u32 *)ptr. This is constant and doesn't depend on endianess,
PCI, anything.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
