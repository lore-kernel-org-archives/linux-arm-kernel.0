From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 7 Feb 2018 10:40:07 +0000
Subject: [PATCH v2 19/20] arm64: Delay enabling hardware DBM feature
In-Reply-To: <20180131182807.32134-20-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-20-suzuki.poulose@arm.com>
Message-ID: <20180207104007.GJ5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:28:06PM +0000, Suzuki K Poulose wrote:
> We enable hardware DBM bit in a capable CPU, very early in the
> boot via __cpu_setup. This doesn't give us a flexibility of
> optionally disable the feature, as the clearing the bit
> is a bit costly as the TLB can cache the settings. Instead,
> we delay enabling the feature until the CPU is brought up
> into the kernel. We use the feature capability mechanism
> to handle it.
> 
> The hardware DBM is a non-conflicting feature. i.e, the kernel
> can safely run with a mix of CPUs with some using the feature
> and the others don't. So, it is safe for a late CPU to have
> this capability and enable it, even if the active CPUs don't.
> 
> To get this handled properly by the infrastructure, we
> unconditionally set the capability and only enable it
> on CPUs which really have the feature.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>  arch/arm64/kernel/cpufeature.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/proc.S             |  9 +++------
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index bb263820de13..8df80cc828ac 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -45,7 +45,8 @@
>  #define ARM64_HARDEN_BRANCH_PREDICTOR		24
>  #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
>  #define ARM64_HAS_RAS_EXTN			26
> +#define ARM64_HW_DBM				27
>  
> -#define ARM64_NCAPS				27
> +#define ARM64_NCAPS				28
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 13e30c1b1e99..1f695a998eed 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -903,6 +903,33 @@ static int __init parse_kpti(char *str)
>  __setup("kpti=", parse_kpti);
>  #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +static bool has_hw_dbm(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	/*
> +	 * DBM is a non-conflicting feature. i.e, the kernel can safely run
> +	 * a mix of CPUs with and without the feature. So, we unconditionally
> +	 * enable the capability to allow any late CPU to use the feature.
> +	 * We only enable the control bits on the CPU, if it actually supports.
> +	 */
> +	return true;

As for bp hardening, can we just use a generic "always on" function
here?

[...]

Cheers
---Dave
