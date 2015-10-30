From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Oct 2015 11:51:55 +0000
Subject: [PATCH] ARM: don't infer VIPT I-cache properties from its
 reported geometry
In-Reply-To: <1446205603-14285-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446205603-14285-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151030115155.GF20030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 12:46:43PM +0100, Ard Biesheuvel wrote:
> The cache geometry reported by the CCSIDR system registers is tightly
> coupled to the instructions to perform cache maintenance by set/way,
> and the architecture explicitly forbids inferring anything about the
> actual cache geometry from them:
> 
>   The parameters NumSets, Associativity, and LineSize in these registers
>   define the architecturally visible parameters that are required for
>   the cache maintenance by Set/Way instructions. They are not guaranteed
>   to represent the actual microarchitectural features of a design. You
>   cannot make any inference about the actual sizes of caches based on
>   these parameters.
> 
> This includes calculating the way size of a VIPT I-cache to decide
> whether it is free of aliases. So remove the code that implements this
> for v7 CPUs, and treat all non-PIPT I-caches as aliasing instead.
> 
> Reported-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kernel/setup.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 20edd349d379..1275135488ee 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -279,7 +279,6 @@ int __pure cpu_architecture(void)
>  static int cpu_has_aliasing_icache(unsigned int arch)
>  {
>  	int aliasing_icache;
> -	unsigned int id_reg, num_sets, line_size;
>  
>  	/* PIPT caches never alias. */
>  	if (icache_is_pipt())
> @@ -288,15 +287,7 @@ static int cpu_has_aliasing_icache(unsigned int arch)
>  	/* arch specifies the register format */
>  	switch (arch) {
>  	case CPU_ARCH_ARMv7:
> -		asm("mcr	p15, 2, %0, c0, c0, 0 @ set CSSELR"
> -		    : /* No output operands */
> -		    : "r" (1));
> -		isb();
> -		asm("mrc	p15, 1, %0, c0, c0, 0 @ read CCSIDR"
> -		    : "=r" (id_reg));
> -		line_size = 4 << ((id_reg & 0x7) + 2);
> -		num_sets = ((id_reg >> 13) & 0x7fff) + 1;
> -		aliasing_icache = (line_size * num_sets) > PAGE_SIZE;
> +		aliasing_icache = 1;
>  		break;
>  	case CPU_ARCH_ARMv6:
>  		aliasing_icache = read_cpuid_cachetype() & (1 << 11);

I think this is the tip of the iceberg... If we have to audit/fix all
users of flush_pfn_alias and flush_icache_alias, we're in for some fun.

Will
