From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jun 2015 18:05:18 +0100
Subject: [PATCH 1/8] iommu/arm-smmu: fix the assignment of log2size field
In-Reply-To: <1435307584-9812-2-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
 <1435307584-9812-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20150629170517.GH17474@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhen Lei,

On Fri, Jun 26, 2015 at 09:32:57AM +0100, Zhen Lei wrote:
> Add a new local variable to store the value of log2size, so that it will
> not be overridden by L1 table size.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f141301..ba7fe2d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2021,19 +2021,19 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  {
>  	void *strtab;
>  	u64 reg;
> -	u32 size;
> +	u32 size, log2size;
>  	int ret;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> 
>  	/* Calculate the L1 size, capped to the SIDSIZE */
> -	size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
> -	size = min(size, smmu->sid_bits - STRTAB_SPLIT);
> -	if (size + STRTAB_SPLIT < smmu->sid_bits)
> +	log2size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
> +	log2size = min(log2size, smmu->sid_bits - STRTAB_SPLIT);
> +	if (log2size + STRTAB_SPLIT < smmu->sid_bits)

I still think this is wrong. LOG2SIZE should correspond to the whole
stream-table, not just the first level. How about the (totally untested)
patch below, instead?

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8e9ec81ce4bb..1942a45f68b2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2020,21 +2020,23 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 {
 	void *strtab;
 	u64 reg;
-	u32 size;
+	u32 size, l1size;
 	int ret;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 
 	/* Calculate the L1 size, capped to the SIDSIZE */
 	size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
 	size = min(size, smmu->sid_bits - STRTAB_SPLIT);
-	if (size + STRTAB_SPLIT < smmu->sid_bits)
+	cfg->num_l1_ents = 1 << size;
+
+	size += STRTAB_SPLIT;
+	if (size < smmu->sid_bits)
 		dev_warn(smmu->dev,
 			 "2-level strtab only covers %u/%u bits of SID\n",
-			 size + STRTAB_SPLIT, smmu->sid_bits);
+			 size, smmu->sid_bits);
 
-	cfg->num_l1_ents = 1 << size;
-	size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
-	strtab = dma_zalloc_coherent(smmu->dev, size, &cfg->strtab_dma,
+	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
+	strtab = dma_zalloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
 				     GFP_KERNEL);
 	if (!strtab) {
 		dev_err(smmu->dev,
@@ -2055,8 +2057,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	ret = arm_smmu_init_l1_strtab(smmu);
 	if (ret)
 		dma_free_coherent(smmu->dev,
-				  cfg->num_l1_ents *
-				  (STRTAB_L1_DESC_DWORDS << 3),
+				  l1size,
 				  strtab,
 				  cfg->strtab_dma);
 	return ret;
