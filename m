From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 29 Apr 2011 10:25:54 +1000
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428131531.GK17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<003e01cc058f$94beb490$be3c1db0$%szyprowski@samsung.com>
	<20110428105131.GD17290@n2100.arm.linux.org.uk>
	<201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
Message-ID: <1304036754.2513.201.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> However, dma_alloc_coherent() memory can't be used with the dma_sync_*
> API as its return address (unlike other architectures) is not in the
> kernel direct mapped memory range.

Well, on non-coherent architectures, dma_sync_* are cache flushes, I
don't see the point of doing those on a non-cachable mapping anyways.

> The only thing valid for dma_sync_* are buffers which have been passed
> to the dma_map_* APIs.

Right, at least that's our expectation on powerpc as well.

> Instead, I think what you're referring to is dma_cache_sync(), which is
> the API to be used with dma_alloc_noncoherent(), which we don't
> implement.

Too may confusing APIs....

Ben.

> As we have problems with some SMP implementations, and the noncoherent
> API doesn't have the idea of buffer ownership, it's rather hard to deal
> with the DMA cache implications with the existing API, especially with
> the issues of speculative prefetching.  The current usage (looking at
> drivers/scsi/53c700.c) doesn't cater for speculative prefetch as the
> dma_cache_sync(,,,DMA_FROM_DEVICE) is done well in advance of the DMA
> actually happening.
> 
> So all in all, I think the noncoherent API is broken as currently
> designed - and until we have devices on ARM which use it, I don't see
> much point into trying to fix the current thing especially as we'd be
> unable to test.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
