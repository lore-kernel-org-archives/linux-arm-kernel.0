From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Jun 2017 10:39:06 -0400
Subject: [RFC,20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
In-Reply-To: <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
References: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
 <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
Message-ID: <fad6510f-922a-550b-0429-bc59f857c307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Philippe,
 
> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
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

According to the PASID ECN here (https://pcisig.com/sites/default/files/specification_documents/ECN-PASID-ATS-2011-03-31.pdf),
PASID should be enabled only if all switches between the root port and
a device support TLP prefix. 
 
I'm only seeing a call to pci_enable_pasid() in this patch but I don't
see anybody checking for TLP prefix support on the hierarchy.

This could potentially be an addition to the PCI core code.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
