From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon, 06 Oct 2014 12:02:47 -0700
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <20140925170108.GE8306@8bytes.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <20140925170108.GE8306@8bytes.org>
Message-ID: <5432E757.10201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/25/2014 10:01 AM, Joerg Roedel wrote:
> On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
>> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			       struct scatterlist *sg, unsigned int nents,
>> +			       int prot, unsigned long flags)
>> +{
>> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
>> +}
>> +
>> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
>> +				 unsigned long iova, size_t size,
>> +				 unsigned long flags)
>> +{
>> +	return domain->ops->unmap_sg(domain, iova, size, flags);
>> +}
>
> I have thought a little bit more about this interface and think that it
> would be better to just return a size_t from iommu_map_sg().  The
> function returns the amount of address space mapped by it, 0 in the
> worst case.
>
> This makes it easy to unmap the region just with
> iommu_unmap(domain, iova, size) in the end and removing the need for a
> new iommu_unmap_sg() function. Also the error-path of the map_sg
> call-backs becomes easier as the function then just returns the amount
> of address-space already mapped before the error happened.
>
> So the prototype would be:
>
> 	size_t iommu_map_sg(struct iommu_domain *domain,
> 			    unsigned long iova,
> 			    struct scatterlist *sg,
> 			    unsigned int nents,
> 			    int prot);
>
> (as I said before, the flags parameter should not be added by this
>   patch-set).
>

Ok, sounds good. I'll post v6 soon.

.Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
