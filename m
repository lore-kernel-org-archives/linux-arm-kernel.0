From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 7 Feb 2018 10:38:14 +0000
Subject: [PATCH v2 06/20] arm64: capabilities: Unify the verification
In-Reply-To: <20180131182807.32134-7-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-7-suzuki.poulose@arm.com>
Message-ID: <20180207103813.GW5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:27:53PM +0000, Suzuki K Poulose wrote:
> Now that each capability describes how to treat the conflicts
> of CPU cap state vs System wide cap state, we can unify the
> verification logic to a single place.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  1 +
>  arch/arm64/kernel/cpufeature.c      | 89 +++++++++++++++++++++++--------------
>  2 files changed, 57 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 1b29b3f0a1bc..5e4d581c97f1 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1233,6 +1233,56 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
>  	}
>  }
>  
> +/*
> + * Run through the list of capabilities to check for conflicts.
> + * If the system has already detected a capability, take necessary
> + * action on this CPU.
> + *
> + * Returns "false" on conflicts.
> + */
> +static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
> +{
> +	bool cpu_has_cap, system_has_cap;
> +	const struct arm64_cpu_capabilities *caps = caps_list;
> +
> +	for (; caps->matches; caps++) {
> +		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
> +		system_has_cap =  cpus_have_cap(caps->capability);

Nit: Odd spacing?

[...]

Otherwise,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
