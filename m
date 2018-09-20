From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 20 Sep 2018 10:05:48 +0100
Subject: [PATCH 2/5] ARM: split out processor lookup
In-Reply-To: <E1g2Z6O-0003eQ-Lh@rmk-PC.armlinux.org.uk>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <E1g2Z6O-0003eQ-Lh@rmk-PC.armlinux.org.uk>
Message-ID: <2b7eb8fd-4ec4-efe3-89bf-b442f3b11fa6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 19/09/18 10:48, Russell King wrote:
> Split out the lookup of the processor type and associated error handling
> from the rest of setup_processor() - we will need to use this in the
> secondary CPU bringup path for big.Little Spectre variant 2 mitigation.
> 

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm/include/asm/cputype.h |  1 +
>   arch/arm/kernel/setup.c        | 31 +++++++++++++++++++------------
>   2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 26021980504d..f6df4bb4e543 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -107,6 +107,7 @@
>   #define ARM_CPU_PART_SCORPION		0x510002d0
>   
>   extern unsigned int processor_id;
> +struct proc_info_list *lookup_processor(u32 midr);
>   
>   #ifdef CONFIG_CPU_CP15
>   #define read_cpuid(reg)							\
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index fc40a2b40595..05a4eb6b0d01 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -667,22 +667,29 @@ static void __init smp_build_mpidr_hash(void)
>   }
>   #endif
>   
> -static void __init setup_processor(void)
> +/*
> + * locate processor in the list of supported processor types.  The linker
> + * builds this table for us from the entries in arch/arm/mm/proc-*.S
> + */
> +struct proc_info_list *lookup_processor(u32 midr)
>   {
> -	struct proc_info_list *list;
> +	struct proc_info_list *list = lookup_processor_type(midr);
>   
> -	/*
> -	 * locate processor in the list of supported processor
> -	 * types.  The linker builds this table for us from the
> -	 * entries in arch/arm/mm/proc-*.S
> -	 */
> -	list = lookup_processor_type(read_cpuid_id());
>   	if (!list) {
> -		pr_err("CPU configuration botched (ID %08x), unable to continue.\n",
> -		       read_cpuid_id());
> -		while (1);
> +		pr_err("CPU%u: configuration botched (ID %08x), CPU halted\n",
> +		       smp_processor_id(), midr);
> +		while (1)
> +		/* can't use cpu_relax() here as it may require MMU setup */;
>   	}
>   
> +	return list;
> +}
> +
> +static void __init setup_processor(void)
> +{
> +	unsigned int midr = read_cpuid_id();
> +	struct proc_info_list *list = lookup_processor(midr);
> +
>   	cpu_name = list->cpu_name;
>   	__cpu_architecture = __get_cpu_architecture();
>   
> @@ -700,7 +707,7 @@ static void __init setup_processor(void)
>   #endif
>   
>   	pr_info("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
> -		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
> +		list->cpu_name, midr, midr & 15,
>   		proc_arch[cpu_architecture()], get_cr());
>   
>   	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
> 

-- 
Julien Thierry
