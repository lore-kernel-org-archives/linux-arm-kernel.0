From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 14:32:09 +0100
Subject: [PATCH v4 2/5] arm64: Allow a capability to be checked on a
 single CPU
In-Reply-To: <1461324335-5081-3-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
 <1461324335-5081-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160422133209.GJ2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:25:32PM +0100, Suzuki K. Poulose wrote:
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1005,6 +1005,24 @@ static void __init setup_feature_capabilities(void)
>  	enable_cpu_capabilities(arm64_features);
>  }
>  
> +/*
> + * Check if the current CPU has a given feature capability.
> + * Should be called from non-preemptible context.
> + */
> +bool this_cpu_has_cap(unsigned int cap)
> +{
> +	const struct arm64_cpu_capabilities *caps = arm64_features;
> +
> +	if (WARN_ON(preemptible()))
> +		return false;
> +
> +	for (caps = arm64_features; caps->desc; caps++)
> +		if (caps->capability == cap && caps->matches)
> +			return caps->matches(caps, SCOPE_LOCAL_CPU);

Nitpick: you don't need to initialise "caps" twice.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
