From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 13:56:42 +0000
Subject: [PATCH 03/17] arm64: Allow checking of a CPU-local erratum
In-Reply-To: <20170306112622.13853-4-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-4-marc.zyngier@arm.com>
Message-ID: <20170320135641.GD31213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 11:26:08AM +0000, Marc Zyngier wrote:
> this_cpu_has_cap() only checks the feature array, and not the errata
> one. In order to be able to check for a CPU-local erratum, allow it
> to inspect the latter as well.
> 
> This is consistent with cpus_have_cap()'s behaviour, which includes
> errata already.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This sounds sensible to me.

Suzuki, any comments?

Thanks,
Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index abda8e861865..6eb77ae99b79 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1090,20 +1090,29 @@ static void __init setup_feature_capabilities(void)
>   * Check if the current CPU has a given feature capability.
>   * Should be called from non-preemptible context.
>   */
> -bool this_cpu_has_cap(unsigned int cap)
> +static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
> +			       unsigned int cap)
>  {
>  	const struct arm64_cpu_capabilities *caps;
>  
>  	if (WARN_ON(preemptible()))
>  		return false;
>  
> -	for (caps = arm64_features; caps->desc; caps++)
> +	for (caps = cap_array; caps->desc; caps++)
>  		if (caps->capability == cap && caps->matches)
>  			return caps->matches(caps, SCOPE_LOCAL_CPU);
>  
>  	return false;
>  }
>  
> +extern const struct arm64_cpu_capabilities arm64_errata[];
> +
> +bool this_cpu_has_cap(unsigned int cap)
> +{
> +	return (__this_cpu_has_cap(arm64_features, cap) ||
> +		__this_cpu_has_cap(arm64_errata, cap));
> +}
> +
>  void __init setup_cpu_features(void)
>  {
>  	u32 cwg;
> -- 
> 2.11.0
> 
