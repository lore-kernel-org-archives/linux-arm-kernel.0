From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 4 May 2016 14:23:00 +0100
Subject: [PATCH v8 8/8] genirq/msi: use the MSI doorbell's IOVA when
 requested
In-Reply-To: <1461831730-5575-9-git-send-email-eric.auger@linaro.org>
References: <1461831730-5575-1-git-send-email-eric.auger@linaro.org>
 <1461831730-5575-9-git-send-email-eric.auger@linaro.org>
Message-ID: <5729F7B4.7020401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/16 09:22, Eric Auger wrote:
> On MSI message composition we now use the MSI doorbell's IOVA in
> place of the doorbell's PA in case the device is upstream to an
> IOMMU that requires MSI addresses to be mapped. The doorbell's
> allocation and mapping happened on an early stage (pci_enable_msi).
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> v7 -> v8:
> - use iommu_msi_msg_pa_to_va
> - add WARN_ON
> 
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
>  kernel/irq/msi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index d5f95e6..835938b 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -64,8 +64,16 @@ static int msi_compose(struct irq_data *irq_data,
>  
>  	if (erase)
>  		memset(msg, 0, sizeof(*msg));
> -	else

Nit: Braces on both sides of the 'else'.

> +	else {
> +		struct device *dev;
> +
>  		ret = irq_chip_compose_msi_msg(irq_data, msg);
> +		if (ret)
> +			return ret;
> +
> +		dev = msi_desc_to_dev(irq_data_get_msi_desc(irq_data));
> +		WARN_ON(iommu_msi_msg_pa_to_va(dev, msg));
> +	}
>  
>  	return ret;
>  }
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
