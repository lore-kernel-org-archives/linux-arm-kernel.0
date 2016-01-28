From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 28 Jan 2016 17:10:33 +0000
Subject: [RFC PATCH 5/6] iommu/arm-smmu: Option to treat instruction fetch
 as data read for SMMUv2
In-Reply-To: <1453872079-27140-6-git-send-email-anup.patel@broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-6-git-send-email-anup.patel@broadcom.com>
Message-ID: <56AA4B89.3040400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/16 05:21, Anup Patel wrote:
> Currently, the SMMU driver by default provides unprivilege read-write
> permission in page table entries of stage1 page table. For SMMUv2 with
> aarch64 long descriptor format, a privilege instruction fetch will
> generate context fault. To allow privilege instruction fetch from a
> MMU master we need to treat instruction fetch as data read.
>
> This patch adds an optional DT attribute 'smmu-inst-as-data' to treat
> privilege/unprivilege instruction fetch as data read for SMMUv2.

What's the use-case for retaining the privilege attribute over the 
instruction attribute? The pagetable code still maps everything with 
unprivileged permissions, and it isn't going to be relevant for the vast 
majority of devices. Conversely, the instruction/data distinction is 
likely to be useful in a lot more cases - there's a veritable class of 
exploits around tricking a DSP/GPU/VPU/whatever into executing malicious 
firmware/shaders/etc. - and the IOMMU API does already have support for 
that which this change subtly undermines: if you override INSTCFG this 
way, you also need to stop the SMMU from claiming to support 
IOMMU_NOEXEC, because it no longer will.

> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   drivers/iommu/arm-smmu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 43424fe..a14850b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -169,6 +169,9 @@
>   #define S2CR_TYPE_TRANS			(0 << S2CR_TYPE_SHIFT)
>   #define S2CR_TYPE_BYPASS		(1 << S2CR_TYPE_SHIFT)
>   #define S2CR_TYPE_FAULT			(2 << S2CR_TYPE_SHIFT)
> +#define S2CR_INSTCFG_SHIFT		26
> +#define S2CR_INSTCFG_MASK		0x3
> +#define S2CR_INSTCFG_DATA		(0x2 << S2CR_INSTCFG_SHIFT)
>
>   /* Context bank attribute registers */
>   #define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))
> @@ -305,6 +308,7 @@ struct arm_smmu_device {
>   	u32				features;
>
>   #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> +#define ARM_SMMU_OPT_INST_AS_DATA      (1 << 1)
>   	u32				options;
>   	enum arm_smmu_arch_version	version;
>
> @@ -366,6 +370,7 @@ struct arm_smmu_option_prop {
>
>   static struct arm_smmu_option_prop arm_smmu_options[] = {
>   	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
> +	{ ARM_SMMU_OPT_INST_AS_DATA, "smmu-inst-as-data" },
>   	{ 0, NULL},
>   };
>
> @@ -1097,6 +1102,9 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>   		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
>   		s2cr = S2CR_TYPE_TRANS |
>   		       (smmu_domain->cfg.cbndx << S2CR_CBNDX_SHIFT);
> +		if ((smmu->version == ARM_SMMU_V2) &&

I would say this is too broad a condition - there's still no need to do 
this for AArch32 contexts at stage 1, and there's no need for it at 
stage 2 at all.

Robin.

> +		    (smmu->options & ARM_SMMU_OPT_INST_AS_DATA))
> +			s2cr |= S2CR_INSTCFG_DATA;
>   		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
>   	}
>
>
