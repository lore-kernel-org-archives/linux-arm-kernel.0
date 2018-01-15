From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Jan 2018 11:51:34 +0000
Subject: [PATCH v3 11/13] arm64: Implement branch predictor hardening for
 affected Cortex-A CPUs
In-Reply-To: <20180109161218.2079-1-suzuki.poulose@arm.com>
References: <1515432758-26440-12-git-send-email-will.deacon@arm.com>
 <20180109161218.2079-1-suzuki.poulose@arm.com>
Message-ID: <0baae1c1-8ea8-e01d-ff16-aabae36f8ee5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 09/01/18 16:12, Suzuki K Poulose wrote:
> On 08/01/18 17:32, Will Deacon wrote:
>> Cortex-A57, A72, A73 and A75 are susceptible to branch predictor aliasing
>> and can theoretically be attacked by malicious code.
>>
>> This patch implements a PSCI-based mitigation for these CPUs when available.
>> The call into firmware will invalidate the branch predictor state, preventing
>> any malicious entries from affecting other victim contexts.
>>
>> Co-developed-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Will, Marc,
> 
>> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>> +	{
>> +		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
>> +		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
>> +		.enable = enable_psci_bp_hardening,
>> +	},
>> +	{
>> +		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
>> +		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
>> +		.enable = enable_psci_bp_hardening,
>> +	},
>> +	{
>> +		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
>> +		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>> +		.enable = enable_psci_bp_hardening,
>> +	},
>> +	{
>> +		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
>> +		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
>> +		.enable = enable_psci_bp_hardening,
>> +	},
>> +#endif
> 
> The introduction of multiple entries for the same capability breaks
> some assumptions in this_cpu_has_caps() and verify_local_cpu_features()
> as they all stop at the first entry matching the "capability" and could
> return wrong results. We need something like the following to make this
> work, should someone add duplicate feature entry or use
> this_cpu_has_caps() on one of the errata.
> 
> ---8>---
> 
> arm64: capabilities: Handle duplicate entries for a capability
> 
> Sometimes a single capability could be listed multiple times with
> differing matches(), e.g, CPU errata for different MIDR versions.
> This breaks verify_local_cpu_feature() and this_cpu_has_cap() as
> we stop checking for a capability on a CPU with the first
> entry in the given table, which is not sufficient. Make sure we
> run the checks for all entries of the same capability. We do
> this by fixing __this_cpu_has_cap() to run through all the
> entries in the given table for a match and reuse it for
> verify_local_cpu_feature().
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 44 ++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 862a417ca0e2..0c43447f7406 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1120,6 +1120,26 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
>  			cap_set_elf_hwcap(hwcaps);
>  }
>  
> +/*
> + * Check if the current CPU has a given feature capability.
> + * Should be called from non-preemptible context.
> + */
> +static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
> +			       unsigned int cap)
> +{
> +	const struct arm64_cpu_capabilities *caps;
> +
> +	if (WARN_ON(preemptible()))
> +		return false;
> +
> +	for (caps = cap_array; caps->desc; caps++)
> +		if (caps->capability == cap &&
> +		    caps->matches &&
> +		    caps->matches(caps, SCOPE_LOCAL_CPU))
> +			return true;
> +	return false;
> +}
> +
>  void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>  			    const char *info)
>  {
> @@ -1183,8 +1203,9 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
>  }
>  
>  static void
> -verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
> +verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
>  {
> +	const struct arm64_cpu_capabilities *caps = caps_list;
>  	for (; caps->matches; caps++) {
>  		if (!cpus_have_cap(caps->capability))
>  			continue;
> @@ -1192,7 +1213,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
>  		 * If the new CPU misses an advertised feature, we cannot proceed
>  		 * further, park the cpu.
>  		 */
> -		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
> +		if (!__this_cpu_has_cap(caps_list, caps->capability)) {
>  			pr_crit("CPU%d: missing feature: %s\n",
>  					smp_processor_id(), caps->desc);
>  			cpu_die_early();
> @@ -1274,25 +1295,6 @@ static void __init mark_const_caps_ready(void)
>  	static_branch_enable(&arm64_const_caps_ready);
>  }
>  
> -/*
> - * Check if the current CPU has a given feature capability.
> - * Should be called from non-preemptible context.
> - */
> -static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
> -			       unsigned int cap)
> -{
> -	const struct arm64_cpu_capabilities *caps;
> -
> -	if (WARN_ON(preemptible()))
> -		return false;
> -
> -	for (caps = cap_array; caps->desc; caps++)
> -		if (caps->capability == cap && caps->matches)
> -			return caps->matches(caps, SCOPE_LOCAL_CPU);
> -
> -	return false;
> -}
> -
>  extern const struct arm64_cpu_capabilities arm64_errata[];
>  
>  bool this_cpu_has_cap(unsigned int cap)
> 

This looks sensible to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
