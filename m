From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 14:56:14 +0000
Subject: [PATCH 13/17] arm64: cpu_errata: Allow an erratum to be match
 for all revisions of a core
In-Reply-To: <20170306112622.13853-14-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-14-marc.zyngier@arm.com>
Message-ID: <20170320145613.GH31213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 11:26:18AM +0000, Marc Zyngier wrote:
> Some minor erratum may not be fixed in further revisions of a core,
> leading to a situation where the workaround needs to be updated each
> time an updated core is released.

That is somewhat unfortunate. :(

> Introduce a MIDR_ALL_VERSIONS match helper that will work for all
> versions of that MIDR, once and for all.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This looks sane to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Suzuki, any thoughts?

Mark.

> ---
>  arch/arm64/kernel/cpu_errata.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index f6cc67e7626e..2be1d1c05303 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -53,6 +53,13 @@ static int cpu_enable_trap_ctr_access(void *__unused)
>  	.midr_range_min = min, \
>  	.midr_range_max = max
>  
> +#define MIDR_ALL_VERSIONS(model) \
> +	.def_scope = SCOPE_LOCAL_CPU, \
> +	.matches = is_affected_midr_range, \
> +	.midr_model = model, \
> +	.midr_range_min = 0, \
> +	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
>  	defined(CONFIG_ARM64_ERRATUM_827319) || \
> -- 
> 2.11.0
> 
