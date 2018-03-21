From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Mar 2018 15:31:19 +0000
Subject: [PATCH v4 22/22] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
In-Reply-To: <20180313115120.17256-23-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-23-suzuki.poulose@arm.com>
Message-ID: <20180321153118.GE16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 11:51:20AM +0000, Suzuki K Poulose wrote:
> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> from an erratum 1024718, which causes incorrect updates when DBM/AP
> bits in a page table entry is modified without a break-before-make
> sequence. The work around is to skip enabling the hardware DBM feature
> on the affected cores. The hardware Access Flag management features
> is not affected. There are some other cores suffering from this
> errata, which could be added to the midr_list to trigger the work
> around.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: ckadabi at codeaurora.org
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4e73c610a409..0fc097e2b72e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -963,9 +963,23 @@ static inline void __cpu_enable_hw_dbm(void)
>  	isb();
>  }
>  
> +static bool cpu_has_broken_dbm(void)
> +{
> +	/* List of CPUs which have broken DBM support. */
> +	static const struct midr_range cpus[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_1024718
> +		MIDR_RANGE(MIDR_CORTEX_A55, 0, 0, 1, 0),  // A55 r0p0 -r1p0
> +#endif
> +		{},
> +	};
> +
> +	return is_midr_in_range_list(read_cpuid_id(), cpus);
> +}
> +
>  static bool cpu_can_use_dbm(const struct arm64_cpu_capabilities *cap)
>  {
> -	return has_cpuid_feature(cap, SCOPE_LOCAL_CPU);
> +	return has_cpuid_feature(cap, SCOPE_LOCAL_CPU) &&
> +	       !cpu_has_broken_dbm();

This refactoring seems sensbile to me.  The mapping between erratum IDs
and features that don't work is never guaranteed to be 1:1, so it
makes sense for the check function to have a generic name and to paste
in the relevant erratum ID ranges depending on the kernel config.

[...]

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
