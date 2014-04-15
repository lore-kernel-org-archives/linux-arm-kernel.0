From: lee.essen@nowonline.co.uk (Lee Essen)
Date: Tue, 15 Apr 2014 14:01:39 +0400
Subject: dma_alloc_coherent and cache?
In-Reply-To: <4356499.vN3lxjGqPZ@wuerfel>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
 <4356499.vN3lxjGqPZ@wuerfel>
Message-ID: <E94CEA02-A987-4212-A0CA-D0CDC80E7250@nowonline.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 15 Apr 2014, at 12:43, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> dma_alloc_coherent() is a wrapper around a device-specific allocator,
> based on the dma_map_ops implementation. The default allocator
> from arm_dma_ops gives you uncached, buffered memory. It is expected
> that the driver uses a barrier (which is implied by readl/writel
> but not __raw_readl/__raw_writel or readl_relaxed/writel_relaxed)
> to ensure the write buffers are flushed.
> 
> If the machine sets arm_coherent_dma_ops rather than arm_dma_ops,
> the memory will be cacheable, as it's assumed that the hardware
> is set up for cache-coherent DMAs.

Hi,

The driver writes to the descriptor and then uses wmb() before enabling DMA. The descriptor is in dma_alloc_coherent() space, but the enable is a writel().

> 
> Can you post a link to the source code?
> 
>   Arnd

The code is available here:

http://www.nowonline.co.uk/scratch/le_netdev.c

It hangs consistently when it executes the txq_enable() on line 1280. Occasionally I see a corrupt packet on the wire, but mostly it's just a hang. If I uncomment all the printk's then it generally gets 20 or 30 packets out before it freezes.

Regards,

Lee.
