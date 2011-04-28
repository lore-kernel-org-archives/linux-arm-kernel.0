From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 14:28:56 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428105131.GD17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<003e01cc058f$94beb490$be3c1db0$%szyprowski@samsung.com>
	<20110428105131.GD17290@n2100.arm.linux.org.uk>
Message-ID: <201104281428.56780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Russell King - ARM Linux wrote:
> What I'd suggest is that dma_alloc_noncoherent() should be architecture
> independent, and should call into whatever iommu support the device has
> to setup an approprite iommu mapping.  IOW, I don't see any need for
> every architecture to provide its own dma_alloc_noncoherent() allocation
> function - or indeed every iommu implementation to deal with the
> allocation issues either.

Almost all architectures today define dma_alloc_noncoherent to
dma_alloc_coherent, which is totally fine on architectures
where cacheable coherent mappings are the default or where
we don't need to flush individual cache lines for dma_sync_*.

The problem with backing either of the two with alloc_pages or
alloc_pages_exact is that you cannot do large allocation when
physical memory is fragmented, even if you have an IOMMU.

IMHO the allocation for both dma_alloc_coherent and
dma_alloc_noncoherent should therefore depend on whether you
have an IOMMU. If you do, you can easily allocate megabytes,
e.g. for use as a frame buffer.

	Arnd
