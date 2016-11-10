From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Nov 2016 18:37:28 +0000
Subject: [PATCH v2 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <1ae5dc0f-2e59-3e10-a61a-1f5452ad560f@arm.com>
References: <4e84146ae49a4edd5f1226d76617be9aa92a58ee.1477503578.git.robin.murphy@arm.com>
 <20161110122420.GH9996@8bytes.org>
 <1ae5dc0f-2e59-3e10-a61a-1f5452ad560f@arm.com>
Message-ID: <20161110183728.GH15943@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 02:30:04PM +0000, Robin Murphy wrote:
> On 10/11/16 12:24, Joerg Roedel wrote:
> > On Wed, Oct 26, 2016 at 06:43:56PM +0100, Robin Murphy wrote:
> >> With the new dma_{map,unmap}_resource() functions added to the DMA API
> >> for the benefit of cases like slave DMA, add suitable implementations to
> >> the arsenal of our generic layer. Since cache maintenance should not be
> >> a concern, these can both be standalone callback implementations without
> >> the need for arch code wrappers.
> >>
> >> CC: Joerg Roedel <joro@8bytes.org>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>
> >> v2: Use iommu_dma_unmap_page for symmetry, instead of being sneaky.
> >>
> >>  drivers/iommu/dma-iommu.c | 13 +++++++++++++
> >>  include/linux/dma-iommu.h |  4 ++++
> >>  2 files changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >> index c5ab8667e6f2..a2fd90a6a782 100644
> >> --- a/drivers/iommu/dma-iommu.c
> >> +++ b/drivers/iommu/dma-iommu.c
> >> @@ -624,6 +624,19 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> >>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
> >>  }
> >>  
> >> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> >> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> >> +{
> >> +	return iommu_dma_map_page(dev, phys_to_page(phys), offset_in_page(phys),
> >> +			size, dma_direction_to_prot(dir, false) | IOMMU_MMIO);
> >> +}
> > 
> > Isn't the whole point of map_resource that we can map regions which have
> > no 'struct page' associated? The use phys_to_page() will certainly not
> > do the right thing here.
> 
> Perhaps it's a bit cheeky, but the struct page pointer is never
> dereferenced - the only thing iommu_dma_map_page() does with it is
> immediately convert it back again. Is there ever a case where
> page_to_phys(phys_to_page(phys)) != phys ?

Without SPARSEMEM_VMEMMAP or FLATMEM, it wouldn't work. For example,
__page_to_pfn() in the SPARSEMEM case, used by page_to_phys(), even
accesses the page structure (through page_to_section()).

If the page struct is not relevant to the iommu code in question, you
could factor it out into an __iommu_dma_map_pfn(). Or maybe move the
whole logic to iommu_dma_map_resource() and call it from
iommu_dma_map_page() with the page_to_phys(page) argument.

-- 
Catalin
