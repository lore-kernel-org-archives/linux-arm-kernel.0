From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Fri, 27 Jul 2018 17:41:46 +0800
Subject: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
 register
In-Reply-To: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <dfeaf347-afd4-b3f2-eb01-2781028371e8@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I saw it in your trees, is it necessary to Cc stable version?

Cheers,
Shaokun

On 2018/7/23 20:56, Shaokun Zhang wrote:
> From: Miao Zhong <zhongmiao@hisilicon.com>
> 
> When PRI queue occurs overflow, driver should update the OVACKFLG to
> the PRIQ consumer register, otherwise subsequent PRI requests will not
> be processed.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com> 
> Signed-off-by: Miao Zhong <zhongmiao@hisilicon.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..deacc15 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1301,6 +1301,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>  
>  	/* Sync our overflow flag, as we believe we're up to speed */
>  	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
> +	writel(q->cons, q->cons_reg);
>  	return IRQ_HANDLED;
>  }
>  
> 
