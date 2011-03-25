From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Mar 2011 10:08:25 +0000
Subject: IO access and *_relaxed macros
In-Reply-To: <4D8B8BD3.5070403@codeaurora.org>
References: <4D8B8BD3.5070403@codeaurora.org>
Message-ID: <1301047705.25814.4.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-24 at 18:22 +0000, Steve Muckle wrote:
> On ARMv7 the readl and writel macros (and readb, etc) include memory
> barriers (dmb or dsb, unless defined otherwise by the machine) due to
> CONFIG_ARM_DMA_MEM_BUFFERABLE being defined by default. Likewise the
> ioread* and iowrite* macros also include memory barriers.
> 
> The barriers in the io accessor macros are only on one side, and the
> reads and writes have them on different sides, so it's easy to slip up
> if you're relying on these macros to perform memory barriers in certain
> locations. They also have a noticeable effect on performance.

They were put on each side because they were meant to work in relation
with Normal memory accesses. The scenarios I've had in mind were:

1. Write to the coherent DMA buffer followed by writel() to start the
transfer

2. Check the transfer status via readl() followed by a read from the
coherent DMA buffer (BTW, I checked with architecture people and this
should be a DSB as well, I'll post a separate patch).

Are there other scenarios (in relation with coherent DMA buffers) where
we need a DSB after writel() or before readl()?

> To obtain best performance in drivers it would seem appropriate to use
> the *_relaxed io accessor macros which lack memory barriers and manage
> the memory barriers directly, inserting them only when strictly
> required. Usage of the *_relaxed macros doesn't seem to be especially
> prevalent however so I thought I'd see if others had thoughts or
> concerns on this.

Yes, that's the suggestion we got on LKML in the past about improving
the I/O performance.

-- 
Catalin
