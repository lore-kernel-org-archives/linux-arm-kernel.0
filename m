From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Aug 2011 14:28:44 +0200
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <006b01cc5cb3$dac09fa0$9041dee0$%szyprowski@samsung.com>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<201108161626.26130.arnd@arndb.de>
	<006b01cc5cb3$dac09fa0$9041dee0$%szyprowski@samsung.com>
Message-ID: <201108171428.44555.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2011, Marek Szyprowski wrote:
> Do we really need the dynamic pool for the first version? I would like to
> know how much memory can be allocated in GFP_ATOMIC context. What are the
> typical sizes of such allocations?

I think this highly depends on the board and on the use case. We know
that 2 MB is usually enough, because that is the current CONSISTENT_DMA_SIZE
on most platforms. Most likely something a lot smaller will be ok
in practice. CONSISTENT_DMA_SIZE is currently used for both atomic
and non-atomic allocations.

> Maybe for the first version a static pool with reasonably small size
> (like 128KiB) will be more than enough? This size can be even board
> depended or changed with kernel command line for systems that really
> needs more memory.

For a first version that sounds good enough. Maybe we could use a fraction
of the CONSISTENT_DMA_SIZE as an estimate?

For the long-term solution, I see two options:

1. make the preallocated pool rather small so we normally don't need it.
2. make it large enough so we can also fulfill most nonatomic allocations
   from that pool to avoid the TLB flushes and going through the CMA
   code. Only use the real CMA region when the pool allocation fails.

In either case, there should be some method for balancing the pool
size.

> I noticed one more problem. The size of the CMA managed area must be
> the multiple of 16MiBs (MAX_ORDER+1). This means that the smallest CMA area
> is 16MiB. These values comes from the internals of the kernel memory 
> management design and page blocks are the only entities that can be managed
> with page migration code.
> 
> I'm not sure if all ARMv6+ boards have at least 32MiB of memory be able to
> create a CMA area.

My guess is that you can assume to have 64 MB or more on ARMv6 running Linux,
but other people may have more accurate data.

Also, there is the option of setting a lower value for FORCE_MAX_ZONEORDER
for some platforms if it becomes a problem.

	Arnd
