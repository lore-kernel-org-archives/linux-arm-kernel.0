From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 21 Oct 2016 15:37:12 +0100
Subject: [PATCH 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <20161019140252.GR9193@arm.com>
References: <b6c78e6c18d98069b0fdfa219da51d2aed129aed.1476705500.git.robin.murphy@arm.com>
 <20161019140252.GR9193@arm.com>
Message-ID: <fb5d86eb-d634-176e-4887-04721f55fbc3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/16 15:02, Will Deacon wrote:
> On Mon, Oct 17, 2016 at 01:05:29PM +0100, Robin Murphy wrote:
>> With the new dma_{map,unmap}_resource() functions added to the DMA API
>> for the benefit of cases like slave DMA, add suitable implementations to
>> the arsenal of our generic layer. Since cache maintenance should not be
>> a concern, these can both be standalone versions without the need for
>> architecture-specific wrappers.
>>
>> CC: Joerg Roedel <joro@8bytes.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Since patch 2 has a build dependency on this one, they should probably
>> go together through either the arm64 tree or the iommu tree, but I can't
>> make up my mind which one seems more appropriate...
> 
> I can take it via the smmu tree, if you like. However, comment below.

I'm surprised that didn't occur to me - makes sense, thanks.

>>  drivers/iommu/dma-iommu.c | 13 +++++++++++++
>>  include/linux/dma-iommu.h |  4 ++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index c5ab8667e6f2..50acd71915db 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -624,6 +624,19 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
>>  }
>>  
>> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	return iommu_dma_map_page(dev, phys_to_page(phys), offset_in_page(phys),
>> +			size, dma_direction_to_prot(dir, false) | IOMMU_MMIO);
>> +}
>>
>> +void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
>> +}
> 
> I think it's better to call iommu_dma_unmap_page instead. That said, are
> you sure it's safe to ignore the "size" parameter here? Is it permitted
> to unmap part of a region? If not, why does that parameter exist?

Actually, "#define iommu_dma_unmap_resource iommu_dma_unmap_page" in the
header would make life even simpler. Or is that too evil?

Glossing over the size parameter is a detail of this particular
implementation. Equivalently to iommu_dma_unmap_page(), it's there
(along with dir and attrs) to match the signature of
dma_unmap_resource(), so that arch code doesn't need yet another wrapper
for its .unmap_resource callback in dma_ops (see patch 2). As it
happens, ignoring the size is effectively extra-safe in the sense that
we're enforcing the API and not even trusting the caller - since we have
to look up the iova to free it, and that iova records the size
originally mapped, we simply unmap that original size because it makes
for simpler code and can't be wrong. See the __iommu_dma_unmap()
implementation itself.

Robin.

> 
> Will
> 
