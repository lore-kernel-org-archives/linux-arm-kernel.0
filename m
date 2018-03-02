From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 2 Mar 2018 14:56:18 +0000
Subject: [PATCH 01/14] iommu: Add DOMAIN_ATTR_ENABLE_TTBR1
In-Reply-To: <20180221225924.30737-2-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-2-jcrouse@codeaurora.org>
Message-ID: <39425ac4-d58b-18c1-3025-837222aecc5e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/18 22:59, Jordan Crouse wrote:
> Add a new domain attribute to enable the TTBR1 pagetable for drivers
> and devices that support it.  This will enabled using a TTBR1 (otherwise
> known as a "global" or "system" pagetable for devices that support a split
> pagetable scheme for switching pagetables quickly and safely.

TTBR1 is very much an Arm VMSA-specific term; if the concept of a split 
address space is useful in general, is it worth trying to frame it in 
general terms? AFAICS other IOMMU drivers could achieve the same effect 
fairly straightforwardly by simply copying the top-level "global" 
entries across whenever they switch "private" tables.

FWIW even for SMMU there could potentially be cases with Arm Ltd. IP 
where the SoC vendor implements a stage-2-only configuration in their 
media subsystem, because they care most about minimising area and 
stage-1-only isn't an option.

Robin.

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>   include/linux/iommu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 641aaf0f1b81..e2c49e583d8d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -153,6 +153,7 @@ enum iommu_attr {
>   	DOMAIN_ATTR_FSL_PAMU_ENABLE,
>   	DOMAIN_ATTR_FSL_PAMUV1,
>   	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> +	DOMAIN_ATTR_ENABLE_TTBR1,
>   	DOMAIN_ATTR_MAX,
>   };
>   
> 
