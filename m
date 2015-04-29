From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Apr 2015 10:17:14 +0100
Subject: dma_alloc_coherent versus streaming DMA, neither works
 satisfactory
In-Reply-To: <4351847.Ycu9R2FQB8@wuerfel>
References: <5538DD02.6050401@topic.nl> <2757951.K585xX1rYN@wuerfel>
 <55409A89.5070008@topic.nl> <4351847.Ycu9R2FQB8@wuerfel>
Message-ID: <20150429091714.GH12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 11:01:35AM +0200, Arnd Bergmann wrote:
> You still need to synchronize MMIO register accesses with write buffers,
> as the readl() and writel() functions do in the kernel.
> 
> In particular, after you have written a buffer to memory from the CPU,
> you will need to do an outer_sync() before the MMIO write that triggers
> the DMA. This is still much cheaper than doing the cache flush though.

Note that outer_sync() is already done by readl/writel and/or the write
memory barriers (mb()/wmb()).

> Another possible problem would be if the driver mmaps the buffer in
> uncached mode to user space. This is something your kernel driver has
> to get right, it won't be handled automatically by setting the
> "dma-coherent" property in DT.

The buffer should also be mapped into userspace with the same memory
type and cache attributes as the kernel side mapping.  If using ACP,
then you probably want "normal memory, cacheable, writeback, read
allocate" or in the case of SMP, the same but "read/write allocate".

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
