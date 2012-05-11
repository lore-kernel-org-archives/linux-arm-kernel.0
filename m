From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 12 May 2012 06:31:59 +0900
Subject: [PATCH 1/2] iommu/exynos: fix runtime pm support
In-Reply-To: <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
 <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4FAD854F.7040403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/12 23:34, Marek Szyprowski wrote:
> Fix registration to runtime pw and add missing resume callback.
>
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park<kyungmin.park@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c |   20 ++++++++++++++++++--
>   1 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b8daf7c..eef924d 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -651,8 +651,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>
>   	__set_fault_handler(data,&default_fault_handler);
>
> -	if (dev->parent)
> -		pm_runtime_enable(dev);
> +	pm_runtime_enable(dev);
>
>   	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
>   	return 0;
> @@ -674,11 +673,28 @@ err_alloc:
>   	return ret;
>   }
>
> +static int exynos_pm_resume(struct device *dev)
> +{
> +	struct sysmmu_drvdata *data;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	if (is_sysmmu_active(data))
> +		__exynos_sysmmu_enable(data, data->pgtable, NULL);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops exynos_pm_ops = {
> +	.resume =&exynos_pm_resume,
> +};
> +
>   static struct platform_driver exynos_sysmmu_driver = {
>   	.probe		= exynos_sysmmu_probe,
>   	.driver		= {
>   		.owner		= THIS_MODULE,
>   		.name		= "exynos-sysmmu",
> +		.pm		=&exynos_pm_ops,
>   	}
>   };
>

Joerg,

This patch is needed to correct run-time pm for EXYNOS SoCs with System 
MMU after KyongHo's iommu/exynos patch. So if you're ok on this, let me 
apply this in samsung tree.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
