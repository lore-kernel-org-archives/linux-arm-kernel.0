From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 May 2014 16:12:24 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <20140501230214.ed53cd0fc977225f37b14e29@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <7044616.kdaKNu3Qet@wuerfel>
 <20140501230214.ed53cd0fc977225f37b14e29@samsung.com>
Message-ID: <5035945.xBiLK9bFYq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 May 2014 23:02:14 Cho KyongHo wrote:
> > 
> > - device can only do DMA to a limited address range
> > - DMA is noncoherent and needs manual cache management
> > - DMA address is at an offset from physical address
> > - some devices have an IOMMU
> > - some IOMMUs are shared between devices
> > - some devices with IOMMU can have multiple simultaneous contexts
> > - a device may access some memory directly and some other memory through IOMMU
> 
> Do we need to consider this case?
> I don't think a device can have different contexts at the same time.
> If there such device is in a system, its driver must handle it correctly
> with different devices descriptors for the different contexts, for example.
> I mean, if a device has two DMA ports that are in different contexts,
> they can be treated as different devices which are handed by a driver.
> 
> I worry that abstracting everything we can think may make the problem harder.

It's the default operation for some of the simpler IOMMUs, see
arch/x86/kernel/amd_gart_64.c for instance. It's possible that AMD
will have the same thing in their ARM64 SoCs, but I don't have
specific information about that.

It can probably be handled in the iommu_map_ops() as a generalization,
at least if we only have to worry about checking whether a memory address
is below the dma_mask in order to decide whether to use the IOMMU or not.

Or we can decide not to handle it at all, and always go through the IOMMU,
which would be slightly slower but still functional.

	Arnd
