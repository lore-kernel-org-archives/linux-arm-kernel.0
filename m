From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 15:28:26 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <201207171312.06987.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <201207161554.04812.arnd@arndb.de> <20120717121640.589780ce@skate>
 <201207171312.06987.arnd@arndb.de>
Message-ID: <20120717152826.2bf75948@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks a lot for those details.

Le Tue, 17 Jul 2012 13:12:06 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> > My understanding until now was that __raw_readl/__raw_writel should
> > be used for accesses with native endianness, but apparently, it's
> > more subtle than this. Would you mind expanding a bit on this?
> 
> The __raw_* versions are basically only valid if you access a memory
> buffer, such as a video framebuffer. They do the conversion of an
> __iomem pointer into something that can be accessed by the compiler.
> 
> The non-raw versions have fixed endianess, guarantee that the access
> is done atomically (could be byte-wise otherwise) and that all the
> necessary barriers are used to synchronize against DMA and
> out-of-order execution.
> 
> We don't actually have accessors that are CPU-endian and guarantee
> that you can access an MMIO register properly.
> 
> On powerpc, the convention is that readl/writel should only be used
> to access PCI, but that is for the enhanced error handling, not for
> endianess.

And then, on PowerPC, which accessors do you use to access
SoC-peripherals that are not on the PCI bus?

For example, drivers/tty/serial/mpsc.c uses writel/readl, so a
conversion to/from little-endian is done when writing/reading
registers. Are those memory-mapped devices little-endian even though
they are used on big-endian PowerPCs?

I apologize for the silly questions, but I'm trying to make some sense
out of these numerous I/O and memory accessors.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
