From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Mar 2014 14:28:36 +0100
Subject: [PATCH v11 10/27] iommu/exynos: use managed device helper
 functions
In-Reply-To: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
References: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
Message-ID: <53230404.6070601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KyongHo,

On 14.03.2014 06:05, Cho KyongHo wrote:
> This patch uses managed device helper functions in the probe().
>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c |   64 +++++++++++++++++-------------------------
>   1 file changed, 26 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 36e6b73..33b424d 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -499,51 +499,48 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
>
>   static int exynos_sysmmu_probe(struct platform_device *pdev)
>   {
> -	int ret;
> +	int irq, ret;
>   	struct device *dev = &pdev->dev;
>   	struct sysmmu_drvdata *data;
>   	struct resource *res;
>
> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data) {
> -		dev_dbg(dev, "Not enough memory\n");
> -		ret = -ENOMEM;
> -		goto err_alloc;
> -	}
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
> -		dev_dbg(dev, "Unable to find IOMEM region\n");
> -		ret = -ENOENT;
> -		goto err_init;
> +		dev_err(dev, "Unable to find IOMEM region\n");
> +		return -ENOENT;
>   	}

No need to check for error and print message, because 
devm_ioremap_resource() already checks the passed resource and handles 
error cases.

Best regards,
Tomasz
