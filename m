From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 10 Oct 2017 15:36:13 +0100
Subject: [PATCH 3/3] arm64: Introduce command line parameter to disable CNP
In-Reply-To: <1507553734-27854-4-git-send-email-vladimir.murzin@arm.com>
References: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
 <1507553734-27854-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <6671190b-0d76-2e57-d105-444bbbc13fa0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 09/10/17 13:55, Vladimir Murzin wrote:
> There are cases when activating of Common Not Private (CNP) feature
> might not be desirable; this patch allows to forcefully disable CNP
> even it is supported by hardware.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>   arch/arm64/kernel/cpufeature.c                  | 20 +++++++++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0549662..3c1e45d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2560,6 +2560,10 @@
>   
>   	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
>   
> +	nocnp		[ARM64]
> +			Disable CNP (Common not Private translations)
> +			even if it is supported by processor.
> +
>   	nodelayacct	[KNL] Disable per-task delay accounting
>   
>   	nodsp		[SH] Disable hardware DSP at boot time.
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8d098a1..724fd93 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -771,6 +771,24 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int _
>   		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
>   }
>   
> +static bool nocnp;
> +
> +static int __init early_nocnp(char *p)
> +{
> +	nocnp = true;
> +	return 0;
> +}
> +early_param("nocnp", early_nocnp);
> +
> +static bool has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +	if (!has_cpuid_feature(entry, scope))
> +		return false;
> +
> +	return nocnp ? false : true;

This feels a bit odd.

Wouldn't the following be better?
return !nocnp;

Or simply the whole function as:
return has_cpuid_feature(entry, scope) && !nocnp;

Thanks,

> +}
> +
> +
>   static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
>   {
>   	return is_kernel_in_hyp_mode();
> @@ -905,7 +923,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.desc = "Common not Private translations",
>   		.capability = ARM64_HAS_CNP,
>   		.def_scope = SCOPE_SYSTEM,
> -		.matches = has_cpuid_feature,
> +		.matches = has_useable_cnp,
>   		.sys_reg = SYS_ID_AA64MMFR2_EL1,
>   		.sign = FTR_UNSIGNED,
>   		.field_pos = ID_AA64MMFR2_CNP_SHIFT,
> 

-- 
Julien Thierry
