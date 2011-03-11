From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Mar 2011 12:50:51 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <002101cbdfcb$5c657820$15306860$%szyprowski@samsung.com>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<201103101552.15536.arnd@arndb.de>
	<002101cbdfcb$5c657820$15306860$%szyprowski@samsung.com>
Message-ID: <201103111250.51252.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011, Marek Szyprowski wrote:
> 
> We followed the style of iommu API for other mainline ARM platforms (both OMAP and MSM
> also have custom API for their iommu modules). I've briefly checked include/linux/iommu.h
> API and I've noticed that it has been designed mainly for KVM support. There is also
> include/linux/intel-iommu.h interface, but I it is very specific to intel gfx chips.

The MSM code actually uses the generic iommu.h code, using register_iommu, so
the drivers can use the regular iommu_map.

I believe the omap code predates the iommu API, and should really be changed
to use that. At least it was added before I started reviewing the code.

The iommu API is not really meant to be KVM specific, it's just that the
in-tree users are basically limited to KVM at the moment. Another user that
is coming up soon is the vmio device driver that can be used to transparently
pass devices to user space. The idea behind the IOMMU API is that you can
map arbitrary bus addresses to physical memory addresses, but it does not
deal with allocating the bus addresses or providing buffer management such
as cache flushes.

> Is there any example how include/linux/dma-mapping.h interface can be used for iommu
> mappings?

The dma-mapping API is the normal interface that you should use for IOMMUs
that sit between DMA devices and kernel memory. The idea is that you
completely abstract the concept of an IOMMU so the device driver uses
the same code for talking to a device with an IOMMU and another device with
a linear mapping or an swiotlb bounce buffer.

This means that the user of the dma-mapping API does not get to choose the
bus addresses, but instead you use the API to get a bus address for a
chunk of memory, and then you can pass that address to a device.

See arch/powerpc/kernel/iommu.c and arch/x86/kernel/amd_iommu.c for common
examples of how this is implemented. The latter one actually implements
both the iommu_ops for iommu.h and dma_map_ops for dma-mapping.h.

	Arnd
