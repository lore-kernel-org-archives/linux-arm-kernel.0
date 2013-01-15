From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jan 2013 19:05:11 +0000
Subject: [Linaro-mm-sig][RFC] ARM: dma-mapping: Add DMA attribute to skip
 iommu mapping
In-Reply-To: <50F570A4.70606@samsung.com>
References: <1357639944-12050-1-git-send-email-abhinav.k@samsung.com>
 <50F570A4.70606@samsung.com>
Message-ID: <201301151905.11704.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, Marek Szyprowski wrote:
> I'm sorry, but from my perspective this patch and the yet another dma
> attribute shows that there is something fishy happening in the exynos-drm
> driver. Creating a mapping in DMA address space is the MAIN purpose of
> the DMA mapping subsystem, so adding an attribute which skips this
> operation already should give you a sign of warning that something is
> not used right.
> 
> It looks that dma-mapping in the current state is simply not adequate
> for this driver. I noticed that DRM drivers are already known for
> implementing a lots of common code for their own with slightly changed
> behavior, like custom page manager/allocator. It looks that exynos-drm
> driver grew to the point where it also needs such features. It already
> contains custom code for CPU cache handling, IOMMU and contiguous
> memory special cases management. I would advise to drop DMA-mapping
> API completely, avoid adding yet another dozen of DMA attributes useful
> only for one driver and implement your own memory manager with direct
> usage of IOMMU API, alloc_pages() and dma_alloc_pages_from_contiguous().
> This way DMA mapping subsystem can be kept simple, robust and easy to
> understand without confusing or conflicting parts.

Makes sense. DRM drivers and KVM are the two cases where you typically
want to use the iommu API rather than the dma-mapping API, because you
need protection between multiple concurrent user contexts.

	Arnd
