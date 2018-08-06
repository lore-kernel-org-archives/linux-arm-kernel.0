From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 06 Aug 2018 14:09:38 +0200
Subject: [PATCH] iommu/rockchip: Handle errors returned from PM framework
In-Reply-To: <20180805124616.18020-1-marc.zyngier@arm.com>
References: <20180805124616.18020-1-marc.zyngier@arm.com>
Message-ID: <2071881.EAoDzUiQGL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Am Sonntag, 5. August 2018, 14:46:16 CEST schrieb Marc Zyngier:
> pm_runtime_get_if_in_use can fail: either PM has been disabled
> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> Sadly, we ignore the first case at the moment, and end up treating
> it as if we had received a valid interrupt.
> 
> The first case could happen because the interrupt line is shared
> (with the VOP for example), and although that device hasn't been
> programmed yet, an interrupt may be pending (think kexec/kdump).
> 
> The second case means that we've enabled the IOMMU, but it is
> not powered-on just yet. This could be another instance of the
> above, but as it deserves investigation, let's output a single
> warning (instead of flodding the console).
> 
> In both cases, bail with an IRQ_NONE.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Hmm, maybe my thinking is flawed, but to me it looks a bit different.

I.e. the iommu, as well as the vop have the capability to check if the irq
is for them via their status registers (INT_STATUS and MMU_STATUS).

For this to happen the power-domain must be active and the device clocked.
Clock handling is done on both the vop and iommu and in the !CONFIG_PM
case all power-domains are left on.

Right now a !CONFIG_PM just passes through the driver unnoticed but with
this change, we would actually make it depend on PM?

What am I missing?

Also there are quite a bit more instances of pm_runtime_get_if_in_use
present in the iommu driver.


Heiko

>  drivers/iommu/rockchip-iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 054cd2c8e9c8..9d21495a8433 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -521,10 +521,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>  	u32 int_status;
>  	dma_addr_t iova;
>  	irqreturn_t ret = IRQ_NONE;
> -	int i;
> +	int i, err;
>  
> -	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
> -		return 0;
> +	err = pm_runtime_get_if_in_use(iommu->dev);
> +	if ((err < 0) || WARN_ON_ONCE(!err))
> +		return ret;
>  
>  	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>  		goto out;
> 
