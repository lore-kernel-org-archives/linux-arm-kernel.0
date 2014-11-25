From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Nov 2014 10:28:11 +0000
Subject: Question:  Does dma_alloc_coherent  have problem?
In-Reply-To: <547445F8.4070500@huawei.com>
References: <547445F8.4070500@huawei.com>
Message-ID: <20141125102811.GA18858@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 09:03:52AM +0000, leizhen wrote:
> On arm64, invoke dma_alloc_coherent will indirect call swiotlb_alloc_coherent.
> The latter function allocates memory by __get_free_pages or from swiotlb buffer,
> then use function phys_to_dma to get iova.
> 
> static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> {
> 	return (dma_addr_t)paddr;
> }
> 
> But dma_alloc_coherent have not use iommu_map or other functions to create mapping
> between iova and pa. I known that SMMUv2 support bypass mode, so there is no problem
> in this case. But, some device drivers need use SMMU page table to create exact mapping,
> to enhance security.
> 
> And I saw that: on X86, intel_alloc_coherent manages iova address space of each iommu_group,
> and create mapping between iova and pa when needed.
> 
> So, I think create mapping should be done in dma_alloc_coherent.

The swiotlb, as the name implies, is for software tlbs. IOW, nothing to
do with the IOMMU.

We need separate dma_ops for IOMMU which are not implemented on arm64
yet. There were patches to make part of the arm32 dma ops generic but we
are dropping this approach as we don't want to implement another
allocator. It's best to use the existing drivers/iommu/iova.c, maybe
with a few bits from intel-iommu.c made generic.

-- 
Catalin
