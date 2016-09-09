From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 9 Sep 2016 15:18:29 +0100
Subject: [PATCH] iommu/arm-smmu: Disable interrupts whilst holding the
 cmdq lock
In-Reply-To: <1473429014-17926-1-git-send-email-will.deacon@arm.com>
References: <1473429014-17926-1-git-send-email-will.deacon@arm.com>
Message-ID: <59c5e15e-b937-e966-6419-ef8f3043f505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 09/09/16 14:50, Will Deacon wrote:
> The cmdq lock is taken whenever we issue comments into the command queue,

s/comments/commands/

> which can occur in IRQ context (as a result if unmap) or in process

s/if/of/

> context (as a result of a threaded IRQ handler or device probe).
> 
> This can lead to a theoretical deadlock if the interrupt handler
> performing the unmap hits whilst the lock is taken, so explicitly use
> the {irqsave,irqrestore} spin_lock accessors for the cmdq lock.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Works for me and keeps lockdep quiet, so FWIW

Tested-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

> ---
>  drivers/iommu/arm-smmu-v3.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index c040e246bc59..5db6931c715c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -893,6 +893,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  				    struct arm_smmu_cmdq_ent *ent)
>  {
>  	u64 cmd[CMDQ_ENT_DWORDS];
> +	unsigned long flags;
>  	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>  	struct arm_smmu_queue *q = &smmu->cmdq.q;
>  
> @@ -902,7 +903,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  		return;
>  	}
>  
> -	spin_lock(&smmu->cmdq.lock);
> +	spin_lock_irqsave(&smmu->cmdq.lock, flags);
>  	while (queue_insert_raw(q, cmd) == -ENOSPC) {
>  		if (queue_poll_cons(q, false, wfe))
>  			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> @@ -910,7 +911,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  
>  	if (ent->opcode == CMDQ_OP_CMD_SYNC && queue_poll_cons(q, true, wfe))
>  		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
> -	spin_unlock(&smmu->cmdq.lock);
> +	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>  }
>  
>  /* Context descriptor manipulation functions */
> 
