From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 22 Aug 2017 17:41:42 +0200
Subject: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to
 reduce lock confliction
In-Reply-To: <1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
 <1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20170822154142.GA19533@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 09:38:46PM +0800, Zhen Lei wrote:
> -static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
> +static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent, int optimize)
>  {
>  	if (queue_full(q))
>  		return -ENOSPC;
>  
>  	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
> -	queue_inc_prod(q);
> +
> +	/*
> +	 * We don't want too many commands to be delayed, this may lead the
> +	 * followed sync command to wait for a long time.
> +	 */
> +	if (optimize && (++q->nr_delay < CMDQ_MAX_DELAYED)) {
> +		queue_inc_swprod(q);
> +	} else {
> +		queue_inc_prod(q);
> +		q->nr_delay = 0;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -909,6 +928,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
>  static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  				    struct arm_smmu_cmdq_ent *ent)
>  {
> +	int optimize = 0;
>  	u64 cmd[CMDQ_ENT_DWORDS];
>  	unsigned long flags;
>  	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> @@ -920,8 +940,17 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  		return;
>  	}
>  
> +	/*
> +	 * All TLBI commands should be followed by a sync command later.
> +	 * The CFGI commands is the same, but they are rarely executed.
> +	 * So just optimize TLBI commands now, to reduce the "if" judgement.
> +	 */
> +	if ((ent->opcode >= CMDQ_OP_TLBI_NH_ALL) &&
> +	    (ent->opcode <= CMDQ_OP_TLBI_NSNH_ALL))
> +		optimize = 1;
> +
>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -	while (queue_insert_raw(q, cmd) == -ENOSPC) {
> +	while (queue_insert_raw(q, cmd, optimize) == -ENOSPC) {
>  		if (queue_poll_cons(q, false, wfe))
>  			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>  	}

This doesn't look correct. How do you make sure that a given IOVA range
is flushed before the addresses are reused?


Regards,

	Joerg
