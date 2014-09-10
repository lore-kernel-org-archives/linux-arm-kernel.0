From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 10 Sep 2014 13:16:06 +0200
Subject: [RFC PATCH v2 3/7] iommu: add new iommu_ops callback for adding an
 OF device
In-Reply-To: <1409680587-29818-4-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-4-git-send-email-will.deacon@arm.com>
Message-ID: <541032F6.1090809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-09-02 19:56, Will Deacon wrote:
> This patch adds a new function to the iommu_ops structure to allow an
> OF device to be added to a specific IOMMU instance using the recently
> merged generic devicetree binding for IOMMUs. The callback (of_xlate)
> takes a struct device representing the master and an of_phandle_args
> representing the IOMMU and the correspondong IDs for the new master.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   include/linux/iommu.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fdddb14cd8f5..3e766b85daa3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -21,6 +21,7 @@
>   
>   #include <linux/errno.h>
>   #include <linux/err.h>
> +#include <linux/of.h>
>   #include <linux/types.h>
>   #include <trace/events/iommu.h>
>   
> @@ -136,6 +137,10 @@ struct iommu_ops {
>   	/* Get the numer of window per domain */
>   	u32 (*domain_get_windows)(struct iommu_domain *domain);
>   
> +#ifdef CONFIG_OF_IOMMU
> +	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);

If I understand correctly how it is designed to work, then it should be:

struct iommu_data *(*of_xlate)(struct device *dev, struct 
of_phandle_args *args);

> +#endif
> +
>   	unsigned long pgsize_bitmap;
>   };
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
