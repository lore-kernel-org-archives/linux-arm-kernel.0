From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2016 10:44:29 +0100
Subject: [PATCH v7 8/8] genirq/msi: use the MSI doorbell's IOVA when
 requested
In-Reply-To: <1461085990-2547-9-git-send-email-eric.auger@linaro.org>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
 <1461085990-2547-9-git-send-email-eric.auger@linaro.org>
Message-ID: <57174F7D.4090501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 18:13, Eric Auger wrote:
> On MSI message composition we now use the MSI doorbell's IOVA in
> place of the doorbell's PA in case the device is upstream to an
> IOMMU that requires MSI addresses to be mapped. The doorbell's
> allocation and mapping happened on an early stage (pci_enable_msi).
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> v6 -> v7:
> - allocation/mapping is done at an earlier stage. We now just perform
>   the iova lookup. So it is safe now to be called in a code that cannot
>   sleep. iommu_msi_set_doorbell_iova is moved in the dma-reserved-iommu
>   API: I think it cleans things up with respect to various #ifdef CONFIGS.
> 
> v5:
> - use macros to increase the readability
> - add comments
> - fix a typo that caused a compilation error if CONFIG_IOMMU_API
>   is not set
> ---
>  kernel/irq/msi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index e45907e..0ebb2d8 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -19,6 +19,7 @@
>  
>  /* Temparory solution for building, will be removed later */
>  #include <linux/pci.h>
> +#include <linux/dma-reserved-iommu.h>
>  
>  struct msi_desc *alloc_msi_entry(struct device *dev)
>  {
> @@ -64,8 +65,12 @@ static int msi_compose(struct irq_data *irq_data,
>  
>  	if (erase)
>  		memset(msg, 0, sizeof(*msg));
> -	else
> +	else {
>  		ret = irq_chip_compose_msi_msg(irq_data, msg);
> +		if (ret)
> +			return ret;
> +		iommu_msi_mapping_translate_msg(irq_data, msg);

I've just commented on this function in its respective series. I really
think it deals with the wrong data structure. Id rather see something like:

struct device *dev = msi_desc_to_dev(irq_data_get_msi_desc(irq_data));
iommu_msi_msg_pa_to_va(dev, msg);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
