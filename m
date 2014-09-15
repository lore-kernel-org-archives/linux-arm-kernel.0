From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Sep 2014 13:57:38 +0200
Subject: [RFC PATCH v3 3/7] iommu: add new iommu_ops callback for adding an
 OF device
In-Reply-To: <1410539695-29128-4-git-send-email-will.deacon@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-4-git-send-email-will.deacon@arm.com>
Message-ID: <5416D432.8020107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-09-12 18:34, Will Deacon wrote:
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
> index 4256f3ce1673..821eb0bd9f6c 100644
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
> @@ -140,6 +141,10 @@ struct iommu_ops {
>   	/* Get the numer of window per domain */
>   	u32 (*domain_get_windows)(struct iommu_domain *domain);
>   
> +#ifdef CONFIG_OF_IOMMU
> +	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> +#endif


If I understand correctly, this callback is intended to do per-master 
initialization
of the iommu structures required by the given iommu driver (I stored them in
dev->archdata.iommu). However I really don't get what is the meaning of 
the return
value. Is it a boolean value? It is used only by of_iommu_configure to 
check if
the parse loop should be terminated...

> +
>   	unsigned long pgsize_bitmap;
>   };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
