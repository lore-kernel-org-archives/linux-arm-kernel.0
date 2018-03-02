From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 2 Mar 2018 16:59:12 +0000
Subject: [PATCH 3/3] iommu: armsmmu: set iommu ops for rpmsg bus
In-Reply-To: <20180302145531.20463-4-srinivas.kandagatla@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-4-srinivas.kandagatla@linaro.org>
Message-ID: <57fc5480-c57e-dfd3-e6af-5e5bba296430@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/18 14:55, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> On Qualcomm SoCs, ADSP exposes many functions like audio and
> others. These services need iommu access to allocate any
> memory for the DSP. As these drivers are childeren of
> rpmsg bus, able to allocate memory from iommus is basic
> requirement. So set arm smmu iommu ops for this bus type.

Documentation/rpmsg.txt: "Every rpmsg device is a communication channel 
with a remote processor (thus rpmsg devices are called channels)."

I'd instinctively assume that a remote processor already has its own 
memory, and that a communication channel doesn't somehow go directly 
through an IOMMU, so that "basic requirement" seems like a pretty big 
assumption.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/iommu/arm-smmu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e6920d32ac9e..9b63489af15c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -53,6 +53,7 @@
>   #include <linux/spinlock.h>
>   
>   #include <linux/amba/bus.h>
> +#include <linux/rpmsg.h>
>   
>   #include "io-pgtable.h"
>   #include "arm-smmu-regs.h"
> @@ -2168,6 +2169,10 @@ static void arm_smmu_bus_init(void)
>   		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>   	}
>   #endif
> +#ifdef CONFIG_RPMSG

Ah, so this will at least build OK with RPMSG=m, but I doubt it does 
what you want it to in that case.

Robin.

> +	if (!iommu_present(&rpmsg_bus))
> +		bus_set_iommu(&rpmsg_bus, &arm_smmu_ops);
> +#endif
>   }
>   
>   static int arm_smmu_device_probe(struct platform_device *pdev)
> 
