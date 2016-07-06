From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Jul 2016 15:09:42 +0200
Subject: [PATCH -next] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
In-Reply-To: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
Message-ID: <577D0316.1050502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 02:15 PM, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function of_platform_device_create() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/iommu/exynos-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 33dcc29..9b23059 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1345,8 +1345,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
>  		exynos_iommu_init();
>  
>  	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	if (!pdev)
> +		return -ENOMEM;
>  
>  	/*
>  	 * use the first registered sysmmu device for performing
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Which in case of first sysmmu device and of_platform_device_create()
failure will lead to NULL pointer exception, so I think it is
appropriate to:
Fixes: 8ed55c812fa8 ("iommu/exynos: Init from dt-specific callback
instead of initcall")
Cc: <stable@vger.kernel.org>

Best regards,
Krzysztof
