From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Sep 2013 16:42:52 +0100
Subject: [PATCH 7/7] iommu/arm-smmu: Clear global and context bank fault
 status and syndrome registers
In-Reply-To: <1380035221-11576-8-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-8-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20130924154252.GG20774@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 04:07:01PM +0100, Andreas Herrmann wrote:
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 251564e..a499146 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -645,6 +645,10 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
>  	stage1 = root_cfg->cbar != CBAR_TYPE_S2_TRANS;
>  	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
>  
> +	/* clear fsr */
> +	writel_relaxed(0xffffffff, cb_base + ARM_SMMU_CB_FSR);
> +	writel_relaxed(0, cb_base + ARM_SMMU_CB_FSYNR0);
> +
>  	/* CBAR */
>  	reg = root_cfg->cbar;
>  	if (smmu->version == 1)
> @@ -1570,6 +1574,11 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	int i = 0;
>  	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
>  
> +	/* clear global FSRs */
> +	writel(0xffffffff, gr0_base + ARM_SMMU_GR0_sGFSR);
> +	writel(0, gr0_base + ARM_SMMU_GR0_sGFSYNR0);
> +	writel(0, gr0_base + ARM_SMMU_GR0_sGFSYNR1);

Why do you need this?

Will
