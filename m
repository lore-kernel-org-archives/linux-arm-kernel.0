From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Feb 2017 14:46:59 +0100
Subject: [PATCH 10/11] iommu/exynos: Make use of iommu_device_register
 interface
In-Reply-To: <1486639981-32368-11-git-send-email-joro@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
 <CGME20170209113308epcas2p2cd79f382b04635bc7e973a62c093d557@epcas2p2.samsung.com>
 <1486639981-32368-11-git-send-email-joro@8bytes.org>
Message-ID: <9a1997dd-5835-cb9a-6478-7fb276151e52@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 2017-02-09 12:32, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Register Exynos IOMMUs to the IOMMU core and make them
> visible in sysfs. This patch does not add the links between
> IOMMUs and translated devices yet.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/iommu/exynos-iommu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 57ba0d3..64325d8 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -276,6 +276,8 @@ struct sysmmu_drvdata {
>   	struct list_head owner_node;	/* node for owner controllers list */
>   	phys_addr_t pgtable;		/* assigned page table structure */
>   	unsigned int version;		/* our version */
> +
> +	struct iommu_device iommu;	/* IOMMU core handle */
>   };
>   
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -611,6 +613,18 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   	data->sysmmu = dev;
>   	spin_lock_init(&data->lock);
>   
> +	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> +				     dev_name(data->sysmmu));
> +	if (ret)
> +		return ret;
> +
> +	iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
> +	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
> +
> +	ret = iommu_device_register(&data->iommu);
> +	if (ret)
> +		return ret;
> +
>   	platform_set_drvdata(pdev, data);
>   
>   	__sysmmu_get_version(data);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
