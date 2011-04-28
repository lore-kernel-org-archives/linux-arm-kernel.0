From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 14:15:31 +0100
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104281428.56780.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<003e01cc058f$94beb490$be3c1db0$%szyprowski@samsung.com>
	<20110428105131.GD17290@n2100.arm.linux.org.uk>
	<201104281428.56780.arnd@arndb.de>
Message-ID: <20110428131531.GK17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 02:28:56PM +0200, Arnd Bergmann wrote:
> On Thursday 28 April 2011, Russell King - ARM Linux wrote:
> > What I'd suggest is that dma_alloc_noncoherent() should be architecture
> > independent, and should call into whatever iommu support the device has
> > to setup an approprite iommu mapping.  IOW, I don't see any need for
> > every architecture to provide its own dma_alloc_noncoherent() allocation
> > function - or indeed every iommu implementation to deal with the
> > allocation issues either.
> 
> Almost all architectures today define dma_alloc_noncoherent to
> dma_alloc_coherent, which is totally fine on architectures
> where cacheable coherent mappings are the default or where
> we don't need to flush individual cache lines for dma_sync_*.

However, dma_alloc_coherent() memory can't be used with the dma_sync_*
API as its return address (unlike other architectures) is not in the
kernel direct mapped memory range.

The only thing valid for dma_sync_* are buffers which have been passed
to the dma_map_* APIs.

Instead, I think what you're referring to is dma_cache_sync(), which is
the API to be used with dma_alloc_noncoherent(), which we don't
implement.

As we have problems with some SMP implementations, and the noncoherent
API doesn't have the idea of buffer ownership, it's rather hard to deal
with the DMA cache implications with the existing API, especially with
the issues of speculative prefetching.  The current usage (looking at
drivers/scsi/53c700.c) doesn't cater for speculative prefetch as the
dma_cache_sync(,,,DMA_FROM_DEVICE) is done well in advance of the DMA
actually happening.

So all in all, I think the noncoherent API is broken as currently
designed - and until we have devices on ARM which use it, I don't see
much point into trying to fix the current thing especially as we'd be
unable to test.
