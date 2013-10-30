From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 30 Oct 2013 11:40:50 +0000
Subject: [PATCH] ARM64: DT: define ARM64 specific arch_match_cpu_phys_id
In-Reply-To: <1382358582-32726-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1382358582-32726-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <5270F042.6060600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 21/10/13 13:29, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> OF/DT core library provides architecture specific hook to match the
> logical cpu index with the corresponding physical identifier.
> 
> On ARM64, the MPIDR_EL1 contains specific bitfields(MPIDR_EL1.Aff{3..0})
> which uniquely identify a CPU, in addition to some non-identifying
> information and reserved bits. The ARM cpu binding defines the 'reg'
> property to only contain the affinity bits, and any cpu nodes with other
> bits set in their 'reg' entry are skipped.
> 
> This patch overrides the weak definition of arch_match_cpu_phys_id
> with ARM64 specific version using MPIDR_EL1.Aff{3..0} as cpu physical
> identifiers.
> 

Can you take this trivial patch for v3.13 ?

Regards,
Sudeep

> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/setup.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 055cfb8..ff629f9 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -97,6 +97,11 @@ void __init early_print(const char *str, ...)
>  	printk("%s", buf);
>  }
>  
> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> +{
> +	return phys_id == cpu_logical_map(cpu);
> +}
> +
>  static void __init setup_processor(void)
>  {
>  	struct cpu_info *cpu_info;
> 
