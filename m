From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 2 Mar 2018 17:57:21 +0000
Subject: [PATCH 02/14] iommu/arm-smmu: Add support for TTBR1
In-Reply-To: <20180221225924.30737-3-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-3-jcrouse@codeaurora.org>
Message-ID: <155a85ea-1c66-ce0b-06b3-d3933d6f54df@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/18 22:59, Jordan Crouse wrote:
> Allow a SMMU device to opt into allocating a TTBR1 pagetable.
> 
> The size of the TTBR1 region will be the same as
> the TTBR0 size with the sign extension bit set on the highest
> bit in the region unless the upstream size is 49 bits and then
> the sign-extension bit will be set on the 49th bit.

Um, isn't the 49th bit still "the highest bit" if the address size is 49 
bits? ;)

> The map/unmap operations will automatically use the appropriate
> pagetable based on the specified iova and the existing mask.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu-regs.h  |   2 -
>   drivers/iommu/arm-smmu.c       |  22 ++++--
>   drivers/iommu/io-pgtable-arm.c | 160 ++++++++++++++++++++++++++++++++++++-----
>   drivers/iommu/io-pgtable-arm.h |  20 ++++++
>   drivers/iommu/io-pgtable.h     |  16 ++++-
>   5 files changed, 192 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..0ce85d5b22e9 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -193,8 +193,6 @@ enum arm_smmu_s2cr_privcfg {
>   #define RESUME_RETRY			(0 << 0)
>   #define RESUME_TERMINATE		(1 << 0)
>   
> -#define TTBCR2_SEP_SHIFT		15
> -#define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
>   #define TTBCR2_AS			(1 << 4)
>   
>   #define TTBRn_ASID_SHIFT		48
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..ebfa59b59622 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -248,6 +248,7 @@ struct arm_smmu_domain {
>   	enum arm_smmu_domain_stage	stage;
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> +	u32 attributes;
>   	struct iommu_domain		domain;
>   };
>   
> @@ -598,7 +599,6 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>   		} else {
>   			cb->tcr[0] = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>   			cb->tcr[1] = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
> -			cb->tcr[1] |= TTBCR2_SEP_UPSTREAM;
>   			if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
>   				cb->tcr[1] |= TTBCR2_AS;
>   		}
> @@ -729,6 +729,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	enum io_pgtable_fmt fmt;
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	unsigned int quirks =
> +		smmu_domain->attributes & (1 << DOMAIN_ATTR_ENABLE_TTBR1) ?
> +			IO_PGTABLE_QUIRK_ARM_TTBR1 : 0;
>   
>   	mutex_lock(&smmu_domain->init_mutex);
>   	if (smmu_domain->smmu)
> @@ -852,7 +855,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	else
>   		cfg->asid = cfg->cbndx + smmu->cavium_id_base;
>   
> +	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> +		quirks |= IO_PGTABLE_QUIRK_NO_DMA;
> +
>   	pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.quirks		= quirks,
>   		.pgsize_bitmap	= smmu->pgsize_bitmap,
>   		.ias		= ias,
>   		.oas		= oas,
> @@ -860,9 +867,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   		.iommu_dev	= smmu->dev,
>   	};
>   
> -	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> -		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> -
>   	smmu_domain->smmu = smmu;
>   	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>   	if (!pgtbl_ops) {
> @@ -1477,6 +1481,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>   	case DOMAIN_ATTR_NESTING:
>   		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>   		return 0;
> +	case DOMAIN_ATTR_ENABLE_TTBR1:
> +		*((int *)data) = !!(smmu_domain->attributes
> +					& (1 << DOMAIN_ATTR_ENABLE_TTBR1));
> +		return 0;
>   	default:
>   		return -ENODEV;
>   	}
> @@ -1505,6 +1513,12 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>   		else
>   			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>   
> +		break;
> +	case DOMAIN_ATTR_ENABLE_TTBR1:
> +		if (*((int *)data))
> +			smmu_domain->attributes |=
> +				1 << DOMAIN_ATTR_ENABLE_TTBR1;
> +		ret = 0;
>   		break;
>   	default:
>   		ret = -ENODEV;
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index fff0b6ba0a69..1bd0045f2cb7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -152,7 +152,7 @@ struct arm_lpae_io_pgtable {
>   	unsigned long		pg_shift;
>   	unsigned long		bits_per_level;
>   
> -	void			*pgd;
> +	void			*pgd[2];

This might be reasonable for short-descriptor, but I really don't like 
it for LPAE. The two tables are more or less independent in terms of 
size, granule, etc., so this brings in a lot of artificial coupling.

I think it would be a lot cleaner for io-pgtable to have little or no 
knowledge of this, and it be down to the caller to allocate two tables 
and merge the TCRs, then dispatch maps/unmaps to the appropriate table 
by itself.

>   };
>   
>   typedef u64 arm_lpae_iopte;
> @@ -394,20 +394,48 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>   	return pte;
>   }
>   
> +static inline arm_lpae_iopte *
> +arm_lpae_get_table(struct arm_lpae_io_pgtable *data, unsigned long iova)
> +{
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)  {
> +		unsigned long mask;
> +
> +		/*
> +		 * if ias is 48 it really means that bit 48 is the sign
> +		 * extension bit, otherwise the sign extension bit is ias - 1
> +		 * (for example, bit 31 for ias 32)
> +		 */
> +		mask = (cfg->ias == 48) ? (1UL << 48) :
> +			(1UL << (cfg->ias - 1));

This would look less silly if it was done in the SMMU driver where the 
original UBS information is directly to hand, instead of having to 
reverse-engineer it from the pagetable config (on every operation, no less).

That said, it's still going to be pretty fragile in general, since on 
SMMUv1 the UBS is merely guessed at from the IPA size, and either way 
all it tells you is what the SMMU knows about its own interfaces; it 
doesn't have a clue how many bits the masters connected to said 
interface(s) are actually capable of driving.

> +
> +		if (iova & mask)
> +			return data->pgd[1];
> +	}
> +
> +	return data->pgd[0];
> +}
> +
>   static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>   			phys_addr_t paddr, size_t size, int iommu_prot)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	arm_lpae_iopte *ptep = data->pgd;
> +	arm_lpae_iopte *ptep;
>   	int ret, lvl = ARM_LPAE_START_LVL(data);
>   	arm_lpae_iopte prot;
>   
> +	ptep = arm_lpae_get_table(data, iova);
> +
>   	/* If no access, then nothing to do */
>   	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>   		return 0;
>   
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> -		    paddr >= (1ULL << data->iop.cfg.oas)))
> +	if (WARN_ON(paddr >= (1ULL << data->iop.cfg.oas)))
> +		return -ERANGE;
> +
> +	if (WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) &&
> +		    iova >= (1ULL << data->iop.cfg.ias)))
>   		return -ERANGE;
>   
>   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> @@ -456,7 +484,10 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(iop);
>   
> -	__arm_lpae_free_pgtable(data, ARM_LPAE_START_LVL(data), data->pgd);
> +	__arm_lpae_free_pgtable(data, ARM_LPAE_START_LVL(data), data->pgd[0]);
> +	if (data->pgd[1])
> +		__arm_lpae_free_pgtable(data, ARM_LPAE_START_LVL(data),
> +			data->pgd[1]);
>   	kfree(data);
>   }
>   
> @@ -564,10 +595,13 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>   			  size_t size)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	arm_lpae_iopte *ptep = data->pgd;
> +	arm_lpae_iopte *ptep;
>   	int lvl = ARM_LPAE_START_LVL(data);
>   
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
> +	ptep = arm_lpae_get_table(data, iova);
> +
> +	if (WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) &&
> +		    iova >= (1ULL << data->iop.cfg.ias)))
>   		return 0;
>   
>   	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
> @@ -577,9 +611,11 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>   					 unsigned long iova)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	arm_lpae_iopte pte, *ptep = data->pgd;
> +	arm_lpae_iopte pte, *ptep;
>   	int lvl = ARM_LPAE_START_LVL(data);
>   
> +	ptep = arm_lpae_get_table(data, iova);
> +
>   	do {
>   		/* Valid IOPTE pointer? */
>   		if (!ptep)
> @@ -689,13 +725,82 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>   	return data;
>   }
>   
> +static u64 arm_64_lpae_setup_ttbr1(struct io_pgtable_cfg *cfg,
> +		struct arm_lpae_io_pgtable *data)
> +
> +{
> +	u64 reg;
> +
> +	/* If TTBR1 is disabled, disable speculative walks through the TTBR1 */
> +	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)) {
> +		reg = ARM_LPAE_TCR_EPD1;
> +		reg |= (ARM_LPAE_TCR_SEP_UPSTREAM << ARM_LPAE_TCR_SEP_SHIFT);
> +		return reg;
> +	}
> +
> +	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH1_SHIFT) |
> +	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN1_SHIFT) |
> +	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN1_SHIFT);
> +
> +	switch (1 << data->pg_shift) {
> +	case SZ_4K:
> +		reg |= ARM_LPAE_TCR_TG1_4K;
> +		break;
> +	case SZ_16K:
> +		reg |= ARM_LPAE_TCR_TG1_16K;
> +		break;
> +	case SZ_64K:
> +		reg |= ARM_LPAE_TCR_TG1_64K;
> +		break;
> +	}
> +
> +	/* Set T1SZ */
> +	reg |= (64ULL - cfg->ias) << ARM_LPAE_TCR_T1SZ_SHIFT;
> +
> +	/* Set the SEP bit based on the size */
> +	switch (cfg->ias) {
> +	case 32:
> +		reg |= (ARM_LPAE_TCR_SEP_31 << ARM_LPAE_TCR_SEP_SHIFT);
> +		break;
> +	case 36:
> +		reg |= (ARM_LPAE_TCR_SEP_35 << ARM_LPAE_TCR_SEP_SHIFT);
> +		break;
> +	case 40:
> +		reg |= (ARM_LPAE_TCR_SEP_39 << ARM_LPAE_TCR_SEP_SHIFT);
> +		break;
> +	case 42:
> +		reg |= (ARM_LPAE_TCR_SEP_41 << ARM_LPAE_TCR_SEP_SHIFT);
> +		break;
> +	case 44:
> +		reg |= (ARM_LPAE_TCR_SEP_43 << ARM_LPAE_TCR_SEP_SHIFT);
> +		break;
> +	case 48:
> +		/*
> +		 * If ias is 48 then that probably means that the UBS on the
> +		 * device was 0101b (49) which is a special case that assumes
> +		 * bit 48 is the sign extension bit. In this case we are
> +		 * expected to use ARM_LPAE_TCR_SEP_UPSTREAM to use bit 48 as
> +		 * the extension bit. One might be confused because there is
> +		 * also an option to set the SEP to bit 47 but this is probably
> +		 * not what the arm-smmu driver intended.
> +		 */

Again, a clear sign that this probably isn't the most appropriate place 
to be trying to handle this.

> +	default:
> +		reg |= (ARM_LPAE_TCR_SEP_UPSTREAM << ARM_LPAE_TCR_SEP_SHIFT);
> +		break;
> +	}
> +
> +	return reg;
> +}
> +
>   static struct io_pgtable *
>   arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   {
>   	u64 reg;
>   	struct arm_lpae_io_pgtable *data;
>   
> -	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
> +	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> +			IO_PGTABLE_QUIRK_NO_DMA |
> +			IO_PGTABLE_QUIRK_ARM_TTBR1))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -744,8 +849,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	reg |= (64ULL - cfg->ias) << ARM_LPAE_TCR_T0SZ_SHIFT;
>   
> -	/* Disable speculative walks through TTBR1 */
> -	reg |= ARM_LPAE_TCR_EPD1;
> +	/* Bring in the TTBR1 configuration */
> +	reg |= arm_64_lpae_setup_ttbr1(cfg, data);
> +
>   	cfg->arm_lpae_s1_cfg.tcr = reg;
>   
>   	/* MAIRs */
> @@ -760,16 +866,32 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   	cfg->arm_lpae_s1_cfg.mair[1] = 0;
>   
>   	/* Looking good; allocate a pgd */
> -	data->pgd = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
> -	if (!data->pgd)
> +	data->pgd[0] = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
> +	if (!data->pgd[0])
>   		goto out_free_data;
>   
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +		data->pgd[1] = __arm_lpae_alloc_pages(data->pgd_size,
> +			GFP_KERNEL, cfg);
> +		if (!data->pgd[1]) {
> +			__arm_lpae_free_pages(data->pgd[0], data->pgd_size,
> +				cfg);
> +			goto out_free_data;
> +		}
> +	} else {
> +		data->pgd[1] = NULL;
> +	}
> +
>   	/* Ensure the empty pgd is visible before any actual TTBR write */
>   	wmb();
>   
>   	/* TTBRs */
> -	cfg->arm_lpae_s1_cfg.ttbr[0] = virt_to_phys(data->pgd);
> -	cfg->arm_lpae_s1_cfg.ttbr[1] = 0;
> +	cfg->arm_lpae_s1_cfg.ttbr[0] = virt_to_phys(data->pgd[0]);
> +
> +	if (data->pgd[1])
> +		cfg->arm_lpae_s1_cfg.ttbr[1] = virt_to_phys(data->pgd[1]);
> +
>   	return &data->iop;
>   
>   out_free_data:
> @@ -854,15 +976,15 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   	cfg->arm_lpae_s2_cfg.vtcr = reg;
>   
>   	/* Allocate pgd pages */
> -	data->pgd = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
> -	if (!data->pgd)
> +	data->pgd[0] = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
> +	if (!data->pgd[0])
>   		goto out_free_data;
>   
>   	/* Ensure the empty pgd is visible before any actual TTBR write */
>   	wmb();
>   
>   	/* VTTBR */
> -	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
> +	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd[0]);
>   	return &data->iop;
>   
>   out_free_data:
> @@ -960,7 +1082,7 @@ static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
>   		cfg->pgsize_bitmap, cfg->ias);
>   	pr_err("data: %d levels, 0x%zx pgd_size, %lu pg_shift, %lu bits_per_level, pgd @ %p\n",
>   		data->levels, data->pgd_size, data->pg_shift,
> -		data->bits_per_level, data->pgd);
> +		data->bits_per_level, data->pgd[0]);
>   }
>   
>   #define __FAIL(ops, i)	({						\
> diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
> index cb31314971ac..6344b1d359a5 100644
> --- a/drivers/iommu/io-pgtable-arm.h
> +++ b/drivers/iommu/io-pgtable-arm.h
> @@ -25,14 +25,21 @@
>   #define ARM_LPAE_TCR_TG0_64K		(1 << 14)
>   #define ARM_LPAE_TCR_TG0_16K		(2 << 14)
>   
> +#define ARM_LPAE_TCR_TG1_16K            (1 << 30)
> +#define ARM_LPAE_TCR_TG1_4K             (2 << 30)
> +#define ARM_LPAE_TCR_TG1_64K            (3 << 30)
> +
>   #define ARM_LPAE_TCR_SH0_SHIFT		12
> +#define ARM_LPAE_TCR_SH1_SHIFT		28
>   #define ARM_LPAE_TCR_SH0_MASK		0x3
>   #define ARM_LPAE_TCR_SH_NS		0
>   #define ARM_LPAE_TCR_SH_OS		2
>   #define ARM_LPAE_TCR_SH_IS		3
>   
>   #define ARM_LPAE_TCR_ORGN0_SHIFT	10
> +#define ARM_LPAE_TCR_ORGN1_SHIFT	26
>   #define ARM_LPAE_TCR_IRGN0_SHIFT	8
> +#define ARM_LPAE_TCR_IRGN1_SHIFT	24
>   #define ARM_LPAE_TCR_RGN_MASK		0x3
>   #define ARM_LPAE_TCR_RGN_NC		0
>   #define ARM_LPAE_TCR_RGN_WBWA		1
> @@ -45,6 +52,9 @@
>   #define ARM_LPAE_TCR_T0SZ_SHIFT		0
>   #define ARM_LPAE_TCR_SZ_MASK		0x3f
>   
> +#define ARM_LPAE_TCR_T1SZ_SHIFT         16
> +#define ARM_LPAE_TCR_T1SZ_MASK          0x3f
> +
>   #define ARM_LPAE_TCR_PS_SHIFT		16
>   #define ARM_LPAE_TCR_PS_MASK		0x7
>   
> @@ -58,6 +68,16 @@
>   #define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
>   #define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
>   
> +#define ARM_LPAE_TCR_SEP_SHIFT		(15 + 32)
> +
> +#define ARM_LPAE_TCR_SEP_31		0x0ULL
> +#define ARM_LPAE_TCR_SEP_35		0x1ULL
> +#define ARM_LPAE_TCR_SEP_39		0x2ULL
> +#define ARM_LPAE_TCR_SEP_41		0x3ULL
> +#define ARM_LPAE_TCR_SEP_43		0x4ULL
> +#define ARM_LPAE_TCR_SEP_47		0x5ULL
> +#define ARM_LPAE_TCR_SEP_UPSTREAM	0x7ULL
> +
>   #define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
>   #define ARM_LPAE_MAIR_ATTR_MASK		0xff
>   #define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index cd2e1eafffe6..55f7b60cc44d 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -71,12 +71,18 @@ struct io_pgtable_cfg {
>   	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
>   	 *	software-emulated IOMMU), such that pagetable updates need not
>   	 *	be treated as explicit DMA data.
> +	 *
> +	 * PGTABLE_QUIRK_ARM_TTBR1: Specifies that TTBR1 has been enabled on
> +	 *	this domain. Set up the configuration registers and dyanmically
> +	 *      choose which pagetable (TTBR0 or TTBR1) a mapping should go into
> +	 *	based on the address.
>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
>   	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
>   	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
> +	#define IO_PGTABLE_QUIRK_ARM_TTBR1      BIT(5)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> @@ -173,18 +179,22 @@ struct io_pgtable {
>   
>   static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
>   {
> -	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> +	if (iop->cfg.tlb)
> +		iop->cfg.tlb->tlb_flush_all(iop->cookie);

What's going on here?

It's not obvious how this change is relevant to TTBR1 support, and 
either way I can't see how an io_pgtable with no TLB ops wouldn't just 
be fundamentally broken.

Robin.

>   }
>   
>   static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
>   		unsigned long iova, size_t size, size_t granule, bool leaf)
>   {
> -	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
> +	if (iop->cfg.tlb)
> +		iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf,
> +			iop->cookie);
>   }
>   
>   static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
>   {
> -	iop->cfg.tlb->tlb_sync(iop->cookie);
> +	if (iop->cfg.tlb)
> +		iop->cfg.tlb->tlb_sync(iop->cookie);
>   }
>   
>   /**
> 
