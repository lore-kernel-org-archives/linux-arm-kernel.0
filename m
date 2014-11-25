From: thunder.leizhen@huawei.com (leizhen)
Date: Tue, 25 Nov 2014 17:03:52 +0800
Subject: Question:  Does dma_alloc_coherent  have problem?
Message-ID: <547445F8.4070500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Catalin and Will:

On arm64, invoke dma_alloc_coherent will indirect call swiotlb_alloc_coherent.
The latter function allocates memory by __get_free_pages or from swiotlb buffer,
then use function phys_to_dma to get iova.

static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
{
	return (dma_addr_t)paddr;
}

But dma_alloc_coherent have not use iommu_map or other functions to create mapping
between iova and pa. I known that SMMUv2 support bypass mode, so there is no problem
in this case. But, some device drivers need use SMMU page table to create exact mapping,
to enhance security.

And I saw that: on X86, intel_alloc_coherent manages iova address space of each iommu_group,
and create mapping between iova and pa when needed.

So, I think create mapping should be done in dma_alloc_coherent.
