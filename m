From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 09:58:12 +0100
Subject: [PATCH 1/9] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
In-Reply-To: <1380234982-1677-2-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-2-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20130927085811.GD8319@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 11:36:13PM +0100, Andreas Herrmann wrote:
> This should ensure that arm-smmu is initialized before other drivers
> start handling devices that propably need smmu support.
> 
> Also remove module_exit function as we most likely never want to
> unload this driver.

Doesn't hurt to leave the exit function there though, right?

> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 181c9ba..6808577 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1976,13 +1976,7 @@ static int __init arm_smmu_init(void)
>  	return 0;
>  }
>  
> -static void __exit arm_smmu_exit(void)
> -{
> -	return platform_driver_unregister(&arm_smmu_driver);
> -}
> -
> -module_init(arm_smmu_init);
> -module_exit(arm_smmu_exit);
> +arch_initcall(arm_smmu_init);

Why not subsys_initcall, like the other ARM IOMMUs?

Will
