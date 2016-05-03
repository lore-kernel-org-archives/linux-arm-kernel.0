From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 3 May 2016 12:15:52 +0100
Subject: [PATCH] iommu/arm-smmu: clear cache lock bit of ACR
In-Reply-To: <1462270527-17074-1-git-send-email-van.freenix@gmail.com>
References: <1462270527-17074-1-git-send-email-van.freenix@gmail.com>
Message-ID: <57288868.9020908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/16 11:15, Peng Fan wrote:
> According MMU-500 TRM, section 3.7.1 Auxiliary Control registers,
> You can modify ACTLR only when the ACR.CACHE_LOCK bit is 0.
>
> So before clearing ARM_MMU500_ACTLR_CPRE of each context bank,
> need clear CACHE_LOCK bit of ACR register first.

Ah, good catch - I think I misread CACHE_LOCK as resetting to 0, and 
proceeded to forget about it. However, it's only present in MMU-500r2 
onwards, so we'd also want to check IDR7 before touching ACR.

Thanks,
Robin.

> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Hi Will,
>
>   Patch based on iommu/devel branch.
>
>
>   drivers/iommu/arm-smmu.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index acff332..d094a5a 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -98,6 +98,9 @@
>   #define sCR0_BSU_SHIFT			14
>   #define sCR0_BSU_MASK			0x3
>
> +/* Auxiliary Configuration register */
> +#define ARM_SMMU_GR0_sACR		0x10
> +
>   /* Identification registers */
>   #define ARM_SMMU_GR0_ID0		0x20
>   #define ARM_SMMU_GR0_ID1		0x24
> @@ -235,6 +238,8 @@
>
>   #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
>
> +#define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> +
>   #define CB_PAR_F			(1 << 0)
>
>   #define ATSR_ACTIVE			(1 << 0)
> @@ -1506,6 +1511,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(i));
>   	}
>
> +	/*
> +	 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
> +	 * clear CACHE_LOCK bit of ACR first.
> +	 */
> +	if (smmu->model == ARM_MMU500) {
> +		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
> +		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
> +		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
> +	}
> +
>   	/* Make sure all context banks are disabled and clear CB_FSR  */
>   	for (i = 0; i < smmu->num_context_banks; ++i) {
>   		cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, i);
>
