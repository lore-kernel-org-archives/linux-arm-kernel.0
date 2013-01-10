From: robherring2@gmail.com (Rob Herring)
Date: Thu, 10 Jan 2013 10:43:03 -0600
Subject: [PATCH] ARM: kernel: DT cpu map validity check helper function
In-Reply-To: <1357818507-8716-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1357818507-8716-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <50EEEF97.4000700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/10/2013 05:48 AM, Lorenzo Pieralisi wrote:
> Since the introduction of /cpu nodes bindings for ARM and the
> corresponding parse function arm_dt_init_cpu_maps(), the cpu_logical_map
> and the number of possible CPUs are set according to the DT /cpu
> nodes entries. Currently most of the existing ARM SMP platforms detect the
> number of cores through HW probing in their .smp_init_cpus functions and set
> the possible CPU mask accordingly.
> This method should be upgraded so that the CPU counting mechanism will be
> based on DT, keeping legacy HW probing mechanism as a fall back solution.
> 
> In order to implement this fall back solution mechanism, the ARM DT code
> should provide a helper function to platforms to check if the cpu map
> has been properly initialized through DT. If the check fails the
> platform will resort to legacy HW based cores counting mechanism.
> 
> This patch implements a trivial flag and a helper function that platform
> can call to check whether DT based cpu map initialization and cores count
> were completed successfully.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/include/asm/prom.h | 10 ++++++++++
>  arch/arm/kernel/devtree.c   |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
> index a219227..487614a 100644
> --- a/arch/arm/include/asm/prom.h
> +++ b/arch/arm/include/asm/prom.h
> @@ -18,6 +18,15 @@
>  extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
>  extern void arm_dt_memblock_reserve(void);
>  extern void __init arm_dt_init_cpu_maps(void);
> +/*
> + * Return true if cpu map initialization has been
> + * carried out correctly from DT
> + */
> +static inline bool __init arm_dt_cpu_map_valid(void)
> +{
> +	extern bool valid_dt_cpu_map;
> +	return valid_dt_cpu_map;
> +}
>  
>  #else /* CONFIG_OF */
>  
> @@ -28,6 +37,7 @@ static inline struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
>  
>  static inline void arm_dt_memblock_reserve(void) { }
>  static inline void arm_dt_init_cpu_maps(void) { }
> +static inline bool __init arm_dt_cpu_map_valid(void) { return false; }
>  
>  #endif /* CONFIG_OF */
>  #endif /* ASMARM_PROM_H */
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 70f1bde..c82af3b 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -62,6 +62,10 @@ void __init arm_dt_memblock_reserve(void)
>  		memblock_reserve(base, size);
>  	}
>  }
> +/*
> + * Export DT cpu map validity flag to platforms
> + */
> +bool valid_dt_cpu_map __initdata;
>  
>  /*
>   * arm_dt_init_cpu_maps - Function retrieves cpu nodes from the device tree
> @@ -158,6 +162,7 @@ void __init arm_dt_init_cpu_maps(void)
>  	 * a reg property, the DT CPU list can be considered valid and the
>  	 * logical map created in smp_setup_processor_id() can be overridden
>  	 */
> +	valid_dt_cpu_map = true;
>  	for (i = 0; i < cpuidx; i++) {
>  		set_cpu_possible(i, true);

I don't see why we need another variable. Doesn't cpu_possible mask
being set here imply that the DT map is valid.

We should start requiring valid /cpus nodes and the legacy fall-back
should be temporary.

Rob

>  		cpu_logical_map(i) = tmp_map[i];
> 
