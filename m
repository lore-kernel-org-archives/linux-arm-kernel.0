From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 20 Jun 2017 12:35:07 +0100
Subject: [PATCH 1/1] iommu/arm-smmu-v3: replace writel with writel_relaxed
 in queue_inc_prod
In-Reply-To: <1497956694-11784-1-git-send-email-thunder.leizhen@huawei.com>
References: <1497956694-11784-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <acafb87c-4ba9-4a44-f868-c8f882717ab1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 12:04, Zhen Lei wrote:
> This function is protected by spinlock, and the latter will do memory
> barrier implicitly. So that we can safely use writel_relaxed. In fact, the
> dmb operation will lengthen the time protected by lock, which indirectly
> increase the locking confliction in the stress scene.

If you remove the DSB between writing the commands (to Normal memory)
and writing the pointer (to Device memory), how can you guarantee that
the complete command is visible to the SMMU and it isn't going to try to
consume stale memory contents? The spinlock is irrelevant since it's
taken *before* the command is written.

Robin.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 380969a..d2fbee3 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -728,7 +728,7 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>  	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
> 
>  	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> -	writel(q->prod, q->prod_reg);
> +	writel_relaxed(q->prod, q->prod_reg);
>  }
> 
>  /*
> --
> 2.5.0
> 
> 
