From: jacob.jun.pan@linux.intel.com (Jacob Pan)
Date: Thu, 17 May 2018 10:00:23 -0700
Subject: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <96c1e0f0-0aa7-badf-123e-cbb1b05e645e@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <20180516134150.34fc8857@jacob-builder>
 <96c1e0f0-0aa7-badf-123e-cbb1b05e645e@arm.com>
Message-ID: <20180517100023.43585c42@jacob-builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018 11:02:02 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Jacob,
> 
> Thanks for reviewing this
> 
> On 16/05/18 21:41, Jacob Pan wrote:
>  [...]  
> > seems the min_pasid never gets used. do you really need it?  
> 
> Yes, the SMMU sets it to 1 in patch 28/40, because it needs to reserve
> PASID 0
> 
>  [...]  
> > should it be !features?  
> 
> This checks if the user sets any unsupported bit in features. No
> feature is supported right now, but patch 09/40 adds
> IOMMU_SVA_FEAT_IOPF, and changes this line to "features &
> ~IOMMU_SVA_FEAT_IOPF"
> 
> >> +	mutex_lock(&dev->iommu_param->lock);
> >> +	param = dev->iommu_param->sva_param;
> >> +	dev->iommu_param->sva_param = NULL;
> >> +	mutex_unlock(&dev->iommu_param->lock);
> >> +	if (!param)
> >> +		return -ENODEV;
> >> +
> >> +	if (domain->ops->sva_device_shutdown)
> >> +		domain->ops->sva_device_shutdown(dev, param);  
> > seems a little mismatch here, do you need pass the param. I don't
> > think there is anything else model specific iommu driver need to do
> > for the param.  
> 
> SMMU doesn't use it, but maybe it would remind other IOMMU driver
> which features were enabled, so they don't have to keep track of that
> themselves? I can remove it if it isn't useful
> 
If there is a use case, I guess iommu driver can always retrieve the
param from struct device.
> Thanks,
> Jean

[Jacob Pan]
