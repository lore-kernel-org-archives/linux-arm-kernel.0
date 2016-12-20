From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Dec 2016 09:53:41 +0000
Subject: [PATCH] iommu/arm-smmu-v3: prevent corruption of ste stage-1
 context ptr
In-Reply-To: <1482179918-4457-1-git-send-email-nwatters@codeaurora.org>
References: <1482179918-4457-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <20161220095340.GB10132@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nate,

Thanks for the patch.

On Mon, Dec 19, 2016 at 03:38:38PM -0500, Nate Watterson wrote:
> To ensure that the stage-1 context ptr for an ste points to the
> intended context descriptor, this patch adds code to clear away
> the stale context ptr value prior to or'ing in the new one.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4d6ec44..093f9f1 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1080,6 +1080,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>  		if (smmu->features & ARM_SMMU_FEAT_STALLS)
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
> +		val &= ~(STRTAB_STE_0_S1CTXPTR_MASK <<
> +			 STRTAB_STE_0_S1CTXPTR_SHIFT);
>  		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
>  		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
>  			STRTAB_STE_0_CFG_S1_TRANS;

Good catch. We only clear the Config field at present, although I think
it would be better if we just did val = 0 instead of clearing the Config
field, and then just recreate all of the S1-related fields (ctxptr, fmt,
cdmax) if we're installing a stage-1 STE. The other STE fields aren't
treated as read-modify-write, so it's more consistent not to treat the
initial dword specially other than for determining ste_live.

What do you think?

Will
