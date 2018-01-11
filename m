From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Jan 2018 15:47:27 +0000
Subject: [PATCH 2/9] iommu/rockchip: Fix error handling in attach
In-Reply-To: <20180111082229.24011-3-jeffy.chen@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
 <20180111082229.24011-3-jeffy.chen@rock-chips.com>
Message-ID: <427ecf29-2024-b746-c567-903c1ce02e75@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/18 08:22, Jeffy Chen wrote:
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
>   drivers/iommu/rockchip-iommu.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9d991c2d8767..ee805e1dfba7 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -826,17 +826,10 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	ret = rk_iommu_force_reset(iommu);
>   	if (ret)
> -		return ret;
> +		goto err_disable_stall;
>   
>   	iommu->domain = domain;
>   
> -	for (i = 0; i < iommu->num_irq; i++) {
> -		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
> -				       IRQF_SHARED, dev_name(dev), iommu);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>   			       rk_domain->dt_dma);
> @@ -844,9 +837,16 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
>   	}
>   
> +	for (i = 0; i < iommu->num_irq; i++) {
> +		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
> +				       IRQF_SHARED, dev_name(dev), iommu);

Why aren't we simply requesting the IRQ once in rk_iommu_probe()? Given 
that the hardware doesn't handle multiple translation contexts, there 
doesn't seem to be much point in being this dynamic about it.

Robin.

> +		if (ret)
> +			goto err_free_irq;
> +	}
> +
>   	ret = rk_iommu_enable_paging(iommu);
>   	if (ret)
> -		return ret;
> +		goto err_free_irq;
>   
>   	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>   	list_add_tail(&iommu->node, &rk_domain->iommus);
> @@ -857,6 +857,14 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   	rk_iommu_disable_stall(iommu);
>   
>   	return 0;
> +
> +err_free_irq:
> +	while (i--)
> +		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
> +err_disable_stall:
> +	rk_iommu_disable_stall(iommu);
> +
> +	return ret;
>   }
>   
>   static void rk_iommu_detach_device(struct iommu_domain *domain,
> 
