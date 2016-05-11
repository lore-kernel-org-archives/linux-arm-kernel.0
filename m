From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 May 2016 14:58:14 +0200
Subject: [PATCH v9 3/7] vfio/type1: bypass unmap/unpin and replay for
 VFIO_IOVA_RESERVED slots
In-Reply-To: <20160509164936.1a5ae402@t450s.home>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
 <1462362858-2925-4-git-send-email-eric.auger@linaro.org>
 <20160509164936.1a5ae402@t450s.home>
Message-ID: <57332C66.30105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,
On 05/10/2016 12:49 AM, Alex Williamson wrote:
> On Wed,  4 May 2016 11:54:14 +0000
> Eric Auger <eric.auger@linaro.org> wrote:
> 
>> Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
>> let's implement the expected behavior for removal and replay. As opposed
>> to user dma slots, IOVAs are not systematically bound to PAs and PAs are
>> not pinned. VFIO just initializes the IOVA "aperture". IOVAs are allocated
>> outside of the VFIO framework, typically the MSI layer which is
>> responsible to free and unmap them. The MSI mapping resources are freeed
>> by the IOMMU driver on domain destruction.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>>
>> v7 -> v8:
>> - do no destroy anything anymore, just bypass unmap/unpin and iommu_map
>>   on replay
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 2d769d4..94a9916 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -391,7 +391,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>  	struct vfio_domain *domain, *d;
>>  	long unlocked = 0;
>>  
>> -	if (!dma->size)
>> +	if (!dma->size || dma->type != VFIO_IOVA_USER)
>>  		return;
>>  	/*
>>  	 * We use the IOMMU to track the physical addresses, otherwise we'd
>> @@ -727,6 +727,9 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>>  		dma = rb_entry(n, struct vfio_dma, node);
>>  		iova = dma->iova;
>>  
>> +		if (dma->type == VFIO_IOVA_RESERVED)
>> +			continue;
>> +
> 
> But you do still need some sort of replay mechanism, right?  Not to
> replay the IOVA to PA mapping, but to call iommu_msi_set_aperture() for
> the new domain.  How will you know that this entry is an MSI reserved
> range or something else?  Perhaps we can't have a generic "reserved"
> type here.
Thanks for spotting this bug. I was not testing this case yet and
effectively I need to replay the set_aperture.

Thanks for the review

Best Regards

Eric

> 
>>  		while (iova < dma->iova + dma->size) {
>>  			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
>>  			size_t size;
> 
