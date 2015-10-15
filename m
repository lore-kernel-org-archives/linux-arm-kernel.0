From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2015 11:36:12 +0100
Subject: [PATCH v3 09/24] arm64: Keep track of CPU feature registers
In-Reply-To: <1444756952-31145-10-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <1444756952-31145-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151015103611.GK4239@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

Some minor comments below.

On Tue, Oct 13, 2015 at 06:22:17PM +0100, Suzuki K. Poulose wrote:
> This patch adds an infrastructure to keep track of the CPU feature
> registers on the system. For each register, the infrastructure keeps
> track of the system wide safe value of the feature bits. Also, tracks
> the which fields of a register should be matched strictly across all
> the CPUs on the system for the SANITY check infrastructure.
> 
> The feature bits are classified as one of SCALAR_MIN, SCALAR_MAX and DISCRETE
> depending on the implication of the possible values. This information
> is used to decide the safe value for a feature.
> 
> LOWER_SAFE  - The smaller value is safer
> HIGHER_SAFE - The bigger value is safer
> EXACT       - We can't decide between the two, so a predefined safe_value is used.

The "SCALAR..." etc. in the comment needs updating.

> +#define FTR_STRICT	true
> +#define FTR_NONSTRICT	false

Please add a comment on what STRICT/NONSTRICT mean.

> +static inline u64 ftr_mask(struct arm64_ftr_bits *ftrp)
> +{
> +	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
> +}
> +
> +static inline s64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 val)
> +{
> +	return cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width);
> +}

Slightly inconsistent naming: since you are prefixing everything with
arm64_, do the same for ftr_mask.

> +static struct arm64_ftr_reg arm64_ftr_regs[] = {
> +
> +	/* This array should be always kept in the ascending order of id  */

Do we have a sanity check somewhere? You could also call sort() on this
array and we wouldn't have to worry.

> +/*
> + * get_arm64_sys_reg - Lookup a feature register entry using its
> + * sys_reg() encoding. With the array arm64_ftr_regs sorted in the
> + * ascending order, we use binary search to find a matching entry.
> + *
> + * returns - Upon success,  matching ftr_reg entry for id.
> + *         - NULL on failure. It is upto the caller to decide
> + *	     the impact of a failure.
> + */
> +static struct arm64_ftr_reg* get_arm64_sys_reg(u32 sys_id)

Nitpick: the * near the function name.

Also rename it to get_arm64_ftr_reg() to match the actual return type.

-- 
Catalin
