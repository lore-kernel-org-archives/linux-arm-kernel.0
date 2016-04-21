From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Apr 2016 17:30:20 +0100
Subject: [PATCH 6/7] iommu/arm-smmu: Decouple context format from kernel
 config
In-Reply-To: <173006777218859d1671ae517c70592c6c02f630.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <173006777218859d1671ae517c70592c6c02f630.1460391217.git.robin.murphy@arm.com>
Message-ID: <20160421163019.GL929@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, Apr 13, 2016 at 06:13:02PM +0100, Robin Murphy wrote:
> The way the driver currently forces an AArch32 or AArch64 context format
> based on the kernel config and SMMU architecture version is suboptimal,
> in that it makes it very hard to support oddball mix-and-match cases
> like the SMMUv1 64KB supplement, or situations where the reduced table
> depth of an AArch32 short descriptor context may be desirable under an
> AArch64 kernel. It also only happens to work on current implementations
> which do support all the relevant formats.
> 
> Introduce an explicit notion of context format, so we can manage that
> independently and get rid of the inflexible #ifdeffery.

Thanks for doing all of this! One comment on the page size stuff:

> +	if (IS_ENABLED(CONFIG_64BIT) || cfg->fmt == ARM_SMMU_CTX_FMT_NONE) {
> +		switch (PAGE_SIZE) {
> +		case SZ_64K:
> +			if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K) {
> +				cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
> +				break;
> +			} /* else fall through */
> +		case SZ_16K:
> +			if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_16K) {
> +				cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
> +				break;
> +			} /* else fall through */
> +		case SZ_4K:
> +			if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_4K)
> +				cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
> +		}
> +	}

The io-pgtable code (arm_lpae_restrict_pgsizes) already does something
*very* similar to this, using the pgsize_bitmap as input. Can you not
just choose the ARM_SMMU_CTX_FMT_AARCH64 here and set the pgsize_bitmap
to represent all page sizes supported by the hardware? That way, you should
end up with the best option coming back from the pgtable code (I do this
in the v3 driver, fwiw).

Will
