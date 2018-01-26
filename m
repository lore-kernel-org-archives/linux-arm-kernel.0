From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 26 Jan 2018 14:16:11 +0000
Subject: [PATCH 13/16] arm64: Add support for checking errata based on a
 list of MIDRS
In-Reply-To: <20180123122809.16269-14-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-14-suzuki.poulose@arm.com>
Message-ID: <20180126141610.GU5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 12:28:06PM +0000, Suzuki K Poulose wrote:
> Add helpers for detecting an errata on list of midr ranges
> of affected CPUs.

This doesn't describe what the patch does: instead, helpers are being
added for checking whether an MIDR falls in one of multiple affected
model(s) and or revision(s).

Doing this makes sense, but is it really worth it?

We might save 100-200 bytes in the kernel image for now, but a common
workaround for errata on multiple unrelated cpus is surely a rare case.

Only if there are many such lists, or if the lists become large does
this start to seem a clear win.

> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  1 +
>  arch/arm64/kernel/cpu_errata.c      | 40 ++++++++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index a3d54c2c411f..70712de687c7 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h

[...]

> @@ -330,22 +353,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>  	{
>  		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> -		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> -		.enable = enable_psci_bp_hardening,
> -	},
> -	{
> -		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> -		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> -		.enable = enable_psci_bp_hardening,
> -	},
> -	{
> -		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> -		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> -		.enable = enable_psci_bp_hardening,
> -	},
> -	{
> -		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> -		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> +		ERRATA_MIDR_RANGE_LIST(cortex_bp_harden_cpus),

Could we just use a macro to generate multiple structs, instead of
inventing a new type of struct?

Cheers
---Dave
