From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 12 Jul 2016 10:36:06 +0100
Subject: [PATCH] iommu/arm-smmu-v3: limit use of 2-level stream tables
In-Reply-To: <1468260059-10759-1-git-send-email-nwatters@codeaurora.org>
References: <1468260059-10759-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <5784BA06.2020607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/16 19:00, Nate Watterson wrote:
> In the current arm-smmu-v3 driver, all smmus that support 2-level
> stream tables are being forced to use them. This is suboptimal for
> smmus that support fewer stream id bits than would fill in a single
> second level table. This patch limits the use of 2-level tables to
> smmus that both support the feature and whose first level table can
> possibly contain more than a single entry.

Makes sense to me, in principle.

> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5f6b3bc..742254c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2531,6 +2531,17 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>  	smmu->ssid_bits = reg >> IDR1_SSID_SHIFT & IDR1_SSID_MASK;
>  	smmu->sid_bits = reg >> IDR1_SID_SHIFT & IDR1_SID_MASK;
>  
> +	/*
> +	 * If the SMMU supports fewer bits than would fill a single L2 stream
> +	 * table, use a linear table instead.
> +	 */
> +	if (smmu->sid_bits <= STRTAB_SPLIT &&
> +	    smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> +		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> +		dev_info(smmu->dev, "SIDSIZE (%d) <= STRTAB_SPLIT (%d) : disabling 2-level stream tables\n",
> +			 smmu->sid_bits, STRTAB_SPLIT);

There's no useful reason to squawk about this; it's just noise.

Whatever old version of the spec I have here would appear to agree: "In
all cases, aside from the lookup of the STE itself, the choice of Stream
Table format is irrelevant to any other SMMU operation."

> +	}
> +
>  	/* IDR5 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);

I think this now leaves some of the logic in arm_smmu_init_strtab_2lvl()
redundant, so it would probably be worth tidying that up at the same time.

Robin.
