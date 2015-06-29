From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jun 2015 18:26:22 +0100
Subject: [PATCH 4/8] iommu/arm-smmu: set EPD1 to disable TT1 translation
 table walk
In-Reply-To: <1435307584-9812-5-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
 <1435307584-9812-5-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20150629172622.GK17474@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 09:33:00AM +0100, Zhen Lei wrote:
> Now we only use TT0 translation, disable TT1 translation will safer.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 43120ad..6d6712e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -285,6 +285,7 @@
>  #define ARM64_TCR_EPD1_MASK		0x1UL
> 
>  #define CTXDESC_CD_0_ENDI		(1UL << 15)
> +#define CTXDESC_CD_0_EPD1		(1UL << 30)
>  #define CTXDESC_CD_0_V			(1UL << 31)
> 
>  #define CTXDESC_CD_0_TCR_IPS_SHIFT	32
> @@ -893,7 +894,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>  #endif
>  	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
>  	      CTXDESC_CD_0_AA64 | (u64)cfg->cd.asid << CTXDESC_CD_0_ASID_SHIFT |
> -	      CTXDESC_CD_0_V;
> +	      CTXDESC_CD_0_EPD1 | CTXDESC_CD_0_V;


This is redundant. EPD1 is already set by the io-pgtable code.

Will
