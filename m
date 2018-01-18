From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 18 Jan 2018 13:23:00 +0000
Subject: [PATCH v4 04/13] iommu/rockchip: Fix error handling in attach
In-Reply-To: <20180118115251.5542-5-jeffy.chen@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-5-jeffy.chen@rock-chips.com>
Message-ID: <fa4277ef-ddfe-e23b-034c-167281cf0db1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/18 11:52, Jeffy Chen wrote:
> From: Tomasz Figa <tfiga@chromium.org>
> 
> Currently if the driver encounters an error while attaching device, it
> will leave the IOMMU in an inconsistent state. Even though it shouldn't
> really happen in reality, let's just add proper error path to keep
> things consistent.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> Move irq request to probe(in patch[0])
> 
>   drivers/iommu/rockchip-iommu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index b743d82e6fe1..37065a7127c9 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -824,7 +824,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	ret = rk_iommu_force_reset(iommu);
>   	if (ret)
> -		return ret;
> +		goto err_disable_stall;
>   
>   	iommu->domain = domain;
>   
> @@ -837,7 +837,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	ret = rk_iommu_enable_paging(iommu);
>   	if (ret)
> -		return ret;
> +		goto err_disable_stall;
>   
>   	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>   	list_add_tail(&iommu->node, &rk_domain->iommus);
> @@ -848,6 +848,11 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   	rk_iommu_disable_stall(iommu);
>   
>   	return 0;

Nit: if you like, it looks reasonable to name the label 
"out_disable_stall" and remove these lines above here, to save the 
duplication between the error and success paths (since ret will already 
be 0 on the latter).

Either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
> +err_disable_stall:
> +	rk_iommu_disable_stall(iommu);
> +
> +	return ret;
>   }
>   
>   static void rk_iommu_detach_device(struct iommu_domain *domain,
> 
