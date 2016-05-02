From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 2 May 2016 17:48:13 +0200
Subject: [PATCH v8 6/8] iommu/msi-iommu: iommu_msi_domain
In-Reply-To: <20160428162740.28db4b8d@t450s.home>
References: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
 <1461831323-5480-7-git-send-email-eric.auger@linaro.org>
 <20160428162740.28db4b8d@t450s.home>
Message-ID: <572776BD.2080503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,
On 04/29/2016 12:27 AM, Alex Williamson wrote:
> On Thu, 28 Apr 2016 08:15:21 +0000
> Eric Auger <eric.auger@linaro.org> wrote:
> 
>> This function checks whether
>> - the device belongs to a non default iommu domain
>> - this iommu domain requires the MSI address to be mapped.
>>
>> If those conditions are met, the function returns the iommu domain
>> to be used for mapping the MSI doorbell; else it returns NULL.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>>
>> v7 -> v8:
>> - renamed  iommu_msi_mapping_desc_to_domain to iommu_msi_domain
>> - the function now takes a struct device *
>> - use DOMAIN_ATTR_MSI_GEOMETRY attribute
>> ---
>>  drivers/iommu/msi-iommu.c | 17 +++++++++++++++++
>>  include/linux/msi-iommu.h | 14 ++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/iommu/msi-iommu.c b/drivers/iommu/msi-iommu.c
>> index 203e86e..023ff17 100644
>> --- a/drivers/iommu/msi-iommu.c
>> +++ b/drivers/iommu/msi-iommu.c
>> @@ -243,3 +243,20 @@ unlock:
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_msi_put_doorbell_iova);
>> +
>> +struct iommu_domain *iommu_msi_domain(struct device *dev)
>> +{
>> +	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
>> +	struct iommu_domain_msi_geometry msi_geometry;
>> +
>> +	if (!d || (d->type == IOMMU_DOMAIN_DMA))
>> +		return NULL;
>> +
>> +	iommu_domain_get_attr(d, DOMAIN_ATTR_MSI_GEOMETRY, &msi_geometry);
>> +	if (!msi_geometry.programmable)
> 
> It feels like we're conflating ideas with using the "programmable" flag
> in this way.  AIUI the IOMMU API consumer is supposed to see the
> invalid MSI geometry with the programmable feature set and know to call
> iommu_msi_set_aperture().  Looking for the msi_cookie would tell us if
> that had been done, but that doesn't tell us if it should have been
> done.  iommu_msi_msg_pa_to_va() handles this later, if we return
> NULL here that function returns success otherwise it goes on to fail if
> the iova or msi cookie is not set.  So really what we're trying to flag
> is that the MSI geometry participates in the IOMMU-MSI API you've
> created and we should pick a feature name that says that rather than
> something as vague a "programmable".  Perhaps simply iommu_msi_api
> rather than programmable.
Yes I had the same questioning too when I wrote this code. So if my
understanding is correct we would have
- programmable: tells whether the MSI range is fixed or pogrammable and,
- mapping_required (new boolean field): indicating whether MSIs need to
be mapped in the IOMMU
> 
> BTW, I don't see that you ever set aperture_start/end once
> iommu_msi_set_aperture() has been called.  It seems like doing so would
> add some consistency to that MSI geometry attribute.
Indeed currently I mentionned:
/* In case the aperture is programmable, start/end are set to 0 */

If I set start/end in iommu_msi_set_aperture then I think I should also
return the actual values in iommu_domain_get_attr. I thought the extra
care to handle the possible race between the set_aperture (msi_iommu)
and the get_attr (iommu) was maybe not worth the benefits:
is_aperture_set is not visible to get_attr so I would be forced to
introduce a mutex at iommu_domain level or call an msi-iommu function
from iommu implementation. So I preferred to keep start/end as read-only
info initialized by the iommu driver.

> 
> Nice series overall.  Thanks,

Thanks

Eric
> 
> Alex
> 
>> +		return NULL;
>> +
>> +	return d;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_msi_domain);
>> +
>> diff --git a/include/linux/msi-iommu.h b/include/linux/msi-iommu.h
>> index 1cd115f..114bd69 100644
>> --- a/include/linux/msi-iommu.h
>> +++ b/include/linux/msi-iommu.h
>> @@ -81,6 +81,15 @@ int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
>>   */
>>  void iommu_msi_put_doorbell_iova(struct iommu_domain *domain, phys_addr_t addr);
>>  
>> +/**
>> + * iommu_msi_domain: in case the device is upstream to an IOMMU and this IOMMU
>> + * translates the MSI transaction, returns the iommu domain the MSI doorbell
>> + * address must be mapped in; else returns NULL.
>> + *
>> + * @dev: device handle
>> + */
>> +struct iommu_domain *iommu_msi_domain(struct device *dev);
>> +
>>  #else
>>  
>>  static inline int
>> @@ -100,5 +109,10 @@ static inline int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
>>  static inline void iommu_msi_put_doorbell_iova(struct iommu_domain *domain,
>>  					       phys_addr_t addr) {}
>>  
>> +static inline struct iommu_domain *iommu_msi_domain(struct device *dev)
>> +{
>> +	return NULL;
>> +}
>> +
>>  #endif	/* CONFIG_IOMMU_MSI */
>>  #endif	/* __MSI_IOMMU_H */
> 
