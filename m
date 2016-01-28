From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 28 Jan 2016 17:28:30 +0000
Subject: [RFC PATCH 4/6] iommu/arm-smmu: Add support for IOMMU_DOMAIN_DMA
 in SMMUv1/SMMUv2 driver
In-Reply-To: <1453872079-27140-5-git-send-email-anup.patel@broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-5-git-send-email-anup.patel@broadcom.com>
Message-ID: <56AA4FBE.6090702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/16 05:21, Anup Patel wrote:
> To allow use of large memory (> 4Gb) with 32bit devices we need to use
> some kind of iommu for such 32bit devices.
>
> This patch extends SMMUv1/SMMUv2 driver to support DMA domains which
> in-turn will allows us to use iommu based DMA mappings for 32bit devices.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   drivers/iommu/arm-smmu.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9bdf6b2..43424fe 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -29,6 +29,7 @@
>   #define pr_fmt(fmt) "arm-smmu: " fmt
>
>   #include <linux/delay.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/err.h>
>   #include <linux/interrupt.h>
> @@ -967,7 +968,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>   {
>   	struct arm_smmu_domain *smmu_domain;
>
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>   		return NULL;
>   	/*
>   	 * Allocate the domain and initialise some of its data structures.
> @@ -978,6 +979,12 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>   	if (!smmu_domain)
>   		return NULL;
>
> +	if (type == IOMMU_DOMAIN_DMA &&
> +	    iommu_get_dma_cookie(&smmu_domain->domain)) {
> +		kfree(smmu_domain);
> +		return NULL;
> +	}
> +
>   	mutex_init(&smmu_domain->init_mutex);
>   	spin_lock_init(&smmu_domain->pgtbl_lock);
>
> @@ -992,6 +999,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>   	 * Free the domain resources. We assume that all devices have
>   	 * already been detached.
>   	 */
> +	iommu_put_dma_cookie(domain);
>   	arm_smmu_destroy_domain_context(domain);
>   	kfree(smmu_domain);
>   }
> @@ -1361,6 +1369,16 @@ static int arm_smmu_init_platform_device(struct device *dev,
>   	return 0;
>   }
>
> +int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	/*
> +	 * Nothing to do here because SMMU is already aware of all
> +	 * MMU masters and their stream IDs using mmu-master attibute
> +	 * SMMU DT node.
> +	 */

...but on the same hand this will also never get called if there's no 
"iommus" property on the master. Maintaining support for existing users 
of the "mmu-masters" binding is one thing (namely the thing that's been 
slowing down my efforts to clean up the really hacky generic binding 
support I did all the DMA stuff with), but having _both_ bindings in a 
single DT is something I don't think anybody wants to see - is that how 
you've tested this?

Robin.

> +	return 0;
> +}
> +
>   static int arm_smmu_add_device(struct device *dev)
>   {
>   	struct iommu_group *group;
> @@ -1458,6 +1476,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.unmap			= arm_smmu_unmap,
>   	.map_sg			= default_iommu_map_sg,
>   	.iova_to_phys		= arm_smmu_iova_to_phys,
> +	.of_xlate		= arm_smmu_of_xlate,
>   	.add_device		= arm_smmu_add_device,
>   	.remove_device		= arm_smmu_remove_device,
>   	.device_group		= arm_smmu_device_group,
>
