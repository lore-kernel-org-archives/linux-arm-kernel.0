From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Aug 2014 10:41:55 +0100
Subject: [PATCH v1 1/2] iommu/arm-smmu: Fix programming of SMMU_CBn_TCR
 for stage 1
In-Reply-To: <1407113264-23426-2-git-send-email-ohaugan@codeaurora.org>
References: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
 <1407113264-23426-2-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140804094155.GC15117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olav,

On Mon, Aug 04, 2014 at 01:47:43AM +0100, Olav Haugan wrote:
> Stage-1 context bank does not have SMMU_CBn_TCR[SL0] field. SL0 field
> is only applicable to stage-2 context banks.

Ha, I actually noticed this last week but didn't get around to writing a
a fix. Thanks for taking a look!

> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ff6633d..a83ca6a 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -833,6 +833,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
>  				reg |= (TTBCR2_ADDR_48 << TTBCR_PASIZE_SHIFT);
>  				break;
>  			}
> +			reg |= (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
> +

I think this block is all predicated on smmu->version > 1, so we need
something for stage2 CBs on SMMUv1 too.

Will
