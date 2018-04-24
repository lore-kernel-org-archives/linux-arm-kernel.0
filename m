From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 23 Apr 2018 21:32:33 -0400
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Message-ID: <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> /**
>   * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
>   * @dev: the device
> @@ -129,7 +439,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
>  int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>  			  unsigned long flags, void *drvdata)
>  {
> +	int i, ret;
> +	struct io_mm *io_mm = NULL;
>  	struct iommu_domain *domain;
> +	struct iommu_bond *bond = NULL, *tmp;
>  	struct iommu_param *dev_param = dev->iommu_param;
>  
>  	domain = iommu_get_domain_for_dev(dev);
> @@ -145,7 +458,42 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>  	if (flags != (IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF))
>  		return -EINVAL;
>  
> -	return -ENOSYS; /* TODO */
> +	/* If an io_mm already exists, use it */
> +	spin_lock(&iommu_sva_lock);
> +	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
> +		if (io_mm->mm != mm || !io_mm_get_locked(io_mm))
> +			continue;
> +
> +		/* Is it already bound to this device? */
> +		list_for_each_entry(tmp, &io_mm->devices, mm_head) {
> +			if (tmp->dev != dev)
> +				continue;
> +
> +			bond = tmp;
> +			refcount_inc(&bond->refs);
> +			io_mm_put_locked(io_mm);
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_sva_lock);
> +
> +	if (bond)

Please return pasid when you find an io_mm that is already bound. Something like
*pasid = io_mm->pasid should do the work here when bond is true.

> +		return 0;


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
