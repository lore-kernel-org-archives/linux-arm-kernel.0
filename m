From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 17 May 2018 11:02:02 +0100
Subject: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <20180516134150.34fc8857@jacob-builder>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <20180516134150.34fc8857@jacob-builder>
Message-ID: <96c1e0f0-0aa7-badf-123e-cbb1b05e645e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Thanks for reviewing this

On 16/05/18 21:41, Jacob Pan wrote:
>> + * The device must support multiple address spaces (e.g. PCI PASID).
>> By default
>> + * the PASID allocated during bind() is limited by the IOMMU
>> capacity, and by
>> + * the device PASID width defined in the PCI capability or in the
>> firmware
>> + * description. Setting @max_pasid to a non-zero value smaller than
>> this limit
>> + * overrides it.
>> + *
> seems the min_pasid never gets used. do you really need it?

Yes, the SMMU sets it to 1 in patch 28/40, because it needs to reserve
PASID 0

>> + * The device should not be performing any DMA while this function
>> is running,
>> + * otherwise the behavior is undefined.
>> + *
>> + * Return 0 if initialization succeeded, or an error.
>> + */
>> +int iommu_sva_device_init(struct device *dev, unsigned long features,
>> +			  unsigned int max_pasid)
>> +{
>> +	int ret;
>> +	struct iommu_sva_param *param;
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (!domain || !domain->ops->sva_device_init)
>> +		return -ENODEV;
>> +
>> +	if (features)
>> +		return -EINVAL;
> should it be !features?

This checks if the user sets any unsupported bit in features. No feature
is supported right now, but patch 09/40 adds IOMMU_SVA_FEAT_IOPF, and
changes this line to "features & ~IOMMU_SVA_FEAT_IOPF"

>> +	mutex_lock(&dev->iommu_param->lock);
>> +	param = dev->iommu_param->sva_param;
>> +	dev->iommu_param->sva_param = NULL;
>> +	mutex_unlock(&dev->iommu_param->lock);
>> +	if (!param)
>> +		return -ENODEV;
>> +
>> +	if (domain->ops->sva_device_shutdown)
>> +		domain->ops->sva_device_shutdown(dev, param);
> seems a little mismatch here, do you need pass the param. I don't think
> there is anything else model specific iommu driver need to do for the
> param.

SMMU doesn't use it, but maybe it would remind other IOMMU driver which
features were enabled, so they don't have to keep track of that
themselves? I can remove it if it isn't useful

Thanks,
Jean
