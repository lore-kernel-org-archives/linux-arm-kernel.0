From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 9 Jan 2018 11:34:36 +0530
Subject: [PATCH 1/2] iommu/msm: Claim bus ops on probe
In-Reply-To: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
Message-ID: <f839cc47-7c3a-d509-6cae-7d0897f53f61@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/9/2018 12:12 AM, Robin Murphy wrote:
> Since the MSM IOMMU driver now probes via DT exclusively rather than
> platform data, dependent masters should be deferred until the IOMMU
> itself is ready. Thus we can do away with the early initialisation
> hook to unconditionally claim the bus ops, and instead do that only
> once an IOMMU is actually probed. Furthermore, this should also make
> the driver safe for multiplatform kernels on non-MSM SoCs.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/msm_iommu.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 04f4d51ffacb..dda1ce87a070 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -823,6 +823,8 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> +	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
> +
>  	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
>  		iommu->base, iommu->irq, iommu->ncb);
>  
> @@ -875,19 +877,7 @@ static void __exit msm_iommu_driver_exit(void)
>  subsys_initcall(msm_iommu_driver_init);
>  module_exit(msm_iommu_driver_exit);
>  
> -static int __init msm_iommu_init(void)
> -{
> -	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
> -	return 0;
> -}
> -
> -static int __init msm_iommu_of_setup(struct device_node *np)
> -{
> -	msm_iommu_init();
> -	return 0;
> -}
> -
> -IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", msm_iommu_of_setup);
> +IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", NULL);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Stepan Moskovchenko <stepanm@codeaurora.org>");
> 

Reviewed-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
