From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 31 May 2017 10:10:07 -0400
Subject: [RFC,20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
In-Reply-To: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
Message-ID: <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Philippe,

On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
> Enable PASID for PCI devices that support it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 499dc1cd07eb..37fd061405e9 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -730,6 +730,8 @@ struct arm_smmu_master_data {
>  
>  	struct arm_smmu_stream		*streams;
>  	struct rb_root			contexts;
> +
> +	u32				avail_contexts;
>  };
>  

I know that you are doing some code restructuring. As I was looking at the amdkfd
driver, I realized that there is quite a bit of PASID, ATS and PRI work here that
can be plumbed into the framework you are building. 

https://github.com/torvalds/linux/tree/master/drivers/gpu/drm/amd/amdkfd

I wanted to share this with if you were aware of this or not. Functions of interest
are:

amd_iommu_init_device
amd_iommu_free_device
amd_iommu_bind_pasid
amd_iommu_set_invalid_ppr_cb
amd_iommu_unbind_pasid
amd_iommu_device_info

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
