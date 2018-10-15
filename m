From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 15 Oct 2018 14:00:16 +0100
Subject: [PATCH 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806
 SoC erratum #582743
In-Reply-To: <1539604846-21151-3-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-3-git-send-email-hannah@marvell.com>
Message-ID: <8a7eefcf-6a77-8dc1-2ce9-9bb7395a3bb7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanna,

On 15/10/18 13:00, hannah at marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit
> to ARM SMMUv2 registers.
> This patch split the writeq/readq to two accesses of writel/readl.
> 
> Note that separate writes/reads to 2 is not problem regards to atomicity,
> because the driver use the readq/writeq while initialize the SMMU, report
> for SMMU fault, and use spinlock in one case (iova_to_phys).

In general, this doesn't work. Here's what the SMMU spec says about 
SMMU_CBn_TLBIVA, but others are similar:

"If SMMU_CBA2Rn.VA64 is one, then AArch64 format is selected. The 
programmer should use 64 bit accesses to this register. If 32-bit 
accesses are used then writes to the top 32 bits are ignored and writes 
to the lower 32 bits are zero extended."

If your interconnect won't let 64-bit transactions through, then you 
can't use AArch64 format at stage 1 at all, since there's no way to 
invalidate entries with the correct ASID, and you'll have to restrict 
stage 2 formats to at most 44-bit IOVAs in order for TLBIIPAS2{L} not to 
invalidate the wrong thing.

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> ---
>   Documentation/arm64/silicon-errata.txt |  2 ++
>   drivers/iommu/arm-smmu.c               | 33 +++++++++++++++++++++++++++++----
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 3b2f2dd..fc3f2a0 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -67,6 +67,8 @@ stable kernels.
>   | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>   | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>   |                |                 |                 |                             |
> +| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
> +|                |                 |                 |                             |

Nit: the convention here seems to be at least alphabetically sorted by 
Implementer.

>   | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>   |                |                 |                 |                             |
>   | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fccb1d4..d64f892 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -119,6 +119,7 @@ enum arm_smmu_arch_version {
>   enum arm_smmu_implementation {
>   	GENERIC_SMMU,
>   	ARM_MMU500,
> +	MRVL_MMU500,

Is there any actually modification to the MMU-500 RTL itself here, or is 
the problem just in the interconnect in front of the SMMU programming 
interface? I would normally assume the latter, in which case treating it 
as a separate implementation isn't really accurate, and I'd much rather 
handle any workaround via smmu->options, just like the secure access 
workaround (which is a similar integration issue).

Robin.

>   	CAVIUM_SMMUV2,
>   };
>   
> @@ -276,13 +277,35 @@ static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
>   				       u64 val,
>   				       void __iomem *addr)
>   {
> -	writeq_relaxed(val, addr);
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the writeq to double writel
> +	 */
> +	if (smmu->model != MRVL_MMU500) {
> +		writeq_relaxed(val, addr);
> +		return;
> +	}
> +
> +	writel_relaxed(upper_32_bits(val), addr + 4);
> +	writel_relaxed(lower_32_bits(val), addr);
>   }
>   
>   static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
>   				     void __iomem *addr)
>   {
> -	return readq_relaxed(addr);
> +	u64 val;
> +
> +	/*
> +	 * Marvell Armada-AP806 erratum #582743.
> +	 * Split all the readq to double readl
> +	 */
> +	if (smmu->model != MRVL_MMU500)
> +		return readq_relaxed(addr);
> +
> +	val = (u64)readl_relaxed(addr + 4) << 32;
> +	val |= readl_relaxed(addr);
> +
> +	return val;
>   }
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
> @@ -1611,7 +1634,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   	for (i = 0; i < smmu->num_mapping_groups; ++i)
>   		arm_smmu_write_sme(smmu, i);
>   
> -	if (smmu->model == ARM_MMU500) {
> +	if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
>   		/*
>   		 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
>   		 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
> @@ -1640,7 +1663,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   		 * Disable MMU-500's not-particularly-beneficial next-page
>   		 * prefetcher for the sake of errata #841119 and #826419.
>   		 */
> -		if (smmu->model == ARM_MMU500) {
> +		if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
>   			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
>   			reg &= ~ARM_MMU500_ACTLR_CPRE;
>   			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);
> @@ -1923,6 +1946,7 @@ struct arm_smmu_match_data {
>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> +ARM_SMMU_MATCH_DATA(mrvl_mmu500, ARM_SMMU_V2, MRVL_MMU500);
>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>   
>   static const struct of_device_id arm_smmu_of_match[] = {
> @@ -1931,6 +1955,7 @@ struct arm_smmu_match_data {
>   	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
>   	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>   	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
> +	{ .compatible = "marvell,mmu-500", .data = &mrvl_mmu500 },
>   	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
>   	{ },
>   };
> 
