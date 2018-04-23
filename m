From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 23 Apr 2018 17:19:38 +0100
Subject: [PATCH] arm64: add sentinel to kpti_safe_list
In-Reply-To: <20180423104133.36395-1-mark.rutland@arm.com>
References: <20180423104133.36395-1-mark.rutland@arm.com>
Message-ID: <931cba30-91ee-0940-e0f2-a599fbf8eb5a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/18 11:41, Mark Rutland wrote:
> We're missing a sentinel entry in kpti_safe_list. Thus is_midr_in_range_list()
> can walk past the end of kpti_safe_list. Depending on the contents of memory,
> this could erroneously match a CPU's MIDR, cause a data abort, or other bad
> outcomes.
> 
> Add the sentinel entry to avoid this.
> 
> Fixes: be5b299830c63ed7 ("arm64: capabilities: Add support for checks based on a list of MIDRs")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> As discussesd in [1].
> 
> Mark.
> 
> [1] https://lkml.kernel.org/r/97d99ad9-c5cf-a4d2-126a-2b39ffead0b3 at web.de
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 536d572e5596..9d1b06d67c53 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -868,6 +868,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>   	static const struct midr_range kpti_safe_list[] = {
>   		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
>   		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
> +		{ /* sentinel */ }
>   	};
>   	char const *str = "command line option";

Thanks for the report and the fix.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
