From: rric@kernel.org (Robert Richter)
Date: Sat, 6 May 2017 01:03:28 +0200
Subject: [PATCH v3 1/7] iommu/arm-smmu-v3: Introduce SMMU option
 PAGE0_REGS_ONLY for ThunderX2 errata #74
In-Reply-To: <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170505230328.GN4906@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.05.17 17:38:05, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
> and PAGE0_REGS_ONLY option will be enabled as an errata workaround.
> 
> This option when turned on, replaces all page 1 offsets used for
> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 +++
>  drivers/iommu/arm-smmu-v3.c                        | 44 ++++++++++++++++------
>  2 files changed, 38 insertions(+), 12 deletions(-)

> @@ -1995,8 +2011,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
>  
> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
> -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
> +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
> +				       ARM_SMMU_PRIQ_PROD(smmu),
> +				       ARM_SMMU_PRIQ_CONS(smmu),
> +				       PRIQ_ENT_DWORDS);

I would also suggest Robin's idea from the v1 review here. This works
if we rework arm_smmu_init_one_queue() to pass addresses instead of
offsets.

This would make these widespread offset calculations obsolete.

-Robert
